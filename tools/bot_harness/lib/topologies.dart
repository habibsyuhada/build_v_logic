import 'package:content_schema/content_schema.dart';

const DagDef _quarantineDefense = DagDef(nodes: [
  DagNode(id: 'det', blockId: 'intruder_detected', out: {'next': 'branch'}),
  DagNode(id: 'branch', blockId: 'if_else', out: {'true': 'q'}),
  DagNode(id: 'q', blockId: 'quarantine'),
], entry: 'det');

class _TopologySpec {
  final String id;
  final int chainLength; // total nodes: entry + relays + gate + data
  final int firewallLevel;
  final bool guarded;
  final int dataValue;

  const _TopologySpec({
    required this.id,
    required this.chainLength,
    required this.firewallLevel,
    required this.guarded,
    required this.dataValue,
  });
}

/// 12 topology variants (§4.3) spanning chain length, firewall strength,
/// presence of a quarantine-on-detect guard, and data value — enough
/// spread to catch a single block becoming dominant or useless across
/// different defensive postures. Simpler than 12 hand-authored bespoke
/// networks (see docs/DECISIONS.md); a first pass meant to be replaced or
/// extended once Phase 3's curated topology set exists.
const List<_TopologySpec> _specs = [
  _TopologySpec(id: 't01', chainLength: 8, firewallLevel: 0, guarded: false, dataValue: 10),
  _TopologySpec(id: 't02', chainLength: 8, firewallLevel: 2, guarded: false, dataValue: 10),
  _TopologySpec(id: 't03', chainLength: 8, firewallLevel: 4, guarded: false, dataValue: 10),
  _TopologySpec(id: 't04', chainLength: 8, firewallLevel: 0, guarded: true, dataValue: 10),
  _TopologySpec(id: 't05', chainLength: 8, firewallLevel: 2, guarded: true, dataValue: 10),
  _TopologySpec(id: 't06', chainLength: 10, firewallLevel: 0, guarded: false, dataValue: 20),
  _TopologySpec(id: 't07', chainLength: 10, firewallLevel: 2, guarded: false, dataValue: 20),
  _TopologySpec(id: 't08', chainLength: 10, firewallLevel: 4, guarded: true, dataValue: 20),
  _TopologySpec(id: 't09', chainLength: 12, firewallLevel: 0, guarded: false, dataValue: 30),
  _TopologySpec(id: 't10', chainLength: 12, firewallLevel: 3, guarded: false, dataValue: 30),
  _TopologySpec(id: 't11', chainLength: 12, firewallLevel: 3, guarded: true, dataValue: 30),
  _TopologySpec(id: 't12', chainLength: 12, firewallLevel: 5, guarded: true, dataValue: 5),
];

NetworkDef _buildFromSpec(_TopologySpec spec) {
  final relayCount = spec.chainLength - 3;
  final nodes = <NetworkNodeDef>[];
  nodes.add(const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['r1']));
  for (var i = 1; i <= relayCount; i++) {
    final next = i == relayCount ? 'gate' : 'r${i + 1}';
    nodes.add(NetworkNodeDef(id: 'r$i', type: NodeType.relay, edges: [next]));
  }
  nodes.add(NetworkNodeDef(
    id: 'gate',
    type: NodeType.relay,
    edges: const ['data'],
    firewall: FirewallDef(level: spec.firewallLevel),
    defenseLogic: spec.guarded ? _quarantineDefense.toJson() : null,
  ));
  nodes.add(NetworkNodeDef(
    id: 'data',
    type: NodeType.data,
    edges: const ['entry'],
    data: DataDef(value: spec.dataValue, verified: true),
  ));
  return NetworkDef(id: spec.id, nodes: nodes);
}

List<NetworkDef> buildTopologies() => _specs.map(_buildFromSpec).toList();
