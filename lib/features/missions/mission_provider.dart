import 'package:cielo_estrellado/models/mission.dart';
import 'package:cielo_estrellado/models/sessions.dart';
import 'package:cielo_estrellado/models/repositories/mission_repository.dart';
import 'package:cielo_estrellado/features/stats/stats_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final missionRepositoryProvider = Provider<MissionRepository>((ref) {
  return MissionRepository();
});

final missionsStreamProvider = StreamProvider<List<Mission>>((ref) {
  final repo = ref.watch(missionRepositoryProvider);
  return repo.watchMissions();
});

final missionProvider = NotifierProvider<MissionNotifier, List<Mission>>(() {
  return MissionNotifier();
});

class MissionNotifier extends Notifier<List<Mission>> {
  @override
  List<Mission> build() {
    _initMissions();
    return [];
  }

  Future<void> _initMissions() async {
    final repo = ref.read(missionRepositoryProvider);
    final existing = await repo.getActiveMissions();
    
    if (existing.isEmpty) {
      // Create default missions
      final defaults = [
        Mission(
          id: 'focus_1',
          titleKey: 'missionFocus1',
          descriptionKey: 'missionFocus1Desc',
          targetValue: 1,
          type: MissionType.milestone,
        ),
        Mission(
          id: 'stars_500_daily',
          titleKey: 'missionStars500',
          descriptionKey: 'missionStars500Desc',
          targetValue: 500,
          type: MissionType.daily,
          lastReset: DateTime.now(),
        ),
      ];
      
      for (final m in defaults) {
        await repo.saveMission(m);
      }
      state = defaults;
    } else {
      state = existing;
    }
    
    _checkDailyReset();
  }

  Future<void> _checkDailyReset() async {
    final now = DateTime.now();
    final repo = ref.read(missionRepositoryProvider);
    bool changed = false;
    
    final updatedMissions = state.map((m) {
      if (m.type == MissionType.daily && m.lastReset != null) {
        final last = m.lastReset!;
        if (last.day != now.day || last.month != now.month || last.year != now.year) {
          changed = true;
          return m.copyWith(currentValue: 0, isCompleted: false, lastReset: now);
        }
      }
      return m;
    }).toList();
    
    if (changed) {
      for (final m in updatedMissions) {
        await repo.saveMission(m);
      }
      state = updatedMissions;
    }
  }

  Future<void> processSession(Session session) async {
    final repo = ref.read(missionRepositoryProvider);

    state = [
      for (final m in state)
        (() {
          double increment = 0;
          if (m.id == 'focus_1' && session.durationMinutes >= 20 && !m.isCompleted) {
            increment = 1;
          } else if (m.id == 'stars_500_daily') {
            increment = session.starsGenerated.toDouble();
          }

          if (increment > 0) {
            final newVal = m.currentValue + increment;
            final isComp = newVal >= m.targetValue;
            final updated = m.copyWith(currentValue: newVal, isCompleted: isComp);
            repo.saveMission(updated);
            return updated;
          }
          return m;
        })()
    ];
  }

  Future<void> updateProgress(String missionId, double increment) async {
    final repo = ref.read(missionRepositoryProvider);
    state = [
      for (final m in state)
        if (m.id == missionId)
          (() {
            final newVal = m.currentValue + increment;
            final isComp = newVal >= m.targetValue;
            final updated = m.copyWith(currentValue: newVal, isCompleted: isComp);
            repo.saveMission(updated);
            return updated;
          })()
        else
          m
    ];
  }
}
