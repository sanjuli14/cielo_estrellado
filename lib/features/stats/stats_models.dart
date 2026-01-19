class DayStat {
  final DateTime day;
  final int sessions;
  final int minutes;

  const DayStat({
    required this.day,
    required this.sessions,
    required this.minutes,
  });
}

class PeriodSummary {
  final DateTime start;
  final DateTime end;
  final int totalMinutes;
  final int sessions;
  final double averageMinutesPerDay;
  final DayStat? bestDay;
  final DayStat? worstDay;
  final List<DayStat> byDay;

  const PeriodSummary({
    required this.start,
    required this.end,
    required this.totalMinutes,
    required this.sessions,
    required this.averageMinutesPerDay,
    required this.bestDay,
    required this.worstDay,
    required this.byDay,
  });
}
