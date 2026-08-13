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

/// A block a player has unlocked (§2.4 `unlocks`), via campaign mission
/// completion (see app's CampaignController for the client-side mirror of
/// this table, kept in sync once cloud-sync lands).
abstract class Unlock
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Unlock._({
    this.id,
    required this.playerId,
    this.player,
    required this.blockId,
    DateTime? unlockedAt,
  }) : unlockedAt = unlockedAt ?? DateTime.now();

  factory Unlock({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String blockId,
    DateTime? unlockedAt,
  }) = _UnlockImpl;

  factory Unlock.fromJson(Map<String, dynamic> jsonSerialization) {
    return Unlock(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      blockId: jsonSerialization['blockId'] as String,
      unlockedAt: jsonSerialization['unlockedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['unlockedAt']),
    );
  }

  static final t = UnlockTable();

  static const db = UnlockRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  /// content/blocks.json block id.
  String blockId;

  DateTime unlockedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Unlock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Unlock copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    String? blockId,
    DateTime? unlockedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Unlock',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'blockId': blockId,
      'unlockedAt': unlockedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Unlock',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJsonForProtocol(),
      'blockId': blockId,
      'unlockedAt': unlockedAt.toJson(),
    };
  }

  static UnlockInclude include({_i2.PlayerInclude? player}) {
    return UnlockInclude._(player: player);
  }

  static UnlockIncludeList includeList({
    _i1.WhereExpressionBuilder<UnlockTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UnlockTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UnlockTable>? orderByList,
    UnlockInclude? include,
  }) {
    return UnlockIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Unlock.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Unlock.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UnlockImpl extends Unlock {
  _UnlockImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required String blockId,
    DateTime? unlockedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         blockId: blockId,
         unlockedAt: unlockedAt,
       );

  /// Returns a shallow copy of this [Unlock]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Unlock copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    String? blockId,
    DateTime? unlockedAt,
  }) {
    return Unlock(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      blockId: blockId ?? this.blockId,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }
}

class UnlockUpdateTable extends _i1.UpdateTable<UnlockTable> {
  UnlockUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playerId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.playerId,
        value,
      );

  _i1.ColumnValue<String, String> blockId(String value) => _i1.ColumnValue(
    table.blockId,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> unlockedAt(DateTime value) =>
      _i1.ColumnValue(
        table.unlockedAt,
        value,
      );
}

class UnlockTable extends _i1.Table<_i1.UuidValue?> {
  UnlockTable({super.tableRelation}) : super(tableName: 'unlocks') {
    updateTable = UnlockUpdateTable(this);
    playerId = _i1.ColumnUuid(
      'playerId',
      this,
    );
    blockId = _i1.ColumnString(
      'blockId',
      this,
    );
    unlockedAt = _i1.ColumnDateTime(
      'unlockedAt',
      this,
    );
  }

  late final UnlockUpdateTable updateTable;

  late final _i1.ColumnUuid playerId;

  _i2.PlayerTable? _player;

  /// content/blocks.json block id.
  late final _i1.ColumnString blockId;

  late final _i1.ColumnDateTime unlockedAt;

  _i2.PlayerTable get player {
    if (_player != null) return _player!;
    _player = _i1.createRelationTable(
      relationFieldName: 'player',
      field: Unlock.t.playerId,
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
    blockId,
    unlockedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'player') {
      return player;
    }
    return null;
  }
}

class UnlockInclude extends _i1.IncludeObject {
  UnlockInclude._({_i2.PlayerInclude? player}) {
    _player = player;
  }

  _i2.PlayerInclude? _player;

  @override
  Map<String, _i1.Include?> get includes => {'player': _player};

  @override
  _i1.Table<_i1.UuidValue?> get table => Unlock.t;
}

class UnlockIncludeList extends _i1.IncludeList {
  UnlockIncludeList._({
    _i1.WhereExpressionBuilder<UnlockTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Unlock.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Unlock.t;
}

class UnlockRepository {
  const UnlockRepository._();

  final attachRow = const UnlockAttachRowRepository._();

  /// Returns a list of [Unlock]s matching the given query parameters.
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
  Future<List<Unlock>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UnlockTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UnlockTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UnlockTable>? orderByList,
    _i1.Transaction? transaction,
    UnlockInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Unlock>(
      where: where?.call(Unlock.t),
      orderBy: orderBy?.call(Unlock.t),
      orderByList: orderByList?.call(Unlock.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Unlock] matching the given query parameters.
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
  Future<Unlock?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UnlockTable>? where,
    int? offset,
    _i1.OrderByBuilder<UnlockTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UnlockTable>? orderByList,
    _i1.Transaction? transaction,
    UnlockInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Unlock>(
      where: where?.call(Unlock.t),
      orderBy: orderBy?.call(Unlock.t),
      orderByList: orderByList?.call(Unlock.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Unlock] by its [id] or null if no such row exists.
  Future<Unlock?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    UnlockInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Unlock>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Unlock]s in the list and returns the inserted rows.
  ///
  /// The returned [Unlock]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Unlock>> insert(
    _i1.DatabaseSession session,
    List<Unlock> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Unlock>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Unlock] and returns the inserted row.
  ///
  /// The returned [Unlock] will have its `id` field set.
  Future<Unlock> insertRow(
    _i1.DatabaseSession session,
    Unlock row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Unlock>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Unlock]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Unlock>> update(
    _i1.DatabaseSession session,
    List<Unlock> rows, {
    _i1.ColumnSelections<UnlockTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Unlock>(
      rows,
      columns: columns?.call(Unlock.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Unlock]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Unlock> updateRow(
    _i1.DatabaseSession session,
    Unlock row, {
    _i1.ColumnSelections<UnlockTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Unlock>(
      row,
      columns: columns?.call(Unlock.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Unlock] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Unlock?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<UnlockUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Unlock>(
      id,
      columnValues: columnValues(Unlock.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Unlock]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Unlock>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UnlockUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UnlockTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UnlockTable>? orderBy,
    _i1.OrderByListBuilder<UnlockTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Unlock>(
      columnValues: columnValues(Unlock.t.updateTable),
      where: where(Unlock.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Unlock.t),
      orderByList: orderByList?.call(Unlock.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Unlock]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Unlock>> delete(
    _i1.DatabaseSession session,
    List<Unlock> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Unlock>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Unlock].
  Future<Unlock> deleteRow(
    _i1.DatabaseSession session,
    Unlock row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Unlock>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Unlock>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UnlockTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Unlock>(
      where: where(Unlock.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UnlockTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Unlock>(
      where: where?.call(Unlock.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Unlock] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UnlockTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Unlock>(
      where: where(Unlock.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class UnlockAttachRowRepository {
  const UnlockAttachRowRepository._();

  /// Creates a relation between the given [Unlock] and [Player]
  /// by setting the [Unlock]'s foreign key `playerId` to refer to the [Player].
  Future<void> player(
    _i1.DatabaseSession session,
    Unlock unlock,
    _i2.Player player, {
    _i1.Transaction? transaction,
  }) async {
    if (unlock.id == null) {
      throw ArgumentError.notNull('unlock.id');
    }
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }

    var $unlock = unlock.copyWith(playerId: player.id);
    await session.db.updateRow<Unlock>(
      $unlock,
      columns: [Unlock.t.playerId],
      transaction: transaction,
    );
  }
}
