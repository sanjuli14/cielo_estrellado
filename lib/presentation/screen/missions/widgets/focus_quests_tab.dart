import 'package:cielo_estrellado/features/missions/quest_provider.dart';
import 'package:cielo_estrellado/models/life_quest.dart';
import 'package:cielo_estrellado/models/quest_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FocusQuestsTab extends ConsumerWidget {
  const FocusQuestsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questsAsync = ref.watch(lifeQuestsProvider);

    return questsAsync.when(
      data: (quests) {
        if (quests.isEmpty) {
          return const Center(
            child: Text("No hay misiones de foco disponibles", 
              style: TextStyle(color: Colors.white38)),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: quests.length,
          itemBuilder: (context, index) {
            final quest = quests[index];
            return _FocusQuestCard(quest: quest);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: $e")),
    );
  }
}

class _FocusQuestCard extends ConsumerWidget {
  final LifeQuest quest;
  const _FocusQuestCard({required this.quest});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLevel = quest.currentLevel;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: ExpansionTile(
        title: Text(
          quest.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Poppins',
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nivel ${quest.currentLevelIndex + 1}: ${currentLevel.name}",
                style: const TextStyle(color: Color(0xFFFFD1A4), fontSize: 13, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: quest.totalProgress,
                  minHeight: 4,
                  backgroundColor: Colors.white.withOpacity(0.05),
                  color: const Color(0xFFFFD1A4),
                ),
              ),
            ],
          ),
        ),
        childrenPadding: const EdgeInsets.all(16),
        collapsedIconColor: Colors.white38,
        iconColor: const Color(0xFFFFD1A4),
        children: [
          const Divider(color: Colors.white10),
          ...currentLevel.tasks.map((task) => _TaskItem(
            questId: quest.id,
            task: task,
          )),
        ],
      ),
    );
  }
}

class _TaskItem extends ConsumerWidget {
  final String questId;
  final QuestTask task;
  const _TaskItem({required this.questId, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.description,
                  style: TextStyle(
                    color: task.isCompleted ? Colors.white38 : Colors.white,
                    fontSize: 14,
                    fontWeight: task.isCompleted ? FontWeight.normal : FontWeight.w500,
                  ),
                ),
              ),
              if (task.isCompleted)
                const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20)
              else
                Text(
                  "${task.safeCurrentValue.toInt()} / ${task.safeTargetValue.toInt()} ${task.unit ?? ''}",
                  style: const TextStyle(
                    color: Color(0xFFFFD1A4),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: task.progress,
              minHeight: 4,
              backgroundColor: Colors.white.withOpacity(0.05),
              valueColor: AlwaysStoppedAnimation<Color>(
                task.isCompleted ? Colors.greenAccent.withOpacity(0.5) : const Color(0xFFFFD1A4).withOpacity(0.7),
              ),
            ),
          ),
          if (!task.isCompleted) ...[
            const SizedBox(height: 4),
            Text(
              "+${task.xpReward} XP",
              style: TextStyle(color: const Color(0xFFFFD1A4).withOpacity(0.5), fontSize: 10),
            ),
          ],
        ],
      ),
    );
  }
}
