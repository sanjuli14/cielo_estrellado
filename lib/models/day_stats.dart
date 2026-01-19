import 'package:hive/hive.dart';

part 'day_stats.g.dart';

@HiveType(typeId: 1)
class DayStat extends HiveObject {
  @HiveField(0)
  DateTime day;

  @HiveField(1)
  int sessions;

  @HiveField(2)
  int minutes;

  DayStat({
    required this.day,
    required this.sessions,
    required this.minutes,
  });
}
