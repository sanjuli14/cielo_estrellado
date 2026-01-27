import 'dart:async';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkTimerState {
  final Duration elapsed;
  final bool isRunning;
  final bool isFinished;
  final DateTime? startedAt;
  final DateTime? endedAt;
  final int skySeed;

  const WorkTimerState({
    required this.elapsed,
    required this.isRunning,
    required this.isFinished,
    required this.startedAt,
    required this.endedAt,
    required this.skySeed,
  });

  factory WorkTimerState.initial({required int skySeed}) {
    return WorkTimerState(
      elapsed: Duration.zero,
      isRunning: false,
      isFinished: false,
      startedAt: null,
      endedAt: null,
      skySeed: skySeed,
    );
  }

  int get sessionStars {
    // Generates 3 stars per second focuses on a linear, "automatic" feeling.
    // At 45 min (2700s) -> ~8100 stars. At 2 hours -> ~21600 stars.
    return (elapsed.inSeconds * 3);
  }

  WorkTimerState copyWith({
    Duration? elapsed,
    bool? isRunning,
    bool? isFinished,
    DateTime? startedAt,
    DateTime? endedAt,
    int? skySeed,
  }) {
    return WorkTimerState(
      elapsed: elapsed ?? this.elapsed,
      isRunning: isRunning ?? this.isRunning,
      isFinished: isFinished ?? this.isFinished,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      skySeed: skySeed ?? this.skySeed,
    );
  }
}

class WorkTimerController extends Notifier<WorkTimerState> {
  Timer? _ticker;

  @override
  WorkTimerState build() {
    ref.onDispose(() {
      _ticker?.cancel();
    });

    final seed = DateTime.now().millisecondsSinceEpoch;
    return WorkTimerState.initial(skySeed: seed);
  }

  void toggle() {
    if (state.isRunning) {
      finish();
      return;
    }

    if (state.isFinished) {
      reset();
      start();
      return;
    }

    if (state.startedAt == null) {
      start();
      return;
    }

    resume();
  }

  void start() {
    if (state.isRunning) return;
    final now = DateTime.now();
    state = state.copyWith(
      isRunning: true,
      isFinished: false,
      startedAt: now,
      endedAt: null,
      elapsed: Duration.zero,
    );

    _startTicker();
  }

  void pause() {
    finish();
  }

  void resume() {
    if (state.isRunning) return;
    if (state.isFinished) return;
    state = state.copyWith(isRunning: true);
    _startTicker();
  }

  void finish() {
    if (!state.isRunning) return;
    _ticker?.cancel();
    state = state.copyWith(
      isRunning: false,
      isFinished: true,
      endedAt: DateTime.now(),
    );
  }

  void stop() {
    finish();
  }

  void reset() {
    _ticker?.cancel();
    final seed = DateTime.now().millisecondsSinceEpoch;
    state = WorkTimerState.initial(skySeed: seed);
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      _tick();
    });
  }

  void _tick() {
    if (!state.isRunning) return;

    state = state.copyWith(elapsed: state.elapsed + const Duration(seconds: 1));
  }
}

final workTimerProvider = NotifierProvider<WorkTimerController, WorkTimerState>(
  WorkTimerController.new,
);
