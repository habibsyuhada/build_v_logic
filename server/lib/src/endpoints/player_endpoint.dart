import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';

import '../generated/protocol.dart';

/// Player account management (§2.5 auth, §2.4 `players`).
///
/// Sign-in *method* (guest/email/Google/Apple) is handled by
/// `serverpod_auth`; this endpoint only manages the game-specific
/// [Player] profile that sits on top of one `AuthUser`. Google/Apple
/// identity providers need live OAuth client credentials this environment
/// doesn't have configured — see docs/DECISIONS.md — so only the guest
/// flow is wired up end-to-end here. Upgrading a guest later is just
/// linking an email/Google/Apple credential to the *same* `AuthUser`
/// (a `serverpod_auth` operation), which leaves this `Player` row and its
/// `authUserId` untouched.
class PlayerEndpoint extends Endpoint {
  /// Creates a fresh guest account and returns a signed session token.
  Future<AuthSuccess> createGuest(Session session, {required String handle}) async {
    final authUser = await AuthUsers().create(session);
    final authUserId = authUser.id;

    await Player.db.insertRow(
      session,
      Player(authUserId: authUserId, isGuest: true, handle: handle),
    );

    return AuthServices.instance.tokenManager.issueToken(
      session,
      authUserId: authUserId,
      method: 'guest',
      scopes: {},
    );
  }

  /// The calling player's profile, or null if unauthenticated or no
  /// [Player] row exists yet for this session's `AuthUser`.
  Future<Player?> me(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return null;
    return Player.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authInfo.authUserId),
    );
  }

  /// Updates the calling player's accessibility/audio/etc. settings blob
  /// (§1.8) — stored opaque, the client owns the schema.
  Future<Player?> updateSettings(Session session, {required String settingsJson}) async {
    final authInfo = session.authenticated;
    if (authInfo == null) return null;
    final player = await Player.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authInfo.authUserId),
    );
    if (player == null) return null;
    return Player.db.updateRow(session, player.copyWith(settingsJson: settingsJson));
  }
}
