import 'package:cielo_estrellado/features/goals/goal_providers.dart';
import 'package:cielo_estrellado/l10n/app_localizations.dart';
import 'package:cielo_estrellado/models/goal.dart';
import 'package:cielo_estrellado/models/goal_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoalsScreen extends ConsumerStatefulWidget {
  const GoalsScreen({super.key});

  @override
  ConsumerState<GoalsScreen> createState() => _GoalsScreenState();
}

class _GoalsScreenState extends ConsumerState<GoalsScreen> {
  final Map<GoalType, TextEditingController> _controllers = {};
  final Map<GoalType, bool> _activeStates = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadExistingGoals();
  }

  void _initializeControllers() {
    for (final type in GoalType.values) {
      _controllers[type] = TextEditingController();
      _activeStates[type] = false;
    }
  }

  Future<void> _loadExistingGoals() async {
    final repo = ref.read(goalRepositoryProvider);
    
    // Cleanup any orphaned goals from old versions
    await repo.cleanupOrphanedGoals();
    
    final goals = await repo.getActiveGoals();

    for (final goal in goals) {
      _controllers[goal.type]?.text = goal.targetValue.toString();
      _activeStates[goal.type] = goal.isActive;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _getGoalTitle(GoalType type) {
    switch (type) {
      case GoalType.starsPerMonth:
        return '⭐ Estrellas por mes';
      case GoalType.consecutiveDays:
        return '🔥 Días seguidos';
    }
  }

  String _getGoalHint(GoalType type) {
    switch (type) {
      case GoalType.starsPerMonth:
        return 'Ej: 100';
      case GoalType.consecutiveDays:
        return 'Ej: 7';
    }
  }

  String _getGoalUnit(GoalType type) {
    switch (type) {
      case GoalType.starsPerMonth:
        return 'estrellas';
      case GoalType.consecutiveDays:
        return 'días';
    }
  }

  Future<void> _saveGoals() async {
    final repo = ref.read(goalRepositoryProvider);

    for (final type in GoalType.values) {
      final isActive = _activeStates[type] ?? false;
      final text = _controllers[type]?.text ?? '';

      if (isActive && text.isNotEmpty) {
        final targetValue = int.tryParse(text) ?? 0;
        if (targetValue > 0) {
          final goal = Goal(
            id: type.name,
            type: type,
            targetValue: targetValue,
            isActive: true,
            createdAt: DateTime.now(),
          );
          await repo.saveGoal(goal);
        }
      } else {
        // Delete goal if deactivated
        await repo.deleteGoal(type.name);
      }
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Metas guardadas exitosamente'),
          backgroundColor: Color(0xFFFFD1A4),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0E21),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFFFD1A4),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Metas Personales',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  // Progress bars section
                  Consumer(
                    builder: (context, ref, child) {
                      final goalProgressAsync = ref.watch(goalProgressProvider);
                      final goalProgress = goalProgressAsync.asData?.value ?? [];

                      if (goalProgress.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Tu Progreso',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const SizedBox(height: 16),
                          ...goalProgress.map((progress) => _buildProgressBar(progress)),
                          const SizedBox(height: 32),
                          const Divider(color: Colors.white24),
                          const SizedBox(height: 24),
                        ],
                      );
                    },
                  ),
                  const Text(
                    'Define tus objetivos de productividad',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(height: 32),
                  ...GoalType.values.map((type) => _buildGoalCard(type)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveGoals,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD1A4),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Guardar Metas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(GoalType type) {
    final isActive = _activeStates[type] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive
              ? const Color(0xFFFFD1A4).withOpacity(0.3)
              : Colors.white.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getGoalTitle(type),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Switch(
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    _activeStates[type] = value;
                  });
                },
                activeColor: const Color(0xFFFFD1A4),
                activeTrackColor: const Color(0xFFFFD1A4).withOpacity(0.5),
                inactiveThumbColor: Colors.white70,
                inactiveTrackColor: Colors.transparent,
                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return null; // Use default for active
                  }
                  return Colors.white24; // Subtle border for inactive
                }),
              ),
            ],
          ),
          if (isActive) ...[
            const SizedBox(height: 16),
            TextField(
              controller: _controllers[type],
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
              decoration: InputDecoration(
                hintText: _getGoalHint(type),
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.3),
                  fontFamily: 'Poppins',
                ),
                suffixText: _getGoalUnit(type),
                suffixStyle: const TextStyle(
                  color: Colors.white54,
                  fontFamily: 'Poppins',
                ),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFFFFD1A4),
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBar(GoalProgress progress) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getGoalIcon(progress.goal.type),
                style: const TextStyle(fontSize: 20),
              ),
              Text(
                _getProgressText(progress),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress.progress,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF5C875)),
            ),
          ),
        ],
      ),
    );
  }

  String _getGoalIcon(GoalType type) {
    switch (type) {
      case GoalType.starsPerMonth:
        return '⭐';
      case GoalType.consecutiveDays:
        return '🔥';
    }
  }

  String _getProgressText(GoalProgress progress) {
    final current = progress.currentValue;
    final target = progress.goal.targetValue;

    switch (progress.goal.type) {
      case GoalType.starsPerMonth:
        return '$current - $target estrellas';
      case GoalType.consecutiveDays:
        return '$current - $target días';
    }
  }
}
