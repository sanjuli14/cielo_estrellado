import 'package:cielo_estrellado/features/stats/stats_aggregator.dart';
import 'package:cielo_estrellado/features/stats/stats_models.dart';
import 'package:cielo_estrellado/models/repositories/session_repositories.dart';
import 'package:cielo_estrellado/models/sessions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sessionsStreamProvider = StreamProvider<List<Session>>((ref) {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.watchSessions();
});

final statsAggregatorProvider = Provider<StatsAggregator>((ref) {
  return const StatsAggregator();
});

final weeklySummaryProvider = Provider<AsyncValue<PeriodSummary>>((ref) {
  final sessionsAsync = ref.watch(sessionsStreamProvider);
  final agg = ref.watch(statsAggregatorProvider);

  return sessionsAsync.whenData((sessions) {
    return agg.weeklySummary(sessions);
  });
});

final monthlySummaryProvider = Provider<AsyncValue<PeriodSummary>>((ref) {
  final sessionsAsync = ref.watch(sessionsStreamProvider);
  final agg = ref.watch(statsAggregatorProvider);

  return sessionsAsync.whenData((sessions) {
    return agg.monthlySummary(sessions);
  });
});
