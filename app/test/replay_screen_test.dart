import 'package:content_schema/content_schema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payload_app/features/replay/replay_screen.dart';
import 'package:sim_core/sim_core.dart';

NetworkDef _network() => NetworkDef(id: 'n', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['data']),
      const NetworkNodeDef(id: 'data', type: NodeType.data, edges: []),
      for (var i = 0; i < 6; i++) NetworkNodeDef(id: 's$i', type: NodeType.relay, edges: const []),
    ]);

BattleLog _log() => resolveBattle(
      network: _network(),
      virusDef: const VirusDef(
          program: DagDef(nodes: [DagNode(id: 'a', blockId: 'move_random')], entry: 'a')),
      balance: BalanceConfig.defaults,
      blockCatalog: const [
        BlockDef(id: 'move_random', family: BlockFamily.action, sizeKb: 2, energyCost: 2, noise: 1),
      ],
      seed: 1,
    );

void main() {
  testWidgets('renders the Flame game and playback controls', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ReplayScreen(network: _network(), log: _log())));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.byKey(const Key('replay_game_widget')), findsOneWidget);
    expect(find.byKey(const Key('replay_scrubber')), findsOneWidget);
    expect(find.byKey(const Key('replay_play_pause_button')), findsOneWidget);
  });

  testWidgets('play/pause button toggles the icon', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ReplayScreen(network: _network(), log: _log())));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    await tester.tap(find.byKey(const Key('replay_play_pause_button')));
    await tester.pump();
    expect(find.byIcon(Icons.pause), findsOneWidget);

    // Stop the running timer before the test disposes the widget tree.
    await tester.tap(find.byKey(const Key('replay_skip_to_result_button')));
    await tester.pump();
  });

  testWidgets('export GIF button renders a clip and shows its size', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ReplayScreen(network: _network(), log: _log())));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));

    await tester.tap(find.byKey(const Key('replay_export_gif_button')));
    await tester.pump();

    expect(find.textContaining('Replay GIF rendered'), findsOneWidget);
  });

  testWidgets('skip to result shows the result banner', (tester) async {
    await tester.pumpWidget(MaterialApp(home: ReplayScreen(network: _network(), log: _log())));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));

    await tester.tap(find.byKey(const Key('replay_skip_to_result_button')));
    await tester.pump();

    expect(find.byKey(const Key('replay_result_banner')), findsOneWidget);
  });
}
