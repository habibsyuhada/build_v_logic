import 'dart:convert';

import 'package:content_schema/content_schema.dart';
import 'package:sim_core/sim_core.dart';

import '../generated/protocol.dart';
import 'battle_outcome_classifier.dart';
import 'log_storage_decision.dart';
import 'rating_calculator.dart';

/// The result of processing one attack request — everything a caller
/// needs to persist a [Battle] row and notify the defender.
class BattleResolution {
  final BattleLog log;
  final BattleOutcome outcome;
  final int ratingDelta;
  final LogStorageDecision storage;

  const BattleResolution({
    required this.log,
    required this.outcome,
    required this.ratingDelta,
    required this.storage,
  });
}

/// Resolves one attack (§2.3, §3.1) and computes its downstream effects
/// (outcome classification, rating delta, log storage sizing). Pure — no
/// `Session`/database access — so it's the exact function a Redis-backed
/// queue consumer would call per job, and is fully unit-testable without
/// live infrastructure. The endpoint layer (`BattleEndpoint`) is the thin
/// wrapper that actually talks to the database; see docs/DECISIONS.md for
/// why the queue itself isn't wired to a live worker process in this
/// environment.
class BattleWorker {
  static BattleResolution process({
    required NetworkDef defenseNetwork,
    required VirusDef virusDef,
    required BalanceConfig balance,
    required List<BlockDef> blockCatalog,
    required int seed,
    required int attackerRating,
    required int defenderRating,
    required int attackerGamesPlayed,
  }) {
    final log = resolveBattle(
      network: defenseNetwork,
      virusDef: virusDef,
      balance: balance,
      blockCatalog: blockCatalog,
      seed: seed,
    );

    final outcome = BattleOutcomeClassifier.classify(log.result);
    final ratingDelta = RatingCalculator.attackerRatingDelta(
      attackerRating: attackerRating,
      defenderRating: defenderRating,
      attackerGamesPlayed: attackerGamesPlayed,
      attackerWon: BattleOutcomeClassifier.attackerWon(outcome),
    );

    return BattleResolution(
      log: log,
      outcome: outcome,
      ratingDelta: ratingDelta,
      storage: LogStorageDecision.decide(jsonEncode(log.toJson())),
    );
  }
}
