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

/// A player's saved defense: topology + per-node defense-logic (§2.4
/// `defenses`). PvP attacks always target the most recent snapshot with
/// `isActive == true` — never a defense mid-edit (§2.3: "defender tidak
/// bisa di-grief saat sedang mengedit").
abstract class Defense
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Defense._({
    this.id,
    required this.playerId,
    this.player,
    required this.defJson,
    int? version,
    bool? isActive,
    this.validatedAt,
  }) : version = version ?? 1,
       isActive = isActive ?? false;

  factory Defense({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String defJson,
    int? version,
    bool? isActive,
    DateTime? validatedAt,
  }) = _DefenseImpl;

  factory Defense.fromJson(Map<String, dynamic> jsonSerialization) {
    return Defense(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      defJson: jsonSerialization['defJson'] as String,
      version: jsonSerialization['version'] as int?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      validatedAt: jsonSerialization['validatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['validatedAt'],
            ),
    );
  }

  static final t = DefenseTable();

  static const db = DefenseRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  /// The network topology + per-node defense DAGs, as JSON matching
  /// `content_schema.NetworkDef.toJson()` (defense_logic embedded per node).
  String defJson;

  int version;

  bool isActive;

  /// Set once `content_schema.validateNetwork` + per-node `validateDag`
  /// have both passed server-side.
  DateTime? validatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Defense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Defense copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    String? defJson,
    int? version,
    bool? isActive,
    DateTime? validatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Defense',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'defJson': defJson,
      'version': version,
      'isActive': isActive,
      if (validatedAt != null) 'validatedAt': validatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Defense',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJsonForProtocol(),
      'defJson': defJson,
      'version': version,
      'isActive': isActive,
      if (validatedAt != null) 'validatedAt': validatedAt?.toJson(),
    };
  }

  static DefenseInclude include({_i2.PlayerInclude? player}) {
    return DefenseInclude._(player: player);
  }

  static DefenseIncludeList includeList({
    _i1.WhereExpressionBuilder<DefenseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DefenseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DefenseTable>? orderByList,
    DefenseInclude? include,
  }) {
    return DefenseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Defense.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Defense.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DefenseImpl extends Defense {
  _DefenseImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String defJson,
    int? version,
    bool? isActive,
    DateTime? validatedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         defJson: defJson,
         version: version,
         isActive: isActive,
         validatedAt: validatedAt,
       );

  /// Returns a shallow copy of this [Defense]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Defense copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    String? defJson,
    int? version,
    bool? isActive,
    Object? validatedAt = _Undefined,
  }) {
    return Defense(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      defJson: defJson ?? this.defJson,
      version: version ?? this.version,
      isActive: isActive ?? this.isActive,
      validatedAt: validatedAt is DateTime? ? validatedAt : this.validatedAt,
    );
  }
}

class DefenseUpdateTable extends _i1.UpdateTable<DefenseTable> {
  DefenseUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playerId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.playerId,
        value,
      );

  _i1.ColumnValue<String, String> defJson(String value) => _i1.ColumnValue(
    table.defJson,
    value,
  );

  _i1.ColumnValue<int, int> version(int value) => _i1.ColumnValue(
    table.version,
    value,
  );

  _i1.ColumnValue<bool, bool> isActive(bool value) => _i1.ColumnValue(
    table.isActive,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> validatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.validatedAt,
        value,
      );
}

class DefenseTable extends _i1.Table<_i1.UuidValue?> {
  DefenseTable({super.tableRelation}) : super(tableName: 'defenses') {
    updateTable = DefenseUpdateTable(this);
    playerId = _i1.ColumnUuid(
      'playerId',
      this,
    );
    defJson = _i1.ColumnString(
      'defJson',
      this,
    );
    version = _i1.ColumnInt(
      'version',
      this,
    );
    isActive = _i1.ColumnBool(
      'isActive',
      this,
    );
    validatedAt = _i1.ColumnDateTime(
      'validatedAt',
      this,
    );
  }

  late final DefenseUpdateTable updateTable;

  late final _i1.ColumnUuid playerId;

  _i2.PlayerTable? _player;

  /// The network topology + per-node defense DAGs, as JSON matching
  /// `content_schema.NetworkDef.toJson()` (defense_logic embedded per node).
  late final _i1.ColumnString defJson;

  late final _i1.ColumnInt version;

  late final _i1.ColumnBool isActive;

  /// Set once `content_schema.validateNetwork` + per-node `validateDag`
  /// have both passed server-side.
  late final _i1.ColumnDateTime validatedAt;

  _i2.PlayerTable get player {
    if (_player != null) return _player!;
    _player = _i1.createRelationTable(
      relationFieldName: 'player',
      field: Defense.t.playerId,
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
    defJson,
    version,
    isActive,
    validatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'player') {
      return player;
    }
    return null;
  }
}

class DefenseInclude extends _i1.IncludeObject {
  DefenseInclude._({_i2.PlayerInclude? player}) {
    _player = player;
  }

  _i2.PlayerInclude? _player;

  @override
  Map<String, _i1.Include?> get includes => {'player': _player};

  @override
  _i1.Table<_i1.UuidValue?> get table => Defense.t;
}

class DefenseIncludeList extends _i1.IncludeList {
  DefenseIncludeList._({
    _i1.WhereExpressionBuilder<DefenseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Defense.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Defense.t;
}

class DefenseRepository {
  const DefenseRepository._();

  final attachRow = const DefenseAttachRowRepository._();

  /// Returns a list of [Defense]s matching the given query parameters.
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
  Future<List<Defense>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DefenseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DefenseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DefenseTable>? orderByList,
    _i1.Transaction? transaction,
    DefenseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Defense>(
      where: where?.call(Defense.t),
      orderBy: orderBy?.call(Defense.t),
      orderByList: orderByList?.call(Defense.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Defense] matching the given query parameters.
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
  Future<Defense?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DefenseTable>? where,
    int? offset,
    _i1.OrderByBuilder<DefenseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DefenseTable>? orderByList,
    _i1.Transaction? transaction,
    DefenseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Defense>(
      where: where?.call(Defense.t),
      orderBy: orderBy?.call(Defense.t),
      orderByList: orderByList?.call(Defense.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Defense] by its [id] or null if no such row exists.
  Future<Defense?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    DefenseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Defense>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Defense]s in the list and returns the inserted rows.
  ///
  /// The returned [Defense]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Defense>> insert(
    _i1.DatabaseSession session,
    List<Defense> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Defense>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Defense] and returns the inserted row.
  ///
  /// The returned [Defense] will have its `id` field set.
  Future<Defense> insertRow(
    _i1.DatabaseSession session,
    Defense row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Defense>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Defense]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Defense>> update(
    _i1.DatabaseSession session,
    List<Defense> rows, {
    _i1.ColumnSelections<DefenseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Defense>(
      rows,
      columns: columns?.call(Defense.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Defense]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Defense> updateRow(
    _i1.DatabaseSession session,
    Defense row, {
    _i1.ColumnSelections<DefenseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Defense>(
      row,
      columns: columns?.call(Defense.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Defense] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Defense?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<DefenseUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Defense>(
      id,
      columnValues: columnValues(Defense.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Defense]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Defense>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DefenseUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DefenseTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DefenseTable>? orderBy,
    _i1.OrderByListBuilder<DefenseTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Defense>(
      columnValues: columnValues(Defense.t.updateTable),
      where: where(Defense.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Defense.t),
      orderByList: orderByList?.call(Defense.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Defense]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Defense>> delete(
    _i1.DatabaseSession session,
    List<Defense> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Defense>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Defense].
  Future<Defense> deleteRow(
    _i1.DatabaseSession session,
    Defense row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Defense>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Defense>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DefenseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Defense>(
      where: where(Defense.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DefenseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Defense>(
      where: where?.call(Defense.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Defense] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DefenseTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Defense>(
      where: where(Defense.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class DefenseAttachRowRepository {
  const DefenseAttachRowRepository._();

  /// Creates a relation between the given [Defense] and [Player]
  /// by setting the [Defense]'s foreign key `playerId` to refer to the [Player].
  Future<void> player(
    _i1.DatabaseSession session,
    Defense defense,
    _i2.Player player, {
    _i1.Transaction? transaction,
  }) async {
    if (defense.id == null) {
      throw ArgumentError.notNull('defense.id');
    }
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }

    var $defense = defense.copyWith(playerId: player.id);
    await session.db.updateRow<Defense>(
      $defense,
      columns: [Defense.t.playerId],
      transaction: transaction,
    );
  }
}
