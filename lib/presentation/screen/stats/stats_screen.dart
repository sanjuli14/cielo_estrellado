
import 'package:cielo_estrellado/features/sky/constellation_provider.dart';
import 'package:cielo_estrellado/features/sky/constellations.dart';
import 'package:cielo_estrellado/features/stats/stats_providers.dart';
import 'package:cielo_estrellado/models/month_stats.dart';
import 'package:cielo_estrellado/models/period_summary.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:cielo_estrellado/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekly = ref.watch(weeklySummaryProvider);
    final monthlyStars = ref.watch(last12MonthsSummaryProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.statsTitle, 
          style: TextStyle(
            fontFamily: "Poppins", 
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          )),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
          children: [
            _DailyHoursSection(data: weekly),
            const SizedBox(height: 24),
            _MonthlyStarsSection(data: monthlyStars),
            const SizedBox(height: 24),
            const _ConstellationsCatalogSection(),
          ],
        ),
      ),
    );
  }
}

class _DailyHoursSection extends StatelessWidget {
  final AsyncValue<PeriodSummary> data;

  const _DailyHoursSection({required this.data});

  @override
  Widget build(BuildContext context) {
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
          Text(AppLocalizations.of(context)!.statsDailyHours, 
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.045,
            )),
          const SizedBox(height: 24),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25, // Dynamic height
            child: data.when(
              data: (summary) => _DailyHoursChart(summary: summary),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text(AppLocalizations.of(context)!.statsError(e.toString()))),
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyStarsSection extends StatelessWidget {
  final AsyncValue<List<MonthStat>> data;

  const _MonthlyStarsSection({required this.data});

  @override
  Widget build(BuildContext context) {
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
          Text(AppLocalizations.of(context)!.statsMonthlyStars, 
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.045,
            )),
          const SizedBox(height: 24),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25, // Dynamic height
            child: data.when(
              data: (stats) => _MonthlyStarsChart(stats: stats),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) => Center(child: Text(AppLocalizations.of(context)!.statsError(e.toString()))),
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyHoursChart extends StatelessWidget {
  final PeriodSummary summary;

  const _DailyHoursChart({required this.summary});

  @override
  Widget build(BuildContext context) {
    // Generate data for the last 7 days
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final days = List.generate(7, (index) {
      final d = today.subtract(Duration(days: 6 - index));
      return d;
    });

    // Create a map for quick lookup
     final statsMap = {for (var s in summary.byDay) DateTime(s.day.year, s.day.month, s.day.day): s};

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _calculateMaxHours(summary).toDouble(),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final day = days[groupIndex];
              final minutes = rod.toY * 60;
              final locale = Localizations.localeOf(context).languageCode;
              return BarTooltipItem(
                '${DateFormat.E(locale).format(day)}\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${minutes.toInt()} ${AppLocalizations.of(context)!.statsUnitMin}',
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                 final index = value.toInt();
                if (index < 0 || index >= days.length) return const SizedBox.shrink();
                final day = days[index];
                final locale = Localizations.localeOf(context).languageCode;
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    DateFormat.E(locale).format(day)[0].toUpperCase(), // First letter of day
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const SizedBox.shrink();
                return Text(
                  '${value.toInt()}h',
                  style: const TextStyle(color: Colors.white30, fontSize: 10),
                );
              },
              reservedSize: 30,
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.white.withOpacity(0.1),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: days.asMap().entries.map((entry) {
          final index = entry.key;
          final day = entry.value;
          // Normalize day key
          final dayKey = DateTime(day.year, day.month, day.day);
          final stat = statsMap[dayKey];
          final hours = stat != null ? stat.minutes / 60.0 : 0.0;

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: hours,
                color: Colors.blueAccent,
                width: 16,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: _calculateMaxHours(summary).toDouble(), 
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  int _calculateMaxHours(PeriodSummary summary) {
     double maxMinutes = 0;
     for (var s in summary.byDay) {
       if (s.minutes > maxMinutes) maxMinutes = s.minutes.toDouble();
     }
     // Add some buffer
     return (maxMinutes / 60).ceil() + 1;
  }
}


class _MonthlyStarsChart extends StatelessWidget {
  final List<MonthStat> stats;

  const _MonthlyStarsChart({required this.stats});

  @override
  Widget build(BuildContext context) {
    if (stats.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.statsNoData));
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: _calculateMaxStars(stats).toDouble(),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            // tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final stat = stats[groupIndex];
              final locale = Localizations.localeOf(context).languageCode;
              return BarTooltipItem(
                '${DateFormat.MMM(locale).format(stat.month)}\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${stat.totalStars} ${AppLocalizations.of(context)!.statsUnitStars}',
                     style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= stats.length) return const SizedBox.shrink();
                 // Show every other month if too many, or just letter?
                 // Let's show first letter of month
                final stat = stats[index];
                final locale = Localizations.localeOf(context).languageCode;
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    DateFormat.MMM(locale).format(stat.month).toUpperCase(),
                    style: const TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const SizedBox.shrink();
                 return Text(
                  meta.formattedValue,
                  style: const TextStyle(color: Colors.white30, fontSize: 10),
                );
              },
              reservedSize: 30,
            ),
          ),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
           getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.white.withOpacity(0.1),
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: stats.asMap().entries.map((entry) {
          final index = entry.key;
          final stat = entry.value;
          
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: stat.totalStars.toDouble(),
                color: Colors.amber, 
                width: 12,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                 backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: _calculateMaxStars(stats).toDouble(),
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  int _calculateMaxStars(List<MonthStat> stats) {
    int max = 0;
    for (var s in stats) {
      if (s.totalStars > max) max = s.totalStars;
    }
    // Add buffer
    return max + (max * 0.2).ceil() + 5; 
  }
}

class _ConstellationsCatalogSection extends ConsumerWidget {
  const _ConstellationsCatalogSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalStarsAsync = ref.watch(totalStarsProvider);
    final unlockedAsync = ref.watch(unlockedConstellationsProvider);
    final allConstellations = Constellation.all;

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Catálogo de Constelaciones",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              totalStarsAsync.when(
                data: (total) => Text(
                  "$total ★",
                  style: const TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          unlockedAsync.when(
            data: (unlocked) {
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allConstellations.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final constellation = allConstellations[index];
                  final isUnlocked = unlocked.any((c) => c.id == constellation.id);
                  
                  return _ConstellationItem(
                    constellation: constellation,
                    isUnlocked: isUnlocked,
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, __) => Text("Error: $e"),
          ),
        ],
      ),
    );
  }
}

class _ConstellationItem extends StatelessWidget {
  final Constellation constellation;
  final bool isUnlocked;

  const _ConstellationItem({
    required this.constellation,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: isUnlocked ? 1.0 : 0.4,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isUnlocked 
              ? Colors.white.withOpacity(0.05) 
              : Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isUnlocked 
                ? Colors.amber.withOpacity(0.3) 
                : Colors.white.withOpacity(0.05),
            width: isUnlocked ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isUnlocked ? Colors.amber.withOpacity(0.1) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isUnlocked ? Icons.auto_awesome : Icons.lock_outline,
                  color: isUnlocked ? Colors.amber : Colors.white24,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    constellation.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: isUnlocked ? FontWeight.bold : FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isUnlocked ? "¡Desbloqueada!" : "Requiere ${constellation.starsRequired} estrellas",
                    style: TextStyle(
                      color: isUnlocked ? Colors.amber : Colors.white38,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isUnlocked)
              const Icon(
                Icons.check_circle,
                color: Colors.amber,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
