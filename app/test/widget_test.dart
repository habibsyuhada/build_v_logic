import 'package:content_schema/content_schema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/app.dart';
import 'package:payload_app/features/core/content/content_repository.dart';

ContentRepository _fixtureContent() {
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
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['r1']),
      const NetworkNodeDef(id: 'r1', type: NodeType.relay, edges: ['data']),
      const NetworkNodeDef(id: 'data', type: NodeType.data, edges: ['entry'],
          data: DataDef(value: 10, verified: true)),
      const NetworkNodeDef(id: 's1', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's2', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's3', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's4', type: NodeType.relay, edges: []),
      const NetworkNodeDef(id: 's5', type: NodeType.relay, edges: []),
    ]),
  );
}

void main() {
  testWidgets('app boots to the workbench screen', (WidgetTester tester) async {
    await tester.pumpWidget(PayloadApp(content: _fixtureContent()));
    await tester.pumpAndSettle();

    expect(find.text('workbench'), findsOneWidget);
    expect(find.byKey(const Key('block_tray_list')), findsOneWidget);
  });

  testWidgets('tapping a block in the tray adds it to the canvas', (WidgetTester tester) async {
    await tester.pumpWidget(PayloadApp(content: _fixtureContent()));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('node_n0')), findsNothing);
    await tester.tap(find.text('move_random'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('node_n0')), findsOneWidget);
    expect(find.byKey(const Key('budget_size_label')), findsOneWidget);
    expect(find.text('2 / 40 KB'), findsOneWidget);
  });

  testWidgets('Test Run button is disabled with an empty canvas and enabled after adding a block',
      (WidgetTester tester) async {
    await tester.pumpWidget(PayloadApp(content: _fixtureContent()));
    await tester.pumpAndSettle();

    final runButtonFinder = find.byKey(const Key('run_test_button'));
    IconButton runButton = tester.widget(runButtonFinder);
    expect(runButton.onPressed, isNull);

    await tester.tap(find.text('wait'));
    await tester.pumpAndSettle();

    runButton = tester.widget(runButtonFinder);
    expect(runButton.onPressed, isNotNull);

    await tester.tap(runButtonFinder);
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('test_run_summary')), findsOneWidget);
    expect(find.byKey(const Key('timeline_scrubber')), findsOneWidget);
  });
}
