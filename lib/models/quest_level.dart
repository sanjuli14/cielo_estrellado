import 'package:cielo_estrellado/models/quest_task.dart';
import 'package:hive/hive.dart';

part 'quest_level.g.dart';

@HiveType(typeId: 11)
class QuestLevel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<QuestTask> tasks;

  @HiveField(3)
  final int xpReward;

  @HiveField(4)
  final String? constellationId; // ID of the constellation to unlock

  QuestLevel({
    required this.id,
    required this.name,
    required this.tasks,
    required this.xpReward,
    this.constellationId,
  });

  bool get isCompleted => tasks.every((task) => task.isCompleted);
  
  double get progress {
    if (tasks.isEmpty) return 0;
    double totalProgress = 0;
    for (var task in tasks) {
      totalProgress += task.progress; // This now uses safeCurrentValue/safeTargetValue
    }
    return totalProgress / tasks.length;
  }
}
