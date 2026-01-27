
import 'package:cielo_estrellado/features/sky/constellations.dart';
import 'package:cielo_estrellado/models/repositories/session_repositories.dart';
import 'package:cielo_estrellado/models/sessions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final totalStarsProvider = StreamProvider<int>((ref) {
  final repository = ref.watch(sessionRepositoryProvider);
  return repository.watchSessions().map((sessions) {
    return sessions.fold<int>(0, (sum, session) => sum + session.starsGenerated);
  });
});

final unlockedConstellationsProvider = Provider<AsyncValue<List<Constellation>>>((ref) {
  final totalStarsAsync = ref.watch(totalStarsProvider);

  return totalStarsAsync.whenData((totalStars) {
    return Constellation.all.where((c) => totalStars >= c.starsRequired).toList();
  });
});
