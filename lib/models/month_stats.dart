class MonthStat {
  final DateTime month; // Should be the 1st of the month
  final int sessions;
  final int totalMinutes;
  final int totalStars;

  MonthStat({
    required this.month,
    required this.sessions,
    required this.totalMinutes,
    required this.totalStars,
  });
}
