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
import 'season.dart' as _i2;
import 'player.dart' as _i3;
import 'package:payload_server/src/generated/protocol.dart' as _i4;

/// A player's final standing in a completed [Season] (§2.4
/// `season_results`), snapshotted at rollover before `seasonRating`
/// resets.
abstract class SeasonResult
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  SeasonResult._({
    this.id,
    required this.seasonId,
    this.season,
    required this.playerId,
    this.player,
    required this.finalRating,
    required this.rank,
  });

  factory SeasonResult({
    _i1.UuidValue? id,
    required _i1.UuidValue seasonId,
    _i2.Season? season,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required int finalRating,
    required int rank,
  }) = _SeasonResultImpl;

  factory SeasonResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return SeasonResult(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      seasonId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['seasonId'],
      ),
      season: jsonSerialization['season'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Season>(jsonSerialization['season']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Player>(jsonSerialization['player']),
      finalRating: jsonSerialization['finalRating'] as int,
      rank: jsonSerialization['rank'] as int,
    );
  }

  static final t = SeasonResultTable();

  static const db = SeasonResultRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue seasonId;

  _i2.Season? season;

  _i1.UuidValue playerId;

  _i3.Player? player;

  int finalRating;

  int rank;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [SeasonResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SeasonResult copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? seasonId,
    _i2.Season? season,
    _i1.UuidValue? playerId,
    _i3.Player? player,
    int? finalRating,
    int? rank,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SeasonResult',
      if (id != null) 'id': id?.toJson(),
      'seasonId': seasonId.toJson(),
      if (season != null) 'season': season?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'finalRating': finalRating,
      'rank': rank,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SeasonResult',
      if (id != null) 'id': id?.toJson(),
      'seasonId': seasonId.toJson(),
      if (season != null) 'season': season?.toJsonForProtocol(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJsonForProtocol(),
      'finalRating': finalRating,
      'rank': rank,
    };
  }

  static SeasonResultInclude include({
    _i2.SeasonInclude? season,
    _i3.PlayerInclude? player,
  }) {
    return SeasonResultInclude._(
      season: season,
      player: player,
    );
  }

  static SeasonResultIncludeList includeList({
    _i1.WhereExpressionBuilder<SeasonResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SeasonResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SeasonResultTable>? orderByList,
    SeasonResultInclude? include,
  }) {
    return SeasonResultIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SeasonResult.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SeasonResult.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SeasonResultImpl extends SeasonResult {
  _SeasonResultImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue seasonId,
    _i2.Season? season,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required int finalRating,
    required int rank,
  }) : super._(
         id: id,
         seasonId: seasonId,
         season: season,
         playerId: playerId,
         player: player,
         finalRating: finalRating,
         rank: rank,
       );

  /// Returns a shallow copy of this [SeasonResult]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SeasonResult copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? seasonId,
    Object? season = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    int? finalRating,
    int? rank,
  }) {
    return SeasonResult(
      id: id is _i1.UuidValue? ? id : this.id,
      seasonId: seasonId ?? this.seasonId,
      season: season is _i2.Season? ? season : this.season?.copyWith(),
      playerId: playerId ?? this.playerId,
      player: player is _i3.Player? ? player : this.player?.copyWith(),
      finalRating: finalRating ?? this.finalRating,
      rank: rank ?? this.rank,
    );
  }
}

class SeasonResultUpdateTable extends _i1.UpdateTable<SeasonResultTable> {
  SeasonResultUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> seasonId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.seasonId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playerId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.playerId,
        value,
      );

  _i1.ColumnValue<int, int> finalRating(int value) => _i1.ColumnValue(
    table.finalRating,
    value,
  );

  _i1.ColumnValue<int, int> rank(int value) => _i1.ColumnValue(
    table.rank,
    value,
  );
}

class SeasonResultTable extends _i1.Table<_i1.UuidValue?> {
  SeasonResultTable({super.tableRelation})
    : super(tableName: 'season_results') {
    updateTable = SeasonResultUpdateTable(this);
    seasonId = _i1.ColumnUuid(
      'seasonId',
      this,
    );
    playerId = _i1.ColumnUuid(
      'playerId',
      this,
    );
    finalRating = _i1.ColumnInt(
      'finalRating',
      this,
    );
    rank = _i1.ColumnInt(
      'rank',
      this,
    );
  }

  late final SeasonResultUpdateTable updateTable;

  late final _i1.ColumnUuid seasonId;

  _i2.SeasonTable? _season;

  late final _i1.ColumnUuid playerId;

  _i3.PlayerTable? _player;

  late final _i1.ColumnInt finalRating;

  late final _i1.ColumnInt rank;

  _i2.SeasonTable get season {
    if (_season != null) return _season!;
    _season = _i1.createRelationTable(
      relationFieldName: 'season',
      field: SeasonResult.t.seasonId,
      foreignField: _i2.Season.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.SeasonTable(tableRelation: foreignTableRelation),
    );
    return _season!;
  }

  _i3.PlayerTable get player {
    if (_player != null) return _player!;
    _player = _i1.createRelationTable(
      relationFieldName: 'player',
      field: SeasonResult.t.playerId,
      foreignField: _i3.Player.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.PlayerTable(tableRelation: foreignTableRelation),
    );
    return _player!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    seasonId,
    playerId,
    finalRating,
    rank,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'season') {
      return season;
    }
    if (relationField == 'player') {
      return player;
    }
    return null;
  }
}

class SeasonResultInclude extends _i1.IncludeObject {
  SeasonResultInclude._({
    _i2.SeasonInclude? season,
    _i3.PlayerInclude? player,
  }) {
    _season = season;
    _player = player;
  }

  _i2.SeasonInclude? _season;

  _i3.PlayerInclude? _player;

  @override
  Map<String, _i1.Include?> get includes => {
    'season': _season,
    'player': _player,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => SeasonResult.t;
}

class SeasonResultIncludeList extends _i1.IncludeList {
  SeasonResultIncludeList._({
    _i1.WhereExpressionBuilder<SeasonResultTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SeasonResult.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => SeasonResult.t;
}

class SeasonResultRepository {
  const SeasonResultRepository._();

  final attachRow = const SeasonResultAttachRowRepository._();

  /// Returns a list of [SeasonResult]s matching the given query parameters.
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
  Future<List<SeasonResult>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SeasonResultTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SeasonResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SeasonResultTable>? orderByList,
    _i1.Transaction? transaction,
    SeasonResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SeasonResult>(
      where: where?.call(SeasonResult.t),
      orderBy: orderBy?.call(SeasonResult.t),
      orderByList: orderByList?.call(SeasonResult.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SeasonResult] matching the given query parameters.
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
  Future<SeasonResult?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SeasonResultTable>? where,
    int? offset,
    _i1.OrderByBuilder<SeasonResultTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SeasonResultTable>? orderByList,
    _i1.Transaction? transaction,
    SeasonResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SeasonResult>(
      where: where?.call(SeasonResult.t),
      orderBy: orderBy?.call(SeasonResult.t),
      orderByList: orderByList?.call(SeasonResult.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SeasonResult] by its [id] or null if no such row exists.
  Future<SeasonResult?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    SeasonResultInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SeasonResult>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SeasonResult]s in the list and returns the inserted rows.
  ///
  /// The returned [SeasonResult]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SeasonResult>> insert(
    _i1.DatabaseSession session,
    List<SeasonResult> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SeasonResult>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SeasonResult] and returns the inserted row.
  ///
  /// The returned [SeasonResult] will have its `id` field set.
  Future<SeasonResult> insertRow(
    _i1.DatabaseSession session,
    SeasonResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SeasonResult>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SeasonResult]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SeasonResult>> update(
    _i1.DatabaseSession session,
    List<SeasonResult> rows, {
    _i1.ColumnSelections<SeasonResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SeasonResult>(
      rows,
      columns: columns?.call(SeasonResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SeasonResult]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SeasonResult> updateRow(
    _i1.DatabaseSession session,
    SeasonResult row, {
    _i1.ColumnSelections<SeasonResultTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SeasonResult>(
      row,
      columns: columns?.call(SeasonResult.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SeasonResult] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SeasonResult?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<SeasonResultUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SeasonResult>(
      id,
      columnValues: columnValues(SeasonResult.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SeasonResult]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SeasonResult>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SeasonResultUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SeasonResultTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SeasonResultTable>? orderBy,
    _i1.OrderByListBuilder<SeasonResultTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SeasonResult>(
      columnValues: columnValues(SeasonResult.t.updateTable),
      where: where(SeasonResult.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SeasonResult.t),
      orderByList: orderByList?.call(SeasonResult.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SeasonResult]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SeasonResult>> delete(
    _i1.DatabaseSession session,
    List<SeasonResult> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SeasonResult>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SeasonResult].
  Future<SeasonResult> deleteRow(
    _i1.DatabaseSession session,
    SeasonResult row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SeasonResult>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SeasonResult>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SeasonResultTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SeasonResult>(
      where: where(SeasonResult.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SeasonResultTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SeasonResult>(
      where: where?.call(SeasonResult.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SeasonResult] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SeasonResultTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SeasonResult>(
      where: where(SeasonResult.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SeasonResultAttachRowRepository {
  const SeasonResultAttachRowRepository._();

  /// Creates a relation between the given [SeasonResult] and [Season]
  /// by setting the [SeasonResult]'s foreign key `seasonId` to refer to the [Season].
  Future<void> season(
    _i1.DatabaseSession session,
    SeasonResult seasonResult,
    _i2.Season season, {
    _i1.Transaction? transaction,
  }) async {
    if (seasonResult.id == null) {
      throw ArgumentError.notNull('seasonResult.id');
    }
    if (season.id == null) {
      throw ArgumentError.notNull('season.id');
    }

    var $seasonResult = seasonResult.copyWith(seasonId: season.id);
    await session.db.updateRow<SeasonResult>(
      $seasonResult,
      columns: [SeasonResult.t.seasonId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [SeasonResult] and [Player]
  /// by setting the [SeasonResult]'s foreign key `playerId` to refer to the [Player].
  Future<void> player(
    _i1.DatabaseSession session,
    SeasonResult seasonResult,
    _i3.Player player, {
    _i1.Transaction? transaction,
  }) async {
    if (seasonResult.id == null) {
      throw ArgumentError.notNull('seasonResult.id');
    }
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }

    var $seasonResult = seasonResult.copyWith(playerId: player.id);
    await session.db.updateRow<SeasonResult>(
      $seasonResult,
      columns: [SeasonResult.t.playerId],
      transaction: transaction,
    );
  }
}
