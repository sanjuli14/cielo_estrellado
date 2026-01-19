import 'package:cielo_estrellado/features/stats/stats_models.dart';
import 'package:cielo_estrellado/features/stats/stats_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  String _formatMinutes(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h > 0) {
      return '${h}h ${m}m';
    }
    return '${m}m';
  }

  String _formatDay(DateTime day) {
    const weekdays = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    final w = weekdays[(day.weekday - 1).clamp(0, 6)];
    return '$w ${day.day}/${day.month}';
  }

  Widget _summaryCard(BuildContext context, String title, PeriodSummary s) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF060816).withOpacity(0.65),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: textTheme.titleMedium),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _metric(context, 'Tiempo', _formatMinutes(s.totalMinutes)),
              ),
              Expanded(
                child: _metric(context, 'Sesiones', s.sessions.toString()),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _metric(
            context,
            'Promedio/día',
            _formatMinutes(s.averageMinutesPerDay.round()),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _metric(
                  context,
                  'Más',
                  s.bestDay == null
                      ? '-'
                      : '${_formatDay(s.bestDay!.day)} · ${_formatMinutes(s.bestDay!.minutes)}',
                ),
              ),
              Expanded(
                child: _metric(
                  context,
                  'Menos',
                  s.worstDay == null
                      ? '-'
                      : '${_formatDay(s.worstDay!.day)} · ${_formatMinutes(s.worstDay!.minutes)}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _metric(BuildContext context, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.labelMedium?.copyWith(
            color: Colors.white.withOpacity(0.70),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _dayList(BuildContext context, PeriodSummary s) {
    final items = [...s.byDay]..sort((a, b) => b.minutes.compareTo(a.minutes));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF060816).withOpacity(0.65),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Días (ranking)', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          for (final d in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _formatDay(d.day),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Text(
                    _formatMinutes(d.minutes),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _section(BuildContext context, AsyncValue<PeriodSummary> async, String title) {
    return async.when(
      data: (s) => Column(
        children: [
          _summaryCard(context, title, s),
          const SizedBox(height: 16),
          _dayList(context, s),
        ],
      ),
      error: (e, _) => Text('Error: $e'),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekly = ref.watch(weeklySummaryProvider);
    final monthly = ref.watch(monthlySummaryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            _section(context, weekly, 'Últimos 7 días'),
            const SizedBox(height: 20),
            _section(context, monthly, 'Este mes'),
          ],
        ),
      ),
    );
  }
}
