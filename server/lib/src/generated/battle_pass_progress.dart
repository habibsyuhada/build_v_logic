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
import 'season.dart' as _i3;
import 'package:payload_server/src/generated/protocol.dart' as _i4;

/// A player's battle pass progress for one [Season] (§1.6). Tier is
/// derived from `xp` (see `BattlePassTierCalculator`), not stored
/// directly, so a tier-curve rebalance never needs a data migration.
abstract class BattlePassProgress
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  BattlePassProgress._({
    this.id,
    required this.playerId,
    this.player,
    required this.seasonId,
    this.season,
    int? xp,
    bool? hasPremium,
  }) : xp = xp ?? 0,
       hasPremium = hasPremium ?? false;

  factory BattlePassProgress({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue seasonId,
    _i3.Season? season,
    int? xp,
    bool? hasPremium,
  }) = _BattlePassProgressImpl;

  factory BattlePassProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return BattlePassProgress(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      seasonId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['seasonId'],
      ),
      season: jsonSerialization['season'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Season>(jsonSerialization['season']),
      xp: jsonSerialization['xp'] as int?,
      hasPremium: jsonSerialization['hasPremium'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['hasPremium']),
    );
  }

  static final t = BattlePassProgressTable();

  static const db = BattlePassProgressRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  _i1.UuidValue seasonId;

  _i3.Season? season;

  int xp;

  /// Whether the premium track was purchased for this season — the free
  /// track's rewards are always available regardless (§1.6: "Tidak ada
  /// blok/kapasitas di track premium").
  bool hasPremium;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [BattlePassProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BattlePassProgress copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    _i1.UuidValue? seasonId,
    _i3.Season? season,
    int? xp,
    bool? hasPremium,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BattlePassProgress',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'seasonId': seasonId.toJson(),
      if (season != null) 'season': season?.toJson(),
      'xp': xp,
      'hasPremium': hasPremium,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BattlePassProgress',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJsonForProtocol(),
      'seasonId': seasonId.toJson(),
      if (season != null) 'season': season?.toJsonForProtocol(),
      'xp': xp,
      'hasPremium': hasPremium,
    };
  }

  static BattlePassProgressInclude include({
    _i2.PlayerInclude? player,
    _i3.SeasonInclude? season,
  }) {
    return BattlePassProgressInclude._(
      player: player,
      season: season,
    );
  }

  static BattlePassProgressIncludeList includeList({
    _i1.WhereExpressionBuilder<BattlePassProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BattlePassProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BattlePassProgressTable>? orderByList,
    BattlePassProgressInclude? include,
  }) {
    return BattlePassProgressIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BattlePassProgress.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BattlePassProgress.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BattlePassProgressImpl extends BattlePassProgress {
  _BattlePassProgressImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue seasonId,
    _i3.Season? season,
    int? xp,
    bool? hasPremium,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         seasonId: seasonId,
         season: season,
         xp: xp,
         hasPremium: hasPremium,
       );

  /// Returns a shallow copy of this [BattlePassProgress]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BattlePassProgress copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    _i1.UuidValue? seasonId,
    Object? season = _Undefined,
    int? xp,
    bool? hasPremium,
  }) {
    return BattlePassProgress(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      seasonId: seasonId ?? this.seasonId,
      season: season is _i3.Season? ? season : this.season?.copyWith(),
      xp: xp ?? this.xp,
      hasPremium: hasPremium ?? this.hasPremium,
    );
  }
}

class BattlePassProgressUpdateTable
    extends _i1.UpdateTable<BattlePassProgressTable> {
  BattlePassProgressUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playerId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.playerId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> seasonId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.seasonId,
        value,
      );

  _i1.ColumnValue<int, int> xp(int value) => _i1.ColumnValue(
    table.xp,
    value,
  );

  _i1.ColumnValue<bool, bool> hasPremium(bool value) => _i1.ColumnValue(
    table.hasPremium,
    value,
  );
}

class BattlePassProgressTable extends _i1.Table<_i1.UuidValue?> {
  BattlePassProgressTable({super.tableRelation})
    : super(tableName: 'battle_pass_progress') {
    updateTable = BattlePassProgressUpdateTable(this);
    playerId = _i1.ColumnUuid(
      'playerId',
      this,
    );
    seasonId = _i1.ColumnUuid(
      'seasonId',
      this,
    );
    xp = _i1.ColumnInt(
      'xp',
      this,
    );
    hasPremium = _i1.ColumnBool(
      'hasPremium',
      this,
    );
  }

  late final BattlePassProgressUpdateTable updateTable;

  late final _i1.ColumnUuid playerId;

  _i2.PlayerTable? _player;

  late final _i1.ColumnUuid seasonId;

  _i3.SeasonTable? _season;

  late final _i1.ColumnInt xp;

  /// Whether the premium track was purchased for this season — the free
  /// track's rewards are always available regardless (§1.6: "Tidak ada
  /// blok/kapasitas di track premium").
  late final _i1.ColumnBool hasPremium;

  _i2.PlayerTable get player {
    if (_player != null) return _player!;
    _player = _i1.createRelationTable(
      relationFieldName: 'player',
      field: BattlePassProgress.t.playerId,
      foreignField: _i2.Player.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PlayerTable(tableRelation: foreignTableRelation),
    );
    return _player!;
  }

  _i3.SeasonTable get season {
    if (_season != null) return _season!;
    _season = _i1.createRelationTable(
      relationFieldName: 'season',
      field: BattlePassProgress.t.seasonId,
      foreignField: _i3.Season.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SeasonTable(tableRelation: foreignTableRelation),
    );
    return _season!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    playerId,
    seasonId,
    xp,
    hasPremium,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'player') {
      return player;
    }
    if (relationField == 'season') {
      return season;
    }
    return null;
  }
}

class BattlePassProgressInclude extends _i1.IncludeObject {
  BattlePassProgressInclude._({
    _i2.PlayerInclude? player,
    _i3.SeasonInclude? season,
  }) {
    _player = player;
    _season = season;
  }

  _i2.PlayerInclude? _player;

  _i3.SeasonInclude? _season;

  @override
  Map<String, _i1.Include?> get includes => {
    'player': _player,
    'season': _season,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => BattlePassProgress.t;
}

class BattlePassProgressIncludeList extends _i1.IncludeList {
  BattlePassProgressIncludeList._({
    _i1.WhereExpressionBuilder<BattlePassProgressTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BattlePassProgress.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => BattlePassProgress.t;
}

class BattlePassProgressRepository {
  const BattlePassProgressRepository._();

  final attachRow = const BattlePassProgressAttachRowRepository._();

  /// Returns a list of [BattlePassProgress]s matching the given query parameters.
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
  Future<List<BattlePassProgress>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BattlePassProgressTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BattlePassProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BattlePassProgressTable>? orderByList,
    _i1.Transaction? transaction,
    BattlePassProgressInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BattlePassProgress>(
      where: where?.call(BattlePassProgress.t),
      orderBy: orderBy?.call(BattlePassProgress.t),
      orderByList: orderByList?.call(BattlePassProgress.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BattlePassProgress] matching the given query parameters.
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
  Future<BattlePassProgress?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BattlePassProgressTable>? where,
    int? offset,
    _i1.OrderByBuilder<BattlePassProgressTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BattlePassProgressTable>? orderByList,
    _i1.Transaction? transaction,
    BattlePassProgressInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BattlePassProgress>(
      where: where?.call(BattlePassProgress.t),
      orderBy: orderBy?.call(BattlePassProgress.t),
      orderByList: orderByList?.call(BattlePassProgress.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BattlePassProgress] by its [id] or null if no such row exists.
  Future<BattlePassProgress?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    BattlePassProgressInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BattlePassProgress>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BattlePassProgress]s in the list and returns the inserted rows.
  ///
  /// The returned [BattlePassProgress]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<BattlePassProgress>> insert(
    _i1.DatabaseSession session,
    List<BattlePassProgress> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<BattlePassProgress>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [BattlePassProgress] and returns the inserted row.
  ///
  /// The returned [BattlePassProgress] will have its `id` field set.
  Future<BattlePassProgress> insertRow(
    _i1.DatabaseSession session,
    BattlePassProgress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BattlePassProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [BattlePassProgress]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<BattlePassProgress>> update(
    _i1.DatabaseSession session,
    List<BattlePassProgress> rows, {
    _i1.ColumnSelections<BattlePassProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BattlePassProgress>(
      rows,
      columns: columns?.call(BattlePassProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BattlePassProgress]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BattlePassProgress> updateRow(
    _i1.DatabaseSession session,
    BattlePassProgress row, {
    _i1.ColumnSelections<BattlePassProgressTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BattlePassProgress>(
      row,
      columns: columns?.call(BattlePassProgress.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BattlePassProgress] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BattlePassProgress?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<BattlePassProgressUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<BattlePassProgress>(
      id,
      columnValues: columnValues(BattlePassProgress.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BattlePassProgress]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<BattlePassProgress>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BattlePassProgressUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<BattlePassProgressTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BattlePassProgressTable>? orderBy,
    _i1.OrderByListBuilder<BattlePassProgressTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<BattlePassProgress>(
      columnValues: columnValues(BattlePassProgress.t.updateTable),
      where: where(BattlePassProgress.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BattlePassProgress.t),
      orderByList: orderByList?.call(BattlePassProgress.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [BattlePassProgress]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<BattlePassProgress>> delete(
    _i1.DatabaseSession session,
    List<BattlePassProgress> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BattlePassProgress>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [BattlePassProgress].
  Future<BattlePassProgress> deleteRow(
    _i1.DatabaseSession session,
    BattlePassProgress row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BattlePassProgress>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<BattlePassProgress>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BattlePassProgressTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BattlePassProgress>(
      where: where(BattlePassProgress.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BattlePassProgressTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BattlePassProgress>(
      where: where?.call(BattlePassProgress.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BattlePassProgress] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BattlePassProgressTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BattlePassProgress>(
      where: where(BattlePassProgress.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BattlePassProgressAttachRowRepository {
  const BattlePassProgressAttachRowRepository._();

  /// Creates a relation between the given [BattlePassProgress] and [Player]
  /// by setting the [BattlePassProgress]'s foreign key `playerId` to refer to the [Player].
  Future<void> player(
    _i1.DatabaseSession session,
    BattlePassProgress battlePassProgress,
    _i2.Player player, {
    _i1.Transaction? transaction,
  }) async {
    if (battlePassProgress.id == null) {
      throw ArgumentError.notNull('battlePassProgress.id');
    }
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }

    var $battlePassProgress = battlePassProgress.copyWith(playerId: player.id);
    await session.db.updateRow<BattlePassProgress>(
      $battlePassProgress,
      columns: [BattlePassProgress.t.playerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [BattlePassProgress] and [Season]
  /// by setting the [BattlePassProgress]'s foreign key `seasonId` to refer to the [Season].
  Future<void> season(
    _i1.DatabaseSession session,
    BattlePassProgress battlePassProgress,
    _i3.Season season, {
    _i1.Transaction? transaction,
  }) async {
    if (battlePassProgress.id == null) {
      throw ArgumentError.notNull('battlePassProgress.id');
    }
    if (season.id == null) {
      throw ArgumentError.notNull('season.id');
    }

    var $battlePassProgress = battlePassProgress.copyWith(seasonId: season.id);
    await session.db.updateRow<BattlePassProgress>(
      $battlePassProgress,
      columns: [BattlePassProgress.t.seasonId],
      transaction: transaction,
    );
  }
}
