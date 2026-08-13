import 'package:bot_harness/archetypes.dart';
import 'package:bot_harness/topologies.dart';
import 'package:content_schema/content_schema.dart';
import 'package:sim_core/sim_core.dart';
import 'package:test/test.dart';

void main() {
  test('exactly 3 archetypes and 12 topologies are defined (§4.3)', () {
    expect(allArchetypes.length, 3);
    expect(buildTopologies().length, 12);
  });

  test('every topology is 8-40 nodes and passes validateNetwork', () {
    for (final topology in buildTopologies()) {
      final result = validateNetwork(topology);
      expect(result.isValid, isTrue,
          reason: '${topology.id}: ${result.errors.join('; ')}');
    }
  });

  test('every archetype DAG only references known block ids', () {
    final blocks = <String>{
      'carrying_data', 'node_has_data', 'data_verified', 'firewall_detected',
      'copies_alive_gt', 'if_else', 'move_toward_exit', 'move_toward_data',
      'disguise', 'copy_data', 'brute_force', 'replicate',
    };
    for (final archetype in allArchetypes) {
      for (final node in archetype.program.nodes) {
        expect(blocks.contains(node.blockId), isTrue,
            reason: '${archetype.name} references unknown block ${node.blockId}');
      }
    }
  });

  test('archetype x topology battles resolve deterministically', () {
    final blockCatalog = _loadCatalogForTest();
    const balance = BalanceConfig.defaults;
    final topology = buildTopologies().first;

    final a = resolveBattle(
      network: topology,
      virusDef: VirusDef(program: ghostArchetype.program),
      balance: balance,
      blockCatalog: blockCatalog,
      seed: 42,
    );
    final b = resolveBattle(
      network: topology,
      virusDef: VirusDef(program: ghostArchetype.program),
      balance: balance,
      blockCatalog: blockCatalog,
      seed: 42,
    );
    expect(a.result.score, b.result.score);
    expect(a.result.dataExfiltrated, b.result.dataExfiltrated);
  });
}

List<BlockDef> _loadCatalogForTest() {
  // Kept minimal and self-contained (no dart:io content/ read) so this
  // test doesn't depend on cwd; only the blocks the fixtures above use.
  return const [
    BlockDef(id: 'carrying_data', family: BlockFamily.sensor, sizeKb: 1),
    BlockDef(id: 'node_has_data', family: BlockFamily.sensor, sizeKb: 1),
    BlockDef(id: 'data_verified', family: BlockFamily.sensor, sizeKb: 1),
    BlockDef(id: 'firewall_detected', family: BlockFamily.sensor, sizeKb: 1),
    BlockDef(id: 'copies_alive_gt', family: BlockFamily.sensor, sizeKb: 3),
    BlockDef(id: 'if_else', family: BlockFamily.controlFlow, sizeKb: 2),
    BlockDef(id: 'move_toward_exit', family: BlockFamily.action, sizeKb: 5, energyCost: 3, noise: 1),
    BlockDef(id: 'move_toward_data', family: BlockFamily.action, sizeKb: 5, energyCost: 3, noise: 1),
    BlockDef(id: 'disguise', family: BlockFamily.action, sizeKb: 6, energyCost: 5, noise: 0),
    BlockDef(id: 'copy_data', family: BlockFamily.action, sizeKb: 4, energyCost: 4, noise: 2),
    BlockDef(id: 'brute_force', family: BlockFamily.action, sizeKb: 6, energyCost: 8, noise: 9),
    BlockDef(id: 'replicate', family: BlockFamily.action, sizeKb: 14, energyCost: 20, noise: 6),
  ];
}
