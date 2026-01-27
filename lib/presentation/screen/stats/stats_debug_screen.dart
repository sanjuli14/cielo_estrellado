import 'package:cielo_estrellado/models/repositories/session_repositories.dart';
import 'package:cielo_estrellado/models/sessions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatsDebugScreen extends ConsumerWidget {
  const StatsDebugScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(sessionRepositoryProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug - Sessions'),
      ),
      body: FutureBuilder<List<Session>>(
        future: Future.value(repo.getAllSessions()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final sessions = snapshot.data!;
          
          if (sessions.isEmpty) {
            return const Center(
              child: Text('No hay sesiones guardadas'),
            );
          }
          
          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return ListTile(
                title: Text('Sesión ${session.id}'),
                subtitle: Text(
                  'Inicio: ${session.startTime}\n'
                  'Fin: ${session.endTime}\n'
                  'Duración: ${session.durationMinutes} min\n'
                  'Estrellas: ${session.starsGenerated}',
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add a test session
          final now = DateTime.now();
          final session = Session(
            id: now.millisecondsSinceEpoch,
            startTime: now.subtract(const Duration(minutes: 25)),
            endTime: now,
            durationMinutes: 25,
            starsGenerated: 100,
          );
          await repo.saveSession(session);
          // Trigger rebuild
          (context as Element).markNeedsBuild();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
