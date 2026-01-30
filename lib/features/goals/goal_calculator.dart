import 'package:cielo_estrellado/models/goal.dart';
import 'package:cielo_estrellado/models/goal_type.dart';
import 'package:cielo_estrellado/models/sessions.dart';

class GoalCalculator {
  const GoalCalculator();

  /// Calculate total stars generated in the current month
  int calculateStarsThisMonth(List<Session> sessions, {DateTime? now}) {
    final n = now ?? DateTime.now();
    final currentMonth = DateTime(n.year, n.month, 1);
    final nextMonth = DateTime(n.year, n.month + 1, 1);

    return sessions
        .where((s) =>
            s.startTime.isAfter(currentMonth.subtract(const Duration(seconds: 1))) &&
            s.startTime.isBefore(nextMonth))
        .fold<int>(0, (sum, session) => sum + session.starsGenerated);
  }

  /// Calculate progress (0.0 to 1.0) for a given goal
  double calculateProgress(Goal goal, int currentValue) {
    if (goal.targetValue <= 0) return 0.0;
    return (currentValue / goal.targetValue).clamp(0.0, 1.0);
  }
}
