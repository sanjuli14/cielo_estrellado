
import 'dart:io';
import 'dart:ui' as ui;

import 'package:cielo_estrellado/features/sky/constellation_provider.dart';
import 'package:cielo_estrellado/features/sky/constellations.dart';
import 'package:cielo_estrellado/features/sky/moon_phase_calculator.dart';
import 'package:cielo_estrellado/features/sky/sky_painter.dart';
import 'package:cielo_estrellado/features/timer/timer_controller.dart';
import 'package:cielo_estrellado/models/repositories/session_repositories.dart';
import 'package:cielo_estrellado/models/sessions.dart';
import 'package:cielo_estrellado/presentation/screen/stats/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> with SingleTickerProviderStateMixin {
  final GlobalKey _skyBoundaryKey = GlobalKey();
  bool _savedSessionForThisRun = false;
  bool _isSharing = false;
  bool _showHud = false;

  late final ProviderSubscription<WorkTimerState> _timerSub;
  late final AnimationController _twinkleController;

  @override
  void initState() {
    super.initState();

    _twinkleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )
      ..repeat();

    final sessionsRepo = ref.read(sessionRepositoryProvider);
    _timerSub = ref.listenManual<WorkTimerState>(
        workTimerProvider, (previous, next) async {
      final wasFinished = previous?.isFinished ?? false;
      if (next.isFinished && !wasFinished) {
        _savedSessionForThisRun = false;
      }

      if (next.isFinished && !_savedSessionForThisRun) {
        final startedAt = next.startedAt;
        final endedAt = next.endedAt;
        if (startedAt == null || endedAt == null) return;

        final starsGenerated = (3200 * next.skyProgress).round();
        final session = Session(
          id: endedAt.millisecondsSinceEpoch,
          startTime: startedAt,
          endTime: endedAt,
          durationMinutes: next.elapsed.inMinutes,
          starsGenerated: starsGenerated,
        );

        print('💾 Saving session: ${session.id}');
        print('   Start: ${session.startTime}');
        print('   End: ${session.endTime}');
        print('   Duration: ${session.durationMinutes} minutes');
        print('   Stars: ${session.starsGenerated}');

        await sessionsRepo.saveSession(session);
        _savedSessionForThisRun = true;

        print('✅ Session saved successfully!');
      }
    });
  }

  @override
  void dispose() {
    _timerSub.close();
    _twinkleController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final totalSeconds = d.inSeconds.clamp(0, 1 << 30);
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    if (hours > 0) {
      final hh = hours.toString().padLeft(2, '0');
      final mm = minutes.toString().padLeft(2, '0');
      final ss = seconds.toString().padLeft(2, '0');
      return '$hh:$mm:$ss';
    }
    final mm = minutes.toString().padLeft(2, '0');
    final ss = seconds.toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  Future<XFile?> _captureSky() async {
    final context = _skyBoundaryKey.currentContext;
    if (context == null) return null;

    final boundary = context.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final pixelRatio = MediaQuery
        .of(this.context)
        .devicePixelRatio;
    final image = await boundary.toImage(pixelRatio: pixelRatio);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    if (bytes == null) return null;

    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/night_sky_${DateTime
        .now()
        .millisecondsSinceEpoch}.png';
    final file = File(path);
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return XFile(file.path);
  }

  Future<void> _shareSky() async {
    if (_isSharing) return;
    setState(() {
      _isSharing = true;
    });

    try {
      await Future<void>.delayed(const Duration(milliseconds: 16));
      final xfile = await _captureSky();
      if (xfile == null) return;
      await Share.shareXFiles(
        [xfile],
        text: 'Asi es mi cielo, consigue el tuyo aqui: <URL>',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final timer = ref.watch(workTimerProvider);
    final controller = ref.read(workTimerProvider.notifier);
    final constellationsAsync = ref.watch(unlockedConstellationsProvider);

    final timeStyle = Theme
        .of(context)
        .textTheme
        .displaySmall
        ?.copyWith(
      fontWeight: FontWeight.bold,
      letterSpacing: 0.5,
      fontFamily: "Poppins",
    );

    final finishedStyle = Theme
        .of(context)
        .textTheme
        .displayMedium
        ?.copyWith(
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
    );

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragEnd: (details) {
          if (timer.isRunning) return;
          final v = details.primaryVelocity;
          if (v == null) return;
          if (v < -600) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const StatsScreen(),
              ),
            );
          }
        },
        onTapUp: (details) {
          if (timer.isRunning) return;
          if (timer.isFinished) return;

          // Check for constellation tap
          final constellations = constellationsAsync.asData?.value ?? [];
          final box = _skyBoundaryKey.currentContext
              ?.findRenderObject() as RenderBox?;
          if (box != null && constellations.isNotEmpty) {
            final localPos = box.globalToLocal(details.globalPosition);
            final size = box.size;

            for (final c in constellations) {
              // Simple bounding box or proximity check for points
              // Let's check proximity to any star point in the constellation
              for (final pt in c.points) {
                final cx = pt.x * size.width;
                final cy = pt.y * size.height;
                final dist = (Offset(cx, cy) - localPos).distance;
                if (dist < 30.0) { // Touch radius
                  // Show info
                  _showConstellationInfo(context, c);
                  return;
                }
              }
            }
          }

          setState(() {
            _showHud = !_showHud;
          });
        },
        onLongPress: () {
          if (timer.isRunning) return;
          if (timer.isFinished) {
            _shareSky();
            return;
          }
          controller.reset();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedBuilder(
                  animation: _twinkleController,
                  builder: (context, child) {
                    return RepaintBoundary(
                      key: _skyBoundaryKey,
                      child: CustomPaint(
                        painter: NightSkyPainter(
                          seed: timer.skySeed,
                          progress: timer.skyProgress,
                          twinkleValue: _twinkleController.value,
                          moonPhase: MoonPhaseCalculator.getMoonPhase(DateTime
                              .now()),
                          constellations: constellationsAsync.asData?.value ??
                              [],
                        ),
                      ),
                    );
                  }
              ),
            ),
            if(timer.isRunning == false)
            Positioned(
                top: 190,
                left: 270,
                child:Text(
                  "Fase Lunar",
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold
                  ) ,
                ),
            ),
            if (timer.isFinished)
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white.withOpacity(0.12)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '¡Sesión completada!',
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${timer.elapsed.inMinutes} minutos de foco',
                        style: finishedStyle?.copyWith(fontSize: 32),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${(3200 * timer.skyProgress)
                            .round()} estrellas generadas',
                        style: const TextStyle(
                          color: Color(0xFFFFD1A4),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 1,
                        width: 60,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'El cielo de hoy quedó completo. Compartelo con amigos',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

            // Start Ritual (Idle State)
            if (!timer.isRunning && !timer.isFinished)
              Align(
                alignment: Alignment.center,
                child: StreamBuilder<List<Session>>(
                  stream: ref.watch(sessionRepositoryProvider).watchSessions(),
                  builder: (context, snapshot) {
                    final sessions = snapshot.data ?? [];
                    Session? lastSession;
                    if (sessions.isNotEmpty) {
                      lastSession = sessions.last;
                    }

                    return IgnorePointer(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Esta noche vas por 45 minutos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (lastSession != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Última sesión: ${lastSession
                                  .durationMinutes} min — ${lastSession
                                  .starsGenerated} estrellas',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),


            if (_showHud && !timer.isFinished)
              Align(
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.30),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.white.withOpacity(
                            0.10)),
                      ),
                      child: Text(
                        _formatDuration(timer.elapsed),
                        style: timeStyle,
                      ),
                    ),
                  ),
                ),
              ),
            if(timer.isRunning == false)
              const Positioned(
                bottom: 120,
                right: 45,
                child: IgnorePointer(
                  child: Text(
                    'Desliza hacia arriba para ver estadisticas',
                    style: TextStyle(
                        fontFamily: "Poppins"
                    ),
                  ),
                ),
              ),

            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                minimum: const EdgeInsets.only(bottom: 28),
                child: timer.isFinished
                    ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: controller.toggle,
                      icon: const Icon(Icons.play_arrow_rounded),
                      iconSize: 34,
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white.withOpacity(0.10),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(18),
                      ),
                    ),
                    const SizedBox(width: 14),
                    IconButton(
                      onPressed: _isSharing ? null : _shareSky,
                      icon: const Icon(Icons.ios_share_rounded),
                      iconSize: 26,
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.white.withOpacity(0.10),
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(18),
                      ),
                    ),
                  ],
                )
                    : IconButton(
                  onPressed: controller.toggle,
                  icon: Icon(
                    timer.isRunning ? Icons.pause_rounded : Icons
                        .play_arrow_rounded,
                  ),
                  iconSize: 34,
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white.withOpacity(0.10),
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(18),
                  ),
                ),
              ),
            ),
            if (_isSharing)
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  minimum: const EdgeInsets.fromLTRB(24, 0, 24, 88),
                  child: LinearProgressIndicator(
                    minHeight: 2,
                    backgroundColor: Colors.white.withOpacity(0.06),
                    color: Colors.white.withOpacity(0.75),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showConstellationInfo(BuildContext context, Constellation c) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF0A0E21),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                c.name,
                style: Theme
                    .of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(
                  color: Colors.white,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Desbloqueada a las ${c.starsRequired} estrellas',
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                c.description,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}