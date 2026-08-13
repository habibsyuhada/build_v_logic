import 'battle_event.dart';
import 'battle_result.dart';

/// Current wire version of [BattleLog]. Bump on any breaking change to the
/// event/result shape and add a case to [BattleLog.fromJson]'s version
/// dispatch — §3.1 requires the codec to keep reading at least the two
/// versions prior to current.
const int currentBattleLogVersion = 1;

/// Replay = event log, not video (§2.3). This is exactly what a battle
/// worker persists and what the client's replay renderer consumes.
class BattleLog {
  final int version;
  final int seed;
  final String networkId;
  final List<BattleEvent> events;
  final BattleResult result;

  const BattleLog({
    required this.seed,
    required this.networkId,
    required this.events,
    required this.result,
    this.version = currentBattleLogVersion,
  });

  Map<String, dynamic> toJson() => {
        'version': version,
        'seed': seed,
        'network_id': networkId,
        'events': events.map((e) => e.toJson()).toList(),
        'result': result.toJson(),
      };

  /// Dispatches on `json['version']`. Only version 1 exists today; this
  /// switch is the extension point for the "read 2 versions back" rule —
  /// when v2 ships, add a `case 2` migration path here rather than
  /// replacing v1 parsing.
  factory BattleLog.fromJson(Map<String, dynamic> json) {
    final version = json['version'] as int;
    switch (version) {
      case 1:
        return BattleLog(
          version: version,
          seed: json['seed'] as int,
          networkId: json['network_id'] as String,
          events: (json['events'] as List)
              .map((e) => BattleEvent.fromJson(e as Map<String, dynamic>))
              .toList(),
          result: BattleResult.fromJson(json['result'] as Map<String, dynamic>),
        );
      default:
        throw FormatException('Unsupported BattleLog version: $version');
    }
  }
}
