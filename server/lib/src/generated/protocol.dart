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
import 'defense.dart' as _i8;
import 'defense_not_found_exception.dart' as _i9;
import 'defense_validation_exception.dart' as _i10;
import 'not_authenticated_exception.dart' as _i11;
import 'player.dart' as _i12;
import 'sim_version_mismatch_exception.dart' as _i13;
import 'unlock.dart' as _i14;
import 'virus_preset.dart' as _i15;
export 'attack_validation_exception.dart';
export 'battle.dart';
export 'battle_outcome.dart';
export 'defense.dart';
export 'defense_not_found_exception.dart';
export 'defense_validation_exception.dart';
export 'not_authenticated_exception.dart';
export 'player.dart';
export 'sim_version_mismatch_exception.dart';
export 'unlock.dart';
export 'virus_preset.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
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
    if (t == _i8.Defense) {
      return _i8.Defense.fromJson(data) as T;
    }
    if (t == _i9.DefenseNotFoundException) {
      return _i9.DefenseNotFoundException.fromJson(data) as T;
    }
    if (t == _i10.DefenseValidationException) {
      return _i10.DefenseValidationException.fromJson(data) as T;
    }
    if (t == _i11.NotAuthenticatedException) {
      return _i11.NotAuthenticatedException.fromJson(data) as T;
    }
    if (t == _i12.Player) {
      return _i12.Player.fromJson(data) as T;
    }
    if (t == _i13.SimVersionMismatchException) {
      return _i13.SimVersionMismatchException.fromJson(data) as T;
    }
    if (t == _i14.Unlock) {
      return _i14.Unlock.fromJson(data) as T;
    }
    if (t == _i15.VirusPreset) {
      return _i15.VirusPreset.fromJson(data) as T;
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
    if (t == _i1.getType<_i8.Defense?>()) {
      return (data != null ? _i8.Defense.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DefenseNotFoundException?>()) {
      return (data != null ? _i9.DefenseNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i10.DefenseValidationException?>()) {
      return (data != null
              ? _i10.DefenseValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.NotAuthenticatedException?>()) {
      return (data != null
              ? _i11.NotAuthenticatedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i12.Player?>()) {
      return (data != null ? _i12.Player.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.SimVersionMismatchException?>()) {
      return (data != null
              ? _i13.SimVersionMismatchException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i14.Unlock?>()) {
      return (data != null ? _i14.Unlock.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.VirusPreset?>()) {
      return (data != null ? _i15.VirusPreset.fromJson(data) : null) as T;
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
      _i8.Defense => 'Defense',
      _i9.DefenseNotFoundException => 'DefenseNotFoundException',
      _i10.DefenseValidationException => 'DefenseValidationException',
      _i11.NotAuthenticatedException => 'NotAuthenticatedException',
      _i12.Player => 'Player',
      _i13.SimVersionMismatchException => 'SimVersionMismatchException',
      _i14.Unlock => 'Unlock',
      _i15.VirusPreset => 'VirusPreset',
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
      case _i8.Defense():
        return 'Defense';
      case _i9.DefenseNotFoundException():
        return 'DefenseNotFoundException';
      case _i10.DefenseValidationException():
        return 'DefenseValidationException';
      case _i11.NotAuthenticatedException():
        return 'NotAuthenticatedException';
      case _i12.Player():
        return 'Player';
      case _i13.SimVersionMismatchException():
        return 'SimVersionMismatchException';
      case _i14.Unlock():
        return 'Unlock';
      case _i15.VirusPreset():
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
    if (dataClassName == 'Defense') {
      return deserialize<_i8.Defense>(data['data']);
    }
    if (dataClassName == 'DefenseNotFoundException') {
      return deserialize<_i9.DefenseNotFoundException>(data['data']);
    }
    if (dataClassName == 'DefenseValidationException') {
      return deserialize<_i10.DefenseValidationException>(data['data']);
    }
    if (dataClassName == 'NotAuthenticatedException') {
      return deserialize<_i11.NotAuthenticatedException>(data['data']);
    }
    if (dataClassName == 'Player') {
      return deserialize<_i12.Player>(data['data']);
    }
    if (dataClassName == 'SimVersionMismatchException') {
      return deserialize<_i13.SimVersionMismatchException>(data['data']);
    }
    if (dataClassName == 'Unlock') {
      return deserialize<_i14.Unlock>(data['data']);
    }
    if (dataClassName == 'VirusPreset') {
      return deserialize<_i15.VirusPreset>(data['data']);
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
      case _i8.Defense:
        return _i8.Defense.t;
      case _i12.Player:
        return _i12.Player.t;
      case _i14.Unlock:
        return _i14.Unlock.t;
      case _i15.VirusPreset:
        return _i15.VirusPreset.t;
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
