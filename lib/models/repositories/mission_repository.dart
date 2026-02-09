import 'package:cielo_estrellado/models/mission.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MissionRepository {
  static const String boxName = 'missions';

  Future<Box<Mission>> get box async => Hive.box<Mission>(boxName);

  Future<void> saveMission(Mission mission) async {
    final b = await box;
    await b.put(mission.id, mission);
  }

  Future<List<Mission>> getActiveMissions() async {
    final b = await box;
    return b.values.toList();
  }

  Stream<List<Mission>> watchMissions() async* {
    final b = await box;
    yield b.values.toList();
    yield* b.watch().map((_) => b.values.toList());
  }

  Future<void> deleteMission(String id) async {
    final b = await box;
    await b.delete(id);
  }
}
