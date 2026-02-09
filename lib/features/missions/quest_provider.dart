import 'package:cielo_estrellado/features/missions/quest_pool.dart';
import 'package:cielo_estrellado/models/adventure_diary_entry.dart';
import 'package:cielo_estrellado/models/life_quest.dart';
import 'package:cielo_estrellado/models/user_quest_stats.dart';
import 'package:cielo_estrellado/models/repositories/quest_repository.dart';
import 'package:cielo_estrellado/models/repositories/session_repositories.dart';
import 'package:cielo_estrellado/models/sessions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class AchievementEvent {
  final String title;
  final String description;
  final int? xp;
  final DateTime timestamp;

  AchievementEvent({
    required this.title,
    required this.description,
    this.xp,
    required this.timestamp,
  });
}

class AchievementNotifier extends Notifier<AchievementEvent?> {
  @override
  AchievementEvent? build() => null;

  void notify(AchievementEvent event) {
    state = event;
  }
}

final achievementEventProvider = NotifierProvider<AchievementNotifier, AchievementEvent?>(() {
  return AchievementNotifier();
});

final questRepositoryProvider = Provider<QuestRepository>((ref) {
  return QuestRepository();
});

final lifeQuestsProvider = StreamProvider<List<LifeQuest>>((ref) {
  final repo = ref.watch(questRepositoryProvider);
  return repo.watchQuests();
});

final userQuestStatsProvider = StreamProvider<UserQuestStats>((ref) {
  final repo = ref.watch(questRepositoryProvider);
  return repo.watchStats();
});

final adventureDiaryProvider = StreamProvider<List<AdventureDiaryEntry>>((ref) {
  final repo = ref.watch(questRepositoryProvider);
  return repo.watchDiary();
});

final lifeQuestNotifierProvider = NotifierProvider<LifeQuestNotifier, void>(() {
  return LifeQuestNotifier();
});

class LifeQuestNotifier extends Notifier<void> {
  @override
  void build() {
    _initDefaultQuests();
    _listenToSessions();
  }

  void _listenToSessions() {
    final repo = ref.read(sessionRepositoryProvider);
    repo.watchSessions().listen((sessions) {
      if (sessions.isNotEmpty) {
        _processLatestSession(sessions.last);
      }
    });
  }

  Future<void> _initDefaultQuests() async {
    final repo = ref.read(questRepositoryProvider);
    final existing = await repo.getAllQuests();
    
    // Clear everything if we find ANY quest that doesn't match the new "Milestone" system
    bool holdsOldMissions = existing.any((q) => !q.id.startsWith('focus_milestone_'));
    
    if (holdsOldMissions) {
       await repo.clearQuests();
       await _initDefaultQuests();
       return;
    }

    if (existing.isEmpty) {
      final defaultQuests = QuestPool.generateInitialQuests();
      for (var quest in defaultQuests) {
        await repo.saveQuest(quest);
      }
    }
  }

  Future<void> _processLatestSession(Session session) async {
    final repo = ref.read(questRepositoryProvider);
    final quests = await repo.getAllQuests();
    final stats = await repo.getStats();
    bool changed = false;

    for (var quest in quests) {
      if (quest.isCompleted) continue;
      final currentLvl = quest.currentLevel;
      bool levelProgressed = false;

      for (var task in currentLvl.tasks) {
        if (task.isCompleted) continue;

        if (task.unit == 'minutos') {
          task.currentValue = (task.currentValue ?? 0) + session.durationMinutes;
        } else if (task.unit == 'sesiones') {
          task.currentValue = (task.currentValue ?? 0) + 1;
        } else if (task.unit == 'sesiones largas' && session.durationMinutes >= 45) {
          task.currentValue = (task.currentValue ?? 0) + 1;
        }

        if (task.safeCurrentValue >= task.safeTargetValue) {
          task.isCompleted = true;
          task.currentValue = task.safeTargetValue;
          stats.totalXp += task.xpReward;
          stats.completedTasksCount++;
          
          await repo.saveDiaryEntry(AdventureDiaryEntry(
            id: const Uuid().v4(),
            date: DateTime.now(),
            title: 'Hito Diario Logrado',
            description: 'Has cumplido: ${task.description}',
            type: 'task_completed',
            xpGained: task.xpReward,
          ));

          // Notify Achievement UI
          ref.read(achievementEventProvider.notifier).notify(AchievementEvent(
            title: '¡Misión Cumplida!',
            description: task.description,
            xp: task.xpReward,
            timestamp: DateTime.now(),
          ));
          
          levelProgressed = true;
        }
        changed = true;
      }

      if (levelProgressed && currentLvl.isCompleted) {
        stats.totalXp += currentLvl.xpReward;
        final diaryEntry = AdventureDiaryEntry(
          id: const Uuid().v4(),
          date: DateTime.now(),
          title: '¡Meta Diaria Completada!',
          description: 'Has ganado un bono de ${currentLvl.xpReward} XP.',
          type: 'level_up',
          xpGained: currentLvl.xpReward,
        );
        await repo.saveDiaryEntry(diaryEntry);

        // Notify Achievement UI
        ref.read(achievementEventProvider.notifier).notify(AchievementEvent(
          title: diaryEntry.title,
          description: diaryEntry.description,
          xp: currentLvl.xpReward,
          timestamp: DateTime.now(),
        ));
      }
      if (changed) await repo.saveQuest(quest);
    }

    if (changed) {
      stats.level = UserQuestStats.calculateLevel(stats.totalXp);
      await repo.saveStats(stats);
    }
  }
}
