import 'dart:convert';

import 'package:content_schema/content_schema.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../business/reverse_engineer_progress.dart';
import '../business/profanity_filter.dart';
import '../business/server_content.dart';
import '../business/virus_submission_validator.dart';
import '../generated/protocol.dart';

/// Blueprint sharing + reverse-engineer loop (§1.5.4, §2.5).
///
/// A published blueprint's title goes through [ProfanityFilter] before
/// being stored, and starts `moderationState=pending` — a real deployment
/// would also route it through a player-report queue and a human
/// moderator pass to reach `approved`/`rejected`/`flagged`; that queue and
/// the moderator tooling that drives it are outside this environment's
/// scope (no dashboard to build it against), so `moderationState` here
/// only advances via [publish]'s automated profanity gate.
class BlueprintEndpoint extends Endpoint {
  Future<Player> _requirePlayer(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) throw NotAuthenticatedException();
    final player = await Player.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authInfo.authUserId),
    );
    if (player == null) throw NotAuthenticatedException();
    return player;
  }

  /// Publishes a new blueprint. The title is checked against the
  /// profanity filter and the design against the same validator attack
  /// submissions use (§2.5: never trust the client's own unlock/size
  /// bookkeeping).
  Future<Blueprint> publish(
    Session session, {
    required String title,
    required String virusDefJson,
  }) async {
    final player = await _requirePlayer(session);

    if (!SimpleWordlistProfanityFilter.defaultFilter.isClean(title)) {
      throw BlueprintTitleRejectedException();
    }

    final unlocks = await Unlock.db.find(
      session,
      where: (t) => t.playerId.equals(player.id!),
    );
    final unlockedBlockIds = unlocks.map((u) => u.blockId).toSet();

    final content = ServerContent.instance;
    final validation = VirusSubmissionValidator.validate(
      virusDefJson: virusDefJson,
      blockCatalog: content.blocksById,
      unlockedBlockIds: unlockedBlockIds,
      capacityKb: player.capacityKb,
    );
    if (!validation.isValid) {
      throw BlueprintValidationException(errors: validation.errors);
    }

    return Blueprint.db.insertRow(
      session,
      Blueprint(
        playerId: player.id!,
        title: title,
        virusDefJson: virusDefJson,
        publishedAt: DateTime.now(),
      ),
    );
  }

  /// Lists approved blueprints, most recently published first.
  Future<List<Blueprint>> listApproved(Session session, {int limit = 50}) async {
    return Blueprint.db.find(
      session,
      where: (t) => t.moderationState.equals(BlueprintModerationState.approved),
      orderBy: (t) => t.publishedAt,
      orderDescending: true,
      limit: limit,
    );
  }

  /// Records that the calling player watched one replay of [blueprintId],
  /// advancing their reverse-engineer progress (§1.5.4: 3 replays per
  /// block). Returns the updated reveal state.
  Future<BlueprintReveal> watchReplay(Session session, {required String blueprintId}) async {
    final player = await _requirePlayer(session);
    final blueprint = await Blueprint.db.findById(session, UuidValue.fromString(blueprintId));
    if (blueprint == null) throw BlueprintNotFoundException();

    final totalBlocks =
        VirusDef.fromJson(jsonDecode(blueprint.virusDefJson) as Map<String, dynamic>)
            .program
            .nodes
            .length;

    final existing = await BlueprintReveal.db.findFirstRow(
      session,
      where: (t) => t.playerId.equals(player.id!) & t.blueprintId.equals(blueprint.id!),
    );

    final replaysWatched = (existing?.replaysWatched ?? 0) + 1;
    final blocksRevealed = ReverseEngineerProgress.blocksRevealedFor(
      replaysWatched: replaysWatched,
      totalBlocks: totalBlocks,
    );

    if (existing == null) {
      return BlueprintReveal.db.insertRow(
        session,
        BlueprintReveal(
          playerId: player.id!,
          blueprintId: blueprint.id!,
          replaysWatched: replaysWatched,
          blocksRevealed: blocksRevealed,
          updatedAt: DateTime.now(),
        ),
      );
    }
    return BlueprintReveal.db.updateRow(
      session,
      existing.copyWith(
        replaysWatched: replaysWatched,
        blocksRevealed: blocksRevealed,
        updatedAt: DateTime.now(),
      ),
    );
  }

  /// Returns the blueprint's virus design JSON once fully
  /// reverse-engineered. Throws [BlueprintNotRevealedException] otherwise.
  Future<String> copy(Session session, {required String blueprintId}) async {
    final player = await _requirePlayer(session);
    final blueprint = await Blueprint.db.findById(session, UuidValue.fromString(blueprintId));
    if (blueprint == null) throw BlueprintNotFoundException();

    final totalBlocks =
        VirusDef.fromJson(jsonDecode(blueprint.virusDefJson) as Map<String, dynamic>)
            .program
            .nodes
            .length;

    final reveal = await BlueprintReveal.db.findFirstRow(
      session,
      where: (t) => t.playerId.equals(player.id!) & t.blueprintId.equals(blueprint.id!),
    );
    final replaysWatched = reveal?.replaysWatched ?? 0;

    if (!ReverseEngineerProgress.isFullyRevealed(
      replaysWatched: replaysWatched,
      totalBlocks: totalBlocks,
    )) {
      throw BlueprintNotRevealedException(
        blocksRevealed: reveal?.blocksRevealed ?? 0,
        blocksTotal: totalBlocks,
      );
    }

    await Blueprint.db.updateRow(session, blueprint.copyWith(plays: blueprint.plays + 1));
    return blueprint.virusDefJson;
  }
}
