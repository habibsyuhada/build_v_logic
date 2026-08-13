import 'package:content_schema/content_schema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:payload_app/features/campaign/campaign_controller.dart';
import 'package:payload_app/features/campaign/campaign_screen.dart';
import 'package:payload_app/features/campaign/mission_screen.dart';
import 'package:payload_app/features/core/content/content_repository.dart';
import 'package:payload_app/features/core/storage/campaign_storage.dart';
import 'package:payload_app/features/replay/replay_screen.dart';
import 'package:provider/provider.dart';
import 'package:sim_core/sim_core.dart';

const _catalog = [
  BlockDef(id: 'wait', family: BlockFamily.action, sizeKb: 1),
  BlockDef(id: 'move_toward_data', family: BlockFamily.action, sizeKb: 5, energyCost: 3, noise: 1),
  BlockDef(id: 'copy_data', family: BlockFamily.action, sizeKb: 4, energyCost: 4, noise: 2),
  BlockDef(id: 'move_toward_exit', family: BlockFamily.action, sizeKb: 5, energyCost: 3, noise: 1),
  BlockDef(id: 'carrying_data', family: BlockFamily.sensor, sizeKb: 1),
  BlockDef(id: 'node_has_data', family: BlockFamily.sensor, sizeKb: 1),
  BlockDef(id: 'if_else', family: BlockFamily.controlFlow, sizeKb: 2),
];

NetworkDef _missionNetwork(String id) => NetworkDef(id: 'net_$id', nodes: [
      const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['data']),
      const NetworkNodeDef(id: 'data', type: NodeType.data, edges: ['entry'],
          data: DataDef(value: 10, verified: true)),
      for (var i = 0; i < 6; i++) NetworkNodeDef(id: 's$i', type: NodeType.relay, edges: const []),
    ]);

ContentRepository _content() {
  final missions = [
    MissionDef(
      id: 'ch1_m1',
      chapter: 1,
      indexInChapter: 1,
      title: 'First contact',
      networkId: 'net_ch1_m1',
      dialog: const ['Welcome, operator.'],
      starCriteria: const MissionStarCriteria(maxNoiseForStar: 999, maxTickForStar: 999),
    ),
    MissionDef(
      id: 'ch1_m2',
      chapter: 1,
      indexInChapter: 2,
      title: 'Second run',
      networkId: 'net_ch1_m2',
      starCriteria: const MissionStarCriteria(maxNoiseForStar: 999, maxTickForStar: 999),
    ),
  ];
  return ContentRepository.forTesting(
    blocks: _catalog,
    balance: BalanceConfig.defaults,
    trainingNetwork: _missionNetwork('train'),
    missions: missions,
    networksByMissionId: {
      'ch1_m1': _missionNetwork('ch1_m1'),
      'ch1_m2': _missionNetwork('ch1_m2'),
    },
  );
}

Widget _harness(ContentRepository content, CampaignController campaign) {
  final router = GoRouter(routes: [
    GoRoute(path: '/', builder: (context, state) => const CampaignScreen()),
    GoRoute(
      path: '/campaign/:missionId',
      builder: (context, state) => MissionScreen(missionId: state.pathParameters['missionId']!),
    ),
    GoRoute(
      path: '/replay',
      builder: (context, state) {
        final extra = state.extra as Map<String, Object?>;
        return ReplayScreen(network: extra['network'] as NetworkDef, log: extra['log'] as BattleLog);
      },
    ),
  ]);
  return MultiProvider(
    providers: [
      Provider<ContentRepository>.value(value: content),
      ChangeNotifierProvider<CampaignController>.value(value: campaign),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

void main() {
  testWidgets('chapter 1 expands to show its missions with lock state', (tester) async {
    final content = _content();
    final campaign = CampaignController(content: content, storage: InMemoryCampaignStorage());
    await campaign.load();

    await tester.pumpWidget(_harness(content, campaign));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('chapter_1')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('mission_tile_ch1_m1')), findsOneWidget);
    expect(find.byKey(const Key('mission_tile_ch1_m2')), findsOneWidget);

    final tile2 = tester.widget<ListTile>(find.byKey(const Key('mission_tile_ch1_m2')));
    expect(tile2.enabled, isFalse); // locked until mission 1 earns a star
  });

  testWidgets('full loop: open mission, dismiss briefing, launch attack, see stars, view replay',
      (tester) async {
    final content = _content();
    final campaign = CampaignController(content: content, storage: InMemoryCampaignStorage());
    await campaign.load();

    await tester.pumpWidget(_harness(content, campaign));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('chapter_1')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('mission_tile_ch1_m1')));
    await tester.pumpAndSettle();

    // Briefing dialog shows first.
    expect(find.text('Welcome, operator.'), findsOneWidget);
    await tester.tap(find.text('got it'));
    await tester.pumpAndSettle();

    // Build a virus that actually wins: chase data, copy it, chase the exit.
    await tester.tap(find.text('carrying_data'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('node_has_data'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('copy_data'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('move_toward_data'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('move_toward_exit'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('run_test_button')));
    await tester.pumpAndSettle();

    // Result dialog should have appeared with a star count.
    expect(find.textContaining('★ earned'), findsOneWidget);

    await tester.tap(find.byKey(const Key('view_replay_button')));
    // The replay screen hosts a continuously-running Flame game loop, so
    // pumpAndSettle would never settle here — pump a few fixed frames
    // instead (same approach as replay_screen_test.dart).
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));

    expect(find.byKey(const Key('replay_game_widget')), findsOneWidget);
  });
}
