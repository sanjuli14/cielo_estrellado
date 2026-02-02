
import 'package:cielo_estrellado/models/day_stats.dart';
import 'package:cielo_estrellado/models/month_stats.dart';
import 'package:cielo_estrellado/models/period_summary.dart';
import 'package:cielo_estrellado/models/sessions.dart';
import 'package:intl/intl.dart';

DateTime _dayKey(DateTime dt) {
  return DateTime(dt.year, dt.month, dt.day);
}

class StatsAggregator {
  const StatsAggregator();

  PeriodSummary weeklySummary(List<Session> sessions, {DateTime? now}) {
    final n = now ?? DateTime.now();
    final today = _dayKey(n);

    // Last 7 days including today
    final start = today.subtract(const Duration(days: 6));
    final end = today;

    return _summaryForRange(sessions, start: start, end: end);
  }

  PeriodSummary monthlySummary(List<Session> sessions, {DateTime? now}) {
    final n = now ?? DateTime.now();
    final end = _dayKey(n);
    final start = DateTime(end.year, end.month, 1);

    return _summaryForRange(sessions, start: start, end: end);
  }

  List<MonthStat> last12MonthsSummary(List<Session> sessions, {DateTime? now}) {
     final n = now ?? DateTime.now();
     // Current month
     final currentMonth = DateTime(n.year, n.month, 1);
     
     // Generate keys for the last 12 months (inclusive of current)
     final months = <DateTime>[];
     for (int i = 11; i >= 0; i--) {
       final d = DateTime(n.year, n.month - i, 1);
       months.add(DateTime(d.year, d.month, 1));
     }

     final Map<DateTime, MonthStat> map = {};
     for (final m in months) {
       map[m] = MonthStat(month: m, sessions: 0, totalMinutes: 0, totalStars: 0);
     }

     for (final s in sessions) {
       final cardMonth = DateTime(s.startTime.year, s.startTime.month, 1);
       if (map.containsKey(cardMonth)) {
         final prev = map[cardMonth]!;
         map[cardMonth] = MonthStat(
           month: cardMonth,
           sessions: prev.sessions + 1,
           totalMinutes: prev.totalMinutes + s.durationMinutes,
           totalStars: prev.totalStars + (s.starsGenerated ?? 0), // Handle potential null if older sessions don't have it? Model has required though.
           // Actually Session model had starsGenerated as required, so it should be fine.
         );
       }
     }

     return map.values.toList()..sort((a,b) => a.month.compareTo(b.month));
  }

  int calculateCurrentStreak(List<Session> sessions, {DateTime? now}) {
    if (sessions.isEmpty) return 0;

    final n = now ?? DateTime.now();
    final today = _dayKey(n);
    final yesterday = today.subtract(const Duration(days: 1));

    // Get all unique days with sessions, sorted descending
    final uniqueDays = sessions
        .map((s) => _dayKey(s.startTime))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    if (uniqueDays.isEmpty) return 0;

    // Check if the most recent session is today or yesterday.
    // If the last session was before yesterday, streak is broken -> 0.
    final lastActiveKey = uniqueDays.first;
    if (lastActiveKey.isBefore(yesterday)) {
      return 0;
    }

    int streak = 0;
    DateTime currentCheck = lastActiveKey;

    for (final day in uniqueDays) {
      if (day.isAtSameMomentAs(currentCheck)) {
        streak++;
        currentCheck = currentCheck.subtract(const Duration(days: 1));
      } else {
        // Gap found
        break;
      }
    }

    return streak;
  }

  int calculateBestStreak(List<Session> sessions) {
    if (sessions.isEmpty) return 0;

    // Get all unique days with sessions, sorted ascending
    final uniqueDays = sessions
        .map((s) => _dayKey(s.startTime))
        .toSet()
        .toList()
      ..sort((a, b) => a.compareTo(b));

    if (uniqueDays.isEmpty) return 0;

    int maxStreak = 0;
    int currentStreak = 0;
    DateTime? expectedDay;

    for (final day in uniqueDays) {
      if (expectedDay == null || day.isAtSameMomentAs(expectedDay)) {
        currentStreak++;
      } else {
        if (currentStreak > maxStreak) maxStreak = currentStreak;
        currentStreak = 1;
      }
      expectedDay = day.add(const Duration(days: 1));
    }

    if (currentStreak > maxStreak) maxStreak = currentStreak;
    return maxStreak;
  }

  PeriodSummary _summaryForRange(
    List<Session> sessions, {
    required DateTime start,
    required DateTime end,
  }) {
    final startDay = _dayKey(start);
    final endDay = _dayKey(end);

    final daysCount = endDay.difference(startDay).inDays + 1;

    final byDayMap = <DateTime, DayStat>{};
    for (var i = 0; i < daysCount; i++) {
      final day = startDay.add(Duration(days: i));
      byDayMap[day] = DayStat(day: day, sessions: 0, minutes: 0, starsGenerated: 0);
    }

    int totalMinutes = 0;
    int totalSessions = 0;

    for (final s in sessions) {
      final day = _dayKey(s.startTime);
      if (day.isBefore(startDay) || day.isAfter(endDay)) continue;

      final prev = byDayMap[day];
      if (prev == null) continue;

      final minutes = s.durationMinutes;
      final stars = s.starsGenerated; 

      byDayMap[day] = DayStat(
        day: day,
        sessions: prev.sessions + 1,
        minutes: prev.minutes + minutes,
        starsGenerated: prev.starsGenerated + stars,
      );

      totalMinutes += minutes;
      totalSessions += 1;
    }

    final byDay = byDayMap.values.toList()..sort((a, b) => a.day.compareTo(b.day));

    DayStat? best;
    DayStat? worst;

    for (final d in byDay) {
      if (best == null || d.minutes > best.minutes) best = d;
      if (worst == null || d.minutes < worst.minutes) worst = d;
    }

    final average = daysCount == 0 ? 0.0 : totalMinutes / daysCount;

    return PeriodSummary(
      start: startDay,
      end: endDay,
      totalMinutes: totalMinutes,
      sessions: totalSessions,
      averageMinutesPerDay: average,
      bestDay: best,
      worstDay: worst,
      byDay: byDay,
    );
  }
}
