import 'package:cielo_estrellado/models/sessions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class SessionRepository {
  static const String boxName = "sessions";

  /// Guarda una sesión en Hive
  Future<void> saveSession(Session session) async {
    final box = await Hive.openBox<Session>(boxName);
    // Usar add() en lugar de put() para que Hive genere un ID válido automáticamente
    await box.add(session);
  }

  /// Devuelve todas las sesiones guardadas
  List<Session> getAllSessions() {
    final box = Hive.box<Session>(boxName);
    return box.values.toList();
  }

  Stream<List<Session>> watchSessions() async* {
    final box = await Hive.openBox<Session>(boxName);
    yield box.values.toList();
    await for (final _ in box.watch()) {
      yield box.values.toList();
    }
  }

  /// Borra todas las sesiones (útil para pruebas)
  Future<void> clearAll() async {
    final box = await Hive.openBox<Session>(boxName);
    await box.clear();
  }
}

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return SessionRepository();
});
