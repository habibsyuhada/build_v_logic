import 'package:content_schema/content_schema.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sim_core/sim_core.dart';

import '../core/content/content_repository.dart';
import '../core/theme/payload_theme.dart';
import '../workbench/workbench_screen.dart';
import 'campaign_controller.dart';

/// One mission's attack screen: briefing dialog on first entry, then the
/// workbench targeting this mission's network, restricted to the player's
/// currently-unlocked blocks. A resolved battle awards stars via
/// [CampaignController.completeMission] and offers a replay.
class MissionScreen extends StatefulWidget {
  final String missionId;

  const MissionScreen({super.key, required this.missionId});

  @override
  State<MissionScreen> createState() => _MissionScreenState();
}

class _MissionScreenState extends State<MissionScreen> {
  bool _briefingShown = false;

  @override
  Widget build(BuildContext context) {
    final content = context.read<ContentRepository>();
    final campaign = context.watch<CampaignController>();

    final mission = content.missions.firstWhere((m) => m.id == widget.missionId);
    final network = content.networksByMissionId[widget.missionId];
    if (network == null) {
      return Scaffold(body: Center(child: Text('missing network for ${widget.missionId}')));
    }

    if (!_briefingShown) {
      _briefingShown = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => _showBriefing(context, mission));
    }

    final allowedBlocks =
        content.blocks.where((b) => campaign.isBlockUnlocked(b.id)).toList();

    return WorkbenchScreen(
      content: content,
      targetNetwork: network,
      allowedBlocks: allowedBlocks,
      title: mission.title,
      runButtonTooltip: 'Launch attack',
      onBattleResolved: (log) => _handleResult(context, mission, log),
    );
  }

  void _showBriefing(BuildContext context, MissionDef mission) {
    if (!context.mounted) return;
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(mission.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final line in mission.dialog) Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(line),
            ),
            const SizedBox(height: 8),
            Text(
              'stars: complete · noise < ${mission.starCriteria.maxNoiseForStar} · '
              'ticks ≤ ${mission.starCriteria.maxTickForStar}',
              style: const TextStyle(color: PayloadColors.textMuted, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('got it')),
        ],
      ),
    );
  }

  Future<void> _handleResult(BuildContext context, MissionDef mission, BattleLog log) async {
    final campaign = context.read<CampaignController>();
    final network = context.read<ContentRepository>().networksByMissionId[mission.id]!;
    final stars = await campaign.completeMission(mission, log.result);
    if (!context.mounted) return;

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$stars★ earned'),
        content: Text(
          'score: ${log.result.score}\n'
          'exfil: ${log.result.dataExfiltrated}\n'
          'survived: ${log.result.survivingCopies}\n'
          'peak noise: ${log.result.peakNoiseMeter}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('close'),
          ),
          TextButton(
            key: const Key('view_replay_button'),
            onPressed: () {
              Navigator.of(context).pop();
              context.push('/replay', extra: {'network': network, 'log': log});
            },
            child: const Text('view replay'),
          ),
        ],
      ),
    );
  }
}
