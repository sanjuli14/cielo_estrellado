import 'package:cielo_estrellado/features/goals/goal_calculator.dart';
import 'package:cielo_estrellado/features/stats/stats_aggregator.dart';
import 'package:cielo_estrellado/features/stats/stats_providers.dart';
import 'package:cielo_estrellado/models/goal.dart';
import 'package:cielo_estrellado/models/goal_type.dart';
import 'package:cielo_estrellado/models/repositories/goal_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repository provider
final goalRepositoryProvider = Provider<GoalRepository>((ref) {
  return GoalRepository();
});

// Stream of active goals
final activeGoalsProvider = StreamProvider<List<Goal>>((ref) {
  final repo = ref.watch(goalRepositoryProvider);
  return repo.watchActiveGoals();
});

// Goal calculator provider
final goalCalculatorProvider = Provider<GoalCalculator>((ref) {
  return const GoalCalculator();
});

// Goal progress data class
class GoalProgress {
  final Goal goal;
  final int currentValue;
  final double progress;

  GoalProgress({
    required this.goal,
    required this.currentValue,
    required this.progress,
  });
}

// Provider that calculates progress for all active goals
final goalProgressProvider = StreamProvider<List<GoalProgress>>((ref) {
  final goalsAsync = ref.watch(activeGoalsProvider);
  final sessionsAsync = ref.watch(sessionsStreamProvider);
  final calculator = ref.watch(goalCalculatorProvider);
  final statsAggregator = ref.watch(statsAggregatorProvider);

  return Stream.value(null).asyncMap((_) async {
    final rawGoals = goalsAsync.asData?.value ?? [];
    final sessions = sessionsAsync.asData?.value ?? [];

    if (rawGoals.isEmpty) return <GoalProgress>[];

    // Filter to only include goals with types that are currently in the enum
    // AND ensure we only have one goal per type (the most recent one or first found)
    final goalsMap = <GoalType, Goal>{};
    for (final goal in rawGoals) {
      if (!goalsMap.containsKey(goal.type)) {
        goalsMap[goal.type] = goal;
      }
    }
    
    final goals = goalsMap.values.toList();
    final progressList = <GoalProgress>[];

    for (final goal in goals) {
      int currentValue = 0;

      switch (goal.type) {
        case GoalType.starsPerMonth:
          currentValue = calculator.calculateStarsThisMonth(sessions);
          break;
        case GoalType.consecutiveDays:
          currentValue = statsAggregator.calculateCurrentStreak(sessions);
          break;
      }

      final progress = calculator.calculateProgress(goal, currentValue);

      progressList.add(GoalProgress(
        goal: goal,
        currentValue: currentValue,
        progress: progress,
      ));
    }

    return progressList;
  });
});
