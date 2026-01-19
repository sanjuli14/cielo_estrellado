import 'package:hive/hive.dart';
import 'day_stats.dart';

part 'period_summary.g.dart';

@HiveType(typeId: 2)
class PeriodSummary extends HiveObject {
  @HiveField(0)
  DateTime start;

  @HiveField(1)
  DateTime end;

  @HiveField(2)
  int totalMinutes;

  @HiveField(3)
  int sessions;

  @HiveField(4)
  double averageMinutesPerDay;

  @HiveField(5)
  DayStat? bestDay;

  @HiveField(6)
  DayStat? worstDay;

  @HiveField(7)
  List<DayStat> byDay;

  PeriodSummary({
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
