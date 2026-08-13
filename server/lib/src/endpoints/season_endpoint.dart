import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../business/battle_pass_tier_calculator.dart';
import '../business/season_rollover.dart';
import '../generated/protocol.dart';

/// Season lifecycle + battle pass progress (§1.5.2, §1.6, §2.4).
///
/// Rollover is normally driven by a scheduled job (e.g. an hourly cron
/// hitting [rolloverIfDue]) rather than a player request; it's exposed as
/// a plain endpoint method here since this environment has no live
/// deployment to attach a real cron trigger to — see docs/DECISIONS.md.
class SeasonEndpoint extends Endpoint {
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

  /// The currently-running season, creating the very first one if none
  /// exists yet.
  Future<Season> current(Session session) async {
    final latest = await Season.db.findFirstRow(
      session,
      orderBy: (t) => t.endsAt,
      orderDescending: true,
    );
    if (latest != null && !SeasonRollover.isDue(now: DateTime.now(), seasonEndsAt: latest.endsAt)) {
      return latest;
    }
    final now = DateTime.now();
    return Season.db.insertRow(
      session,
      Season(startsAt: now, endsAt: SeasonRollover.nextSeasonEnd(seasonStartsAt: now)),
    );
  }

  /// If the current season has ended, snapshots every player's
  /// `seasonRating` into ranked [SeasonResult] rows, resets it to the
  /// default, and starts the next season. Returns the new season, or the
  /// still-running one if rollover wasn't due.
  Future<Season> rolloverIfDue(Session session) async {
    final season = await current(session);
    if (!SeasonRollover.isDue(now: DateTime.now(), seasonEndsAt: season.endsAt)) {
      return season;
    }

    final players = await Player.db.find(session);
    final ranked = SeasonRollover.rank([
      for (final p in players) SeasonStanding(playerId: p.id!.toString(), seasonRating: p.seasonRating),
    ]);

    for (final standing in ranked) {
      await SeasonResult.db.insertRow(
        session,
        SeasonResult(
          seasonId: season.id!,
          playerId: UuidValue.fromString(standing.playerId),
          finalRating: standing.finalRating,
          rank: standing.rank,
        ),
      );
    }
    for (final p in players) {
      await Player.db.updateRow(session, p.copyWith(seasonRating: 1000));
    }

    final now = DateTime.now();
    return Season.db.insertRow(
      session,
      Season(startsAt: now, endsAt: SeasonRollover.nextSeasonEnd(seasonStartsAt: now)),
    );
  }

  /// The calling player's battle pass progress for the current season,
  /// creating a fresh (tier-0) row on first access.
  Future<BattlePassProgress> myProgress(Session session) async {
    final player = await _requirePlayer(session);
    final season = await current(session);

    final existing = await BattlePassProgress.db.findFirstRow(
      session,
      where: (t) => t.playerId.equals(player.id!) & t.seasonId.equals(season.id!),
    );
    if (existing != null) return existing;

    return BattlePassProgress.db.insertRow(
      session,
      BattlePassProgress(playerId: player.id!, seasonId: season.id!),
    );
  }

  /// Grants battle pass XP to the calling player for the current season
  /// (called after a battle/mission/contract completion — not exposed as
  /// a way to self-award, since a real deployment would only call this
  /// from other endpoints server-side, not the client directly).
  Future<BattlePassProgress> addXp(Session session, {required int xp}) async {
    final progress = await myProgress(session);
    final newXp = progress.xp + xp;
    return BattlePassProgress.db.updateRow(session, progress.copyWith(xp: newXp));
  }

  /// The tier derived from the calling player's current season XP
  /// (§1.6 — tier is presentation pacing, never stored directly).
  Future<int> myTier(Session session) async {
    final progress = await myProgress(session);
    return BattlePassTierCalculator.tierFor(progress.xp);
  }
}
