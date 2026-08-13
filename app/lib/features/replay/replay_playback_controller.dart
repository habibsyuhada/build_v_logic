import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sim_core/sim_core.dart';

/// Drives replay playback (§3.4): play/pause, speed 1x/2x/4x, skip-to-result,
/// scrub. Framework-agnostic — the Flame game and any UI overlay both just
/// read [currentTick].
class ReplayPlaybackController extends ChangeNotifier {
  final BattleLog log;
  final int baseIntervalMs;

  int currentTick = 0;
  bool isPlaying = false;
  double speed = 1.0;
  Timer? _timer;

  ReplayPlaybackController(this.log, {this.baseIntervalMs = 200});

  int get maxTick => log.result.ticksUsed;

  List<BattleEvent> get eventsAtCurrentTick =>
      log.events.where((e) => e.tick == currentTick).toList();

  void play() {
    if (currentTick >= maxTick) currentTick = 0;
    isPlaying = true;
    _scheduleNext();
    notifyListeners();
  }

  void pause() {
    isPlaying = false;
    _timer?.cancel();
    notifyListeners();
  }

  void togglePlayPause() => isPlaying ? pause() : play();

  void setSpeed(double newSpeed) {
    speed = newSpeed;
    if (isPlaying) {
      _timer?.cancel();
      _scheduleNext();
    }
    notifyListeners();
  }

  void skipToResult() {
    _timer?.cancel();
    isPlaying = false;
    currentTick = maxTick;
    notifyListeners();
  }

  void seekTo(int tick) {
    currentTick = tick.clamp(0, maxTick);
    notifyListeners();
  }

  void _scheduleNext() {
    if (!isPlaying) return;
    final intervalMs = (baseIntervalMs / speed).round();
    _timer = Timer(Duration(milliseconds: intervalMs), () {
      if (currentTick >= maxTick) {
        pause();
        return;
      }
      currentTick++;
      notifyListeners();
      _scheduleNext();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
