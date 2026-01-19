import 'package:cielo_estrellado/features/stats/stats_models.dart';
import 'package:cielo_estrellado/models/sessions.dart';

DateTime _dayKey(DateTime dt) {
  return DateTime(dt.year, dt.month, dt.day);
}

class StatsAggregator {
  const StatsAggregator();

  PeriodSummary weeklySummary(List<Session> sessions, {DateTime? now}) {
    final n = now ?? DateTime.now();
    final today = _dayKey(n);

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
      byDayMap[day] = DayStat(day: day, sessions: 0, minutes: 0);
    }

    int totalMinutes = 0;
    int totalSessions = 0;

    for (final s in sessions) {
      final day = _dayKey(s.startTime);
      if (day.isBefore(startDay) || day.isAfter(endDay)) continue;

      final prev = byDayMap[day];
      if (prev == null) continue;

      final minutes = s.durationMinutes;
      byDayMap[day] = DayStat(
        day: day,
        sessions: prev.sessions + 1,
        minutes: prev.minutes + minutes,
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
