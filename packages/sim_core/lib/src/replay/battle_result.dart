/// Final score breakdown (§1.2: "Skor battle = f(data value dibawa keluar,
/// log dihapus, exit bersih vs mati, tick efisiensi)").
class BattleResult {
  final int ticksUsed;
  final int dataExfiltrated;
  final int logsDeleted;
  final int cleanExits;
  final int survivingCopies;
  final int deadCopies;
  final int tracePenalty;
  final int score;

  const BattleResult({
    required this.ticksUsed,
    required this.dataExfiltrated,
    required this.logsDeleted,
    required this.cleanExits,
    required this.survivingCopies,
    required this.deadCopies,
    required this.tracePenalty,
    required this.score,
  });

  factory BattleResult.fromJson(Map<String, dynamic> json) => BattleResult(
        ticksUsed: json['ticks_used'] as int,
        dataExfiltrated: json['data_exfiltrated'] as int,
        logsDeleted: json['logs_deleted'] as int,
        cleanExits: json['clean_exits'] as int,
        survivingCopies: json['surviving_copies'] as int,
        deadCopies: json['dead_copies'] as int,
        tracePenalty: json['trace_penalty'] as int,
        score: json['score'] as int,
      );

  Map<String, dynamic> toJson() => {
        'ticks_used': ticksUsed,
        'data_exfiltrated': dataExfiltrated,
        'logs_deleted': logsDeleted,
        'clean_exits': cleanExits,
        'surviving_copies': survivingCopies,
        'dead_copies': deadCopies,
        'trace_penalty': tracePenalty,
        'score': score,
      };
}
