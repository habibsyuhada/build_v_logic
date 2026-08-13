/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:shared_models/src/protocol/battle.dart' as _i5;
import 'package:shared_models/src/protocol/blueprint.dart' as _i6;
import 'package:shared_models/src/protocol/blueprint_reveal.dart' as _i7;
import 'package:shared_models/src/protocol/daily_contract.dart' as _i8;
import 'package:shared_models/src/protocol/contract_score.dart' as _i9;
import 'package:shared_models/src/protocol/defense.dart' as _i10;
import 'package:shared_models/src/protocol/player.dart' as _i11;
import 'package:shared_models/src/protocol/season.dart' as _i12;
import 'package:shared_models/src/protocol/battle_pass_progress.dart' as _i13;
import 'package:shared_models/src/protocol/purchase.dart' as _i14;
import 'package:shared_models/src/protocol/telemetry_event.dart' as _i15;
import 'protocol.dart' as _i16;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

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
/// {@category Endpoint}
class EndpointBattle extends _i2.EndpointRef {
  EndpointBattle(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'battle';

  _i3.Future<_i5.Battle> submitAttack({
    required String virusDefJson,
    required String targetDefenseId,
    required int simVersion,
  }) => caller.callServerEndpoint<_i5.Battle>(
    'battle',
    'submitAttack',
    {
      'virusDefJson': virusDefJson,
      'targetDefenseId': targetDefenseId,
      'simVersion': simVersion,
    },
  );

  /// Fetches a resolved battle. Only the attacker or defender involved may
  /// read it.
  _i3.Future<_i5.Battle?> getBattle({required String battleId}) =>
      caller.callServerEndpoint<_i5.Battle?>(
        'battle',
        'getBattle',
        {'battleId': battleId},
      );
}

/// Blueprint sharing + reverse-engineer loop (§1.5.4, §2.5).
///
/// A published blueprint's title goes through [ProfanityFilter] before
/// being stored, and starts `moderationState=pending` — a real deployment
/// would also route it through a player-report queue and a human
/// moderator pass to reach `approved`/`rejected`/`flagged`; that queue and
/// the moderator tooling that drives it are outside this environment's
/// scope (no dashboard to build it against), so `moderationState` here
/// only advances via [publish]'s automated profanity gate.
/// {@category Endpoint}
class EndpointBlueprint extends _i2.EndpointRef {
  EndpointBlueprint(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'blueprint';

  /// Publishes a new blueprint. The title is checked against the
  /// profanity filter and the design against the same validator attack
  /// submissions use (§2.5: never trust the client's own unlock/size
  /// bookkeeping).
  _i3.Future<_i6.Blueprint> publish({
    required String title,
    required String virusDefJson,
  }) => caller.callServerEndpoint<_i6.Blueprint>(
    'blueprint',
    'publish',
    {
      'title': title,
      'virusDefJson': virusDefJson,
    },
  );

  /// Lists approved blueprints, most recently published first.
  _i3.Future<List<_i6.Blueprint>> listApproved({required int limit}) =>
      caller.callServerEndpoint<List<_i6.Blueprint>>(
        'blueprint',
        'listApproved',
        {'limit': limit},
      );

  /// Records that the calling player watched one replay of [blueprintId],
  /// advancing their reverse-engineer progress (§1.5.4: 3 replays per
  /// block). Returns the updated reveal state.
  _i3.Future<_i7.BlueprintReveal> watchReplay({required String blueprintId}) =>
      caller.callServerEndpoint<_i7.BlueprintReveal>(
        'blueprint',
        'watchReplay',
        {'blueprintId': blueprintId},
      );

  /// Returns the blueprint's virus design JSON once fully
  /// reverse-engineered. Throws [BlueprintNotRevealedException] otherwise.
  _i3.Future<String> copy({required String blueprintId}) =>
      caller.callServerEndpoint<String>(
        'blueprint',
        'copy',
        {'blueprintId': blueprintId},
      );
}

/// Remote config delivery (§2.1 "content as data ... bisa dipush via
/// remote config tanpa app update", §5 Phase 6 "remote config"). A client
/// polls [currentVersion] against its cached version and only calls
/// [fetchBundle] when they differ — a balance/content push then reaches
/// players without an app store release.
/// {@category Endpoint}
class EndpointContent extends _i2.EndpointRef {
  EndpointContent(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'content';

  _i3.Future<String> currentVersion() => caller.callServerEndpoint<String>(
    'content',
    'currentVersion',
    {},
  );

  /// The full content bundle plus its version, as a single JSON blob —
  /// same "content_schema types aren't Serverpod models" reasoning as
  /// `ShopEndpoint.listSkus`.
  _i3.Future<String> fetchBundle() => caller.callServerEndpoint<String>(
    'content',
    'fetchBundle',
    {},
  );
}

/// Daily contract puzzle + global leaderboard (§1.5.5, §2.4).
/// {@category Endpoint}
class EndpointContract extends _i2.EndpointRef {
  EndpointContract(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'contract';

  /// Returns today's contract, generating and persisting it on first
  /// request of the day (deterministic from the date, so a concurrent
  /// second request racing this one would generate the identical network —
  /// the unique index on `contractDate` makes the second insert redundant
  /// rather than conflicting in a way that loses data).
  _i3.Future<_i8.DailyContract> today() =>
      caller.callServerEndpoint<_i8.DailyContract>(
        'contract',
        'today',
        {},
      );

  /// Records the calling player's score if it beats their previous best
  /// for [contractId].
  _i3.Future<_i9.ContractScore> submitScore({
    required String contractId,
    required int score,
  }) => caller.callServerEndpoint<_i9.ContractScore>(
    'contract',
    'submitScore',
    {
      'contractId': contractId,
      'score': score,
    },
  );

  /// Top scores for [contractId], highest first.
  _i3.Future<List<_i9.ContractScore>> leaderboard({
    required String contractId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i9.ContractScore>>(
    'contract',
    'leaderboard',
    {
      'contractId': contractId,
      'limit': limit,
    },
  );
}

/// Defense builder backend (§1.4, §2.5). Attacks always target the most
/// recent `isActive` snapshot — never a defense mid-edit (§2.3).
/// {@category Endpoint}
class EndpointDefense extends _i2.EndpointRef {
  EndpointDefense(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'defense';

  /// Validates and saves a new defense version, activating it and
  /// deactivating any previous active version. Throws
  /// [DefenseValidationException] if the submission fails validation.
  _i3.Future<_i10.Defense> save({required String networkDefJson}) =>
      caller.callServerEndpoint<_i10.Defense>(
        'defense',
        'save',
        {'networkDefJson': networkDefJson},
      );
}

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
/// {@category Endpoint}
class EndpointPlayer extends _i2.EndpointRef {
  EndpointPlayer(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'player';

  /// Creates a fresh guest account and returns a signed session token.
  _i3.Future<_i4.AuthSuccess> createGuest({required String handle}) =>
      caller.callServerEndpoint<_i4.AuthSuccess>(
        'player',
        'createGuest',
        {'handle': handle},
      );

  /// The calling player's profile, or null if unauthenticated or no
  /// [Player] row exists yet for this session's `AuthUser`.
  _i3.Future<_i11.Player?> me() => caller.callServerEndpoint<_i11.Player?>(
    'player',
    'me',
    {},
  );

  /// Updates the calling player's accessibility/audio/etc. settings blob
  /// (§1.8) — stored opaque, the client owns the schema.
  _i3.Future<_i11.Player?> updateSettings({required String settingsJson}) =>
      caller.callServerEndpoint<_i11.Player?>(
        'player',
        'updateSettings',
        {'settingsJson': settingsJson},
      );

  /// Deletes the calling player's account (§5 Phase 6 store-compliance
  /// requirement — see docs/STORE_COMPLIANCE.md). Deletes the underlying
  /// `AuthUser`; every owned row (`Unlock`, `Defense`, `Battle`,
  /// `Blueprint`, `Purchase`, etc.) cascades via each model's own
  /// `relation(onDelete=Cascade)` back to `Player`, which itself cascades
  /// from `AuthUser` the same way — one delete, not a manual sweep of
  /// every table.
  _i3.Future<void> deleteAccount() => caller.callServerEndpoint<void>(
    'player',
    'deleteAccount',
    {},
  );
}

/// Season lifecycle + battle pass progress (§1.5.2, §1.6, §2.4).
///
/// Rollover is normally driven by a scheduled job (e.g. an hourly cron
/// hitting [rolloverIfDue]) rather than a player request; it's exposed as
/// a plain endpoint method here since this environment has no live
/// deployment to attach a real cron trigger to — see docs/DECISIONS.md.
/// {@category Endpoint}
class EndpointSeason extends _i2.EndpointRef {
  EndpointSeason(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'season';

  /// The currently-running season, creating the very first one if none
  /// exists yet.
  _i3.Future<_i12.Season> current() => caller.callServerEndpoint<_i12.Season>(
    'season',
    'current',
    {},
  );

  /// If the current season has ended, snapshots every player's
  /// `seasonRating` into ranked [SeasonResult] rows, resets it to the
  /// default, and starts the next season. Returns the new season, or the
  /// still-running one if rollover wasn't due.
  _i3.Future<_i12.Season> rolloverIfDue() =>
      caller.callServerEndpoint<_i12.Season>(
        'season',
        'rolloverIfDue',
        {},
      );

  /// The calling player's battle pass progress for the current season,
  /// creating a fresh (tier-0) row on first access.
  _i3.Future<_i13.BattlePassProgress> myProgress() =>
      caller.callServerEndpoint<_i13.BattlePassProgress>(
        'season',
        'myProgress',
        {},
      );

  /// Grants battle pass XP to the calling player for the current season
  /// (called after a battle/mission/contract completion — not exposed as
  /// a way to self-award, since a real deployment would only call this
  /// from other endpoints server-side, not the client directly).
  _i3.Future<_i13.BattlePassProgress> addXp({required int xp}) =>
      caller.callServerEndpoint<_i13.BattlePassProgress>(
        'season',
        'addXp',
        {'xp': xp},
      );

  /// The tier derived from the calling player's current season XP
  /// (§1.6 — tier is presentation pacing, never stored directly).
  _i3.Future<int> myTier() => caller.callServerEndpoint<int>(
    'season',
    'myTier',
    {},
  );
}

/// Shop catalog + IAP purchase verification (§1.6, §2.4, §2.5).
///
/// [receiptValidator] defaults to [AlwaysRejectReceiptValidator] — this
/// environment has no live Google Play / App Store service-account
/// credentials to verify a real receipt against, and a validator that
/// silently approved everything would be a dangerous default to ship. A
/// real deployment swaps this for store-specific implementations; every
/// purchase submitted here is durably recorded either way (state
/// `verified` or `failed`), so nothing about the entitlement-granting path
/// downstream of verification needs to change when that swap happens.
/// {@category Endpoint}
class EndpointShop extends _i2.EndpointRef {
  EndpointShop(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'shop';

  /// The product catalog (`content/shop.json`), as a JSON array —
  /// `content_schema.SkuDef` isn't a Serverpod-generated model, so it's
  /// serialized the same way virus/network defs are elsewhere in this
  /// API.
  _i3.Future<String> listSkus() => caller.callServerEndpoint<String>(
    'shop',
    'listSkus',
    {},
  );

  /// Submits a purchase for server-side verification. Always persists a
  /// [Purchase] row recording the outcome; only grants the entitlement
  /// (keys or battle pass premium) if verification succeeds.
  _i3.Future<_i14.Purchase> purchase({
    required String sku,
    required String storeReceipt,
  }) => caller.callServerEndpoint<_i14.Purchase>(
    'shop',
    'purchase',
    {
      'sku': sku,
      'storeReceipt': storeReceipt,
    },
  );
}

/// Client telemetry ingestion (§2.6: "event funnel: install -> tutorial
/// step N -> first battle -> D1/D7 return. Kirim batched ke endpoint
/// sendiri"). Events are only ingested and stored here; a real dashboard
/// (Grafana/Amplitude/etc.) reading this table for funnel visualization
/// is outside this environment's scope — see docs/DECISIONS.md.
/// {@category Endpoint}
class EndpointTelemetry extends _i2.EndpointRef {
  EndpointTelemetry(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'telemetry';

  /// Ingests a batch of client-side events. `player` may be unauthenticated
  /// (some funnel events, like first app open, happen before login).
  _i3.Future<int> ingest({required List<_i15.TelemetryEvent> events}) =>
      caller.callServerEndpoint<int>(
        'telemetry',
        'ingest',
        {'events': events},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    auth = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller auth;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i16.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    battle = EndpointBattle(this);
    blueprint = EndpointBlueprint(this);
    content = EndpointContent(this);
    contract = EndpointContract(this);
    defense = EndpointDefense(this);
    player = EndpointPlayer(this);
    season = EndpointSeason(this);
    shop = EndpointShop(this);
    telemetry = EndpointTelemetry(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointBattle battle;

  late final EndpointBlueprint blueprint;

  late final EndpointContent content;

  late final EndpointContract contract;

  late final EndpointDefense defense;

  late final EndpointPlayer player;

  late final EndpointSeason season;

  late final EndpointShop shop;

  late final EndpointTelemetry telemetry;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'battle': battle,
    'blueprint': blueprint,
    'content': content,
    'contract': contract,
    'defense': defense,
    'player': player,
    'season': season,
    'shop': shop,
    'telemetry': telemetry,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'auth': modules.auth,
  };
}
