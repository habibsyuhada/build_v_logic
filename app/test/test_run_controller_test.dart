import 'package:content_schema/content_schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/replay/test_run_controller.dart';

NetworkDef _tinyNetwork() => NetworkDef(id: 'tiny', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['data']),
      const NetworkNodeDef(id: 'data', type: NodeType.data, edges: ['entry'],
          data: DataDef(value: 5, verified: true)),
      for (var i = 0; i < 6; i++) NetworkNodeDef(id: 's$i', type: NodeType.relay, edges: const []),
    ]);

final _blocks = [
  const BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 2),
  const BlockDef(id: 'move_random', family: BlockFamily.action, sizeKb: 2, energyCost: 2, noise: 1),
];

void main() {
  test('run() populates a result and resets tick to 0', () {
    final controller = TestRunController();
    controller.run(
      network: _tinyNetwork(),
      virusDef: const VirusDef(program: DagDef(nodes: [DagNode(id: 'a', blockId: 'wait')], entry: 'a')),
      balance: BalanceConfig.defaults,
      blockCatalog: _blocks,
      seed: 1,
    );
    expect(controller.hasResult, isTrue);
    expect(controller.tick, 0);
    expect(controller.maxTick, 600); // wait-forever runs to the tick cap
  });

  test('stepForward/stepBack/scrubTo stay within [0, maxTick]', () {
    final controller = TestRunController();
    controller.run(
      network: _tinyNetwork(),
      virusDef: const VirusDef(program: DagDef(nodes: [DagNode(id: 'a', blockId: 'wait')], entry: 'a')),
      balance: BalanceConfig.defaults,
      blockCatalog: _blocks,
      seed: 1,
    );

    controller.stepBack(); // already at 0, should clamp
    expect(controller.tick, 0);

    controller.stepForward();
    expect(controller.tick, 1);

    controller.scrubTo(999999);
    expect(controller.tick, controller.maxTick);

    controller.scrubTo(-5);
    expect(controller.tick, 0);
  });

  test('snapshotAtCurrentTick exposes per-tick virus energy for the inspector', () {
    final controller = TestRunController();
    controller.run(
      network: _tinyNetwork(),
      virusDef:
          const VirusDef(program: DagDef(nodes: [DagNode(id: 'a', blockId: 'move_random')], entry: 'a')),
      balance: BalanceConfig.defaults,
      blockCatalog: _blocks,
      seed: 1,
    );
    controller.scrubTo(1);
    final snap = controller.snapshotAtCurrentTick;
    expect(snap, isNotNull);
    expect(snap!.virusCopies.single.energy, lessThan(BalanceConfig.defaults.startingEnergy));
  });

  test('clear() resets to no-result state', () {
    final controller = TestRunController();
    controller.run(
      network: _tinyNetwork(),
      virusDef: const VirusDef(program: DagDef(nodes: [DagNode(id: 'a', blockId: 'wait')], entry: 'a')),
      balance: BalanceConfig.defaults,
      blockCatalog: _blocks,
      seed: 1,
    );
    controller.clear();
    expect(controller.hasResult, isFalse);
    expect(controller.log, isNull);
  });
}
