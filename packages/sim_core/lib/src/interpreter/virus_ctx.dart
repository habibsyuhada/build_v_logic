import 'package:content_schema/content_schema.dart';

import '../model/sim_state.dart';
import '../prng/xoshiro128.dart';

typedef EmitFn = void Function(String type, Map<String, dynamic> data);

/// Everything a virus-side block behavior needs to read/mutate.
class VirusCtx {
  final VirusRuntime virus;
  final SimState state;
  final BalanceConfig balance;
  final Xoshiro128 rng;
  final int tick;
  final EmitFn emit;

  VirusCtx({
    required this.virus,
    required this.state,
    required this.balance,
    required this.rng,
    required this.tick,
    required this.emit,
  });

  NodeRuntime get here => state.nodes[virus.position]!;

  /// Spends energy; if it drives the virus to <= 0, kills it and leaves a
  /// forensic log at its current node (§1.3: "energi 0 = virus mati di
  /// tempat, log tertinggal → skor minus").
  void spendEnergy(int amount) {
    virus.energy -= amount;
    if (virus.energy <= 0) {
      virus.energy = 0;
      virus.alive = false;
      here.logPresent = true;
      emit('virus_died', {
        'virus_id': virus.id,
        'node_id': virus.position,
        'cause': 'energy_depleted',
      });
    }
  }

  void addNoise(int amount) {
    if (amount == 0) return;
    state.addNoise(amount);
  }

  /// Marks [nodeId] and its immediate neighbors as "seen" (fog of war,
  /// §1.3 dagger footnote: pathfinding only uses info the virus has seen).
  void revealFromCurrentNode() {
    virus.knownNodes.add(virus.position);
    for (final n in here.edges) {
      virus.knownNodes.add(n);
    }
  }
}
