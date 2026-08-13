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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'attack_validation_exception.dart' as _i5;
import 'battle.dart' as _i6;
import 'battle_outcome.dart' as _i7;
import 'battle_pass_progress.dart' as _i8;
import 'blueprint.dart' as _i9;
import 'blueprint_moderation_state.dart' as _i10;
import 'blueprint_not_found_exception.dart' as _i11;
import 'blueprint_not_revealed_exception.dart' as _i12;
import 'blueprint_reveal.dart' as _i13;
import 'blueprint_title_rejected_exception.dart' as _i14;
import 'blueprint_validation_exception.dart' as _i15;
import 'contract_score.dart' as _i16;
import 'daily_contract.dart' as _i17;
import 'defense.dart' as _i18;
import 'defense_not_found_exception.dart' as _i19;
import 'defense_validation_exception.dart' as _i20;
import 'not_authenticated_exception.dart' as _i21;
import 'player.dart' as _i22;
import 'purchase.dart' as _i23;
import 'purchase_state.dart' as _i24;
import 'season.dart' as _i25;
import 'season_result.dart' as _i26;
import 'sim_version_mismatch_exception.dart' as _i27;
import 'sku_not_found_exception.dart' as _i28;
import 'telemetry_event.dart' as _i29;
import 'unlock.dart' as _i30;
import 'virus_preset.dart' as _i31;
import 'package:payload_server/src/generated/blueprint.dart' as _i32;
import 'package:payload_server/src/generated/contract_score.dart' as _i33;
import 'package:payload_server/src/generated/telemetry_event.dart' as _i34;
export 'attack_validation_exception.dart';
export 'battle.dart';
export 'battle_outcome.dart';
export 'battle_pass_progress.dart';
export 'blueprint.dart';
export 'blueprint_moderation_state.dart';
export 'blueprint_not_found_exception.dart';
export 'blueprint_not_revealed_exception.dart';
export 'blueprint_reveal.dart';
export 'blueprint_title_rejected_exception.dart';
export 'blueprint_validation_exception.dart';
export 'contract_score.dart';
export 'daily_contract.dart';
export 'defense.dart';
export 'defense_not_found_exception.dart';
export 'defense_validation_exception.dart';
export 'not_authenticated_exception.dart';
export 'player.dart';
export 'purchase.dart';
export 'purchase_state.dart';
export 'season.dart';
export 'season_result.dart';
export 'sim_version_mismatch_exception.dart';
export 'sku_not_found_exception.dart';
export 'telemetry_event.dart';
export 'unlock.dart';
export 'virus_preset.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'battle_pass_progress',
      dartName: 'BattlePassProgress',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'playerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'seasonId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'xp',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'hasPremium',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'battle_pass_progress_fk_0',
          columns: ['playerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'battle_pass_progress_fk_1',
          columns: ['seasonId'],
          referenceTable: 'seasons',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'battle_pass_progress_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'battle_pass_progress_player_season_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'playerId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'seasonId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'battles',
      dartName: 'Battle',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'attackerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'defenderId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'defenseVersion',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isGhostMatch',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'virusDefJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'seed',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'simVersion',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'logJson',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'logRef',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'outcome',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BattleOutcome',
        ),
        _i2.ColumnDefinition(
          name: 'ratingDelta',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'battles_fk_0',
          columns: ['attackerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'battles_fk_1',
          columns: ['defenderId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'battles_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'blueprint_reveals',
      dartName: 'BlueprintReveal',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'playerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'blueprintId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'replaysWatched',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'blocksRevealed',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'blueprint_reveals_fk_0',
          columns: ['playerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'blueprint_reveals_fk_1',
          columns: ['blueprintId'],
          referenceTable: 'blueprints',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'blueprint_reveals_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'blueprint_reveals_player_blueprint_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'playerId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'blueprintId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'blueprints',
      dartName: 'Blueprint',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'playerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'virusDefJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'likes',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'plays',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'publishedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'moderationState',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:BlueprintModerationState',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'blueprints_fk_0',
          columns: ['playerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'blueprints_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'blueprints_moderation_state_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'moderationState',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'contract_scores',
      dartName: 'ContractScore',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'playerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'contractId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'score',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'achievedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'contract_scores_fk_0',
          columns: ['playerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'contract_scores_fk_1',
          columns: ['contractId'],
          referenceTable: 'daily_contracts',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'contract_scores_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'contract_scores_player_contract_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'playerId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'contractId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'contract_scores_leaderboard_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'contractId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'score',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'daily_contracts',
      dartName: 'DailyContract',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'contractDate',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'networkJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'seed',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'daily_contracts_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'daily_contracts_date_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'contractDate',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'defenses',
      dartName: 'Defense',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'playerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'defJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'version',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'isActive',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'validatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'defenses_fk_0',
          columns: ['playerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'defenses_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'players',
      dartName: 'Player',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'isGuest',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'handle',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'rating',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'seasonRating',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'credits',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'keys',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'capacityKb',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'settingsJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'players_fk_0',
          columns: ['authUserId'],
          referenceTable: 'serverpod_auth_core_user',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'players_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'players_handle_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'handle',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'purchases',
      dartName: 'Purchase',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'playerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'sku',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'storeReceipt',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'state',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:PurchaseState',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'purchases_fk_0',
          columns: ['playerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'purchases_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'purchases_player_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'playerId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'season_results',
      dartName: 'SeasonResult',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'seasonId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'playerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'finalRating',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'rank',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'season_results_fk_0',
          columns: ['seasonId'],
          referenceTable: 'seasons',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
        _i2.ForeignKeyDefinition(
          constraintName: 'season_results_fk_1',
          columns: ['playerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'season_results_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'season_results_season_rank_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'seasonId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'rank',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'seasons',
      dartName: 'Season',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'startsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'endsAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'seasons_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'seasons_ends_at_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'endsAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'telemetry_events',
      dartName: 'TelemetryEvent',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'playerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: true,
          dartType: 'UuidValue?',
        ),
        _i2.ColumnDefinition(
          name: 'eventType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'propertiesJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'occurredAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'receivedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'telemetry_events_fk_0',
          columns: ['playerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.setNull,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'telemetry_events_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'telemetry_events_type_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'eventType',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'unlocks',
      dartName: 'Unlock',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'playerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'blockId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'unlockedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'unlocks_fk_0',
          columns: ['playerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'unlocks_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'virus_presets',
      dartName: 'VirusPreset',
      schema: 'public',
      module: 'payload',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue?',
          columnDefault: 'gen_random_uuid_v7()',
        ),
        _i2.ColumnDefinition(
          name: 'playerId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'defJson',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'sizeKb',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [
        _i2.ForeignKeyDefinition(
          constraintName: 'virus_presets_fk_0',
          columns: ['playerId'],
          referenceTable: 'players',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _i2.ForeignKeyAction.noAction,
          onDelete: _i2.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'virus_presets_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.AttackValidationException) {
      return _i5.AttackValidationException.fromJson(data) as T;
    }
    if (t == _i6.Battle) {
      return _i6.Battle.fromJson(data) as T;
    }
    if (t == _i7.BattleOutcome) {
      return _i7.BattleOutcome.fromJson(data) as T;
    }
    if (t == _i8.BattlePassProgress) {
      return _i8.BattlePassProgress.fromJson(data) as T;
    }
    if (t == _i9.Blueprint) {
      return _i9.Blueprint.fromJson(data) as T;
    }
    if (t == _i10.BlueprintModerationState) {
      return _i10.BlueprintModerationState.fromJson(data) as T;
    }
    if (t == _i11.BlueprintNotFoundException) {
      return _i11.BlueprintNotFoundException.fromJson(data) as T;
    }
    if (t == _i12.BlueprintNotRevealedException) {
      return _i12.BlueprintNotRevealedException.fromJson(data) as T;
    }
    if (t == _i13.BlueprintReveal) {
      return _i13.BlueprintReveal.fromJson(data) as T;
    }
    if (t == _i14.BlueprintTitleRejectedException) {
      return _i14.BlueprintTitleRejectedException.fromJson(data) as T;
    }
    if (t == _i15.BlueprintValidationException) {
      return _i15.BlueprintValidationException.fromJson(data) as T;
    }
    if (t == _i16.ContractScore) {
      return _i16.ContractScore.fromJson(data) as T;
    }
    if (t == _i17.DailyContract) {
      return _i17.DailyContract.fromJson(data) as T;
    }
    if (t == _i18.Defense) {
      return _i18.Defense.fromJson(data) as T;
    }
    if (t == _i19.DefenseNotFoundException) {
      return _i19.DefenseNotFoundException.fromJson(data) as T;
    }
    if (t == _i20.DefenseValidationException) {
      return _i20.DefenseValidationException.fromJson(data) as T;
    }
    if (t == _i21.NotAuthenticatedException) {
      return _i21.NotAuthenticatedException.fromJson(data) as T;
    }
    if (t == _i22.Player) {
      return _i22.Player.fromJson(data) as T;
    }
    if (t == _i23.Purchase) {
      return _i23.Purchase.fromJson(data) as T;
    }
    if (t == _i24.PurchaseState) {
      return _i24.PurchaseState.fromJson(data) as T;
    }
    if (t == _i25.Season) {
      return _i25.Season.fromJson(data) as T;
    }
    if (t == _i26.SeasonResult) {
      return _i26.SeasonResult.fromJson(data) as T;
    }
    if (t == _i27.SimVersionMismatchException) {
      return _i27.SimVersionMismatchException.fromJson(data) as T;
    }
    if (t == _i28.SkuNotFoundException) {
      return _i28.SkuNotFoundException.fromJson(data) as T;
    }
    if (t == _i29.TelemetryEvent) {
      return _i29.TelemetryEvent.fromJson(data) as T;
    }
    if (t == _i30.Unlock) {
      return _i30.Unlock.fromJson(data) as T;
    }
    if (t == _i31.VirusPreset) {
      return _i31.VirusPreset.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AttackValidationException?>()) {
      return (data != null
              ? _i5.AttackValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i6.Battle?>()) {
      return (data != null ? _i6.Battle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.BattleOutcome?>()) {
      return (data != null ? _i7.BattleOutcome.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.BattlePassProgress?>()) {
      return (data != null ? _i8.BattlePassProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Blueprint?>()) {
      return (data != null ? _i9.Blueprint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.BlueprintModerationState?>()) {
      return (data != null
              ? _i10.BlueprintModerationState.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.BlueprintNotFoundException?>()) {
      return (data != null
              ? _i11.BlueprintNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i12.BlueprintNotRevealedException?>()) {
      return (data != null
              ? _i12.BlueprintNotRevealedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i13.BlueprintReveal?>()) {
      return (data != null ? _i13.BlueprintReveal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.BlueprintTitleRejectedException?>()) {
      return (data != null
              ? _i14.BlueprintTitleRejectedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i15.BlueprintValidationException?>()) {
      return (data != null
              ? _i15.BlueprintValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i16.ContractScore?>()) {
      return (data != null ? _i16.ContractScore.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.DailyContract?>()) {
      return (data != null ? _i17.DailyContract.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.Defense?>()) {
      return (data != null ? _i18.Defense.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.DefenseNotFoundException?>()) {
      return (data != null
              ? _i19.DefenseNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i20.DefenseValidationException?>()) {
      return (data != null
              ? _i20.DefenseValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i21.NotAuthenticatedException?>()) {
      return (data != null
              ? _i21.NotAuthenticatedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i22.Player?>()) {
      return (data != null ? _i22.Player.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Purchase?>()) {
      return (data != null ? _i23.Purchase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.PurchaseState?>()) {
      return (data != null ? _i24.PurchaseState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.Season?>()) {
      return (data != null ? _i25.Season.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.SeasonResult?>()) {
      return (data != null ? _i26.SeasonResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.SimVersionMismatchException?>()) {
      return (data != null
              ? _i27.SimVersionMismatchException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i28.SkuNotFoundException?>()) {
      return (data != null ? _i28.SkuNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.TelemetryEvent?>()) {
      return (data != null ? _i29.TelemetryEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.Unlock?>()) {
      return (data != null ? _i30.Unlock.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.VirusPreset?>()) {
      return (data != null ? _i31.VirusPreset.fromJson(data) : null) as T;
    }
    if (t == List<_i32.Blueprint>) {
      return (data as List).map((e) => deserialize<_i32.Blueprint>(e)).toList()
          as T;
    }
    if (t == List<_i33.ContractScore>) {
      return (data as List)
              .map((e) => deserialize<_i33.ContractScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i34.TelemetryEvent>) {
      return (data as List)
              .map((e) => deserialize<_i34.TelemetryEvent>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AttackValidationException => 'AttackValidationException',
      _i6.Battle => 'Battle',
      _i7.BattleOutcome => 'BattleOutcome',
      _i8.BattlePassProgress => 'BattlePassProgress',
      _i9.Blueprint => 'Blueprint',
      _i10.BlueprintModerationState => 'BlueprintModerationState',
      _i11.BlueprintNotFoundException => 'BlueprintNotFoundException',
      _i12.BlueprintNotRevealedException => 'BlueprintNotRevealedException',
      _i13.BlueprintReveal => 'BlueprintReveal',
      _i14.BlueprintTitleRejectedException => 'BlueprintTitleRejectedException',
      _i15.BlueprintValidationException => 'BlueprintValidationException',
      _i16.ContractScore => 'ContractScore',
      _i17.DailyContract => 'DailyContract',
      _i18.Defense => 'Defense',
      _i19.DefenseNotFoundException => 'DefenseNotFoundException',
      _i20.DefenseValidationException => 'DefenseValidationException',
      _i21.NotAuthenticatedException => 'NotAuthenticatedException',
      _i22.Player => 'Player',
      _i23.Purchase => 'Purchase',
      _i24.PurchaseState => 'PurchaseState',
      _i25.Season => 'Season',
      _i26.SeasonResult => 'SeasonResult',
      _i27.SimVersionMismatchException => 'SimVersionMismatchException',
      _i28.SkuNotFoundException => 'SkuNotFoundException',
      _i29.TelemetryEvent => 'TelemetryEvent',
      _i30.Unlock => 'Unlock',
      _i31.VirusPreset => 'VirusPreset',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('payload.', '');
    }

    switch (data) {
      case _i5.AttackValidationException():
        return 'AttackValidationException';
      case _i6.Battle():
        return 'Battle';
      case _i7.BattleOutcome():
        return 'BattleOutcome';
      case _i8.BattlePassProgress():
        return 'BattlePassProgress';
      case _i9.Blueprint():
        return 'Blueprint';
      case _i10.BlueprintModerationState():
        return 'BlueprintModerationState';
      case _i11.BlueprintNotFoundException():
        return 'BlueprintNotFoundException';
      case _i12.BlueprintNotRevealedException():
        return 'BlueprintNotRevealedException';
      case _i13.BlueprintReveal():
        return 'BlueprintReveal';
      case _i14.BlueprintTitleRejectedException():
        return 'BlueprintTitleRejectedException';
      case _i15.BlueprintValidationException():
        return 'BlueprintValidationException';
      case _i16.ContractScore():
        return 'ContractScore';
      case _i17.DailyContract():
        return 'DailyContract';
      case _i18.Defense():
        return 'Defense';
      case _i19.DefenseNotFoundException():
        return 'DefenseNotFoundException';
      case _i20.DefenseValidationException():
        return 'DefenseValidationException';
      case _i21.NotAuthenticatedException():
        return 'NotAuthenticatedException';
      case _i22.Player():
        return 'Player';
      case _i23.Purchase():
        return 'Purchase';
      case _i24.PurchaseState():
        return 'PurchaseState';
      case _i25.Season():
        return 'Season';
      case _i26.SeasonResult():
        return 'SeasonResult';
      case _i27.SimVersionMismatchException():
        return 'SimVersionMismatchException';
      case _i28.SkuNotFoundException():
        return 'SkuNotFoundException';
      case _i29.TelemetryEvent():
        return 'TelemetryEvent';
      case _i30.Unlock():
        return 'Unlock';
      case _i31.VirusPreset():
        return 'VirusPreset';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AttackValidationException') {
      return deserialize<_i5.AttackValidationException>(data['data']);
    }
    if (dataClassName == 'Battle') {
      return deserialize<_i6.Battle>(data['data']);
    }
    if (dataClassName == 'BattleOutcome') {
      return deserialize<_i7.BattleOutcome>(data['data']);
    }
    if (dataClassName == 'BattlePassProgress') {
      return deserialize<_i8.BattlePassProgress>(data['data']);
    }
    if (dataClassName == 'Blueprint') {
      return deserialize<_i9.Blueprint>(data['data']);
    }
    if (dataClassName == 'BlueprintModerationState') {
      return deserialize<_i10.BlueprintModerationState>(data['data']);
    }
    if (dataClassName == 'BlueprintNotFoundException') {
      return deserialize<_i11.BlueprintNotFoundException>(data['data']);
    }
    if (dataClassName == 'BlueprintNotRevealedException') {
      return deserialize<_i12.BlueprintNotRevealedException>(data['data']);
    }
    if (dataClassName == 'BlueprintReveal') {
      return deserialize<_i13.BlueprintReveal>(data['data']);
    }
    if (dataClassName == 'BlueprintTitleRejectedException') {
      return deserialize<_i14.BlueprintTitleRejectedException>(data['data']);
    }
    if (dataClassName == 'BlueprintValidationException') {
      return deserialize<_i15.BlueprintValidationException>(data['data']);
    }
    if (dataClassName == 'ContractScore') {
      return deserialize<_i16.ContractScore>(data['data']);
    }
    if (dataClassName == 'DailyContract') {
      return deserialize<_i17.DailyContract>(data['data']);
    }
    if (dataClassName == 'Defense') {
      return deserialize<_i18.Defense>(data['data']);
    }
    if (dataClassName == 'DefenseNotFoundException') {
      return deserialize<_i19.DefenseNotFoundException>(data['data']);
    }
    if (dataClassName == 'DefenseValidationException') {
      return deserialize<_i20.DefenseValidationException>(data['data']);
    }
    if (dataClassName == 'NotAuthenticatedException') {
      return deserialize<_i21.NotAuthenticatedException>(data['data']);
    }
    if (dataClassName == 'Player') {
      return deserialize<_i22.Player>(data['data']);
    }
    if (dataClassName == 'Purchase') {
      return deserialize<_i23.Purchase>(data['data']);
    }
    if (dataClassName == 'PurchaseState') {
      return deserialize<_i24.PurchaseState>(data['data']);
    }
    if (dataClassName == 'Season') {
      return deserialize<_i25.Season>(data['data']);
    }
    if (dataClassName == 'SeasonResult') {
      return deserialize<_i26.SeasonResult>(data['data']);
    }
    if (dataClassName == 'SimVersionMismatchException') {
      return deserialize<_i27.SimVersionMismatchException>(data['data']);
    }
    if (dataClassName == 'SkuNotFoundException') {
      return deserialize<_i28.SkuNotFoundException>(data['data']);
    }
    if (dataClassName == 'TelemetryEvent') {
      return deserialize<_i29.TelemetryEvent>(data['data']);
    }
    if (dataClassName == 'Unlock') {
      return deserialize<_i30.Unlock>(data['data']);
    }
    if (dataClassName == 'VirusPreset') {
      return deserialize<_i31.VirusPreset>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i6.Battle:
        return _i6.Battle.t;
      case _i8.BattlePassProgress:
        return _i8.BattlePassProgress.t;
      case _i9.Blueprint:
        return _i9.Blueprint.t;
      case _i13.BlueprintReveal:
        return _i13.BlueprintReveal.t;
      case _i16.ContractScore:
        return _i16.ContractScore.t;
      case _i17.DailyContract:
        return _i17.DailyContract.t;
      case _i18.Defense:
        return _i18.Defense.t;
      case _i22.Player:
        return _i22.Player.t;
      case _i23.Purchase:
        return _i23.Purchase.t;
      case _i25.Season:
        return _i25.Season.t;
      case _i26.SeasonResult:
        return _i26.SeasonResult.t;
      case _i29.TelemetryEvent:
        return _i29.TelemetryEvent.t;
      case _i30.Unlock:
        return _i30.Unlock.t;
      case _i31.VirusPreset:
        return _i31.VirusPreset.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'payload';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
