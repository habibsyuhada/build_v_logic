/// Star thresholds for a campaign mission (§1.5): complete / silent / efficient.
class MissionStarCriteria {
  final int maxNoiseForStar;
  final int maxTickForStar;

  const MissionStarCriteria({
    required this.maxNoiseForStar,
    required this.maxTickForStar,
  });

  factory MissionStarCriteria.fromJson(Map<String, dynamic> json) {
    return MissionStarCriteria(
      maxNoiseForStar: json['max_noise_for_star'] as int,
      maxTickForStar: json['max_tick_for_star'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'max_noise_for_star': maxNoiseForStar,
        'max_tick_for_star': maxTickForStar,
      };
}

/// One of 60 campaign missions (§1.5): 6 chapters x 10 missions.
class MissionDef {
  final String id;
  final int chapter;
  final int indexInChapter;
  final String title;
  final String networkId;
  final List<String> unlocksBlocks;
  final MissionStarCriteria starCriteria;
  final List<String> dialog;

  const MissionDef({
    required this.id,
    required this.chapter,
    required this.indexInChapter,
    required this.title,
    required this.networkId,
    this.unlocksBlocks = const [],
    required this.starCriteria,
    this.dialog = const [],
  });

  factory MissionDef.fromJson(Map<String, dynamic> json) {
    return MissionDef(
      id: json['id'] as String,
      chapter: json['chapter'] as int,
      indexInChapter: json['index_in_chapter'] as int,
      title: json['title'] as String,
      networkId: json['network_id'] as String,
      unlocksBlocks:
          ((json['unlocks_blocks'] as List?) ?? const []).cast<String>(),
      starCriteria:
          MissionStarCriteria.fromJson(json['star_criteria'] as Map<String, dynamic>),
      dialog: ((json['dialog'] as List?) ?? const []).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'chapter': chapter,
        'index_in_chapter': indexInChapter,
        'title': title,
        'network_id': networkId,
        'unlocks_blocks': unlocksBlocks,
        'star_criteria': starCriteria.toJson(),
        'dialog': dialog,
      };
}
