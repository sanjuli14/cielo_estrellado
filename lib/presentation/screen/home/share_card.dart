
import 'dart:math' as math;
import 'package:cielo_estrellado/features/sky/constellations.dart';
import 'package:cielo_estrellado/features/sky/moon_phase_calculator.dart';
import 'package:cielo_estrellado/features/sky/sky_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ShareCard extends StatelessWidget {
  final int seed;
  final int starCount;
  final int baseStars;
  final double twinkleValue;
  final List<Constellation> constellations;
  final int sessionStars;
  final int sessionDuration;
  final int streakDays;
  final DateTime date;

  const ShareCard({
    super.key,
    required this.seed,
    required this.starCount,
    required this.baseStars,
    required this.twinkleValue,
    required this.constellations,
    required this.sessionStars,
    required this.sessionDuration,
    required this.streakDays,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    // Compact card size - not fullscreen
    const width = 800.0;
    const height = 300.0;
    final moonPhaseValue = MoonPhaseCalculator.getMoonPhase(DateTime.now());
    final moonPhaseEnum = MoonPhaseCalculator.getPhaseName(moonPhaseValue);
    final moonPhaseLabel = MoonPhaseCalculator.getMoonPhaseLabel(moonPhaseEnum);

    return ClipRRect(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          // Solid dark background for the card itself
          color: const Color(0xFF0A0E21),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
          child: Stack(
            children: [
              // Sky background in upper portion
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   right: 0,
              //   height: height * 0.45,
              //   child: ClipRRect(
              //     borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(48),
              //       topRight: Radius.circular(48),
              //     ),
              //     child: CustomPaint(
              //       painter: NightSkyPainter(
              //         seed: seed,
              //         starCount: starCount,
              //         baseStars: baseStars,
              //         twinkleValue: twinkleValue,
              //         constellations: constellations,
              //       ),
              //     ),
              //   ),
              // ),

              // Gradient overlay on sky
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: height * 0.45,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        const Color(0xFF0A0E21),
                      ],
                    ),
                  ),
                ),
              ),

              // Border
              // Positioned.fill(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(48),
              //       border: Border.all(
              //         color: Colors.white.withOpacity(0.65),
              //         width: 1,
              //       ),
              //     ),
              //   ),
              // ),

              // Content
              Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'FOCUS NIGHT',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              moonPhaseLabel.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                letterSpacing: 1.5,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              DateFormat('MMMM d, yyyy').format(date),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Image.asset('assets/icon/iconor.png', width: 60, height: 60,)
                      ],
                    ),

                    const Spacer(),
                    // Stats section
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildStat(
                                label: 'Estrellas',
                                value: '+$sessionStars',
                                color: const Color(0xFFFFD1A4),
                              ),
                              const SizedBox(height: 16),
                              _buildStat(
                                label: 'Tiempo',
                                value: _formatDuration(sessionDuration),
                                color: const Color(0xFFCAE5FF),
                              ),
                              const SizedBox(height: 16),
                              _buildStat(
                                label: 'Racha',
                                value: '$streakDays Dias',
                                color: const Color(0xFFFFD1A4),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
    );
  }

  Widget _buildStat({
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
            color: color,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.0,
          ),
        ),
      ],
    );
  }

  String _formatDuration(int minutes) {
    final h = minutes ~/ 60;
    final m = minutes % 60;
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }
}
