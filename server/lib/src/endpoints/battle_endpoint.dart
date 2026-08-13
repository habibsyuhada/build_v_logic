import 'dart:convert';
import 'dart:math';

import 'package:content_schema/content_schema.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../business/battle_worker.dart';
import '../business/server_content.dart';
import '../business/sim_version.dart';
import '../business/virus_submission_validator.dart';
import '../generated/protocol.dart';

/// PvP battle submission and retrieval (§2.3, §2.5).
///
/// `submitAttack` resolves the battle synchronously within the request
/// rather than through a Redis-backed queue + separate worker process —
/// see docs/DECISIONS.md for why: this environment has no live Redis to
/// verify a queue/worker protocol against, and shipping unverified wire
/// protocol code would be worse than being explicit about the
/// simplification. `BattleWorker.process` (the actual resolution) is the
/// exact function a queue consumer would call per job, so swapping to a
/// real async queue later is a wiring change, not a rewrite.
class BattleEndpoint extends Endpoint {
  Future<Battle> submitAttack(
    Session session, {
    required String virusDefJson,
    required String targetDefenseId,
    required int simVersion,
  }) async {
    if (!SimVersionGate.isCompatible(simVersion)) {
      throw SimVersionMismatchException(
        clientSimVersion: simVersion,
        serverSimVersion: currentSimVersion,
      );
    }

    final authInfo = session.authenticated;
    if (authInfo == null) throw NotAuthenticatedException();

    final attacker = await Player.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authInfo.authUserId),
    );
    if (attacker == null) throw NotAuthenticatedException();

    final defense = await Defense.db.findById(session, UuidValue.fromString(targetDefenseId));
    if (defense == null || !defense.isActive) throw DefenseNotFoundException();

    final defender = await Player.db.findById(session, defense.playerId);
    if (defender == null) throw DefenseNotFoundException();

    final unlocks = await Unlock.db.find(
      session,
      where: (t) => t.playerId.equals(attacker.id!),
    );
    final unlockedBlockIds = unlocks.map((u) => u.blockId).toSet();

    final content = ServerContent.instance;
    final validation = VirusSubmissionValidator.validate(
      virusDefJson: virusDefJson,
      blockCatalog: content.blocksById,
      unlockedBlockIds: unlockedBlockIds,
      capacityKb: attacker.capacityKb,
    );
    if (!validation.isValid) {
      throw AttackValidationException(errors: validation.errors);
    }

    final virusDef = VirusDef.fromJson(jsonDecode(virusDefJson) as Map<String, dynamic>);
    final network = NetworkDef.fromJson(jsonDecode(defense.defJson) as Map<String, dynamic>);

    final attackerGamesPlayed = await Battle.db.count(
      session,
      where: (t) => t.attackerId.equals(attacker.id!),
    );

    final seed = Random.secure().nextInt(0x7fffffff);

    final resolution = BattleWorker.process(
      defenseNetwork: network,
      virusDef: virusDef,
      balance: content.balance,
      blockCatalog: content.blocks,
      seed: seed,
      attackerRating: attacker.rating,
      defenderRating: defender.rating,
      attackerGamesPlayed: attackerGamesPlayed,
    );

    final logJson = jsonEncode(resolution.log.toJson());

    final battle = await Battle.db.insertRow(
      session,
      Battle(
        attackerId: attacker.id!,
        defenderId: defender.id!,
        defenseVersion: defense.version,
        virusDefJson: virusDefJson,
        seed: seed,
        simVersion: currentSimVersion,
        // §2.4: >32KB logs should go to object storage (logRef) instead;
        // not wired up here — see LogStorageDecision's doc comment.
        logJson: logJson,
        score: resolution.log.result.score,
        outcome: resolution.outcome,
        ratingDelta: resolution.ratingDelta,
      ),
    );

    await Player.db.updateRow(
      session,
      attacker.copyWith(rating: attacker.rating + resolution.ratingDelta),
    );
    await Player.db.updateRow(
      session,
      defender.copyWith(rating: defender.rating - resolution.ratingDelta),
    );

    return battle;
  }

  /// Fetches a resolved battle. Only the attacker or defender involved may
  /// read it.
  Future<Battle?> getBattle(Session session, {required String battleId}) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw NotAuthenticatedException();

    final requester = await Player.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authInfo.authUserId),
    );
    if (requester == null) throw NotAuthenticatedException();

    final battle = await Battle.db.findById(session, UuidValue.fromString(battleId));
    if (battle == null) return null;
    if (battle.attackerId != requester.id && battle.defenderId != requester.id) {
      return null;
    }
    return battle;
  }
}
