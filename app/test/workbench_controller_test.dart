import 'package:content_schema/content_schema.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/core/content/content_repository.dart';
import 'package:payload_app/features/workbench/workbench_controller.dart';

ContentRepository _content() {
  final blocks = [
    const BlockDef(id: 'move_random', family: BlockFamily.action, sizeKb: 2, energyCost: 2, noise: 1),
    const BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 2),
    const BlockDef(id: 'firewall_detected', family: BlockFamily.sensor, sizeKb: 1),
    const BlockDef(id: 'if_else', family: BlockFamily.controlFlow, sizeKb: 2),
  ];
  return ContentRepository.forTesting(
    blocks: blocks,
    balance: BalanceConfig.defaults,
    trainingNetwork: NetworkDef(id: 'train', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['data']),
      const NetworkNodeDef(id: 'data', type: NodeType.data, edges: ['entry']),
      for (var i = 0; i < 6; i++) NetworkNodeDef(id: 's$i', type: NodeType.relay, edges: const []),
    ]),
  );
}

void main() {
  late WorkbenchController controller;

  setUp(() {
    controller = WorkbenchController(content: _content(), capacityKb: 40);
  });

  test('first added node becomes the entry automatically', () {
    final id = controller.addNode('wait');
    expect(controller.entryNodeId, id);
  });

  test('totalSizeKb sums the size_kb of every placed block', () {
    controller.addNode('move_random'); // 2 KB
    controller.addNode('wait'); // 2 KB
    expect(controller.totalSizeKb, 4);
  });

  test('isOverBudget flips once total size exceeds capacity', () {
    final small = WorkbenchController(content: _content(), capacityKb: 1);
    small.addNode('move_random'); // 2 KB > 1 KB capacity
    expect(small.isOverBudget, isTrue);
  });

  test('connect via tap-to-connect wires an out edge with the chosen branch', () {
    final a = controller.addNode('firewall_detected');
    final b = controller.addNode('wait');
    controller.startConnect(a);
    controller.completeConnect(b, branch: 'next');
    expect(controller.nodeById(a)!.out, {'next': b});
    expect(controller.connectFromNodeId, isNull);
  });

  test('deleting a node removes edges pointing to it and clears entry if needed', () {
    final a = controller.addNode('firewall_detected');
    final b = controller.addNode('wait');
    controller.startConnect(a);
    controller.completeConnect(b, branch: 'next');

    controller.deleteNode(b);
    expect(controller.nodeById(a)!.out, isEmpty);
    expect(controller.entryNodeId, a);

    controller.deleteNode(a);
    expect(controller.entryNodeId, isNull);
    expect(controller.nodes, isEmpty);
  });

  test('lint surfaces the same validateDag errors the server would see (locked-block reuse via capacity)', () {
    final tiny = WorkbenchController(content: _content(), capacityKb: 1);
    tiny.addNode('move_random'); // 2 KB, over the 1 KB capacity
    final result = tiny.lint;
    expect(result.isValid, isFalse);
    expect(result.errors.any((e) => e.contains('exceeds capacity')), isTrue);
  });

  test('lint on an empty workbench reports a friendly error, not a crash', () {
    expect(controller.lint.isValid, isFalse);
  });

  test('buildDagDef round-trips into a DagDef sim_core can execute', () {
    final a = controller.addNode('firewall_detected');
    final b = controller.addNode('wait');
    controller.startConnect(a);
    controller.completeConnect(b, branch: 'next');

    final dag = controller.buildDagDef()!;
    expect(dag.entry, a);
    expect(dag.nodeById(a)!.out['next'], b);
  });
}
