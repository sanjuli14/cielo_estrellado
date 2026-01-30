import 'package:hive/hive.dart';

part 'goal_type.g.dart';

@HiveType(typeId: 4)
enum GoalType {
  @HiveField(0)
  starsPerMonth,
  
  @HiveField(2)
  consecutiveDays,
}
