import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../core/theme/payload_theme.dart';
import 'campaign_controller.dart';

/// Campaign chapter/mission list (§1.5): 6 chapters x 10 missions, stars
/// earned so far, and linear mission availability.
class CampaignScreen extends StatelessWidget {
  const CampaignScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final campaign = context.watch<CampaignController>();
    if (!campaign.isLoaded) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('campaign — ${campaign.progress.totalStars}★ total'),
      ),
      backgroundColor: PayloadColors.background,
      body: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, i) {
          final chapter = i + 1;
          final missions = campaign.missionsForChapter(chapter);
          return ExpansionTile(
            key: Key('chapter_$chapter'),
            title: Text('Chapter $chapter'),
            children: [
              for (final mission in missions)
                _MissionTile(missionId: mission.id, title: mission.title),
            ],
          );
        },
      ),
    );
  }
}

class _MissionTile extends StatelessWidget {
  final String missionId;
  final String title;

  const _MissionTile({required this.missionId, required this.title});

  @override
  Widget build(BuildContext context) {
    final campaign = context.watch<CampaignController>();
    final available = campaign.isMissionAvailable(missionId);
    final stars = campaign.starsFor(missionId);

    return ListTile(
      key: Key('mission_tile_$missionId'),
      enabled: available,
      leading: Icon(available ? Icons.lock_open : Icons.lock, size: 18),
      title: Text(title, style: TextStyle(color: available ? null : PayloadColors.textMuted)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var s = 0; s < 3; s++)
            Icon(Icons.star, size: 14, color: s < stars ? PayloadColors.warningAmber : PayloadColors.textMuted),
        ],
      ),
      onTap: available ? () => context.push('/campaign/$missionId') : null,
    );
  }
}
