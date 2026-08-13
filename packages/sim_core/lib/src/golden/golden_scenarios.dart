import 'package:content_schema/content_schema.dart';

/// Fixed battle scenarios used for golden determinism testing (§4.2) and by
/// `tool/print_golden_hashes.dart` for the CI cross-platform hash check.
/// Not gameplay content — these are synthetic fixtures, kept in `lib/` (not
/// `test/`) purely so both the test suite and the CLI tool can share one
/// source of truth via a single `package:sim_core/...` import.
class GoldenScenario {
  final String name;
  final NetworkDef network;
  final VirusDef virusDef;
  final int seed;

  const GoldenScenario({
    required this.name,
    required this.network,
    required this.virusDef,
    required this.seed,
  });
}

NetworkDef _chainNetwork({
  int firewallLevelAtGate = 0,
  int dataValue = 10,
  bool dataVerified = true,
  List<String> avRoute = const [],
  String id = 'net_chain',
}) {
  return NetworkDef(id: id, nodes: [
    const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['r1']),
    const NetworkNodeDef(id: 'r1', type: NodeType.relay, edges: ['r2']),
    const NetworkNodeDef(id: 'r2', type: NodeType.relay, edges: ['gate']),
    NetworkNodeDef(
      id: 'gate',
      type: NodeType.relay,
      edges: const ['data'],
      firewall: FirewallDef(level: firewallLevelAtGate),
    ),
    NetworkNodeDef(
      id: 'data',
      type: NodeType.data,
      edges: const ['entry'],
      data: DataDef(value: dataValue, verified: dataVerified),
      avRoute: avRoute,
    ),
    const NetworkNodeDef(id: 'spare1', type: NodeType.relay, edges: []),
    const NetworkNodeDef(id: 'spare2', type: NodeType.relay, edges: []),
    const NetworkNodeDef(id: 'spare3', type: NodeType.relay, edges: []),
  ]);
}

const _smartDrone = DagDef(nodes: [
  DagNode(id: 'has_data', blockId: 'carrying_data', out: {'next': 'branch_carrying'}),
  DagNode(id: 'branch_carrying',
      blockId: 'if_else', out: {'true': 'go_exit', 'false': 'check_here'}),
  DagNode(id: 'go_exit', blockId: 'move_toward_exit'),
  DagNode(id: 'check_here', blockId: 'node_has_data', out: {'next': 'branch_here'}),
  DagNode(id: 'branch_here', blockId: 'if_else', out: {'true': 'do_copy', 'false': 'check_fw'}),
  DagNode(id: 'do_copy', blockId: 'copy_data'),
  DagNode(id: 'check_fw', blockId: 'firewall_detected', out: {'next': 'branch_fw'}),
  DagNode(id: 'branch_fw', blockId: 'if_else', out: {'true': 'do_brute', 'false': 'go_data'}),
  DagNode(id: 'do_brute', blockId: 'brute_force'),
  DagNode(id: 'go_data', blockId: 'move_toward_data'),
], entry: 'has_data');

const _waitForever = DagDef(nodes: [DagNode(id: 'w', blockId: 'wait')], entry: 'w');

const _infiniteSensorLoop = DagDef(nodes: [
  DagNode(id: 's', blockId: 'alarm_active', out: {'next': 'b'}),
  DagNode(id: 'b', blockId: 'if_else', out: {'true': 's', 'false': 's'}),
], entry: 's');

const _selfDestruct = DagDef(nodes: [DagNode(id: 'd', blockId: 'self_destruct')], entry: 'd');

const _moveRandomForever = DagDef(nodes: [DagNode(id: 'm', blockId: 'move_random')], entry: 'm');

const _replicateForever = DagDef(nodes: [DagNode(id: 'r', blockId: 'replicate')], entry: 'r');

const _randomSplit = DagDef(nodes: [
  DagNode(id: 'r', blockId: 'random_branch', out: {'true': 'a', 'false': 'b'}),
  DagNode(id: 'a', blockId: 'move_random'),
  DagNode(id: 'b', blockId: 'wait'),
], entry: 'r');

const _quarantineDefense = DagDef(nodes: [
  DagNode(id: 'det', blockId: 'intruder_detected', out: {'next': 'branch'}),
  DagNode(id: 'branch', blockId: 'if_else', out: {'true': 'q'}),
  DagNode(id: 'q', blockId: 'quarantine'),
], entry: 'det');

const _moveOnly = DagDef(nodes: [DagNode(id: 'm', blockId: 'move_toward_data')], entry: 'm');

const _disguiseThenMove = DagDef(nodes: [
  DagNode(id: 'd', blockId: 'disguise', out: {'next': 'm'}),
  DagNode(id: 'm', blockId: 'move_toward_data'),
], entry: 'd');

NetworkDef _guardedNetwork(String id) => NetworkDef(id: id, nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['guarded']),
      NetworkNodeDef(
        id: 'guarded',
        type: NodeType.relay,
        edges: const ['data'],
        defenseLogic: _quarantineDefense.toJson(),
      ),
      const NetworkNodeDef(
          id: 'data', type: NodeType.data, edges: [], data: DataDef(value: 10, verified: true)),
      const NetworkNodeDef(id: 'spare1', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 'spare2', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 'spare3', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 'spare4', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 'spare5', type: NodeType.relay, edges: []),
    ]);

/// The 10 golden scenarios required by Phase 1's AC (§5, §4.2).
List<GoldenScenario> buildGoldenScenarios() => [
      GoldenScenario(
        name: '01_smart_drone_open_gate',
        network: _chainNetwork(id: 'net_g1', dataValue: 25),
        virusDef: const VirusDef(program: _smartDrone),
        seed: 1001,
      ),
      GoldenScenario(
        name: '02_smart_drone_firewalled_gate',
        network: _chainNetwork(id: 'net_g2', firewallLevelAtGate: 3, dataValue: 5),
        virusDef: const VirusDef(program: _smartDrone),
        seed: 1002,
      ),
      GoldenScenario(
        name: '03_move_random_energy_death',
        network: _chainNetwork(id: 'net_g3'),
        virusDef: const VirusDef(program: _moveRandomForever),
        seed: 1003,
      ),
      GoldenScenario(
        name: '04_wait_forever_tick_cap',
        network: _chainNetwork(id: 'net_g4'),
        virusDef: const VirusDef(program: _waitForever),
        seed: 1004,
      ),
      GoldenScenario(
        name: '05_infinite_sensor_loop_stalls',
        network: _chainNetwork(id: 'net_g5'),
        virusDef: const VirusDef(program: _infiniteSensorLoop),
        seed: 1005,
      ),
      GoldenScenario(
        name: '06_self_destruct_immediately',
        network: _chainNetwork(id: 'net_g6'),
        virusDef: const VirusDef(program: _selfDestruct),
        seed: 1006,
      ),
      GoldenScenario(
        name: '07_replicate_forever_bounded',
        network: _chainNetwork(id: 'net_g7'),
        virusDef: const VirusDef(program: _replicateForever),
        seed: 1007,
      ),
      GoldenScenario(
        name: '08_random_split_move_or_wait',
        network: _chainNetwork(id: 'net_g8'),
        virusDef: const VirusDef(program: _randomSplit),
        seed: 1008,
      ),
      GoldenScenario(
        name: '09_defense_quarantine_catches_intruder',
        network: _guardedNetwork('net_g9'),
        virusDef: const VirusDef(program: _moveOnly),
        seed: 1009,
      ),
      GoldenScenario(
        name: '10_defense_evaded_via_disguise',
        network: _guardedNetwork('net_g10'),
        virusDef: const VirusDef(program: _disguiseThenMove),
        seed: 1010,
      ),
    ];
