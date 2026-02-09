import 'package:hive/hive.dart';

part 'quest_task.g.dart';

@HiveType(typeId: 12)
class QuestTask extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String description;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  final int xpReward;

  @HiveField(4)
  double? currentValue;

  @HiveField(5)
  double? targetValue;

  @HiveField(6)
  String? unit; // 'minutes', 'sessions', etc.

  QuestTask({
    required this.id,
    required this.description,
    this.isCompleted = false,
    required this.xpReward,
    this.currentValue = 0,
    this.targetValue = 1,
    this.unit,
  });

  double get progress => (safeCurrentValue / safeTargetValue).clamp(0.0, 1.0);

  double get safeCurrentValue => currentValue ?? 0;
  double get safeTargetValue => (targetValue == null || targetValue == 0) ? 1 : targetValue!;

  QuestTask copyWith({
    bool? isCompleted,
    double? currentValue,
  }) {
    return QuestTask(
      id: id,
      description: description,
      isCompleted: isCompleted ?? this.isCompleted,
      xpReward: xpReward,
      currentValue: currentValue ?? this.currentValue,
      targetValue: targetValue,
      unit: unit,
    );
  }
}
