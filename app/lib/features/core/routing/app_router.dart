import 'package:content_schema/content_schema.dart';
import 'package:go_router/go_router.dart';
import 'package:sim_core/sim_core.dart';

import '../../blueprints/blueprints_screen.dart';
import '../../campaign/campaign_screen.dart';
import '../../campaign/mission_screen.dart';
import '../../network_builder/network_builder_screen.dart';
import '../../profile/profile_screen.dart';
import '../../pvp/pvp_screen.dart';
import '../../replay/replay_screen.dart';
import '../../settings/settings_screen.dart';
import '../../shop/shop_screen.dart';
import '../../workbench/workbench_screen.dart';
import '../content/content_repository.dart';

/// App-wide routing (§2.2 `features/core`). Workbench is the Phase 2
/// entry point; the rest are placeholder routes so the navigation
/// structure is stable before their features land in later phases.
GoRouter buildAppRouter(ContentRepository content) {
  return GoRouter(
    initialLocation: '/workbench',
    routes: [
      GoRoute(
        path: '/workbench',
        builder: (context, state) => WorkbenchScreen(content: content),
      ),
      GoRoute(
        path: '/campaign',
        builder: (context, state) => const CampaignScreen(),
      ),
      GoRoute(
        path: '/campaign/:missionId',
        builder: (context, state) =>
            MissionScreen(missionId: state.pathParameters['missionId']!),
      ),
      GoRoute(
        path: '/replay',
        builder: (context, state) {
          final extra = state.extra as Map<String, Object?>;
          return ReplayScreen(
            network: extra['network'] as NetworkDef,
            log: extra['log'] as BattleLog,
          );
        },
      ),
      GoRoute(
        path: '/pvp',
        builder: (context, state) => const PvpScreen(),
      ),
      GoRoute(
        path: '/blueprints',
        builder: (context, state) => const BlueprintsScreen(),
      ),
      GoRoute(
        path: '/network-builder',
        builder: (context, state) => const NetworkBuilderScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/shop',
        builder: (context, state) => const ShopScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}
