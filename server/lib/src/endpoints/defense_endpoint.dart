import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../business/defense_submission_validator.dart';
import '../business/server_content.dart';
import '../generated/protocol.dart';

/// Defense builder backend (§1.4, §2.5). Attacks always target the most
/// recent `isActive` snapshot — never a defense mid-edit (§2.3).
class DefenseEndpoint extends Endpoint {
  /// Validates and saves a new defense version, activating it and
  /// deactivating any previous active version. Throws
  /// [DefenseValidationException] if the submission fails validation.
  Future<Defense> save(Session session, {required String networkDefJson}) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw NotAuthenticatedException();
    }
    final player = await Player.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authInfo.authUserId),
    );
    if (player == null) {
      throw NotAuthenticatedException();
    }

    final unlocks = await Unlock.db.find(
      session,
      where: (t) => t.playerId.equals(player.id!),
    );
    final unlockedBlockIds = unlocks.map((u) => u.blockId).toSet();

    final content = ServerContent.instance;
    final result = DefenseSubmissionValidator.validate(
      networkDefJson: networkDefJson,
      blockCatalog: content.blocksById,
      unlockedBlockIds: unlockedBlockIds,
    );
    if (!result.isValid) {
      throw DefenseValidationException(errors: result.errors);
    }

    final previousActive = await Defense.db.findFirstRow(
      session,
      where: (t) => t.playerId.equals(player.id!) & t.isActive.equals(true),
    );
    if (previousActive != null) {
      await Defense.db.updateRow(session, previousActive.copyWith(isActive: false));
    }

    return Defense.db.insertRow(
      session,
      Defense(
        playerId: player.id!,
        defJson: networkDefJson,
        version: (previousActive?.version ?? 0) + 1,
        isActive: true,
        validatedAt: DateTime.now(),
      ),
    );
  }
}
