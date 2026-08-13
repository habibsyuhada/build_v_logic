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
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/battle_endpoint.dart' as _i4;
import '../endpoints/blueprint_endpoint.dart' as _i5;
import '../endpoints/content_endpoint.dart' as _i6;
import '../endpoints/contract_endpoint.dart' as _i7;
import '../endpoints/defense_endpoint.dart' as _i8;
import '../endpoints/player_endpoint.dart' as _i9;
import '../endpoints/season_endpoint.dart' as _i10;
import '../endpoints/shop_endpoint.dart' as _i11;
import '../endpoints/telemetry_endpoint.dart' as _i12;
import 'package:payload_server/src/generated/telemetry_event.dart' as _i13;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i14;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i15;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'battle': _i4.BattleEndpoint()
        ..initialize(
          server,
          'battle',
          null,
        ),
      'blueprint': _i5.BlueprintEndpoint()
        ..initialize(
          server,
          'blueprint',
          null,
        ),
      'content': _i6.ContentEndpoint()
        ..initialize(
          server,
          'content',
          null,
        ),
      'contract': _i7.ContractEndpoint()
        ..initialize(
          server,
          'contract',
          null,
        ),
      'defense': _i8.DefenseEndpoint()
        ..initialize(
          server,
          'defense',
          null,
        ),
      'player': _i9.PlayerEndpoint()
        ..initialize(
          server,
          'player',
          null,
        ),
      'season': _i10.SeasonEndpoint()
        ..initialize(
          server,
          'season',
          null,
        ),
      'shop': _i11.ShopEndpoint()
        ..initialize(
          server,
          'shop',
          null,
        ),
      'telemetry': _i12.TelemetryEndpoint()
        ..initialize(
          server,
          'telemetry',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['battle'] = _i1.EndpointConnector(
      name: 'battle',
      endpoint: endpoints['battle']!,
      methodConnectors: {
        'submitAttack': _i1.MethodConnector(
          name: 'submitAttack',
          params: {
            'virusDefJson': _i1.ParameterDescription(
              name: 'virusDefJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetDefenseId': _i1.ParameterDescription(
              name: 'targetDefenseId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'simVersion': _i1.ParameterDescription(
              name: 'simVersion',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['battle'] as _i4.BattleEndpoint).submitAttack(
                    session,
                    virusDefJson: params['virusDefJson'],
                    targetDefenseId: params['targetDefenseId'],
                    simVersion: params['simVersion'],
                  ),
        ),
        'getBattle': _i1.MethodConnector(
          name: 'getBattle',
          params: {
            'battleId': _i1.ParameterDescription(
              name: 'battleId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['battle'] as _i4.BattleEndpoint).getBattle(
                session,
                battleId: params['battleId'],
              ),
        ),
      },
    );
    connectors['blueprint'] = _i1.EndpointConnector(
      name: 'blueprint',
      endpoint: endpoints['blueprint']!,
      methodConnectors: {
        'publish': _i1.MethodConnector(
          name: 'publish',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'virusDefJson': _i1.ParameterDescription(
              name: 'virusDefJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['blueprint'] as _i5.BlueprintEndpoint).publish(
                    session,
                    title: params['title'],
                    virusDefJson: params['virusDefJson'],
                  ),
        ),
        'listApproved': _i1.MethodConnector(
          name: 'listApproved',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['blueprint'] as _i5.BlueprintEndpoint)
                  .listApproved(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'watchReplay': _i1.MethodConnector(
          name: 'watchReplay',
          params: {
            'blueprintId': _i1.ParameterDescription(
              name: 'blueprintId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['blueprint'] as _i5.BlueprintEndpoint).watchReplay(
                    session,
                    blueprintId: params['blueprintId'],
                  ),
        ),
        'copy': _i1.MethodConnector(
          name: 'copy',
          params: {
            'blueprintId': _i1.ParameterDescription(
              name: 'blueprintId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['blueprint'] as _i5.BlueprintEndpoint).copy(
                session,
                blueprintId: params['blueprintId'],
              ),
        ),
      },
    );
    connectors['content'] = _i1.EndpointConnector(
      name: 'content',
      endpoint: endpoints['content']!,
      methodConnectors: {
        'currentVersion': _i1.MethodConnector(
          name: 'currentVersion',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['content'] as _i6.ContentEndpoint)
                  .currentVersion(session),
        ),
        'fetchBundle': _i1.MethodConnector(
          name: 'fetchBundle',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['content'] as _i6.ContentEndpoint)
                  .fetchBundle(session),
        ),
      },
    );
    connectors['contract'] = _i1.EndpointConnector(
      name: 'contract',
      endpoint: endpoints['contract']!,
      methodConnectors: {
        'today': _i1.MethodConnector(
          name: 'today',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['contract'] as _i7.ContractEndpoint).today(
                session,
              ),
        ),
        'submitScore': _i1.MethodConnector(
          name: 'submitScore',
          params: {
            'contractId': _i1.ParameterDescription(
              name: 'contractId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'score': _i1.ParameterDescription(
              name: 'score',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['contract'] as _i7.ContractEndpoint).submitScore(
                    session,
                    contractId: params['contractId'],
                    score: params['score'],
                  ),
        ),
        'leaderboard': _i1.MethodConnector(
          name: 'leaderboard',
          params: {
            'contractId': _i1.ParameterDescription(
              name: 'contractId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['contract'] as _i7.ContractEndpoint).leaderboard(
                    session,
                    contractId: params['contractId'],
                    limit: params['limit'],
                  ),
        ),
      },
    );
    connectors['defense'] = _i1.EndpointConnector(
      name: 'defense',
      endpoint: endpoints['defense']!,
      methodConnectors: {
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'networkDefJson': _i1.ParameterDescription(
              name: 'networkDefJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['defense'] as _i8.DefenseEndpoint).save(
                session,
                networkDefJson: params['networkDefJson'],
              ),
        ),
      },
    );
    connectors['player'] = _i1.EndpointConnector(
      name: 'player',
      endpoint: endpoints['player']!,
      methodConnectors: {
        'createGuest': _i1.MethodConnector(
          name: 'createGuest',
          params: {
            'handle': _i1.ParameterDescription(
              name: 'handle',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['player'] as _i9.PlayerEndpoint).createGuest(
                    session,
                    handle: params['handle'],
                  ),
        ),
        'me': _i1.MethodConnector(
          name: 'me',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['player'] as _i9.PlayerEndpoint).me(session),
        ),
        'updateSettings': _i1.MethodConnector(
          name: 'updateSettings',
          params: {
            'settingsJson': _i1.ParameterDescription(
              name: 'settingsJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['player'] as _i9.PlayerEndpoint).updateSettings(
                    session,
                    settingsJson: params['settingsJson'],
                  ),
        ),
        'deleteAccount': _i1.MethodConnector(
          name: 'deleteAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['player'] as _i9.PlayerEndpoint)
                  .deleteAccount(session),
        ),
      },
    );
    connectors['season'] = _i1.EndpointConnector(
      name: 'season',
      endpoint: endpoints['season']!,
      methodConnectors: {
        'current': _i1.MethodConnector(
          name: 'current',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['season'] as _i10.SeasonEndpoint).current(session),
        ),
        'rolloverIfDue': _i1.MethodConnector(
          name: 'rolloverIfDue',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['season'] as _i10.SeasonEndpoint)
                  .rolloverIfDue(session),
        ),
        'myProgress': _i1.MethodConnector(
          name: 'myProgress',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['season'] as _i10.SeasonEndpoint)
                  .myProgress(session),
        ),
        'addXp': _i1.MethodConnector(
          name: 'addXp',
          params: {
            'xp': _i1.ParameterDescription(
              name: 'xp',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['season'] as _i10.SeasonEndpoint).addXp(
                session,
                xp: params['xp'],
              ),
        ),
        'myTier': _i1.MethodConnector(
          name: 'myTier',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['season'] as _i10.SeasonEndpoint).myTier(session),
        ),
      },
    );
    connectors['shop'] = _i1.EndpointConnector(
      name: 'shop',
      endpoint: endpoints['shop']!,
      methodConnectors: {
        'listSkus': _i1.MethodConnector(
          name: 'listSkus',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['shop'] as _i11.ShopEndpoint).listSkus(session),
        ),
        'purchase': _i1.MethodConnector(
          name: 'purchase',
          params: {
            'sku': _i1.ParameterDescription(
              name: 'sku',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'storeReceipt': _i1.ParameterDescription(
              name: 'storeReceipt',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['shop'] as _i11.ShopEndpoint).purchase(
                session,
                sku: params['sku'],
                storeReceipt: params['storeReceipt'],
              ),
        ),
      },
    );
    connectors['telemetry'] = _i1.EndpointConnector(
      name: 'telemetry',
      endpoint: endpoints['telemetry']!,
      methodConnectors: {
        'ingest': _i1.MethodConnector(
          name: 'ingest',
          params: {
            'events': _i1.ParameterDescription(
              name: 'events',
              type: _i1.getType<List<_i13.TelemetryEvent>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['telemetry'] as _i12.TelemetryEndpoint).ingest(
                    session,
                    events: params['events'],
                  ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i14.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i15.Endpoints()
      ..initializeEndpoints(server);
  }
}
