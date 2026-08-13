/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'player.dart' as _i2;
import 'package:payload_server/src/generated/protocol.dart' as _i3;

/// A saved virus build (§2.4 `virus_presets`). Capped at
/// [maxVirusPresetsPerPlayer] per player, enforced in
/// `PresetEndpoint` (app-side mirror: `app/lib/features/core/storage/preset_storage.dart`'s
/// `maxVirusPresets`, kept equal on purpose).
abstract class VirusPreset
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  VirusPreset._({
    this.id,
    required this.playerId,
    this.player,
    required this.name,
    required this.defJson,
    required this.sizeKb,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  factory VirusPreset({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String name,
    required String defJson,
    required int sizeKb,
    DateTime? updatedAt,
  }) = _VirusPresetImpl;

  factory VirusPreset.fromJson(Map<String, dynamic> jsonSerialization) {
    return VirusPreset(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      name: jsonSerialization['name'] as String,
      defJson: jsonSerialization['defJson'] as String,
      sizeKb: jsonSerialization['sizeKb'] as int,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = VirusPresetTable();

  static const db = VirusPresetRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  String name;

  /// The DAG program, as JSON matching `content_schema.DagDef.toJson()`.
  String defJson;

  int sizeKb;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [VirusPreset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VirusPreset copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    String? name,
    String? defJson,
    int? sizeKb,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VirusPreset',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'name': name,
      'defJson': defJson,
      'sizeKb': sizeKb,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VirusPreset',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJsonForProtocol(),
      'name': name,
      'defJson': defJson,
      'sizeKb': sizeKb,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static VirusPresetInclude include({_i2.PlayerInclude? player}) {
    return VirusPresetInclude._(player: player);
  }

  static VirusPresetIncludeList includeList({
    _i1.WhereExpressionBuilder<VirusPresetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VirusPresetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VirusPresetTable>? orderByList,
    VirusPresetInclude? include,
  }) {
    return VirusPresetIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VirusPreset.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(VirusPreset.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VirusPresetImpl extends VirusPreset {
  _VirusPresetImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String name,
    required String defJson,
    required int sizeKb,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         name: name,
         defJson: defJson,
         sizeKb: sizeKb,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [VirusPreset]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VirusPreset copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    String? name,
    String? defJson,
    int? sizeKb,
    DateTime? updatedAt,
  }) {
    return VirusPreset(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      name: name ?? this.name,
      defJson: defJson ?? this.defJson,
      sizeKb: sizeKb ?? this.sizeKb,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class VirusPresetUpdateTable extends _i1.UpdateTable<VirusPresetTable> {
  VirusPresetUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playerId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.playerId,
        value,
      );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> defJson(String value) => _i1.ColumnValue(
    table.defJson,
    value,
  );

  _i1.ColumnValue<int, int> sizeKb(int value) => _i1.ColumnValue(
    table.sizeKb,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class VirusPresetTable extends _i1.Table<_i1.UuidValue?> {
  VirusPresetTable({super.tableRelation}) : super(tableName: 'virus_presets') {
    updateTable = VirusPresetUpdateTable(this);
    playerId = _i1.ColumnUuid(
      'playerId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    defJson = _i1.ColumnString(
      'defJson',
      this,
    );
    sizeKb = _i1.ColumnInt(
      'sizeKb',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final VirusPresetUpdateTable updateTable;

  late final _i1.ColumnUuid playerId;

  _i2.PlayerTable? _player;

  late final _i1.ColumnString name;

  /// The DAG program, as JSON matching `content_schema.DagDef.toJson()`.
  late final _i1.ColumnString defJson;

  late final _i1.ColumnInt sizeKb;

  late final _i1.ColumnDateTime updatedAt;

  _i2.PlayerTable get player {
    if (_player != null) return _player!;
    _player = _i1.createRelationTable(
      relationFieldName: 'player',
      field: VirusPreset.t.playerId,
      foreignField: _i2.Player.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PlayerTable(tableRelation: foreignTableRelation),
    );
    return _player!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    playerId,
    name,
    defJson,
    sizeKb,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'player') {
      return player;
    }
    return null;
  }
}

class VirusPresetInclude extends _i1.IncludeObject {
  VirusPresetInclude._({_i2.PlayerInclude? player}) {
    _player = player;
  }

  _i2.PlayerInclude? _player;

  @override
  Map<String, _i1.Include?> get includes => {'player': _player};

  @override
  _i1.Table<_i1.UuidValue?> get table => VirusPreset.t;
}

class VirusPresetIncludeList extends _i1.IncludeList {
  VirusPresetIncludeList._({
    _i1.WhereExpressionBuilder<VirusPresetTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VirusPreset.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => VirusPreset.t;
}

class VirusPresetRepository {
  const VirusPresetRepository._();

  final attachRow = const VirusPresetAttachRowRepository._();

  /// Returns a list of [VirusPreset]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<VirusPreset>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VirusPresetTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VirusPresetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VirusPresetTable>? orderByList,
    _i1.Transaction? transaction,
    VirusPresetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VirusPreset>(
      where: where?.call(VirusPreset.t),
      orderBy: orderBy?.call(VirusPreset.t),
      orderByList: orderByList?.call(VirusPreset.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VirusPreset] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<VirusPreset?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VirusPresetTable>? where,
    int? offset,
    _i1.OrderByBuilder<VirusPresetTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<VirusPresetTable>? orderByList,
    _i1.Transaction? transaction,
    VirusPresetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VirusPreset>(
      where: where?.call(VirusPreset.t),
      orderBy: orderBy?.call(VirusPreset.t),
      orderByList: orderByList?.call(VirusPreset.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VirusPreset] by its [id] or null if no such row exists.
  Future<VirusPreset?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    VirusPresetInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VirusPreset>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VirusPreset]s in the list and returns the inserted rows.
  ///
  /// The returned [VirusPreset]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<VirusPreset>> insert(
    _i1.DatabaseSession session,
    List<VirusPreset> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<VirusPreset>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [VirusPreset] and returns the inserted row.
  ///
  /// The returned [VirusPreset] will have its `id` field set.
  Future<VirusPreset> insertRow(
    _i1.DatabaseSession session,
    VirusPreset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<VirusPreset>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [VirusPreset]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<VirusPreset>> update(
    _i1.DatabaseSession session,
    List<VirusPreset> rows, {
    _i1.ColumnSelections<VirusPresetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<VirusPreset>(
      rows,
      columns: columns?.call(VirusPreset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VirusPreset]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VirusPreset> updateRow(
    _i1.DatabaseSession session,
    VirusPreset row, {
    _i1.ColumnSelections<VirusPresetTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<VirusPreset>(
      row,
      columns: columns?.call(VirusPreset.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VirusPreset] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VirusPreset?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<VirusPresetUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<VirusPreset>(
      id,
      columnValues: columnValues(VirusPreset.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VirusPreset]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<VirusPreset>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<VirusPresetUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<VirusPresetTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<VirusPresetTable>? orderBy,
    _i1.OrderByListBuilder<VirusPresetTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<VirusPreset>(
      columnValues: columnValues(VirusPreset.t.updateTable),
      where: where(VirusPreset.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VirusPreset.t),
      orderByList: orderByList?.call(VirusPreset.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [VirusPreset]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<VirusPreset>> delete(
    _i1.DatabaseSession session,
    List<VirusPreset> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<VirusPreset>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [VirusPreset].
  Future<VirusPreset> deleteRow(
    _i1.DatabaseSession session,
    VirusPreset row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VirusPreset>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<VirusPreset>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VirusPresetTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<VirusPreset>(
      where: where(VirusPreset.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<VirusPresetTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<VirusPreset>(
      where: where?.call(VirusPreset.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VirusPreset] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<VirusPresetTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VirusPreset>(
      where: where(VirusPreset.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class VirusPresetAttachRowRepository {
  const VirusPresetAttachRowRepository._();

  /// Creates a relation between the given [VirusPreset] and [Player]
  /// by setting the [VirusPreset]'s foreign key `playerId` to refer to the [Player].
  Future<void> player(
    _i1.DatabaseSession session,
    VirusPreset virusPreset,
    _i2.Player player, {
    _i1.Transaction? transaction,
  }) async {
    if (virusPreset.id == null) {
      throw ArgumentError.notNull('virusPreset.id');
    }
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }

    var $virusPreset = virusPreset.copyWith(playerId: player.id);
    await session.db.updateRow<VirusPreset>(
      $virusPreset,
      columns: [VirusPreset.t.playerId],
      transaction: transaction,
    );
  }
}
