import 'package:cielo_estrellado/features/stats/stats_aggregator.dart';
import 'package:cielo_estrellado/models/month_stats.dart';

import 'package:cielo_estrellado/models/period_summary.dart';
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

final weeklySummaryProvider = StreamProvider<PeriodSummary>((ref) {
  final agg = ref.watch(statsAggregatorProvider);
  final sessionsStream = ref.watch(sessionRepositoryProvider).watchSessions();
  
  return sessionsStream.map((sessions) {
    print('📅 Weekly: Processing ${sessions.length} sessions');
    for (var s in sessions) {
      print('  - Session: ${s.startTime} -> ${s.endTime}, ${s.durationMinutes}min');
    }
    final summary = agg.weeklySummary(sessions);
    print('📅 Weekly Summary: ${summary.sessions} sessions, ${summary.totalMinutes} minutes');
    return summary;
  });
});

final monthlySummaryProvider = StreamProvider<PeriodSummary>((ref) {
  final agg = ref.watch(statsAggregatorProvider);
  final sessionsStream = ref.watch(sessionRepositoryProvider).watchSessions();
  
  return sessionsStream.map((sessions) {
    print('📆 Monthly: Processing ${sessions.length} sessions');
    final summary = agg.monthlySummary(sessions);
    print('📆 Monthly Summary: ${summary.sessions} sessions, ${summary.totalMinutes} minutes');
    return summary;
  });
});

final last12MonthsSummaryProvider = StreamProvider<List<MonthStat>>((ref) {
  final agg = ref.watch(statsAggregatorProvider);
  final sessionsStream = ref.watch(sessionRepositoryProvider).watchSessions();

  return sessionsStream.map((sessions) {
    return agg.last12MonthsSummary(sessions);
  });
});
