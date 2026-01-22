import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:cielo_estrellado/features/sky/constellations.dart';
import 'package:flutter/material.dart';

class NightSkyPainter extends CustomPainter {
  final int seed;
  final double progress;
  final double twinkleValue; // 0.0 to 1.0
  final double moonPhase; // 0.0 to 1.0
  final List<Constellation> constellations;

  NightSkyPainter({
    required this.seed,
    required this.progress,
    this.twinkleValue = 0.0,
    this.moonPhase = 0.0,
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
    final p = progress.clamp(0.0, 1.0);

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

    _paintMoon(canvas, size);
    _paintMilkyWayDust(canvas, size, p);
    _paintStars(canvas, size, p);
    _paintConstellations(canvas, size);
    _paintVignette(canvas, size);
  }

  void _paintConstellations(Canvas canvas, Size size) {
    if (constellations.isEmpty) return;

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..strokeWidth = 0.4
      ..style = PaintingStyle.stroke;

    final starPaint = Paint()
      ..color = const Color(0xFFCAE5FF)
      ..style = PaintingStyle.fill;
      
    final glowPaint = Paint()
      ..style = PaintingStyle.fill;

    for (final constellation in constellations) {
       // Convert normalized points to screen coordinates
       final screenPoints = constellation.points.map((pt) {
         return Offset(pt.x * size.width, pt.y * size.height);
       }).toList();

       // Draw Lines
       for (final line in constellation.lines) {
         if (line.startIndex < screenPoints.length && line.endIndex < screenPoints.length) {
            canvas.drawLine(screenPoints[line.startIndex], screenPoints[line.endIndex], linePaint);
         }
       }

       // Draw Stars
       for (final point in screenPoints) {
          // Glow
          glowPaint.shader = RadialGradient(
            colors: [
              Colors.white.withOpacity(0.25),
              Colors.transparent,
            ],
          ).createShader(Rect.fromCircle(center: point, radius: 3));
          canvas.drawCircle(point, 3, glowPaint);

          // Core
          canvas.drawCircle(point, 0.5, starPaint);
       }
    }
  }

  void _paintMoon(Canvas canvas, Size size) {
    // Position: Top right, but slightly inset
    final cx = size.width * 0.8;
    final cy = size.height * 0.2;
    final radius = size.shortestSide * 0.04;

    final moonCenter = Offset(cx, cy);

    // Glow
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFE0E0E0).withOpacity(0.15),
          const Color(0xFFE0E0E0).withOpacity(0.0),
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: moonCenter, radius: radius * 2));
    canvas.drawCircle(moonCenter, radius * 2, glowPaint);

    // Base Moon (lit part)
    final moonPaint = Paint()..color = const Color(0xFFEADDCA); // Bone white/cream
    
    // Logic to draw phase:
    // We start with a full circle path
    final moonPath = Path()..addOval(Rect.fromCircle(center: moonCenter, radius: radius));

    // Calculate shadow offset to simulate phase
    // 0.0 = New Moon (Fully shadowed)
    // 0.5 = Full Moon (No shadow)
    // 1.0 = New Moon (Fully shadowed)
    
    // We can simulate phases by subtracting another circle (the shadow) moving across
    
    // Simplified rendering for "realistic" enough feel:
    // Use the cosine of the phase to determine how much "shadow" circle overlaps
    
    // Actually, a better approach for crescents is usually scaling a circle
    // But let's try a masking approach which is robust.
    
    // Let's use a simpler visual approximation:
    // We draw the full moon, then draw a "shadow" circle on top of it.
    
    // Actually, drawing the LIT part is safer to avoid artifacts with the background starfield if we drew black shadow.
    // But we are painting ON TOP of background, so we can't draw "black" as shadow, it would obscure stars behind the moon (which is correct physics, but maybe tricky).
    // The moon (and its dark side) should obscure stars.
    
    // So:
    // 1. Draw a black circle (the dark side) to obscure stars behind the moon.
    final darkSidePaint = Paint()..color = const Color(0xFF050810); // Match approx sky color or just black
    canvas.drawCircle(moonCenter, radius, darkSidePaint);

    // 2. Draw the lit part on top.
    
    // Phase 0..1
    // 0 = New (0% lit)
    // 0.25 = First Quarter (50% lit, right side)
    // 0.5 = Full (100% lit)
    // 0.75 = Last Quarter (50% lit, left side)
    
    // We can use an arc combined with a semi-ellipse.
    
    canvas.save();
    canvas.translate(cx, cy);
    // Rotate to match typical ecliptic angle if we wanted, but upright is fine for now.

    if (moonPhase <= 0.5) {
      // Waxing (New -> Full)
      // Light is growing from Right side. 
      // Actually standard view: New -> First Q -> Full
      // Visual: ) -> D -> O
      
      // We will draw the lit portion.
      // Normalize phase 0.0 -> 0.5 to 0.0 -> 1.0
      final progress = moonPhase / 0.5; 
      
      // We can use drawArc for the outer edge, and a curve for the terminator.
      
      final rect = Rect.fromCircle(center: Offset.zero, radius: radius);
      
      if (progress < 0.05) {
         // New moon, essentially invisible
      } else {
        // Draw standard crescent to gibbous logic is complex with paths. 
        // Let's us a shadow mask trick instead? 
        // It's harder without blending modes impacting the whole layer.
        
        // Let's stick to simple Path operations.
        final path = Path();
        
        // Right semicircle (always lit during 0->0.5? No, First Q is 0.25)
        // 0.0 -> 0.5:
        // 0.25 is exactly half moon (Right side lit).
        // < 0.25 is Crescent (Right sliver).
        // > 0.25 is Gibbous (Right side + bulge to left).

        path.addArc(rect, -math.pi / 2, math.pi); // Right semicircle
        
        // The terminator curve:
        // Starts at top (0, -r), ends at bottom (0, r).
        // Control point x varies.
        // At 0.0 phase (New), x = radius (pushes right to edge).
        // At 0.25 phase (Half), x = 0 (straight line).
        // At 0.5 phase (Full), x = -radius (pushes left to edge).
        
        double xControl = radius * (1 - 4 * moonPhase); 
        // phase 0 => r (correct, curve hides right side -> empty) -- wait.
        // If we draw right semicircle, and then SUBTRACT the left-bulging curve?
        
        // Let's construct the LIT path.
        final litPath = Path();
        litPath.moveTo(0, -radius);
        litPath.arcToPoint(Offset(0, radius), radius: Radius.circular(radius), clockwise: true); // Right arc
        
        // Now return to top via the terminator.
        // We use an elliptical arc for the terminator.
        // Width of ellipse depends on phase.
        
        // Width from center. 
        // Phase 0.0 -> width = -radius (curve touches right edge, area 0)
        // Phase 0.25 -> width = 0 (straight line)
        // Phase 0.5 -> width = radius (curve touches left edge, full circle)
        
        double w = radius * (2 * progress - 1); 
        // p=0 -> -r. p=0.5 -> 0. p=1 -> r.
        
        // We need to draw a semi-ellipse from (0, r) back to (0, -r).
        // If w > 0, we bulge left (Gibbous).
        // If w < 0, we bulge right (Crescent), cutting into the semicircle? 
        // Wait, if w < 0 (Crescent), the lit part is the crescent. 
        // My logic for right semicircle assumes Gibbous or Half.
        
        // Correct logic for Waxing (0 -> 0.5):
        // Lit part is always on the right.
        // Boundary is standard circle on right.
        // Terminator moves from right edge to left edge.
        
        final terminator = Path();
        terminator.moveTo(0, -radius);
        
        // Draw ellipse arc
        // Rect for ellipse: 
        // Center (0,0). Width |w|*2. Height r*2.
        
        if (w == 0) {
           terminator.lineTo(0, radius); // Straight line
        } else {
           // If w < 0 (Crescent), we want to curve to the right. 
           // If w > 0 (Gibbous), we want to curve to the left.
           
           // arcToPoint doesn't do ellipses easily.
           // We can verify scale.
           
           // Simplified: Use scaling.
           final tPath = Path();
           tPath.moveTo(0, -radius);
           tPath.arcToPoint(Offset(0, radius), radius: Radius.circular(radius), clockwise: w > 0); 
           // If w > 0 (Gibbous), clockwise from top goes Right? No.
           // Top (0,-r) to Bottom (0,r). 
           // Clockwise goes via Right. Counter-Clockwise via Left.
           
           // We want curve to pass through (-w, 0).
           // If phase is 0.5 (Full), w=r. We want (-r, 0). That is Left side. Counter-Clockwise!
           
           // If phase is 0.25 (Half), w=0. Straight.
           
           // If phase is 0 (New), w=-r. We want (r, 0). That is Right side. Clockwise!
           
           // So if w > 0 (Gibbous), we want CCW (Left bulge).
           // If w < 0 (Crescent), we want CW (Right bulge).
           
           // But wait, if w < 0 (Crescent), we are drawing the terminator for the crescent. 
           // The lit path is Right Semicircle MINUS the gap? 
           // OR Lit path is just the crescent.
           
           // Let's perform a transformation trick.
           // Draw a generic half-circle. Scale X.
           
           // Re-think:
           // Always draw Right Semicircle.
           // Then Add/Subtract the semi-ellipse on the left/right of the Y axis.
           
           // Actually, simpler:
           // 1. Draw Right Semicircle (White).
           // 2. If Gibbous (0.25 < p < 0.5): Draw Left Semi-Ellipse (White).
           // 3. If Crescent (0 < p < 0.25): Draw Right Semi-Ellipse (Black/Dark).
           
           // Let's refine limits.
           // p=0.0 -> w = -1 (New). 
           // p=0.25 -> w=0 (Half).
           // p=0.5 -> w=1 (Full).
           
           final hemi = Path()
             ..addArc(rect, -math.pi/2, math.pi); // Right hemi
           canvas.drawPath(hemi, moonPaint);
           
           double wNorm = (moonPhase - 0.25) / 0.25; // -1 to 1
           
           if (wNorm.abs() > 0.01) {
             final ellipseRect = Rect.fromLTWH(-radius * wNorm.abs(), -radius, radius * wNorm.abs() * 2, radius * 2);
             final ellipse = Path()..addOval(ellipseRect);
             
             // We only want the LEFT half of the ellipse logic... wait.
             // If wNorm > 0 (Gibbous): We want the left half of the ellipse to be WHITE.
             // If wNorm < 0 (Crescent): We want the right half of the ellipse to be DARK (cutting into the white hemi).
             
             // Since we just drew the ellipse, we need to clip it?
             // Actually drawing the full oval is fine if we clip half?
             
             canvas.save();
             // Clip to Left side of Y-axis if Gibbous (white addition)
             // Clip to Right side of Y-axis if Crescent (dark subtraction)
             
             if (wNorm > 0) {
               // Gibbous: Add white bulge on left
               canvas.clipRect(Rect.fromLTWH(-radius, -radius, radius, radius * 2)); // Left rect
               canvas.drawPath(ellipse, moonPaint);
             } else {
               // Crescent: Subtract white bulge on right (draw dark)
               canvas.clipRect(Rect.fromLTWH(0, -radius, radius, radius * 2)); // Right rect
               canvas.drawPath(ellipse, darkSidePaint);
             }
             canvas.restore();
           }
        }
      }
    } else {
      // Waning (Full -> New)
      // Light is shrinking from Right side? No.
      // Full -> Last Q -> New.
      // O -> C -> (
      // Lit part is on the LEFT.
      
      final rect = Rect.fromCircle(center: Offset.zero, radius: radius);
      
      // 1. Draw Left Semicircle (White).
      final hemi = Path()
         ..addArc(rect, math.pi/2, math.pi); // Left hemi
      canvas.drawPath(hemi, moonPaint);
      
      // p goes 0.5 -> 1.0.
      // p=0.5 (Full) -> w=1. 
      // p=0.75 (Last Q) -> w=0.
      // p=1.0 (New) -> w=-1.
      
      double wNorm = (0.75 - moonPhase) / 0.25; 
      // p=0.5 -> (0.25)/0.25 = 1 (Gibbous equivalent)
      // p=0.75 -> 0
      // p=1.0 -> -1 (Crescent equivalent)
      
       if (wNorm.abs() > 0.01) {
           final ellipseRect = Rect.fromLTWH(-radius * wNorm.abs(), -radius, radius * wNorm.abs() * 2, radius * 2);
           final ellipse = Path()..addOval(ellipseRect);
           
           canvas.save();
           if (wNorm > 0) {
             // Gibbous (Waning Gibbous): Add white bulge on RIGHT.
             canvas.clipRect(Rect.fromLTWH(0, -radius, radius, radius * 2)); // Right rect
             canvas.drawPath(ellipse, moonPaint);
           } else {
             // Crescent (Waning Crescent): Subtract white bulge on LEFT (draw dark).
             canvas.clipRect(Rect.fromLTWH(-radius, -radius, radius, radius * 2)); // Left rect
             canvas.drawPath(ellipse, darkSidePaint);
           }
           canvas.restore();
       }
    }

    canvas.restore();
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

    final dustCount = (9000 * strength).round().clamp(0, 9000);
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
        ..strokeWidth = 0.4 + rnd.nextDouble() * 0.9;

      canvas.drawPoints(ui.PointMode.points, [Offset(px, py)], dustPaint);
    }
  }

  void _paintStars(Canvas canvas, Size size, double p) {
    final rnd = math.Random(seed);

    final maxStars = ((size.width * size.height) / 1100).round().clamp(1200, 3200);
    final count = (maxStars * p).round().clamp(0, maxStars);

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

      final radius = (0.18 + intensity * 1.10) * twinkleFactor;
      final baseAlpha = 10 + (intensity * 215);
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
           oldDelegate.progress != progress ||
           oldDelegate.twinkleValue != twinkleValue ||
           oldDelegate.moonPhase != moonPhase ||
           oldDelegate.constellations != constellations;
  }
}
