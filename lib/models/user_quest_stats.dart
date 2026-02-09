import 'package:hive/hive.dart';

part 'user_quest_stats.g.dart';

@HiveType(typeId: 13)
class UserQuestStats extends HiveObject {
  @HiveField(0)
  int totalXp;

  @HiveField(1)
  int level;

  @HiveField(2)
  int completedQuestsCount;

  @HiveField(3)
  int completedTasksCount;

  UserQuestStats({
    this.totalXp = 0,
    this.level = 1,
    this.completedQuestsCount = 0,
    this.completedTasksCount = 0,
  });

  // Simple leveling logic: level = sqrt(xp / 100) + 1
  // Or more traditional: level 1 = 0, level 2 = 500, level 3 = 1500...
  static int calculateLevel(int xp) {
    if (xp < 500) return 1;
    if (xp < 1500) return 2;
    if (xp < 3000) return 3;
    if (xp < 6000) return 4;
    return (xp / 1500).floor() + 1; // Simplistic for now
  }
}
