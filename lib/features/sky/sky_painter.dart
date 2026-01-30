import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cielo_estrellado/features/sky/constellations.dart';
import 'package:flutter/material.dart';

class NightSkyPainter extends CustomPainter {
  final int seed;
  final int starCount;
  final int baseStars;
  final double twinkleValue; // 0.0 to 1.0
  final List<Constellation> constellations;

  NightSkyPainter({
    required this.seed,
    required this.starCount,
    this.baseStars = 0,
    this.twinkleValue = 0.0,
    this.constellations = const [],
  });

  Color _pickStarColor(math.Random rnd) {
    final t = rnd.nextDouble();
    if (t < 0.02) return const Color(0xFFA9C8FF);
    if (t < 0.10) return const Color(0xFFCFE2FF);
    if (t < 0.60) return const Color(0xFFFFFFFF);
    if (t < 0.85) return const Color(0xFFFFF0D6);
    if (t < 0.96) return const Color(0xFFFFD1A4);
    return const Color(0xFFFFB289);
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Milky Way gets stronger as you gather stars in the session.
    // Reaches full intensity at 3000 stars (~15 min).
    final mwStrength = (starCount / 3000).clamp(0.0, 1.0);

    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF000000),
          Color(0xFF020513),
          Color(0xFF050824),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawRect(Offset.zero & size, bgPaint);

    _paintMilkyWayDust(canvas, size, mwStrength);
    _paintStars(canvas, size);
    _paintConstellations(canvas, size);
    _paintVignette(canvas, size);
  }

  void _paintConstellations(Canvas canvas, Size size) {
    if (constellations.isEmpty) return;

    final base = size.shortestSide;
    final scale = base / 500;

    // Thin but bright lines
    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..strokeWidth = 0.15 * scale  // Thin lines
      ..style = PaintingStyle.stroke;

    // Small but bright constellation stars
    final starPaint = Paint()
      ..color = const Color(0xFFFFFFFF).withOpacity(0.8)  // Pure white for maximum brightness
      ..strokeWidth = 0.02 * scale  // Small but visible stars
      ..style = PaintingStyle.stroke;

    final glowPaint = Paint()..style = PaintingStyle.fill;

    for (final constellation in constellations) {
      // Scale down constellations to be more compact
      // Instead of using full screen coordinates, scale them to ~15% of screen size
      const constellationScale = 0.40;
      
      final screenPoints = constellation.points.map((pt) {
        // Calculate center of constellation
        final centerX = constellation.points.fold(0.0, (sum, p) => sum + p.x) / constellation.points.length;
        final centerY = constellation.points.fold(0.0, (sum, p) => sum + p.y) / constellation.points.length;
        
        // Scale points relative to center
        final scaledX = centerX + (pt.x - centerX) * constellationScale;
        final scaledY = centerY + (pt.y - centerY) * constellationScale;
        
        return Offset(scaledX * size.width, scaledY * size.height);
      }).toList();

      // Lines
      for (final line in constellation.lines) {
        if (line.startIndex < screenPoints.length &&
            line.endIndex < screenPoints.length) {
          canvas.drawLine(
            screenPoints[line.startIndex],
            screenPoints[line.endIndex],
            linePaint,
          );
        }
      }

      // Stars with intense multi-layer glow
      for (final point in screenPoints) {
        // Outer glow layer (large, subtle)
        glowPaint.shader = RadialGradient(
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.1),
            Colors.transparent,
          ],
        ).createShader(
          Rect.fromCircle(
            center: point,
            radius: 8.0 * scale,  // Large glow radius
          ),
        );
        canvas.drawCircle(point, 8.0 * scale, glowPaint);

        // Inner bright glow
        glowPaint.shader = RadialGradient(
          colors: [
            Colors.white.withOpacity(0.8),  // Very bright center
            Colors.white.withOpacity(0.4),
            Colors.transparent,
          ],
        ).createShader(
          Rect.fromCircle(
            center: point,
            radius: 3.0 * scale,
          ),
        );
        canvas.drawCircle(point, 3.0 * scale, glowPaint);

        // Core star (small but bright)
        canvas.drawCircle(
          point,
          0.5 * scale,  // Small core
          starPaint,
        );
      }
    }
  }


  void _paintVignette(Canvas canvas, Size size) {
    final vignette = Paint()
      ..shader = RadialGradient(
        center: Alignment.center,
        radius: 1.05,
        colors: [
          Colors.transparent,
          const Color(0xFF000000).withOpacity(0.18),
          const Color(0xFF000000).withOpacity(0.42),
        ],
        stops: const [0.0, 0.7, 1.0],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, vignette);
  }

  void _paintMilkyWayDust(Canvas canvas, Size size, double p) {
    if (p <= 0) return;

    final strength = (p - 0.08).clamp(0.0, 0.92) / 0.92;
    if (strength <= 0) return;

    final rnd = math.Random(seed ^ 0x6D2);

    final cx = size.width * 0.55;
    final cy = size.height * 0.55;
    final angle = -0.55;
    final dirX = math.cos(angle);
    final dirY = math.sin(angle);

    final bandHalfWidth = size.shortestSide * 0.22;
    final bandHalfLength = size.longestSide * 0.9;

    final cloudCount = (10 + (strength * 16)).round().clamp(0, 26);
    for (var i = 0; i < cloudCount; i++) {
      final t = (rnd.nextDouble() * 2 - 1) * bandHalfLength;
      final w = (rnd.nextDouble() * 2 - 1) * (bandHalfWidth * 0.6);

      final px = cx + dirX * t - dirY * w;
      final py = cy + dirY * t + dirX * w;

      final r = size.shortestSide * (0.18 + rnd.nextDouble() * 0.28);
      final warmMix = rnd.nextDouble();
      final tint = Color.lerp(
        const Color(0xFFB9CBE0),
        const Color(0xFFD7C6A8),
        warmMix,
      )!;

      final cloudPaint = Paint()
        ..shader = RadialGradient(
          colors: [
            tint.withOpacity(0.055 * strength),
            tint.withOpacity(0.0),
          ],
          stops: const [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: Offset(px, py), radius: r))
        ..blendMode = BlendMode.screen;

      canvas.drawCircle(Offset(px, py), r, cloudPaint);
    }

    final laneCount = (5 + (strength * 10)).round().clamp(0, 16);
    for (var i = 0; i < laneCount; i++) {
      final t = (rnd.nextDouble() * 2 - 1) * bandHalfLength;
      final w = (rnd.nextDouble() * 2 - 1) * (bandHalfWidth * 0.45);

      final px = cx + dirX * t - dirY * w;
      final py = cy + dirY * t + dirX * w;

      final r = size.shortestSide * (0.10 + rnd.nextDouble() * 0.22);
      final lanePaint = Paint()
        ..shader = RadialGradient(
          colors: [
            Colors.black.withOpacity(0.10 * strength),
            Colors.black.withOpacity(0.0),
          ],
          stops: const [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: Offset(px, py), radius: r));

      canvas.drawCircle(Offset(px, py), r, lanePaint);
    }

    final dustCount = (12000 * strength).round().clamp(0, 12000);
    final dustPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < dustCount; i++) {
      final t = (rnd.nextDouble() * 2 - 1) * bandHalfLength;
      final w = (rnd.nextDouble() * 2 - 1) * bandHalfWidth;

      final px = cx + dirX * t - dirY * w;
      final py = cy + dirY * t + dirX * w;

      if (px < -10 || py < -10 || px > size.width + 10 || py > size.height + 10) {
        continue;
      }

      final falloff = (1 - (w.abs() / bandHalfWidth)).clamp(0.0, 1.0);
      final grain = math.pow(rnd.nextDouble(), 1.8).toDouble();
      final baseAlpha = 2 + (26 * falloff * falloff * grain);
      final alpha = (baseAlpha * strength).round().clamp(0, 255);

      final color = _pickStarColor(rnd);
      dustPaint
        ..color = color.withAlpha(alpha)
        ..strokeWidth = 0.2 + rnd.nextDouble() * 0.5;

      canvas.drawPoints(ui.PointMode.points, [Offset(px, py)], dustPaint);
    }
  }

  void _paintStars(Canvas canvas, Size size) {
    final rnd = math.Random(seed);

    // Automatic generation: base stars (from history) + current session stars.
    // We only render 1% of base stars to avoid overcrowding, ensuring the sky grows forever
    // but remains visually balanced.
    final baseLayer = (baseStars * 0.01).round();
    final totalToRender = baseLayer + starCount;

    // Safety cap for performance (20,000 points is usually safe for 60fps)
    final count = totalToRender.clamp(0, 20000);

    final smallPaint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < count; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;

      final intensity = math.pow(rnd.nextDouble(), 3.8).toDouble();
      final color = _pickStarColor(rnd);

      // Twinkle calculation
      // We use i (star index) and random offsets so they don't twinkle in unison
      final twinkleOffset = rnd.nextDouble() * math.pi * 2;
      final twinkleSpeed = 0.5 + rnd.nextDouble() * 1.5; // vary speed
      
      // Sine wave -1 to 1 based on twinkleValue
      final wave = math.sin(twinkleValue * math.pi * 2 * twinkleSpeed + twinkleOffset);
      
      // Remap wave to a brightness multiplier, e.g., 0.7 to 1.3
      // Subtle blinking, not fully disappearing
      final twinkleFactor = 0.8 + (wave * 0.3);

      final radius = (0.15 + intensity * 1.05) * twinkleFactor;
      final baseAlpha = 15 + (intensity * 230);
      final alpha = (baseAlpha * twinkleFactor).round().clamp(0, 255);

      smallPaint
        ..color = color.withAlpha(alpha)
        ..strokeWidth = radius;

      canvas.drawPoints(ui.PointMode.points, [Offset(x, y)], smallPaint);
    }
  }

  @override
  bool shouldRepaint(covariant NightSkyPainter oldDelegate) {
    return oldDelegate.seed != seed || 
           oldDelegate.starCount != starCount ||
           oldDelegate.baseStars != baseStars ||
           oldDelegate.twinkleValue != twinkleValue ||
           oldDelegate.constellations != constellations;
  }
}
