import 'package:sim_core/sim_core.dart';

/// The renderable state of a replay at one tick, reconstructed purely from
/// the event log (§2.3: "Replay = event log, bukan video") — no snapshot
/// data required, so this works for any `BattleLog`, including ones
/// fetched from a PvP battle where snapshots were never requested.
class ReplayFrame {
  final Map<int, String> virusPositions; // virusId -> nodeId
  final Set<int> deadVirusIds;
  final List<BattleEvent> eventsThisTick;

  const ReplayFrame({
    required this.virusPositions,
    required this.deadVirusIds,
    required this.eventsThisTick,
  });
}

ReplayFrame computeReplayFrame(BattleLog log, int uptoTick) {
  final positions = <int, String>{};
  final dead = <int>{};

  for (final e in log.events) {
    if (e.tick > uptoTick) break; // events are emitted in non-decreasing tick order
    switch (e.type) {
      case 'virus_spawned':
        positions[e.data['virus_id'] as int] = e.data['node_id'] as String;
        break;
      case 'virus_moved':
        positions[e.data['virus_id'] as int] = e.data['node_id'] as String;
        break;
      case 'virus_replicated':
        final parentId = e.data['parent_id'] as int;
        positions[e.data['child_id'] as int] = positions[parentId] ?? e.data['node_id'] as String;
        break;
      case 'virus_died':
        dead.add(e.data['virus_id'] as int);
        break;
    }
  }

  return ReplayFrame(
    virusPositions: positions,
    deadVirusIds: dead,
    eventsThisTick: log.events.where((e) => e.tick == uptoTick).toList(),
  );
}
