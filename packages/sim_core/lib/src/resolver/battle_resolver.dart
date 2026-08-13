import 'package:content_schema/content_schema.dart';

import '../interpreter/interpreter.dart';
import '../model/sim_state.dart';
import '../prng/xoshiro128.dart';
import '../replay/battle_event.dart';
import '../replay/battle_log.dart';
import '../replay/battle_result.dart';
import '../replay/virus_snapshot.dart';

/// Resolves one battle (§2.3, §3.1). Pure: given the same inputs it
/// produces byte-identical output every time — no wall-clock, no
/// unseeded randomness, no external state. This is the single function
/// both the client's Test Run mode and the server's authoritative worker
/// call.
///
/// [includeSnapshots] attaches a per-tick [TickSnapshot] list to the
/// returned [BattleLog] for the client's Test Run debugger inspector
/// (§3.3). Leave it false (the default, and always false for PvP
/// submission) to keep the log small (§2.3).
BattleLog resolveBattle({
  required NetworkDef network,
  required VirusDef virusDef,
  required BalanceConfig balance,
  required List<BlockDef> blockCatalog,
  required int seed,
  bool includeSnapshots = false,
}) {
  final catalog = {for (final b in blockCatalog) b.id: b};
  final nodes = {for (final n in network.nodes) n.id: NodeRuntime.fromDef(n)};
  final defensePrograms = <String, DagDef>{
    for (final n in network.nodes)
      if (n.defenseLogic != null) n.id: DagDef.fromJson(n.defenseLogic!),
  };

  final state = SimState(nodes: nodes);
  final rng = Xoshiro128(seed);
  final events = <BattleEvent>[];

  final entryNode = network.nodes.firstWhere(
    (n) => n.type == NodeType.entry,
    orElse: () => network.nodes.first,
  );

  final firstCopy = VirusRuntime(
    id: state.nextVirusId++,
    spawnTick: 0,
    position: entryNode.id,
    energy: balance.startingEnergy,
  );
  state.virusCopies.add(firstCopy);
  events.add(BattleEvent(
    tick: 0,
    type: 'virus_spawned',
    data: {'virus_id': firstCopy.id, 'node_id': entryNode.id},
  ));

  var finalTick = 0;
  final alarmThreshold = balance.noiseAlertThreshold;
  final snapshots = includeSnapshots ? <TickSnapshot>[] : null;

  for (var tick = 1; tick <= balance.maxTicksPerBattle; tick++) {
    state.tick = tick;
    finalTick = tick;

    for (final nodeDef in network.nodes) {
      final program = defensePrograms[nodeDef.id];
      if (program == null) continue;
      final runtime = state.nodes[nodeDef.id]!;
      runDefenseTick(
        node: runtime,
        program: program,
        state: state,
        balance: balance,
        rng: rng,
        catalog: catalog,
        events: events,
        tick: tick,
      );
    }

    final copiesThisTick = List<VirusRuntime>.of(state.virusCopies);
    for (final virus in copiesThisTick) {
      if (!virus.alive) continue;
      runVirusTick(
        virus: virus,
        program: virusDef.program,
        state: state,
        balance: balance,
        rng: rng,
        catalog: catalog,
        events: events,
        tick: tick,
      );
    }

    for (final virus in state.virusCopies) {
      if (!virus.alive) continue;
      final node = state.nodes[virus.position]!;
      if (node.type == NodeType.entry && virus.inventoryDataValue > 0) {
        state.dataExfiltrated += virus.inventoryDataValue;
        state.cleanExitCount += 1;
        events.add(BattleEvent(tick: tick, type: 'data_exfiltrated', data: {
          'virus_id': virus.id,
          'value': virus.inventoryDataValue,
        }));
        virus.inventoryDataValue = 0;
      }
    }

    state.decayNoise(balance.noiseDecayPerTick);
    final alarmActive = state.isAlarmActive(alarmThreshold);
    for (final node in state.nodes.values) {
      if (node.avRoute.isEmpty) continue;
      final step = alarmActive ? 2 : 1;
      node.avRouteIndex = (node.avRouteIndex + step) % node.avRoute.length;
    }

    snapshots?.add(TickSnapshot(
      tick: tick,
      noiseMeter: state.noiseMeter,
      virusCopies: state.virusCopies
          .map((v) => VirusSnapshot(
                virusId: v.id,
                position: v.position,
                energy: v.energy,
                alive: v.alive,
                inventoryDataValue: v.inventoryDataValue,
                markedNodesCount: v.markedNodes.length,
                counter: v.counter,
              ))
          .toList(),
    ));

    if (state.aliveCopies.isEmpty) break;
  }

  final survivingCopies = state.aliveCopies.length;
  final deadCopies = state.virusCopies.length - survivingCopies;

  final rawScore = state.dataExfiltrated +
      state.logsDeletedCount * balance.scoreLogDeletedBonus +
      state.cleanExitCount * balance.scoreCleanExitBonus -
      deadCopies * balance.scoreDeadPenalty -
      state.tracePenalty -
      (finalTick ~/ balance.scoreTickEfficiencyDivisor);

  final result = BattleResult(
    ticksUsed: finalTick,
    dataExfiltrated: state.dataExfiltrated,
    logsDeleted: state.logsDeletedCount,
    cleanExits: state.cleanExitCount,
    survivingCopies: survivingCopies,
    deadCopies: deadCopies,
    tracePenalty: state.tracePenalty,
    score: rawScore < 0 ? 0 : rawScore,
    peakNoiseMeter: state.peakNoiseMeter,
  );

  return BattleLog(
    seed: seed,
    networkId: network.id,
    events: events,
    result: result,
    snapshots: snapshots,
  );
}
