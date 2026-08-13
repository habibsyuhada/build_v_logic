import 'dart:convert';
import 'dart:io';

import 'package:content_schema/content_schema.dart';

/// Loads the real `content/blocks.json` + `content/balance.json` so tests
/// exercise the actual authored content, not a hand-rolled subset. Assumes
/// `dart test` runs with cwd = packages/sim_core (true for `dart test` and
/// CI), so the content tree is two levels up.
List<BlockDef> loadRealBlockCatalog() {
  final file = File('../../content/blocks.json');
  final raw = jsonDecode(file.readAsStringSync()) as List;
  return raw.map((e) => BlockDef.fromJson(e as Map<String, dynamic>)).toList();
}

BalanceConfig loadRealBalanceConfig() {
  final file = File('../../content/balance.json');
  final raw = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return BalanceConfig.fromJson(raw);
}

/// A small (8-node) network: entry -> a chain of relays -> data node,
/// with a spare unconnected-from-critical-path relay so it still counts
/// as an 8+ node topology per §1.2.
NetworkDef simpleChainNetwork({
  int firewallLevelAtGate = 0,
  int dataValue = 10,
  bool dataVerified = true,
  List<String> avRoute = const [],
}) {
  return NetworkDef(id: 'net_chain', nodes: [
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

VirusDef virusOf(DagDef program, {String? name}) => VirusDef(name: name, program: program);

/// A single `wait` node — the virus does nothing, forever, and neither
/// dies nor stalls. Used to prove the 600-tick hard cap actually stops the
/// resolver.
DagDef programWaitForever() => const DagDef(
      nodes: [DagNode(id: 'w', blockId: 'wait')],
      entry: 'w',
    );

/// Sensor -> if_else looping back to itself with no action ever reachable
/// — every tick stalls at the 64-eval-step cap with zero actions executed.
DagDef programInfiniteSensorLoop() => const DagDef(nodes: [
      DagNode(id: 's', blockId: 'alarm_active', out: {'next': 'b'}),
      DagNode(id: 'b', blockId: 'if_else', out: {'true': 's', 'false': 's'}),
    ], entry: 's');

DagDef programSelfDestructImmediately() => const DagDef(
      nodes: [DagNode(id: 'd', blockId: 'self_destruct')],
      entry: 'd',
    );

DagDef programMoveRandomForever() => const DagDef(
      nodes: [DagNode(id: 'm', blockId: 'move_random')],
      entry: 'm',
    );

DagDef programReplicateForever() => const DagDef(
      nodes: [DagNode(id: 'r', blockId: 'replicate')],
      entry: 'r',
    );

/// A full "smart drone": chase data, copy it, then chase the exit; if
/// blocked by a firewall, brute-force it first. Reused across integration
/// and golden tests as a realistic virus.
DagDef programSmartDrone() => const DagDef(nodes: [
      DagNode(id: 'has_data', blockId: 'carrying_data', out: {'next': 'branch_carrying'}),
      DagNode(id: 'branch_carrying',
          blockId: 'if_else', out: {'true': 'go_exit', 'false': 'check_here'}),
      DagNode(id: 'go_exit', blockId: 'move_toward_exit'),
      DagNode(id: 'check_here', blockId: 'node_has_data', out: {'next': 'branch_here'}),
      DagNode(id: 'branch_here',
          blockId: 'if_else', out: {'true': 'do_copy', 'false': 'check_fw'}),
      DagNode(id: 'do_copy', blockId: 'copy_data'),
      DagNode(id: 'check_fw', blockId: 'firewall_detected', out: {'next': 'branch_fw'}),
      DagNode(id: 'branch_fw',
          blockId: 'if_else', out: {'true': 'do_brute', 'false': 'go_data'}),
      DagNode(id: 'do_brute', blockId: 'brute_force'),
      DagNode(id: 'go_data', blockId: 'move_toward_data'),
    ], entry: 'has_data');
