import 'package:cielo_estrellado/models/goal_type.dart';
import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 3)
class Goal extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  GoalType type;

  @HiveField(2)
  int targetValue;

  @HiveField(3)
  bool isActive;

  @HiveField(4)
  DateTime createdAt;

  Goal({
    required this.id,
    required this.type,
    required this.targetValue,
    required this.isActive,
    required this.createdAt,
  });
}
