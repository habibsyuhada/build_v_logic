import 'package:content_schema/content_schema.dart';
import 'package:payload_server/src/business/battle_worker.dart';
import 'package:payload_server/src/generated/protocol.dart';
import 'package:test/test.dart';

final _catalog = [
  const BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 2),
  const BlockDef(id: 'self_destruct', family: BlockFamily.action, sizeKb: 2),
  const BlockDef(id: 'move_toward_data', family: BlockFamily.action, sizeKb: 5, energyCost: 3, noise: 1),
  const BlockDef(id: 'move_toward_exit', family: BlockFamily.action, sizeKb: 5, energyCost: 3, noise: 1),
  const BlockDef(id: 'copy_data', family: BlockFamily.action, sizeKb: 4, energyCost: 4, noise: 2),
  const BlockDef(id: 'carrying_data', family: BlockFamily.sensor, sizeKb: 1),
  const BlockDef(id: 'node_has_data', family: BlockFamily.sensor, sizeKb: 1),
  const BlockDef(id: 'if_else', family: BlockFamily.controlFlow, sizeKb: 2),
];

NetworkDef _network() => NetworkDef(id: 'n', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['data']),
      const NetworkNodeDef(id: 'data', type: NodeType.data, edges: ['entry'],
          data: DataDef(value: 10, verified: true)),
      for (var i = 0; i < 6; i++) NetworkNodeDef(id: 's$i', type: NodeType.relay, edges: const []),
    ]);

void main() {
  test('process() resolves a real battle and classifies the outcome', () {
    const winningProgram = DagDef(nodes: [
      DagNode(id: 'has', blockId: 'carrying_data', out: {'next': 'branch_carry'}),
      DagNode(id: 'branch_carry', blockId: 'if_else', out: {'true': 'go_exit', 'false': 'check_here'}),
      DagNode(id: 'go_exit', blockId: 'move_toward_exit'),
      DagNode(id: 'check_here', blockId: 'node_has_data', out: {'next': 'branch_here'}),
      DagNode(id: 'branch_here', blockId: 'if_else', out: {'true': 'copy', 'false': 'go_data'}),
      DagNode(id: 'copy', blockId: 'copy_data'),
      DagNode(id: 'go_data', blockId: 'move_toward_data'),
    ], entry: 'has');

    final resolution = BattleWorker.process(
      defenseNetwork: _network(),
      virusDef: const VirusDef(program: winningProgram),
      balance: BalanceConfig.defaults,
      blockCatalog: _catalog,
      seed: 42,
      attackerRating: 1000,
      defenderRating: 1000,
      attackerGamesPlayed: 50,
    );

    expect(resolution.log.result.dataExfiltrated, greaterThan(0));
    expect(resolution.outcome, BattleOutcome.attackerWin);
    expect(resolution.ratingDelta, greaterThan(0));
    expect(resolution.storage.storeInline, isTrue);
  });

  test('process() is deterministic for the same seed', () {
    const program = DagDef(nodes: [DagNode(id: 'a', blockId: 'wait')], entry: 'a');
    final a = BattleWorker.process(
      defenseNetwork: _network(),
      virusDef: const VirusDef(program: program),
      balance: BalanceConfig.defaults,
      blockCatalog: _catalog,
      seed: 7,
      attackerRating: 1000,
      defenderRating: 1000,
      attackerGamesPlayed: 5,
    );
    final b = BattleWorker.process(
      defenseNetwork: _network(),
      virusDef: const VirusDef(program: program),
      balance: BalanceConfig.defaults,
      blockCatalog: _catalog,
      seed: 7,
      attackerRating: 1000,
      defenderRating: 1000,
      attackerGamesPlayed: 5,
    );
    expect(a.log.result.score, b.log.result.score);
    expect(a.outcome, b.outcome);
    expect(a.ratingDelta, b.ratingDelta);
  });

  test('a definitively defeated attacker gets a negative rating delta', () {
    // self_destruct guarantees survivingCopies == 0 and dataExfiltrated ==
    // 0, i.e. a clean defenderWin, so the rating math has an unambiguous
    // loss to react to.
    const selfDestructs = DagDef(nodes: [DagNode(id: 'a', blockId: 'self_destruct')], entry: 'a');
    final resolution = BattleWorker.process(
      defenseNetwork: _network(),
      virusDef: const VirusDef(program: selfDestructs),
      balance: BalanceConfig.defaults,
      blockCatalog: _catalog,
      seed: 1,
      attackerRating: 1200,
      defenderRating: 800,
      attackerGamesPlayed: 50,
    );
    expect(resolution.outcome, BattleOutcome.defenderWin);
    expect(resolution.ratingDelta, lessThan(0));
  });
}
