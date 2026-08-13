import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/replay/flame/replay_frame.dart';
import 'package:sim_core/sim_core.dart';

BattleLog _logWith(List<BattleEvent> events) => BattleLog(
      seed: 1,
      networkId: 'n',
      events: events,
      result: const BattleResult(
        ticksUsed: 5,
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
  test('spawn event places the virus at its spawn node', () {
    final log = _logWith([
      const BattleEvent(tick: 0, type: 'virus_spawned', data: {'virus_id': 1, 'node_id': 'entry'}),
    ]);
    final frame = computeReplayFrame(log, 0);
    expect(frame.virusPositions[1], 'entry');
    expect(frame.deadVirusIds, isEmpty);
  });

  test('later move events override earlier position, up to the requested tick', () {
    final log = _logWith([
      const BattleEvent(tick: 0, type: 'virus_spawned', data: {'virus_id': 1, 'node_id': 'entry'}),
      const BattleEvent(tick: 1, type: 'virus_moved', data: {'virus_id': 1, 'node_id': 'r1'}),
      const BattleEvent(tick: 2, type: 'virus_moved', data: {'virus_id': 1, 'node_id': 'r2'}),
    ]);
    expect(computeReplayFrame(log, 1).virusPositions[1], 'r1');
    expect(computeReplayFrame(log, 2).virusPositions[1], 'r2');
    // Events beyond the requested tick must not leak in.
    expect(computeReplayFrame(log, 0).virusPositions[1], 'entry');
  });

  test('a dead virus is reported in deadVirusIds', () {
    final log = _logWith([
      const BattleEvent(tick: 0, type: 'virus_spawned', data: {'virus_id': 1, 'node_id': 'entry'}),
      const BattleEvent(tick: 3, type: 'virus_died', data: {'virus_id': 1, 'node_id': 'entry'}),
    ]);
    final frame = computeReplayFrame(log, 3);
    expect(frame.deadVirusIds, contains(1));
  });

  test('replicate places the child at the parent\'s current node', () {
    final log = _logWith([
      const BattleEvent(tick: 0, type: 'virus_spawned', data: {'virus_id': 1, 'node_id': 'entry'}),
      const BattleEvent(tick: 1, type: 'virus_moved', data: {'virus_id': 1, 'node_id': 'r1'}),
      const BattleEvent(
          tick: 2, type: 'virus_replicated', data: {'parent_id': 1, 'child_id': 2, 'node_id': 'r1'}),
    ]);
    final frame = computeReplayFrame(log, 2);
    expect(frame.virusPositions[2], 'r1');
  });

  test('eventsThisTick only includes events exactly at that tick', () {
    final log = _logWith([
      const BattleEvent(tick: 1, type: 'virus_moved', data: {'virus_id': 1, 'node_id': 'r1'}),
      const BattleEvent(tick: 2, type: 'virus_moved', data: {'virus_id': 1, 'node_id': 'r2'}),
    ]);
    final frame = computeReplayFrame(log, 1);
    expect(frame.eventsThisTick.length, 1);
    expect(frame.eventsThisTick.single.tick, 1);
  });
}
