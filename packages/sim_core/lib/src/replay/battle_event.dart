/// One entry in a [BattleLog] (§2.3 "Replay = event log, bukan video").
/// `data` only ever contains JSON-primitive values (int/String/bool/List/
/// Map of those) so the whole log round-trips through JSON losslessly.
class BattleEvent {
  final int tick;
  final String type;
  final Map<String, dynamic> data;

  const BattleEvent({
    required this.tick,
    required this.type,
    this.data = const {},
  });

  factory BattleEvent.fromJson(Map<String, dynamic> json) {
    return BattleEvent(
      tick: json['tick'] as int,
      type: json['type'] as String,
      data: (json['data'] as Map?)?.cast<String, dynamic>() ?? const {},
    );
  }

  Map<String, dynamic> toJson() => {
        'tick': tick,
        'type': type,
        'data': data,
      };

  @override
  String toString() => 'BattleEvent(tick: $tick, type: $type, data: $data)';
}
