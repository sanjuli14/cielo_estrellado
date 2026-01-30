import 'package:cielo_estrellado/models/goal.dart';
import 'package:cielo_estrellado/models/goal_type.dart';
import 'package:hive/hive.dart';

class GoalRepository {
  static const String _boxName = 'goals';

  Future<Box<Goal>> _getBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<Goal>(_boxName);
    }
    return Hive.box<Goal>(_boxName);
  }

  Future<void> saveGoal(Goal goal) async {
    final box = await _getBox();
    await box.put(goal.id, goal);
  }

  Future<Goal?> getGoal(String id) async {
    final box = await _getBox();
    return box.get(id);
  }

  Future<List<Goal>> getActiveGoals() async {
    final box = await _getBox();
    return box.values.where((goal) => goal.isActive).toList();
  }

  Future<void> deleteGoal(String id) async {
    final box = await _getBox();
    await box.delete(id);
  }

  Stream<List<Goal>> watchActiveGoals() async* {
    final box = await _getBox();
    
    // Emit initial value
    yield _filterValidGoals(box.values.toList());
    
    // Listen to changes
    await for (final _ in box.watch()) {
      yield _filterValidGoals(box.values.toList());
    }
  }

  List<Goal> _filterValidGoals(List<Goal> goals) {
    return goals.where((goal) => goal.isActive).toList();
  }

  Future<void> cleanupOrphanedGoals() async {
    final box = await _getBox();
    final keysToDelete = <dynamic>[];

    for (var i = 0; i < box.length; i++) {
      final key = box.keyAt(i);
      final goal = box.get(key);
      
      if (goal != null) {
        // If the goal type name doesn't match its ID or if multiple goals exist for the same type,
        // we might want to clean up. But for now, let's just ensure the type is valid.
        // The read() in the adapter might have already remapped unknown types to a default.
        // However, we can at least ensure we only keep goals whose ID matches a valid GoalType name.
        final isValidType = GoalType.values.any((t) => t.name == goal.id);
        if (!isValidType) {
          keysToDelete.add(key);
        }
      }
    }

    if (keysToDelete.isNotEmpty) {
      print('🧹 Cleaning up ${keysToDelete.length} orphaned goals');
      await box.deleteAll(keysToDelete);
    }
  }

  Future<void> close() async {
    if (Hive.isBoxOpen(_boxName)) {
      await Hive.box<Goal>(_boxName).close();
    }
  }
}
