import 'package:hive/hive.dart';

part 'adventure_diary_entry.g.dart';

@HiveType(typeId: 14)
class AdventureDiaryEntry extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime date;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final String type; // 'task_completed', 'level_up', 'quest_finished', 'constellation_unlocked'

  @HiveField(5)
  final int xpGained;

  AdventureDiaryEntry({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.type,
    this.xpGained = 0,
  });
}
