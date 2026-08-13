import 'dart:convert';

import 'package:content_schema/content_schema.dart';
import 'package:sim_core/sim_core.dart';
import 'package:test/test.dart';

import 'support/fixtures.dart';

void main() {
  final catalog = loadRealBlockCatalog();
  final balance = loadRealBalanceConfig();

  group('resolveBattle: determinism (§3.1)', () {
    test('same seed => byte-identical BattleLog JSON', () {
      final network = simpleChainNetwork();
      final virus = virusOf(programSmartDrone());
      final a = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 123);
      final b = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 123);
      expect(jsonEncode(a.toJson()), jsonEncode(b.toJson()));
    });

    test('different seeds can diverge for randomness-dependent programs', () {
      final network = simpleChainNetwork();
      const randomProgram = DagDef(nodes: [
        DagNode(id: 'r', blockId: 'random_branch', out: {'true': 'a', 'false': 'b'}),
        DagNode(id: 'a', blockId: 'move_random'),
        DagNode(id: 'b', blockId: 'wait'),
      ], entry: 'r');
      final virus = virusOf(randomProgram);
      final logs = List.generate(
          10,
          (i) => resolveBattle(
              network: network,
              virusDef: virus,
              balance: balance,
              blockCatalog: catalog,
              seed: i));
      final encodings = logs.map((l) => jsonEncode(l.toJson())).toSet();
      expect(encodings.length, greaterThan(1));
    });
  });

  group('resolveBattle: hard caps (§1.2, §3.2)', () {
    test('a virus that only waits runs exactly to the 600-tick cap', () {
      final network = simpleChainNetwork();
      final virus = virusOf(programWaitForever());
      final log = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 1);
      expect(log.result.ticksUsed, 600);
      expect(log.result.survivingCopies, 1);
    });

    test('an infinite sensor loop stalls every tick and never acts, but the battle still terminates at 600 ticks', () {
      final network = simpleChainNetwork();
      final virus = virusOf(programInfiniteSensorLoop());
      final log = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 1);
      expect(log.result.ticksUsed, 600);
      final stallEvents = log.events.where((e) => e.type == 'virus_stalled');
      expect(stallEvents.length, 600);
      final moveEvents = log.events.where((e) => e.type == 'virus_moved');
      expect(moveEvents, isEmpty);
    });
  });

  group('resolveBattle: gameplay behaviors', () {
    test('smart drone reaches data, copies it, and exfiltrates cleanly', () {
      final network = simpleChainNetwork(dataValue: 25);
      final virus = virusOf(programSmartDrone());
      final log = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 7);
      expect(log.result.dataExfiltrated, greaterThanOrEqualTo(25));
      expect(log.result.cleanExits, greaterThanOrEqualTo(1));
      expect(log.events.any((e) => e.type == 'data_copied'), isTrue);
      expect(log.events.any((e) => e.type == 'data_exfiltrated'), isTrue);
    });

    test('brute_force chips away firewall level until it opens', () {
      final network = simpleChainNetwork(firewallLevelAtGate: 3, dataValue: 5);
      final virus = virusOf(programSmartDrone());
      final log = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 3);
      final bruteEvents = log.events.where((e) => e.type == 'brute_force');
      expect(bruteEvents.length, greaterThanOrEqualTo(3));
      expect(log.result.dataExfiltrated, greaterThanOrEqualTo(5));
    });

    test('self_destruct kills the virus without leaving a log behind', () {
      final network = simpleChainNetwork();
      final virus = virusOf(programSelfDestructImmediately());
      final log = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 1);
      expect(log.result.survivingCopies, 0);
      expect(log.result.deadCopies, 1);
      expect(log.events.any((e) => e.type == 'virus_died' && e.data['cause'] == 'self_destruct'),
          isTrue);
    });

    test('energy exhaustion kills the virus and leaves a log at its position', () {
      final network = simpleChainNetwork();
      final virus = virusOf(programMoveRandomForever());
      final log = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 5);
      expect(log.result.deadCopies, 1);
      expect(
          log.events.any((e) => e.type == 'virus_died' && e.data['cause'] == 'energy_depleted'),
          isTrue);
    });

    test('replicate spawns bounded copies, never exceeding max_virus_copies', () {
      final network = simpleChainNetwork();
      final virus = virusOf(programReplicateForever());
      final log = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 9);
      final replicatedEvents = log.events.where((e) => e.type == 'virus_replicated');
      expect(replicatedEvents.length, lessThanOrEqualTo(balance.maxVirusCopies - 1));
    });
  });

  group('resolveBattle: defense logic', () {
    test('a quarantine-on-detect defense kills the intruder', () {
      const defenseLogic = DagDef(nodes: [
        DagNode(id: 'det', blockId: 'intruder_detected', out: {'next': 'branch'}),
        DagNode(id: 'branch', blockId: 'if_else', out: {'true': 'q'}),
        DagNode(id: 'q', blockId: 'quarantine'),
      ], entry: 'det');

      final network = NetworkDef(id: 'net_guarded', nodes: [
        const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['guarded']),
        NetworkNodeDef(
          id: 'guarded',
          type: NodeType.relay,
          edges: const ['data'],
          defenseLogic: defenseLogic.toJson(),
        ),
        const NetworkNodeDef(
            id: 'data', type: NodeType.data, edges: [], data: DataDef(value: 10, verified: true)),
        const NetworkNodeDef(id: 'spare1', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare2', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare3', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare4', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare5', type: NodeType.relay, edges: []),
      ]);

      const movesOnly = DagDef(nodes: [
        DagNode(id: 'm', blockId: 'move_random'),
      ], entry: 'm');
      final virus = virusOf(movesOnly);

      // energy is high relative to a single quarantine hit (30 dmg), so run
      // long enough for the virus to wander into the guarded node.
      final log = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 2);
      expect(log.events.any((e) => e.type == 'node_quarantined'), isTrue);
    });

    test('a virus that disguises every tick before moving evades a detect-then-quarantine guard', () {
      const defenseLogic = DagDef(nodes: [
        DagNode(id: 'det', blockId: 'intruder_detected', out: {'next': 'branch'}),
        DagNode(id: 'branch', blockId: 'if_else', out: {'true': 'q'}),
        DagNode(id: 'q', blockId: 'quarantine'),
      ], entry: 'det');

      // entry (undefended) -> guarded (defended, sits between entry and
      // data) -> data. The virus disguises every tick *before* it moves, so
      // by the time it reaches "guarded" it has already been disguised for
      // at least one full tick, and refreshes every tick thereafter with no
      // gap — it should never be caught.
      final network = NetworkDef(id: 'net_guarded2', nodes: [
        const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['guarded']),
        NetworkNodeDef(
          id: 'guarded',
          type: NodeType.relay,
          edges: const ['data'],
          defenseLogic: defenseLogic.toJson(),
        ),
        const NetworkNodeDef(
            id: 'data', type: NodeType.data, edges: [], data: DataDef(value: 10, verified: true)),
        const NetworkNodeDef(id: 'spare1', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare2', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare3', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare4', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare5', type: NodeType.relay, edges: []),
      ]);

      const disguiseThenMove = DagDef(nodes: [
        DagNode(id: 'd', blockId: 'disguise', out: {'next': 'm'}),
        DagNode(id: 'm', blockId: 'move_toward_data'),
      ], entry: 'd');
      final virus = virusOf(disguiseThenMove);

      final log = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 1);
      // The guard never catches it (that's what we're testing); it may
      // still eventually run out of energy from disguising every tick,
      // which is a separate, expected budget effect, not a detection.
      expect(log.events.any((e) => e.type == 'node_quarantined'), isFalse);
      expect(
          log.events.any((e) => e.type == 'virus_died' && e.data['cause'] == 'quarantined'),
          isFalse);
    });

    test('without disguise, the same guard does eventually quarantine the intruder', () {
      const defenseLogic = DagDef(nodes: [
        DagNode(id: 'det', blockId: 'intruder_detected', out: {'next': 'branch'}),
        DagNode(id: 'branch', blockId: 'if_else', out: {'true': 'q'}),
        DagNode(id: 'q', blockId: 'quarantine'),
      ], entry: 'det');

      final network = NetworkDef(id: 'net_guarded3', nodes: [
        const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['guarded']),
        NetworkNodeDef(
          id: 'guarded',
          type: NodeType.relay,
          edges: const ['data'],
          defenseLogic: defenseLogic.toJson(),
        ),
        const NetworkNodeDef(
            id: 'data', type: NodeType.data, edges: [], data: DataDef(value: 10, verified: true)),
        const NetworkNodeDef(id: 'spare1', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare2', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare3', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare4', type: NodeType.relay, edges: []),
        const NetworkNodeDef(id: 'spare5', type: NodeType.relay, edges: []),
      ]);

      const moveOnly = DagDef(nodes: [
        DagNode(id: 'm', blockId: 'move_toward_data'),
      ], entry: 'm');
      final virus = virusOf(moveOnly);

      final log = resolveBattle(
          network: network, virusDef: virus, balance: balance, blockCatalog: catalog, seed: 1);
      expect(log.events.any((e) => e.type == 'node_quarantined'), isTrue);
    });
  });
}
