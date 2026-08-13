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
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i2;
import 'package:payload_server/src/generated/protocol.dart' as _i3;

/// A PAYLOAD player profile (§2.4), one per `serverpod_auth` `AuthUser`.
/// Sign-in method itself (Google/Apple/email/guest) is handled by
/// `serverpod_auth`; this table only carries game-specific state.
abstract class Player
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Player._({
    this.id,
    required this.authUserId,
    this.authUser,
    bool? isGuest,
    required this.handle,
    DateTime? createdAt,
    int? rating,
    int? seasonRating,
    int? credits,
    int? keys,
    int? capacityKb,
    String? settingsJson,
  }) : isGuest = isGuest ?? true,
       createdAt = createdAt ?? DateTime.now(),
       rating = rating ?? 1000,
       seasonRating = seasonRating ?? 1000,
       credits = credits ?? 0,
       keys = keys ?? 0,
       capacityKb = capacityKb ?? 40,
       settingsJson = settingsJson ?? '';

  factory Player({
    _i1.UuidValue? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    bool? isGuest,
    required String handle,
    DateTime? createdAt,
    int? rating,
    int? seasonRating,
    int? credits,
    int? keys,
    int? capacityKb,
    String? settingsJson,
  }) = _PlayerImpl;

  factory Player.fromJson(Map<String, dynamic> jsonSerialization) {
    return Player(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      authUserId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
      isGuest: jsonSerialization['isGuest'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isGuest']),
      handle: jsonSerialization['handle'] as String,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      rating: jsonSerialization['rating'] as int?,
      seasonRating: jsonSerialization['seasonRating'] as int?,
      credits: jsonSerialization['credits'] as int?,
      keys: jsonSerialization['keys'] as int?,
      capacityKb: jsonSerialization['capacityKb'] as int?,
      settingsJson: jsonSerialization['settingsJson'] as String?,
    );
  }

  static final t = PlayerTable();

  static const db = PlayerRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue authUserId;

  /// The underlying serverpod_auth identity. One Player per AuthUser.
  _i2.AuthUser? authUser;

  /// Whether this player is a guest account (§2.5: "guest account
  /// (upgradeable)") — a guest's authUser has no linked login method yet.
  bool isGuest;

  /// Display handle, unique.
  String handle;

  DateTime createdAt;

  /// PvP ladder rating (§1.5, §2.4), Elo-like.
  int rating;

  /// Rating within the current season (§1.5); reset at season rollover.
  int seasonRating;

  /// Soft currency (§1.6).
  int credits;

  /// Premium currency (§1.6), cosmetics only.
  int keys;

  /// Current virus capacity, grows via progression (§1.3: 40KB -> 90KB).
  int capacityKb;

  /// Player settings (accessibility, audio, etc.) as opaque JSON (§1.8).
  String settingsJson;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Player]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Player copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    bool? isGuest,
    String? handle,
    DateTime? createdAt,
    int? rating,
    int? seasonRating,
    int? credits,
    int? keys,
    int? capacityKb,
    String? settingsJson,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Player',
      if (id != null) 'id': id?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'isGuest': isGuest,
      'handle': handle,
      'createdAt': createdAt.toJson(),
      'rating': rating,
      'seasonRating': seasonRating,
      'credits': credits,
      'keys': keys,
      'capacityKb': capacityKb,
      'settingsJson': settingsJson,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Player',
      if (id != null) 'id': id?.toJson(),
      'authUserId': authUserId.toJson(),
      if (authUser != null) 'authUser': authUser?.toJsonForProtocol(),
      'isGuest': isGuest,
      'handle': handle,
      'createdAt': createdAt.toJson(),
      'rating': rating,
      'seasonRating': seasonRating,
      'credits': credits,
      'keys': keys,
      'capacityKb': capacityKb,
      'settingsJson': settingsJson,
    };
  }

  static PlayerInclude include({_i2.AuthUserInclude? authUser}) {
    return PlayerInclude._(authUser: authUser);
  }

  static PlayerIncludeList includeList({
    _i1.WhereExpressionBuilder<PlayerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayerTable>? orderByList,
    PlayerInclude? include,
  }) {
    return PlayerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Player.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Player.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PlayerImpl extends Player {
  _PlayerImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue authUserId,
    _i2.AuthUser? authUser,
    bool? isGuest,
    required String handle,
    DateTime? createdAt,
    int? rating,
    int? seasonRating,
    int? credits,
    int? keys,
    int? capacityKb,
    String? settingsJson,
  }) : super._(
         id: id,
         authUserId: authUserId,
         authUser: authUser,
         isGuest: isGuest,
         handle: handle,
         createdAt: createdAt,
         rating: rating,
         seasonRating: seasonRating,
         credits: credits,
         keys: keys,
         capacityKb: capacityKb,
         settingsJson: settingsJson,
       );

  /// Returns a shallow copy of this [Player]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Player copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? authUserId,
    Object? authUser = _Undefined,
    bool? isGuest,
    String? handle,
    DateTime? createdAt,
    int? rating,
    int? seasonRating,
    int? credits,
    int? keys,
    int? capacityKb,
    String? settingsJson,
  }) {
    return Player(
      id: id is _i1.UuidValue? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      isGuest: isGuest ?? this.isGuest,
      handle: handle ?? this.handle,
      createdAt: createdAt ?? this.createdAt,
      rating: rating ?? this.rating,
      seasonRating: seasonRating ?? this.seasonRating,
      credits: credits ?? this.credits,
      keys: keys ?? this.keys,
      capacityKb: capacityKb ?? this.capacityKb,
      settingsJson: settingsJson ?? this.settingsJson,
    );
  }
}

class PlayerUpdateTable extends _i1.UpdateTable<PlayerTable> {
  PlayerUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<bool, bool> isGuest(bool value) => _i1.ColumnValue(
    table.isGuest,
    value,
  );

  _i1.ColumnValue<String, String> handle(String value) => _i1.ColumnValue(
    table.handle,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<int, int> rating(int value) => _i1.ColumnValue(
    table.rating,
    value,
  );

  _i1.ColumnValue<int, int> seasonRating(int value) => _i1.ColumnValue(
    table.seasonRating,
    value,
  );

  _i1.ColumnValue<int, int> credits(int value) => _i1.ColumnValue(
    table.credits,
    value,
  );

  _i1.ColumnValue<int, int> keys(int value) => _i1.ColumnValue(
    table.keys,
    value,
  );

  _i1.ColumnValue<int, int> capacityKb(int value) => _i1.ColumnValue(
    table.capacityKb,
    value,
  );

  _i1.ColumnValue<String, String> settingsJson(String value) => _i1.ColumnValue(
    table.settingsJson,
    value,
  );
}

class PlayerTable extends _i1.Table<_i1.UuidValue?> {
  PlayerTable({super.tableRelation}) : super(tableName: 'players') {
    updateTable = PlayerUpdateTable(this);
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    isGuest = _i1.ColumnBool(
      'isGuest',
      this,
    );
    handle = _i1.ColumnString(
      'handle',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    rating = _i1.ColumnInt(
      'rating',
      this,
    );
    seasonRating = _i1.ColumnInt(
      'seasonRating',
      this,
    );
    credits = _i1.ColumnInt(
      'credits',
      this,
    );
    keys = _i1.ColumnInt(
      'keys',
      this,
    );
    capacityKb = _i1.ColumnInt(
      'capacityKb',
      this,
    );
    settingsJson = _i1.ColumnString(
      'settingsJson',
      this,
    );
  }

  late final PlayerUpdateTable updateTable;

  late final _i1.ColumnUuid authUserId;

  /// The underlying serverpod_auth identity. One Player per AuthUser.
  _i2.AuthUserTable? _authUser;

  /// Whether this player is a guest account (§2.5: "guest account
  /// (upgradeable)") — a guest's authUser has no linked login method yet.
  late final _i1.ColumnBool isGuest;

  /// Display handle, unique.
  late final _i1.ColumnString handle;

  late final _i1.ColumnDateTime createdAt;

  /// PvP ladder rating (§1.5, §2.4), Elo-like.
  late final _i1.ColumnInt rating;

  /// Rating within the current season (§1.5); reset at season rollover.
  late final _i1.ColumnInt seasonRating;

  /// Soft currency (§1.6).
  late final _i1.ColumnInt credits;

  /// Premium currency (§1.6), cosmetics only.
  late final _i1.ColumnInt keys;

  /// Current virus capacity, grows via progression (§1.3: 40KB -> 90KB).
  late final _i1.ColumnInt capacityKb;

  /// Player settings (accessibility, audio, etc.) as opaque JSON (§1.8).
  late final _i1.ColumnString settingsJson;

  _i2.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _i1.createRelationTable(
      relationFieldName: 'authUser',
      field: Player.t.authUserId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    authUserId,
    isGuest,
    handle,
    createdAt,
    rating,
    seasonRating,
    credits,
    keys,
    capacityKb,
    settingsJson,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class PlayerInclude extends _i1.IncludeObject {
  PlayerInclude._({_i2.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _i2.AuthUserInclude? _authUser;

  @override
  Map<String, _i1.Include?> get includes => {'authUser': _authUser};

  @override
  _i1.Table<_i1.UuidValue?> get table => Player.t;
}

class PlayerIncludeList extends _i1.IncludeList {
  PlayerIncludeList._({
    _i1.WhereExpressionBuilder<PlayerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Player.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Player.t;
}

class PlayerRepository {
  const PlayerRepository._();

  final attachRow = const PlayerAttachRowRepository._();

  /// Returns a list of [Player]s matching the given query parameters.
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
  Future<List<Player>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PlayerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayerTable>? orderByList,
    _i1.Transaction? transaction,
    PlayerInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Player>(
      where: where?.call(Player.t),
      orderBy: orderBy?.call(Player.t),
      orderByList: orderByList?.call(Player.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Player] matching the given query parameters.
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
  Future<Player?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PlayerTable>? where,
    int? offset,
    _i1.OrderByBuilder<PlayerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PlayerTable>? orderByList,
    _i1.Transaction? transaction,
    PlayerInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Player>(
      where: where?.call(Player.t),
      orderBy: orderBy?.call(Player.t),
      orderByList: orderByList?.call(Player.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Player] by its [id] or null if no such row exists.
  Future<Player?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    PlayerInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Player>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Player]s in the list and returns the inserted rows.
  ///
  /// The returned [Player]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Player>> insert(
    _i1.DatabaseSession session,
    List<Player> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Player>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Player] and returns the inserted row.
  ///
  /// The returned [Player] will have its `id` field set.
  Future<Player> insertRow(
    _i1.DatabaseSession session,
    Player row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Player>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Player]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Player>> update(
    _i1.DatabaseSession session,
    List<Player> rows, {
    _i1.ColumnSelections<PlayerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Player>(
      rows,
      columns: columns?.call(Player.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Player]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Player> updateRow(
    _i1.DatabaseSession session,
    Player row, {
    _i1.ColumnSelections<PlayerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Player>(
      row,
      columns: columns?.call(Player.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Player] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Player?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PlayerUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Player>(
      id,
      columnValues: columnValues(Player.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Player]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Player>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PlayerUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PlayerTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PlayerTable>? orderBy,
    _i1.OrderByListBuilder<PlayerTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Player>(
      columnValues: columnValues(Player.t.updateTable),
      where: where(Player.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Player.t),
      orderByList: orderByList?.call(Player.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Player]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Player>> delete(
    _i1.DatabaseSession session,
    List<Player> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Player>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Player].
  Future<Player> deleteRow(
    _i1.DatabaseSession session,
    Player row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Player>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Player>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PlayerTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Player>(
      where: where(Player.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PlayerTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Player>(
      where: where?.call(Player.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Player] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PlayerTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Player>(
      where: where(Player.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PlayerAttachRowRepository {
  const PlayerAttachRowRepository._();

  /// Creates a relation between the given [Player] and [AuthUser]
  /// by setting the [Player]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _i1.DatabaseSession session,
    Player player,
    _i2.AuthUser authUser, {
    _i1.Transaction? transaction,
  }) async {
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $player = player.copyWith(authUserId: authUser.id);
    await session.db.updateRow<Player>(
      $player,
      columns: [Player.t.authUserId],
      transaction: transaction,
    );
  }
}
