import 'dart:convert';

import 'package:content_schema/content_schema.dart';
import 'package:flutter/services.dart' show AssetBundle;

/// All campaign mission ids, in play order (§1.5: 6 chapters x 10
/// missions). Matches exactly what `tools/mission_gen` generates —
/// hardcoded here rather than discovered via an asset manifest so content
/// loading doesn't depend on manifest-format details across Flutter
/// versions.
List<String> allCampaignMissionIds() => [
      for (var ch = 1; ch <= 6; ch++)
        for (var m = 1; m <= 10; m++) 'ch${ch}_m$m',
    ];

/// Loads `content/*.json` (§2.2, §2.6 "content as data") from the app's
/// asset bundle. A day-one PvE/offline install ships a baked-in snapshot;
/// Phase 4+ adds a remote-config sync layer on top without changing this
/// interface.
class ContentRepository {
  final List<BlockDef> blocks;
  final Map<String, BlockDef> blocksById;
  final BalanceConfig balance;
  final NetworkDef trainingNetwork;
  final List<MissionDef> missions;
  final Map<String, NetworkDef> networksByMissionId;

  ContentRepository._({
    required this.blocks,
    required this.balance,
    required this.trainingNetwork,
    required this.missions,
    required this.networksByMissionId,
  }) : blocksById = {for (final b in blocks) b.id: b};

  static Future<ContentRepository> load(AssetBundle bundle) async {
    final blocksRaw = jsonDecode(await bundle.loadString('assets/content/blocks.json')) as List;
    final blocks =
        blocksRaw.map((e) => BlockDef.fromJson(e as Map<String, dynamic>)).toList();

    final balanceRaw =
        jsonDecode(await bundle.loadString('assets/content/balance.json')) as Map<String, dynamic>;
    final balance = BalanceConfig.fromJson(balanceRaw);

    final networkRaw = jsonDecode(
            await bundle.loadString('assets/content/networks/training_01.json'))
        as Map<String, dynamic>;
    final trainingNetwork = NetworkDef.fromJson(networkRaw);

    final missions = <MissionDef>[];
    final networksByMissionId = <String, NetworkDef>{};
    for (final missionId in allCampaignMissionIds()) {
      final missionRaw = jsonDecode(await bundle.loadString('assets/content/missions/$missionId.json'))
          as Map<String, dynamic>;
      final mission = MissionDef.fromJson(missionRaw);
      missions.add(mission);

      final missionNetworkRaw = jsonDecode(
              await bundle.loadString('assets/content/networks/mission_$missionId.json'))
          as Map<String, dynamic>;
      networksByMissionId[missionId] = NetworkDef.fromJson(missionNetworkRaw);
    }

    return ContentRepository._(
      blocks: blocks,
      balance: balance,
      trainingNetwork: trainingNetwork,
      missions: missions,
      networksByMissionId: networksByMissionId,
    );
  }

  /// Bypasses asset loading — for tests that don't want a real asset
  /// bundle in the loop.
  factory ContentRepository.forTesting({
    required List<BlockDef> blocks,
    required BalanceConfig balance,
    required NetworkDef trainingNetwork,
    List<MissionDef> missions = const [],
    Map<String, NetworkDef> networksByMissionId = const {},
  }) =>
      ContentRepository._(
        blocks: blocks,
        balance: balance,
        trainingNetwork: trainingNetwork,
        missions: missions,
        networksByMissionId: networksByMissionId,
      );

  List<BlockDef> byFamily(BlockFamily family) =>
      blocks.where((b) => b.family == family).toList(growable: false);

  /// Blocks unlocked with no mission requirement — the starter kit
  /// (`unlock_mission == null`).
  List<BlockDef> get starterBlocks =>
      blocks.where((b) => b.unlockMission == null).toList(growable: false);
}
