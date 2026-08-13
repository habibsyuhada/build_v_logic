import 'package:content_schema/content_schema.dart';
import 'package:flutter/foundation.dart';
import 'package:sim_core/sim_core.dart';

import '../core/content/content_repository.dart';
import '../core/storage/campaign_storage.dart';
import 'models/campaign_progress.dart';

/// Drives campaign progression (§1.5): mission availability (linear —
/// mission N unlocks once mission N-1 has at least 1 star), stars earned,
/// and which blocks are unlocked. Missions are the single unlock source
/// for both attack and defense-family blocks (see docs/DECISIONS.md).
class CampaignController extends ChangeNotifier {
  final ContentRepository content;
  final CampaignStorage storage;

  CampaignProgress _progress = const CampaignProgress();
  bool _loaded = false;

  CampaignController({required this.content, required this.storage});

  CampaignProgress get progress => _progress;
  bool get isLoaded => _loaded;

  Future<void> load() async {
    _progress = await storage.load();
    _loaded = true;
    notifyListeners();
  }

  List<MissionDef> missionsForChapter(int chapter) =>
      content.missions.where((m) => m.chapter == chapter).toList()
        ..sort((a, b) => a.indexInChapter.compareTo(b.indexInChapter));

  int starsFor(String missionId) => _progress.starsFor(missionId);

  bool isMissionAvailable(String missionId) {
    final missions = content.missions;
    final idx = missions.indexWhere((m) => m.id == missionId);
    if (idx <= 0) return true; // first mission (or unknown id) is always open
    final previous = missions[idx - 1];
    return starsFor(previous.id) > 0;
  }

  Set<String> get unlockedBlockIds =>
      {...content.starterBlocks.map((b) => b.id), ..._progress.unlockedBlockIds};

  bool isBlockUnlocked(String blockId) => unlockedBlockIds.contains(blockId);

  /// Computes the 3-star breakdown for a resolved battle against
  /// [mission]'s criteria and persists the best result so far. Returns the
  /// stars earned *this run* (not the best-ever) so the UI can show a
  /// fresh "3 stars!" moment.
  Future<int> completeMission(MissionDef mission, BattleResult result) async {
    var stars = 0;
    if (result.dataExfiltrated > 0 || result.survivingCopies > 0) stars++; // selesai
    if (result.peakNoiseMeter < mission.starCriteria.maxNoiseForStar) stars++; // senyap
    if (result.ticksUsed <= mission.starCriteria.maxTickForStar) stars++; // efisien

    final unlockedBlockId = mission.unlocksBlocks.isEmpty ? null : mission.unlocksBlocks.first;
    _progress = _progress.withMissionResult(mission.id, stars, unlockedBlockId: unlockedBlockId);
    await storage.save(_progress);
    notifyListeners();
    return stars;
  }
}
