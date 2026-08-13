import 'dart:convert';
import 'dart:io';

import 'package:content_schema/content_schema.dart';

/// Generates the campaign content tree (§1.5, §3.5): 60 missions (6
/// chapters x 10), one training network per mission, and the
/// `unlock_mission` assignment on `content/blocks.json`.
///
/// Per §3.5 ("boleh generate draft lalu curated") this is an explicitly
/// sanctioned first-pass generator, not hand-curated content — designers
/// re-running this script is expected as the catalog evolves. Re-running
/// it is idempotent (same inputs -> same output files).
///
/// Usage: dart run tools/mission_gen/bin/generate_missions.dart [content_dir]
void main(List<String> args) {
  final contentDir = args.isNotEmpty ? args[0] : 'content';

  final blocksFile = File('$contentDir/blocks.json');
  final blocksRaw = jsonDecode(blocksFile.readAsStringSync()) as List;
  final blocks =
      blocksRaw.map((e) => BlockDef.fromJson(e as Map<String, dynamic>)).toList();

  // Starter kit: enough to build a working (if crude) virus that can
  // actually complete the core loop — wander, sense, grab data, branch —
  // without any unlock. `copy_data` is included deliberately: without it,
  // no early mission could ever earn the "selesai" star via a real
  // exfiltration (only via surviving), which would make chapter 1 a
  // hollow tutorial. See docs/DECISIONS.md.
  const starterIds = {
    'wait',
    'move_random',
    'if_else',
    'sequence',
    'firewall_detected',
    'copy_data',
  };
  final unlockOrder = blocks.where((b) => !starterIds.contains(b.id)).toList();

  // 5 chapters' worth of missions (50 slots) carry unlocks; chapter 6 is a
  // pure "mastery" gauntlet with everything already unlocked.
  final missionSlots = <String>[
    for (var ch = 1; ch <= 5; ch++)
      for (var m = 1; m <= 10; m++) 'ch${ch}_m$m',
  ];
  assert(unlockOrder.length <= missionSlots.length);

  final unlockMissionByBlockId = <String, String>{};
  for (var i = 0; i < unlockOrder.length; i++) {
    unlockMissionByBlockId[unlockOrder[i].id] = missionSlots[i];
  }

  final updatedBlocks = blocks
      .map((b) => BlockDef(
            id: b.id,
            family: b.family,
            sizeKb: b.sizeKb,
            energyCost: b.energyCost,
            noise: b.noise,
            paramsSchema: b.paramsSchema,
            unlockMission: unlockMissionByBlockId[b.id],
          ))
      .toList();
  blocksFile.writeAsStringSync(
      const JsonEncoder.withIndent('  ').convert(updatedBlocks.map((b) => b.toJson()).toList()) +
          '\n');

  final missionsDir = Directory('$contentDir/missions')..createSync(recursive: true);
  final networksDir = Directory('$contentDir/networks')..createSync(recursive: true);

  var unlockCursor = 0;
  for (var chapter = 1; chapter <= 6; chapter++) {
    for (var index = 1; index <= 10; index++) {
      final missionId = 'ch${chapter}_m$index';
      final networkId = 'net_mission_$missionId';

      final network = _buildNetwork(networkId, chapter, index);
      networksDir
          .childFile('mission_$missionId.json')
          .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(network.toJson()) + '\n');

      String? unlockedBlockId;
      if (chapter <= 5 && unlockCursor < unlockOrder.length) {
        final candidate = unlockOrder[unlockCursor];
        if (unlockMissionByBlockId[candidate.id] == missionId) {
          unlockedBlockId = candidate.id;
          unlockCursor++;
        }
      }

      final mission = MissionDef(
        id: missionId,
        chapter: chapter,
        indexInChapter: index,
        title: _titleFor(chapter, index, unlockedBlockId),
        networkId: networkId,
        unlocksBlocks: unlockedBlockId == null ? const [] : [unlockedBlockId],
        starCriteria: MissionStarCriteria(
          maxNoiseForStar: (65 - (chapter - 1) * 6).clamp(20, 100),
          maxTickForStar: 60 + chapter * 15 + index * 3,
        ),
        dialog: _dialogFor(chapter, index, unlockedBlockId),
      );
      missionsDir
          .childFile('$missionId.json')
          .writeAsStringSync(const JsonEncoder.withIndent('  ').convert(mission.toJson()) + '\n');
    }
  }

  stdout.writeln('mission_gen: wrote 60 missions + 60 networks, '
      '${unlockOrder.length} blocks assigned an unlock_mission.');
}

extension on Directory {
  File childFile(String name) => File('$path/$name');
}

NetworkDef _buildNetwork(String id, int chapter, int index) {
  final nodeCount = (8 + (chapter - 1) * 2).clamp(8, 24);
  final relayCount = nodeCount - 3; // entry + gate + data
  final firewallLevel = (chapter - 1).clamp(0, 5);
  final dataValue = 10 + chapter * 5 + index;
  final guarded = chapter >= 3 && index.isEven;

  const guardLogic = DagDef(nodes: [
    DagNode(id: 'det', blockId: 'intruder_bruteforcing', out: {'next': 'branch'}),
    DagNode(id: 'branch', blockId: 'if_else', out: {'true': 'alarm'}),
    DagNode(id: 'alarm', blockId: 'raise_alarm'),
  ], entry: 'det');

  final nodes = <NetworkNodeDef>[];
  nodes.add(const NetworkNodeDef(id: 'entry', type: NodeType.entry, edges: ['r1']));
  for (var i = 1; i <= relayCount; i++) {
    final next = i == relayCount ? 'gate' : 'r${i + 1}';
    nodes.add(NetworkNodeDef(id: 'r$i', type: NodeType.relay, edges: [next]));
  }
  nodes.add(NetworkNodeDef(
    id: 'gate',
    type: NodeType.relay,
    edges: const ['data'],
    firewall: FirewallDef(level: firewallLevel),
    defenseLogic: guarded ? guardLogic.toJson() : null,
    avRoute: guarded ? const ['gate', 'r1'] : const [],
  ));
  nodes.add(NetworkNodeDef(
    id: 'data',
    type: NodeType.data,
    edges: const ['entry'],
    data: DataDef(value: dataValue, verified: true),
  ));

  return NetworkDef(id: id, nodes: nodes);
}

String _titleFor(int chapter, int index, String? unlockedBlockId) {
  if (unlockedBlockId != null) return 'Ch$chapter.$index — unlock: $unlockedBlockId';
  return 'Ch$chapter.$index — field run';
}

List<String> _dialogFor(int chapter, int index, String? unlockedBlockId) {
  final lines = <String>[
    'Another network, another crack in the wall.',
  ];
  if (unlockedBlockId != null) {
    lines.add('New tool acquired: `$unlockedBlockId`. Wire it in.');
  }
  if (index == 10) {
    lines.add('Chapter $chapter, cleared. They\'ll notice soon.');
  }
  return lines;
}
