import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../business/daily_contract_generator.dart';
import '../generated/protocol.dart';

/// Daily contract puzzle + global leaderboard (§1.5.5, §2.4).
class ContractEndpoint extends Endpoint {
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

  /// Returns today's contract, generating and persisting it on first
  /// request of the day (deterministic from the date, so a concurrent
  /// second request racing this one would generate the identical network —
  /// the unique index on `contractDate` makes the second insert redundant
  /// rather than conflicting in a way that loses data).
  Future<DailyContract> today(Session session) async {
    final dateKey = DailyContractGenerator.dateKey(DateTime.now());
    final existing = await DailyContract.db.findFirstRow(
      session,
      where: (t) => t.contractDate.equals(dateKey),
    );
    if (existing != null) return existing;

    final network = DailyContractGenerator.buildNetwork(dateKey);
    return DailyContract.db.insertRow(
      session,
      DailyContract(
        contractDate: dateKey,
        networkJson: jsonEncode(network.toJson()),
        seed: DailyContractGenerator.seedFor(dateKey),
      ),
    );
  }

  /// Records the calling player's score if it beats their previous best
  /// for [contractId].
  Future<ContractScore> submitScore(
    Session session, {
    required String contractId,
    required int score,
  }) async {
    final player = await _requirePlayer(session);
    final contractUuid = UuidValue.fromString(contractId);

    final existing = await ContractScore.db.findFirstRow(
      session,
      where: (t) => t.playerId.equals(player.id!) & t.contractId.equals(contractUuid),
    );

    if (existing == null) {
      return ContractScore.db.insertRow(
        session,
        ContractScore(
          playerId: player.id!,
          contractId: contractUuid,
          score: score,
          achievedAt: DateTime.now(),
        ),
      );
    }
    if (score <= existing.score) return existing;
    return ContractScore.db.updateRow(
      session,
      existing.copyWith(score: score, achievedAt: DateTime.now()),
    );
  }

  /// Top scores for [contractId], highest first.
  Future<List<ContractScore>> leaderboard(
    Session session, {
    required String contractId,
    int limit = 50,
  }) async {
    return ContractScore.db.find(
      session,
      where: (t) => t.contractId.equals(UuidValue.fromString(contractId)),
      orderBy: (t) => t.score,
      orderDescending: true,
      limit: limit,
    );
  }
}
