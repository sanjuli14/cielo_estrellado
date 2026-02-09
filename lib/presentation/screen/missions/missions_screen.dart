import 'package:cielo_estrellado/features/missions/quest_provider.dart';
import 'package:cielo_estrellado/models/user_quest_stats.dart';
import 'package:cielo_estrellado/presentation/screen/missions/widgets/focus_quests_tab.dart';
import 'package:cielo_estrellado/core/ui/achievement_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MissionsScreen extends ConsumerWidget {
  const MissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questStatsAsync = ref.watch(userQuestStatsProvider);
    
    // Ensure the notifier is initialized
    ref.watch(lifeQuestNotifierProvider);

    // Listen for achievements
    ref.listen<AchievementEvent?>(achievementEventProvider, (previous, next) {
      if (next != null) {
        AchievementService.showAchievement(
          context,
          title: next.title,
          description: next.description,
          xp: next.xp,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Misiones', 
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF000000), Color(0xFF020513), Color(0xFF050824)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _SimpleLevelHeader(
                questStats: questStatsAsync.asData?.value,
              ),
              const Expanded(
                child: FocusQuestsTab(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SimpleLevelHeader extends StatelessWidget {
  final UserQuestStats? questStats;

  const _SimpleLevelHeader({this.questStats});

  @override
  Widget build(BuildContext context) {
    final userLevel = questStats?.level ?? 1;
    final totalXp = questStats?.totalXp ?? 0;
    
    // Calculate progress to next level (for now let's say 2000 XP per level for simplicity)
    // In UserQuestStats we have calculateLevel. Let's show current XP vs next level threshold.
    // Level 1: 0-499, Level 2: 500-1499, Level 3: 1500-2999...
    int currentLevelThreshold = 0;
    int nextLevelThreshold = 500;
    if (userLevel == 2) { currentLevelThreshold = 500; nextLevelThreshold = 1500; }
    else if (userLevel == 3) { currentLevelThreshold = 1500; nextLevelThreshold = 3000; }
    else if (userLevel == 4) { currentLevelThreshold = 3000; nextLevelThreshold = 6000; }
    else if (userLevel >= 5) { currentLevelThreshold = 6000; nextLevelThreshold = totalXp + 1000; }

    final progress = (totalXp - currentLevelThreshold) / (nextLevelThreshold - currentLevelThreshold);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          Text(
            "NIVEL $userLevel",
            style: const TextStyle(
              color: Color(0xFFFFD1A4),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontFamily: 'Poppins'
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "$totalXp XP",
            style: const TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 10,
              backgroundColor: Colors.white.withOpacity(0.05),
              color: const Color(0xFFFFD1A4),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Próximo nivel: $nextLevelThreshold XP",
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}


