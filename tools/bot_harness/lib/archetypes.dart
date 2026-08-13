import 'package:content_schema/content_schema.dart';

/// Three virus archetypes (§4.3) used as the balance regression fleet.
/// Deliberately simple, hand-authored DAGs — this harness measures whether
/// *these specific* strategies stay in a 40-60% win-rate band as
/// `content/blocks.json` balance numbers change, not an exhaustive search
/// of strategy space.
class Archetype {
  final String name;
  final DagDef program;
  const Archetype(this.name, this.program);
}

/// Ghost: stealthy exfiltrator. Disguises constantly, avoids brute force,
/// only takes verified data, and runs the moment it's carrying anything.
const ghostArchetype = Archetype(
  'Ghost',
  DagDef(nodes: [
    DagNode(id: 'carry', blockId: 'carrying_data', out: {'next': 'branch_carry'}),
    DagNode(id: 'branch_carry', blockId: 'if_else', out: {'true': 'exit', 'false': 'disguise'}),
    DagNode(id: 'exit', blockId: 'move_toward_exit'),
    DagNode(id: 'disguise', blockId: 'disguise', out: {'next': 'has_data'}),
    DagNode(id: 'has_data', blockId: 'node_has_data', out: {'next': 'branch_data'}),
    DagNode(id: 'branch_data', blockId: 'if_else', out: {'true': 'verified', 'false': 'wander'}),
    DagNode(id: 'verified', blockId: 'data_verified', out: {'next': 'branch_verified'}),
    DagNode(id: 'branch_verified',
        blockId: 'if_else', out: {'true': 'copy', 'false': 'wander'}),
    DagNode(id: 'copy', blockId: 'copy_data'),
    DagNode(id: 'wander', blockId: 'move_toward_data'),
  ], entry: 'carry'),
);

/// Bulldozer: brute-forces every firewall it meets, doesn't bother hiding.
const bulldozerArchetype = Archetype(
  'Bulldozer',
  DagDef(nodes: [
    DagNode(id: 'carry', blockId: 'carrying_data', out: {'next': 'branch_carry'}),
    DagNode(id: 'branch_carry', blockId: 'if_else', out: {'true': 'exit', 'false': 'fw'}),
    DagNode(id: 'exit', blockId: 'move_toward_exit'),
    DagNode(id: 'fw', blockId: 'firewall_detected', out: {'next': 'branch_fw'}),
    DagNode(id: 'branch_fw', blockId: 'if_else', out: {'true': 'brute', 'false': 'has_data'}),
    DagNode(id: 'brute', blockId: 'brute_force'),
    DagNode(id: 'has_data', blockId: 'node_has_data', out: {'next': 'branch_data'}),
    DagNode(id: 'branch_data', blockId: 'if_else', out: {'true': 'copy', 'false': 'wander'}),
    DagNode(id: 'copy', blockId: 'copy_data'),
    DagNode(id: 'wander', blockId: 'move_toward_data'),
  ], entry: 'carry'),
);

/// Hydra: floods copies via `replicate` before any of them bother chasing
/// data — a numbers-over-precision strategy.
const hydraArchetype = Archetype(
  'Hydra',
  DagDef(nodes: [
    DagNode(id: 'copies', blockId: 'copies_alive_gt', params: {'x': 3}, out: {'next': 'branch_copies'}),
    DagNode(id: 'branch_copies', blockId: 'if_else', out: {'true': 'hunt', 'false': 'replicate'}),
    DagNode(id: 'replicate', blockId: 'replicate'),
    DagNode(id: 'hunt', blockId: 'carrying_data', out: {'next': 'branch_carry'}),
    DagNode(id: 'branch_carry', blockId: 'if_else', out: {'true': 'exit', 'false': 'has_data'}),
    DagNode(id: 'exit', blockId: 'move_toward_exit'),
    DagNode(id: 'has_data', blockId: 'node_has_data', out: {'next': 'branch_data'}),
    DagNode(id: 'branch_data', blockId: 'if_else', out: {'true': 'copy', 'false': 'wander'}),
    DagNode(id: 'copy', blockId: 'copy_data'),
    DagNode(id: 'wander', blockId: 'move_toward_data'),
  ], entry: 'copies'),
);

const List<Archetype> allArchetypes = [ghostArchetype, bulldozerArchetype, hydraArchetype];
