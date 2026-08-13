import 'package:content_schema/content_schema.dart';

import '../model/sim_state.dart';
import '../prng/xoshiro128.dart';

typedef EmitFn = void Function(String type, Map<String, dynamic> data);

/// Everything a defense-side block behavior needs. Bound to one
/// [NodeRuntime] — defense logic never moves, unlike a virus.
class DefenseCtx {
  final NodeRuntime node;
  final SimState state;
  final BalanceConfig balance;
  final Xoshiro128 rng;
  final int tick;
  final EmitFn emit;

  DefenseCtx({
    required this.node,
    required this.state,
    required this.balance,
    required this.rng,
    required this.tick,
    required this.emit,
  });

  Iterable<VirusRuntime> get intrudersHere =>
      state.virusCopies.where((v) => v.alive && v.position == node.id);

  /// True if [v] is currently detectable by this node's defense sensors
  /// (disguise, §1.3, hides a virus from detection while active).
  bool isDetectable(VirusRuntime v) => !v.isDisguisedAt(tick);

  void damageVirus(VirusRuntime v, int amount) {
    v.energy -= amount;
    if (v.energy <= 0) {
      v.energy = 0;
      v.alive = false;
      state.nodes[v.position]!.logPresent = true;
      emit('virus_died', {
        'virus_id': v.id,
        'node_id': v.position,
        'cause': 'quarantined',
      });
    }
  }
}
