import 'package:cielo_estrellado/models/quest_level.dart';
import 'package:hive/hive.dart';

part 'life_quest.g.dart';

@HiveType(typeId: 10)
class LifeQuest extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final List<QuestLevel> levels;

  @HiveField(4)
  int currentLevelIndex;

  @HiveField(5)
  bool isCompleted;

  @HiveField(6)
  final String category; // e.g., 'Salud', 'Productividad', 'Creatividad'

  @HiveField(7)
  String? type; // 'daily', 'milestone'

  @HiveField(8)
  DateTime? lastReset;

  LifeQuest({
    required this.id,
    required this.title,
    required this.description,
    required this.levels,
    this.currentLevelIndex = 0,
    this.isCompleted = false,
    required this.category,
    this.type = 'milestone',
    this.lastReset,
  });

  QuestLevel get currentLevel => levels[currentLevelIndex];

  double get totalProgress {
    if (levels.isEmpty) return 0;
    double sum = 0;
    for (var level in levels) {
      sum += level.progress;
    }
    return sum / levels.length;
  }
}
