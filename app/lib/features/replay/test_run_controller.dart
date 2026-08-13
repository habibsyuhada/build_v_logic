import 'package:content_schema/content_schema.dart';
import 'package:flutter/foundation.dart';
import 'package:sim_core/sim_core.dart';

/// Drives the workbench's Test Run mode (§3.3): resolve a battle locally
/// with `sim_core` (with per-tick snapshots for the inspector), then let
/// the player scrub the timeline, step tick-by-tick, and inspect virus
/// state — a debugger for their own logic.
class TestRunController extends ChangeNotifier {
  BattleLog? _log;
  int _tick = 0;

  BattleLog? get log => _log;
  int get tick => _tick;
  int get maxTick => _log?.result.ticksUsed ?? 0;
  bool get hasResult => _log != null;

  void run({
    required NetworkDef network,
    required VirusDef virusDef,
    required BalanceConfig balance,
    required List<BlockDef> blockCatalog,
    required int seed,
  }) {
    _log = resolveBattle(
      network: network,
      virusDef: virusDef,
      balance: balance,
      blockCatalog: blockCatalog,
      seed: seed,
      includeSnapshots: true,
    );
    _tick = 0;
    notifyListeners();
  }

  void clear() {
    _log = null;
    _tick = 0;
    notifyListeners();
  }

  void stepForward() => scrubTo(_tick + 1);
  void stepBack() => scrubTo(_tick - 1);

  void scrubTo(int tick) {
    if (_log == null) return;
    _tick = tick.clamp(0, maxTick);
    notifyListeners();
  }

  List<BattleEvent> get eventsAtCurrentTick =>
      _log == null ? const [] : _log!.events.where((e) => e.tick == _tick).toList();

  TickSnapshot? get snapshotAtCurrentTick {
    final snaps = _log?.snapshots;
    if (snaps == null) return null;
    for (final s in snaps) {
      if (s.tick == _tick) return s;
    }
    return null;
  }
}
