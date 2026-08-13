import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/replay/replay_playback_controller.dart';
import 'package:sim_core/sim_core.dart';

BattleLog _log({int ticksUsed = 5}) => BattleLog(
      seed: 1,
      networkId: 'n',
      events: const [],
      result: BattleResult(
        ticksUsed: ticksUsed,
        dataExfiltrated: 0,
        logsDeleted: 0,
        cleanExits: 0,
        survivingCopies: 1,
        deadCopies: 0,
        tracePenalty: 0,
        score: 0,
        peakNoiseMeter: 0,
      ),
    );

void main() {
  test('starts paused at tick 0', () {
    final controller = ReplayPlaybackController(_log());
    expect(controller.isPlaying, isFalse);
    expect(controller.currentTick, 0);
  });

  test('seekTo clamps to [0, maxTick]', () {
    final controller = ReplayPlaybackController(_log(ticksUsed: 10));
    controller.seekTo(999);
    expect(controller.currentTick, 10);
    controller.seekTo(-5);
    expect(controller.currentTick, 0);
  });

  test('skipToResult pauses and jumps to the final tick', () {
    final controller = ReplayPlaybackController(_log(ticksUsed: 10));
    controller.play();
    controller.skipToResult();
    expect(controller.isPlaying, isFalse);
    expect(controller.currentTick, 10);
    controller.dispose();
  });

  test('play advances currentTick over time, then auto-pauses at maxTick', () async {
    final controller = ReplayPlaybackController(_log(ticksUsed: 3), baseIntervalMs: 5);
    controller.play();
    expect(controller.isPlaying, isTrue);

    // 3 ticks * 5ms + slack.
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(controller.currentTick, 3);
    expect(controller.isPlaying, isFalse);
    controller.dispose();
  });

  test('togglePlayPause flips state', () {
    final controller = ReplayPlaybackController(_log(), baseIntervalMs: 5);
    expect(controller.isPlaying, isFalse);
    controller.togglePlayPause();
    expect(controller.isPlaying, isTrue);
    controller.togglePlayPause();
    expect(controller.isPlaying, isFalse);
    controller.dispose();
  });

  test('play() restarts from 0 once already at the end', () async {
    final controller = ReplayPlaybackController(_log(ticksUsed: 2), baseIntervalMs: 5);
    controller.skipToResult();
    expect(controller.currentTick, 2);
    controller.play();
    expect(controller.currentTick, 0);
    controller.dispose();
  });
}
