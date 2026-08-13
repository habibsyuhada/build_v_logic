import 'package:content_schema/content_schema.dart';

import 'defense_ctx.dart';

typedef DefenseSensorFn = bool Function(DefenseCtx ctx, Map<String, dynamic> params);
typedef DefenseActionFn = void Function(
    DefenseCtx ctx, Map<String, dynamic> params, BlockDef block);

int _intParam(Map<String, dynamic> params, String name, [int fallback = 0]) {
  final v = params[name];
  return v is int ? v : fallback;
}

/// §1.3 defense sensor family. Reads one tick behind the virus phase by
/// design: the tick order (§3.1) runs defense sensors *before* virus
/// actions, so `intruder_copying`/`intruder_bruteforcing` see whatever the
/// virus's most recent action was as of the previous tick it acted.
final Map<String, DefenseSensorFn> defenseSensorRegistry = {
  'intruder_detected': (ctx, p) =>
      ctx.intrudersHere.any((v) => ctx.isDetectable(v)),
  'intruder_copying': (ctx, p) => ctx.intrudersHere
      .any((v) => ctx.isDetectable(v) && v.lastActionBlockId == 'copy_data'),
  'intruder_bruteforcing': (ctx, p) => ctx.intrudersHere
      .any((v) => ctx.isDetectable(v) && v.lastActionBlockId == 'brute_force'),
  'noise_gt': (ctx, p) => ctx.state.noiseMeter > _intParam(p, 'x'),
};

/// §1.3 defense action family. Each function reads its own magnitude from
/// [BlockDef] (`energy_cost`/`noise`), repurposed per-action as documented
/// in docs/DECISIONS.md — defenders have no energy pool of their own, so
/// these fields carry action-specific effect strength instead of a cost.
final Map<String, DefenseActionFn> defenseActionRegistry = {
  'quarantine': (ctx, p, block) {
    for (final v in ctx.intrudersHere.toList()) {
      if (!ctx.isDetectable(v)) continue;
      ctx.damageVirus(v, block.energyCost);
    }
    ctx.emit('node_quarantined', {'node_id': ctx.node.id});
  },
  'lockdown_node': (ctx, p, block) {
    ctx.node.lockedDown = true;
    ctx.emit('node_locked_down', {'node_id': ctx.node.id});
  },
  'raise_alarm': (ctx, p, block) {
    ctx.state.addNoise(block.noise);
    ctx.emit('alarm_raised', {'node_id': ctx.node.id, 'amount': block.noise});
  },
  'reroute_av': (ctx, p, block) {
    final idx = ctx.node.avRoute.indexOf(ctx.node.id);
    if (idx != -1) {
      ctx.node.avRouteIndex = idx;
      ctx.emit('av_rerouted', {'node_id': ctx.node.id});
    }
  },
  'fake_data_swap': (ctx, p, block) {
    ctx.node.dataIsFake = true;
    ctx.node.dataVerified = false;
    ctx.emit('fake_data_swapped', {'node_id': ctx.node.id});
  },
  'trace': (ctx, p, block) {
    ctx.state.tracePenalty += block.energyCost;
    ctx.emit('attacker_traced', {'node_id': ctx.node.id, 'penalty': block.energyCost});
  },
};
