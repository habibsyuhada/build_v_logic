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
import 'blueprint.dart' as _i3;
import 'package:payload_server/src/generated/protocol.dart' as _i4;

/// One player's reverse-engineer progress on one blueprint (§1.5.4:
/// "reverse-engineer: replay virus tersebut 3x untuk 'membaca' 1 blok").
/// `blocksRevealed` grows by one every [replaysPerBlock] replays watched;
/// once it reaches the blueprint's full block count, the player may copy
/// the design (checked in business logic, not stored here).
abstract class BlueprintReveal
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  BlueprintReveal._({
    this.id,
    required this.playerId,
    this.player,
    required this.blueprintId,
    this.blueprint,
    int? replaysWatched,
    int? blocksRevealed,
    DateTime? updatedAt,
  }) : replaysWatched = replaysWatched ?? 0,
       blocksRevealed = blocksRevealed ?? 0,
       updatedAt = updatedAt ?? DateTime.now();

  factory BlueprintReveal({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue blueprintId,
    _i3.Blueprint? blueprint,
    int? replaysWatched,
    int? blocksRevealed,
    DateTime? updatedAt,
  }) = _BlueprintRevealImpl;

  factory BlueprintReveal.fromJson(Map<String, dynamic> jsonSerialization) {
    return BlueprintReveal(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      blueprintId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['blueprintId'],
      ),
      blueprint: jsonSerialization['blueprint'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Blueprint>(
              jsonSerialization['blueprint'],
            ),
      replaysWatched: jsonSerialization['replaysWatched'] as int?,
      blocksRevealed: jsonSerialization['blocksRevealed'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = BlueprintRevealTable();

  static const db = BlueprintRevealRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  _i1.UuidValue blueprintId;

  _i3.Blueprint? blueprint;

  int replaysWatched;

  int blocksRevealed;

  DateTime updatedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [BlueprintReveal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BlueprintReveal copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    _i1.UuidValue? blueprintId,
    _i3.Blueprint? blueprint,
    int? replaysWatched,
    int? blocksRevealed,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BlueprintReveal',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'blueprintId': blueprintId.toJson(),
      if (blueprint != null) 'blueprint': blueprint?.toJson(),
      'replaysWatched': replaysWatched,
      'blocksRevealed': blocksRevealed,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BlueprintReveal',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJsonForProtocol(),
      'blueprintId': blueprintId.toJson(),
      if (blueprint != null) 'blueprint': blueprint?.toJsonForProtocol(),
      'replaysWatched': replaysWatched,
      'blocksRevealed': blocksRevealed,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static BlueprintRevealInclude include({
    _i2.PlayerInclude? player,
    _i3.BlueprintInclude? blueprint,
  }) {
    return BlueprintRevealInclude._(
      player: player,
      blueprint: blueprint,
    );
  }

  static BlueprintRevealIncludeList includeList({
    _i1.WhereExpressionBuilder<BlueprintRevealTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BlueprintRevealTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BlueprintRevealTable>? orderByList,
    BlueprintRevealInclude? include,
  }) {
    return BlueprintRevealIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BlueprintReveal.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BlueprintReveal.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BlueprintRevealImpl extends BlueprintReveal {
  _BlueprintRevealImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue blueprintId,
    _i3.Blueprint? blueprint,
    int? replaysWatched,
    int? blocksRevealed,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         blueprintId: blueprintId,
         blueprint: blueprint,
         replaysWatched: replaysWatched,
         blocksRevealed: blocksRevealed,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [BlueprintReveal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BlueprintReveal copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    _i1.UuidValue? blueprintId,
    Object? blueprint = _Undefined,
    int? replaysWatched,
    int? blocksRevealed,
    DateTime? updatedAt,
  }) {
    return BlueprintReveal(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      blueprintId: blueprintId ?? this.blueprintId,
      blueprint: blueprint is _i3.Blueprint?
          ? blueprint
          : this.blueprint?.copyWith(),
      replaysWatched: replaysWatched ?? this.replaysWatched,
      blocksRevealed: blocksRevealed ?? this.blocksRevealed,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class BlueprintRevealUpdateTable extends _i1.UpdateTable<BlueprintRevealTable> {
  BlueprintRevealUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playerId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.playerId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> blueprintId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.blueprintId,
    value,
  );

  _i1.ColumnValue<int, int> replaysWatched(int value) => _i1.ColumnValue(
    table.replaysWatched,
    value,
  );

  _i1.ColumnValue<int, int> blocksRevealed(int value) => _i1.ColumnValue(
    table.blocksRevealed,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class BlueprintRevealTable extends _i1.Table<_i1.UuidValue?> {
  BlueprintRevealTable({super.tableRelation})
    : super(tableName: 'blueprint_reveals') {
    updateTable = BlueprintRevealUpdateTable(this);
    playerId = _i1.ColumnUuid(
      'playerId',
      this,
    );
    blueprintId = _i1.ColumnUuid(
      'blueprintId',
      this,
    );
    replaysWatched = _i1.ColumnInt(
      'replaysWatched',
      this,
    );
    blocksRevealed = _i1.ColumnInt(
      'blocksRevealed',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final BlueprintRevealUpdateTable updateTable;

  late final _i1.ColumnUuid playerId;

  _i2.PlayerTable? _player;

  late final _i1.ColumnUuid blueprintId;

  _i3.BlueprintTable? _blueprint;

  late final _i1.ColumnInt replaysWatched;

  late final _i1.ColumnInt blocksRevealed;

  late final _i1.ColumnDateTime updatedAt;

  _i2.PlayerTable get player {
    if (_player != null) return _player!;
    _player = _i1.createRelationTable(
      relationFieldName: 'player',
      field: BlueprintReveal.t.playerId,
      foreignField: _i2.Player.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PlayerTable(tableRelation: foreignTableRelation),
    );
    return _player!;
  }

  _i3.BlueprintTable get blueprint {
    if (_blueprint != null) return _blueprint!;
    _blueprint = _i1.createRelationTable(
      relationFieldName: 'blueprint',
      field: BlueprintReveal.t.blueprintId,
      foreignField: _i3.Blueprint.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.BlueprintTable(tableRelation: foreignTableRelation),
    );
    return _blueprint!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    playerId,
    blueprintId,
    replaysWatched,
    blocksRevealed,
    updatedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'player') {
      return player;
    }
    if (relationField == 'blueprint') {
      return blueprint;
    }
    return null;
  }
}

class BlueprintRevealInclude extends _i1.IncludeObject {
  BlueprintRevealInclude._({
    _i2.PlayerInclude? player,
    _i3.BlueprintInclude? blueprint,
  }) {
    _player = player;
    _blueprint = blueprint;
  }

  _i2.PlayerInclude? _player;

  _i3.BlueprintInclude? _blueprint;

  @override
  Map<String, _i1.Include?> get includes => {
    'player': _player,
    'blueprint': _blueprint,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => BlueprintReveal.t;
}

class BlueprintRevealIncludeList extends _i1.IncludeList {
  BlueprintRevealIncludeList._({
    _i1.WhereExpressionBuilder<BlueprintRevealTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BlueprintReveal.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => BlueprintReveal.t;
}

class BlueprintRevealRepository {
  const BlueprintRevealRepository._();

  final attachRow = const BlueprintRevealAttachRowRepository._();

  /// Returns a list of [BlueprintReveal]s matching the given query parameters.
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
  Future<List<BlueprintReveal>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BlueprintRevealTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BlueprintRevealTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BlueprintRevealTable>? orderByList,
    _i1.Transaction? transaction,
    BlueprintRevealInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BlueprintReveal>(
      where: where?.call(BlueprintReveal.t),
      orderBy: orderBy?.call(BlueprintReveal.t),
      orderByList: orderByList?.call(BlueprintReveal.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BlueprintReveal] matching the given query parameters.
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
  Future<BlueprintReveal?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BlueprintRevealTable>? where,
    int? offset,
    _i1.OrderByBuilder<BlueprintRevealTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BlueprintRevealTable>? orderByList,
    _i1.Transaction? transaction,
    BlueprintRevealInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BlueprintReveal>(
      where: where?.call(BlueprintReveal.t),
      orderBy: orderBy?.call(BlueprintReveal.t),
      orderByList: orderByList?.call(BlueprintReveal.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BlueprintReveal] by its [id] or null if no such row exists.
  Future<BlueprintReveal?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    BlueprintRevealInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BlueprintReveal>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BlueprintReveal]s in the list and returns the inserted rows.
  ///
  /// The returned [BlueprintReveal]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BlueprintReveal>> insert(
    _i1.DatabaseSession session,
    List<BlueprintReveal> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BlueprintReveal>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BlueprintReveal] and returns the inserted row.
  ///
  /// The returned [BlueprintReveal] will have its `id` field set.
  Future<BlueprintReveal> insertRow(
    _i1.DatabaseSession session,
    BlueprintReveal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BlueprintReveal>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BlueprintReveal]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BlueprintReveal>> update(
    _i1.DatabaseSession session,
    List<BlueprintReveal> rows, {
    _i1.ColumnSelections<BlueprintRevealTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BlueprintReveal>(
      rows,
      columns: columns?.call(BlueprintReveal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BlueprintReveal]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BlueprintReveal> updateRow(
    _i1.DatabaseSession session,
    BlueprintReveal row, {
    _i1.ColumnSelections<BlueprintRevealTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BlueprintReveal>(
      row,
      columns: columns?.call(BlueprintReveal.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BlueprintReveal] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BlueprintReveal?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<BlueprintRevealUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BlueprintReveal>(
      id,
      columnValues: columnValues(BlueprintReveal.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BlueprintReveal]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BlueprintReveal>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BlueprintRevealUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<BlueprintRevealTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BlueprintRevealTable>? orderBy,
    _i1.OrderByListBuilder<BlueprintRevealTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BlueprintReveal>(
      columnValues: columnValues(BlueprintReveal.t.updateTable),
      where: where(BlueprintReveal.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BlueprintReveal.t),
      orderByList: orderByList?.call(BlueprintReveal.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BlueprintReveal]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BlueprintReveal>> delete(
    _i1.DatabaseSession session,
    List<BlueprintReveal> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BlueprintReveal>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BlueprintReveal].
  Future<BlueprintReveal> deleteRow(
    _i1.DatabaseSession session,
    BlueprintReveal row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BlueprintReveal>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BlueprintReveal>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BlueprintRevealTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BlueprintReveal>(
      where: where(BlueprintReveal.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BlueprintRevealTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BlueprintReveal>(
      where: where?.call(BlueprintReveal.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BlueprintReveal] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BlueprintRevealTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BlueprintReveal>(
      where: where(BlueprintReveal.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BlueprintRevealAttachRowRepository {
  const BlueprintRevealAttachRowRepository._();

  /// Creates a relation between the given [BlueprintReveal] and [Player]
  /// by setting the [BlueprintReveal]'s foreign key `playerId` to refer to the [Player].
  Future<void> player(
    _i1.DatabaseSession session,
    BlueprintReveal blueprintReveal,
    _i2.Player player, {
    _i1.Transaction? transaction,
  }) async {
    if (blueprintReveal.id == null) {
      throw ArgumentError.notNull('blueprintReveal.id');
    }
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }

    var $blueprintReveal = blueprintReveal.copyWith(playerId: player.id);
    await session.db.updateRow<BlueprintReveal>(
      $blueprintReveal,
      columns: [BlueprintReveal.t.playerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [BlueprintReveal] and [Blueprint]
  /// by setting the [BlueprintReveal]'s foreign key `blueprintId` to refer to the [Blueprint].
  Future<void> blueprint(
    _i1.DatabaseSession session,
    BlueprintReveal blueprintReveal,
    _i3.Blueprint blueprint, {
    _i1.Transaction? transaction,
  }) async {
    if (blueprintReveal.id == null) {
      throw ArgumentError.notNull('blueprintReveal.id');
    }
    if (blueprint.id == null) {
      throw ArgumentError.notNull('blueprint.id');
    }

    var $blueprintReveal = blueprintReveal.copyWith(blueprintId: blueprint.id);
    await session.db.updateRow<BlueprintReveal>(
      $blueprintReveal,
      columns: [BlueprintReveal.t.blueprintId],
      transaction: transaction,
    );
  }
}
