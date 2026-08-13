/// Per-mission stars earned (§1.5: "Misi 3-star: selesai / senyap / efisien"
/// — completed / silent (low noise) / efficient (few ticks), each earned
/// independently) plus which blocks have been unlocked by completing
/// missions. Locally persisted in Phase 3; Phase 4 adds cloud sync on top
/// of the same shape (§2.2 "save lokal + cloud-sync stub").
class CampaignProgress {
  final Map<String, int> starsByMissionId;
  final Set<String> unlockedBlockIds;

  const CampaignProgress({
    this.starsByMissionId = const {},
    this.unlockedBlockIds = const {},
  });

  int starsFor(String missionId) => starsByMissionId[missionId] ?? 0;
  int get totalStars => starsByMissionId.values.fold(0, (a, b) => a + b);

  CampaignProgress withMissionResult(String missionId, int stars, {String? unlockedBlockId}) {
    final newStars = Map<String, int>.of(starsByMissionId);
    final existing = newStars[missionId] ?? 0;
    if (stars > existing) newStars[missionId] = stars;
    final newUnlocked = Set<String>.of(unlockedBlockIds);
    if (unlockedBlockId != null && stars > 0) newUnlocked.add(unlockedBlockId);
    return CampaignProgress(starsByMissionId: newStars, unlockedBlockIds: newUnlocked);
  }

  Map<String, dynamic> toJson() => {
        'stars_by_mission_id': starsByMissionId,
        'unlocked_block_ids': unlockedBlockIds.toList(),
      };

  factory CampaignProgress.fromJson(Map<String, dynamic> json) => CampaignProgress(
        starsByMissionId: (json['stars_by_mission_id'] as Map?)?.cast<String, int>() ?? const {},
        unlockedBlockIds:
            ((json['unlocked_block_ids'] as List?) ?? const []).cast<String>().toSet(),
      );
}
