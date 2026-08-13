/// A lightweight per-tick snapshot of one virus copy's state — energy,
/// position, memory — for the client's Test Run debugger inspector (§3.3).
/// Not part of the wire-format battle log by default (§2.3: replay logs
/// should stay small); only attached when `resolveBattle` is called with
/// `includeSnapshots: true`, which the local Test Run path opts into and
/// the PvP submit path never does.
class VirusSnapshot {
  final int virusId;
  final String position;
  final int energy;
  final bool alive;
  final int inventoryDataValue;
  final int markedNodesCount;
  final int counter;

  const VirusSnapshot({
    required this.virusId,
    required this.position,
    required this.energy,
    required this.alive,
    required this.inventoryDataValue,
    required this.markedNodesCount,
    required this.counter,
  });

  Map<String, dynamic> toJson() => {
        'virus_id': virusId,
        'position': position,
        'energy': energy,
        'alive': alive,
        'inventory_data_value': inventoryDataValue,
        'marked_nodes_count': markedNodesCount,
        'counter': counter,
      };

  factory VirusSnapshot.fromJson(Map<String, dynamic> json) => VirusSnapshot(
        virusId: json['virus_id'] as int,
        position: json['position'] as String,
        energy: json['energy'] as int,
        alive: json['alive'] as bool,
        inventoryDataValue: json['inventory_data_value'] as int,
        markedNodesCount: json['marked_nodes_count'] as int,
        counter: json['counter'] as int,
      );
}

class TickSnapshot {
  final int tick;
  final List<VirusSnapshot> virusCopies;
  final int noiseMeter;

  const TickSnapshot({required this.tick, required this.virusCopies, required this.noiseMeter});

  Map<String, dynamic> toJson() => {
        'tick': tick,
        'noise_meter': noiseMeter,
        'virus_copies': virusCopies.map((v) => v.toJson()).toList(),
      };

  factory TickSnapshot.fromJson(Map<String, dynamic> json) => TickSnapshot(
        tick: json['tick'] as int,
        noiseMeter: json['noise_meter'] as int,
        virusCopies: (json['virus_copies'] as List)
            .map((e) => VirusSnapshot.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
