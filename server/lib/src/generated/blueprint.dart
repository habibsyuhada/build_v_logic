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
import 'blueprint_moderation_state.dart' as _i2;
import 'player.dart' as _i3;
import 'package:payload_server/src/generated/protocol.dart' as _i4;

/// A published virus design (§1.5.4, §2.4 `blueprints`). Other players
/// see its *results* (replays against their own defense) but must
/// reverse-engineer it (§1.5.4: replay 3x per block to "read" it) before
/// they can copy it — see `BlueprintReveal`.
abstract class Blueprint
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Blueprint._({
    this.id,
    required this.playerId,
    this.player,
    required this.title,
    required this.virusDefJson,
    int? likes,
    int? plays,
    DateTime? publishedAt,
    _i2.BlueprintModerationState? moderationState,
  }) : likes = likes ?? 0,
       plays = plays ?? 0,
       publishedAt = publishedAt ?? DateTime.now(),
       moderationState =
           moderationState ?? _i2.BlueprintModerationState.pending;

  factory Blueprint({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required String title,
    required String virusDefJson,
    int? likes,
    int? plays,
    DateTime? publishedAt,
    _i2.BlueprintModerationState? moderationState,
  }) = _BlueprintImpl;

  factory Blueprint.fromJson(Map<String, dynamic> jsonSerialization) {
    return Blueprint(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Player>(jsonSerialization['player']),
      title: jsonSerialization['title'] as String,
      virusDefJson: jsonSerialization['virusDefJson'] as String,
      likes: jsonSerialization['likes'] as int?,
      plays: jsonSerialization['plays'] as int?,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['publishedAt'],
            ),
      moderationState: jsonSerialization['moderationState'] == null
          ? null
          : _i2.BlueprintModerationState.fromJson(
              (jsonSerialization['moderationState'] as String),
            ),
    );
  }

  static final t = BlueprintTable();

  static const db = BlueprintRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i3.Player? player;

  String title;

  /// The virus program, as JSON (content_schema.VirusDef). Other players
  /// never see this directly until fully reverse-engineered.
  String virusDefJson;

  int likes;

  int plays;

  DateTime publishedAt;

  _i2.BlueprintModerationState moderationState;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Blueprint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Blueprint copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i3.Player? player,
    String? title,
    String? virusDefJson,
    int? likes,
    int? plays,
    DateTime? publishedAt,
    _i2.BlueprintModerationState? moderationState,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Blueprint',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'title': title,
      'virusDefJson': virusDefJson,
      'likes': likes,
      'plays': plays,
      'publishedAt': publishedAt.toJson(),
      'moderationState': moderationState.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Blueprint',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJsonForProtocol(),
      'title': title,
      'virusDefJson': virusDefJson,
      'likes': likes,
      'plays': plays,
      'publishedAt': publishedAt.toJson(),
      'moderationState': moderationState.toJson(),
    };
  }

  static BlueprintInclude include({_i3.PlayerInclude? player}) {
    return BlueprintInclude._(player: player);
  }

  static BlueprintIncludeList includeList({
    _i1.WhereExpressionBuilder<BlueprintTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BlueprintTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BlueprintTable>? orderByList,
    BlueprintInclude? include,
  }) {
    return BlueprintIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Blueprint.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Blueprint.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BlueprintImpl extends Blueprint {
  _BlueprintImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required String title,
    required String virusDefJson,
    int? likes,
    int? plays,
    DateTime? publishedAt,
    _i2.BlueprintModerationState? moderationState,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         title: title,
         virusDefJson: virusDefJson,
         likes: likes,
         plays: plays,
         publishedAt: publishedAt,
         moderationState: moderationState,
       );

  /// Returns a shallow copy of this [Blueprint]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Blueprint copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    String? title,
    String? virusDefJson,
    int? likes,
    int? plays,
    DateTime? publishedAt,
    _i2.BlueprintModerationState? moderationState,
  }) {
    return Blueprint(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i3.Player? ? player : this.player?.copyWith(),
      title: title ?? this.title,
      virusDefJson: virusDefJson ?? this.virusDefJson,
      likes: likes ?? this.likes,
      plays: plays ?? this.plays,
      publishedAt: publishedAt ?? this.publishedAt,
      moderationState: moderationState ?? this.moderationState,
    );
  }
}

class BlueprintUpdateTable extends _i1.UpdateTable<BlueprintTable> {
  BlueprintUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playerId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.playerId,
        value,
      );

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> virusDefJson(String value) => _i1.ColumnValue(
    table.virusDefJson,
    value,
  );

  _i1.ColumnValue<int, int> likes(int value) => _i1.ColumnValue(
    table.likes,
    value,
  );

  _i1.ColumnValue<int, int> plays(int value) => _i1.ColumnValue(
    table.plays,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> publishedAt(DateTime value) =>
      _i1.ColumnValue(
        table.publishedAt,
        value,
      );

  _i1.ColumnValue<_i2.BlueprintModerationState, _i2.BlueprintModerationState>
  moderationState(_i2.BlueprintModerationState value) => _i1.ColumnValue(
    table.moderationState,
    value,
  );
}

class BlueprintTable extends _i1.Table<_i1.UuidValue?> {
  BlueprintTable({super.tableRelation}) : super(tableName: 'blueprints') {
    updateTable = BlueprintUpdateTable(this);
    playerId = _i1.ColumnUuid(
      'playerId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    virusDefJson = _i1.ColumnString(
      'virusDefJson',
      this,
    );
    likes = _i1.ColumnInt(
      'likes',
      this,
    );
    plays = _i1.ColumnInt(
      'plays',
      this,
    );
    publishedAt = _i1.ColumnDateTime(
      'publishedAt',
      this,
    );
    moderationState = _i1.ColumnEnum(
      'moderationState',
      this,
      _i1.EnumSerialization.byName,
    );
  }

  late final BlueprintUpdateTable updateTable;

  late final _i1.ColumnUuid playerId;

  _i3.PlayerTable? _player;

  late final _i1.ColumnString title;

  /// The virus program, as JSON (content_schema.VirusDef). Other players
  /// never see this directly until fully reverse-engineered.
  late final _i1.ColumnString virusDefJson;

  late final _i1.ColumnInt likes;

  late final _i1.ColumnInt plays;

  late final _i1.ColumnDateTime publishedAt;

  late final _i1.ColumnEnum<_i2.BlueprintModerationState> moderationState;

  _i3.PlayerTable get player {
    if (_player != null) return _player!;
    _player = _i1.createRelationTable(
      relationFieldName: 'player',
      field: Blueprint.t.playerId,
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
    playerId,
    title,
    virusDefJson,
    likes,
    plays,
    publishedAt,
    moderationState,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'player') {
      return player;
    }
    return null;
  }
}

class BlueprintInclude extends _i1.IncludeObject {
  BlueprintInclude._({_i3.PlayerInclude? player}) {
    _player = player;
  }

  _i3.PlayerInclude? _player;

  @override
  Map<String, _i1.Include?> get includes => {'player': _player};

  @override
  _i1.Table<_i1.UuidValue?> get table => Blueprint.t;
}

class BlueprintIncludeList extends _i1.IncludeList {
  BlueprintIncludeList._({
    _i1.WhereExpressionBuilder<BlueprintTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Blueprint.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Blueprint.t;
}

class BlueprintRepository {
  const BlueprintRepository._();

  final attachRow = const BlueprintAttachRowRepository._();

  /// Returns a list of [Blueprint]s matching the given query parameters.
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
  Future<List<Blueprint>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BlueprintTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BlueprintTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BlueprintTable>? orderByList,
    _i1.Transaction? transaction,
    BlueprintInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Blueprint>(
      where: where?.call(Blueprint.t),
      orderBy: orderBy?.call(Blueprint.t),
      orderByList: orderByList?.call(Blueprint.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Blueprint] matching the given query parameters.
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
  Future<Blueprint?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BlueprintTable>? where,
    int? offset,
    _i1.OrderByBuilder<BlueprintTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BlueprintTable>? orderByList,
    _i1.Transaction? transaction,
    BlueprintInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Blueprint>(
      where: where?.call(Blueprint.t),
      orderBy: orderBy?.call(Blueprint.t),
      orderByList: orderByList?.call(Blueprint.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Blueprint] by its [id] or null if no such row exists.
  Future<Blueprint?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    BlueprintInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Blueprint>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Blueprint]s in the list and returns the inserted rows.
  ///
  /// The returned [Blueprint]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Blueprint>> insert(
    _i1.DatabaseSession session,
    List<Blueprint> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Blueprint>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Blueprint] and returns the inserted row.
  ///
  /// The returned [Blueprint] will have its `id` field set.
  Future<Blueprint> insertRow(
    _i1.DatabaseSession session,
    Blueprint row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Blueprint>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Blueprint]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Blueprint>> update(
    _i1.DatabaseSession session,
    List<Blueprint> rows, {
    _i1.ColumnSelections<BlueprintTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Blueprint>(
      rows,
      columns: columns?.call(Blueprint.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Blueprint]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Blueprint> updateRow(
    _i1.DatabaseSession session,
    Blueprint row, {
    _i1.ColumnSelections<BlueprintTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Blueprint>(
      row,
      columns: columns?.call(Blueprint.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Blueprint] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Blueprint?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<BlueprintUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Blueprint>(
      id,
      columnValues: columnValues(Blueprint.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Blueprint]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Blueprint>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BlueprintUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BlueprintTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BlueprintTable>? orderBy,
    _i1.OrderByListBuilder<BlueprintTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Blueprint>(
      columnValues: columnValues(Blueprint.t.updateTable),
      where: where(Blueprint.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Blueprint.t),
      orderByList: orderByList?.call(Blueprint.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Blueprint]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Blueprint>> delete(
    _i1.DatabaseSession session,
    List<Blueprint> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Blueprint>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Blueprint].
  Future<Blueprint> deleteRow(
    _i1.DatabaseSession session,
    Blueprint row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Blueprint>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Blueprint>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BlueprintTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Blueprint>(
      where: where(Blueprint.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BlueprintTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Blueprint>(
      where: where?.call(Blueprint.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Blueprint] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BlueprintTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Blueprint>(
      where: where(Blueprint.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BlueprintAttachRowRepository {
  const BlueprintAttachRowRepository._();

  /// Creates a relation between the given [Blueprint] and [Player]
  /// by setting the [Blueprint]'s foreign key `playerId` to refer to the [Player].
  Future<void> player(
    _i1.DatabaseSession session,
    Blueprint blueprint,
    _i3.Player player, {
    _i1.Transaction? transaction,
  }) async {
    if (blueprint.id == null) {
      throw ArgumentError.notNull('blueprint.id');
    }
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }

    var $blueprint = blueprint.copyWith(playerId: player.id);
    await session.db.updateRow<Blueprint>(
      $blueprint,
      columns: [Blueprint.t.playerId],
      transaction: transaction,
    );
  }
}
