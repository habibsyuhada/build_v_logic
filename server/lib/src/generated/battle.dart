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
import 'battle_outcome.dart' as _i3;
import 'package:payload_server/src/generated/protocol.dart' as _i4;

/// One resolved PvP battle (§2.3, §2.4 `battles`). Created by the battle
/// worker after `sim_core.resolveBattle` runs; never written to by the
/// client directly — the client only submits an `AttackRequest` and later
/// fetches this row (see `BattleEndpoint`).
abstract class Battle
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Battle._({
    this.id,
    required this.attackerId,
    this.attacker,
    required this.defenderId,
    this.defender,
    required this.defenseVersion,
    bool? isGhostMatch,
    required this.virusDefJson,
    required this.seed,
    required this.simVersion,
    this.logJson,
    this.logRef,
    required this.score,
    required this.outcome,
    required this.ratingDelta,
    DateTime? createdAt,
  }) : isGhostMatch = isGhostMatch ?? false,
       createdAt = createdAt ?? DateTime.now();

  factory Battle({
    _i1.UuidValue? id,
    required _i1.UuidValue attackerId,
    _i2.Player? attacker,
    required _i1.UuidValue defenderId,
    _i2.Player? defender,
    required int defenseVersion,
    bool? isGhostMatch,
    required String virusDefJson,
    required int seed,
    required int simVersion,
    String? logJson,
    String? logRef,
    required int score,
    required _i3.BattleOutcome outcome,
    required int ratingDelta,
    DateTime? createdAt,
  }) = _BattleImpl;

  factory Battle.fromJson(Map<String, dynamic> jsonSerialization) {
    return Battle(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      attackerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['attackerId'],
      ),
      attacker: jsonSerialization['attacker'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Player>(
              jsonSerialization['attacker'],
            ),
      defenderId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['defenderId'],
      ),
      defender: jsonSerialization['defender'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Player>(
              jsonSerialization['defender'],
            ),
      defenseVersion: jsonSerialization['defenseVersion'] as int,
      isGhostMatch: jsonSerialization['isGhostMatch'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isGhostMatch']),
      virusDefJson: jsonSerialization['virusDefJson'] as String,
      seed: jsonSerialization['seed'] as int,
      simVersion: jsonSerialization['simVersion'] as int,
      logJson: jsonSerialization['logJson'] as String?,
      logRef: jsonSerialization['logRef'] as String?,
      score: jsonSerialization['score'] as int,
      outcome: _i3.BattleOutcome.fromJson(
        (jsonSerialization['outcome'] as String),
      ),
      ratingDelta: jsonSerialization['ratingDelta'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = BattleTable();

  static const db = BattleRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue attackerId;

  _i2.Player? attacker;

  _i1.UuidValue defenderId;

  _i2.Player? defender;

  /// The exact defense version attacked (§2.3: never a mid-edit defense).
  int defenseVersion;

  /// True if the defender was matched via the ghost network (§1.5.3)
  /// rather than a live opponent — still a real snapshot, just presented
  /// anonymized to the attacker.
  bool isGhostMatch;

  /// The submitted virus program, as JSON (content_schema.VirusDef).
  String virusDefJson;

  /// sim_core seed used to resolve this battle (§2.3, §3.1) — the battle
  /// is fully reproducible from (virusDefJson, defense snapshot, seed).
  int seed;

  /// sim_core / content package version this battle was resolved with
  /// (§2.7 versioning). Replays must be read with a compatible version.
  int simVersion;

  /// Inline battle log JSON (BattleLog.toJson()) when small enough.
  /// Mutually exclusive with [logRef] — exactly one is set.
  String? logJson;

  /// Object-storage key for the battle log when it's too large to store
  /// inline (§2.4: ">32 KB"). Mutually exclusive with [logJson].
  String? logRef;

  int score;

  _i3.BattleOutcome outcome;

  /// Elo-like rating delta applied to the attacker (defender gets the
  /// negation). Positive = attacker gained rating.
  int ratingDelta;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Battle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Battle copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? attackerId,
    _i2.Player? attacker,
    _i1.UuidValue? defenderId,
    _i2.Player? defender,
    int? defenseVersion,
    bool? isGhostMatch,
    String? virusDefJson,
    int? seed,
    int? simVersion,
    String? logJson,
    String? logRef,
    int? score,
    _i3.BattleOutcome? outcome,
    int? ratingDelta,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Battle',
      if (id != null) 'id': id?.toJson(),
      'attackerId': attackerId.toJson(),
      if (attacker != null) 'attacker': attacker?.toJson(),
      'defenderId': defenderId.toJson(),
      if (defender != null) 'defender': defender?.toJson(),
      'defenseVersion': defenseVersion,
      'isGhostMatch': isGhostMatch,
      'virusDefJson': virusDefJson,
      'seed': seed,
      'simVersion': simVersion,
      if (logJson != null) 'logJson': logJson,
      if (logRef != null) 'logRef': logRef,
      'score': score,
      'outcome': outcome.toJson(),
      'ratingDelta': ratingDelta,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Battle',
      if (id != null) 'id': id?.toJson(),
      'attackerId': attackerId.toJson(),
      if (attacker != null) 'attacker': attacker?.toJsonForProtocol(),
      'defenderId': defenderId.toJson(),
      if (defender != null) 'defender': defender?.toJsonForProtocol(),
      'defenseVersion': defenseVersion,
      'isGhostMatch': isGhostMatch,
      'virusDefJson': virusDefJson,
      'seed': seed,
      'simVersion': simVersion,
      if (logJson != null) 'logJson': logJson,
      if (logRef != null) 'logRef': logRef,
      'score': score,
      'outcome': outcome.toJson(),
      'ratingDelta': ratingDelta,
      'createdAt': createdAt.toJson(),
    };
  }

  static BattleInclude include({
    _i2.PlayerInclude? attacker,
    _i2.PlayerInclude? defender,
  }) {
    return BattleInclude._(
      attacker: attacker,
      defender: defender,
    );
  }

  static BattleIncludeList includeList({
    _i1.WhereExpressionBuilder<BattleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BattleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BattleTable>? orderByList,
    BattleInclude? include,
  }) {
    return BattleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Battle.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Battle.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BattleImpl extends Battle {
  _BattleImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue attackerId,
    _i2.Player? attacker,
    required _i1.UuidValue defenderId,
    _i2.Player? defender,
    required int defenseVersion,
    bool? isGhostMatch,
    required String virusDefJson,
    required int seed,
    required int simVersion,
    String? logJson,
    String? logRef,
    required int score,
    required _i3.BattleOutcome outcome,
    required int ratingDelta,
    DateTime? createdAt,
  }) : super._(
         id: id,
         attackerId: attackerId,
         attacker: attacker,
         defenderId: defenderId,
         defender: defender,
         defenseVersion: defenseVersion,
         isGhostMatch: isGhostMatch,
         virusDefJson: virusDefJson,
         seed: seed,
         simVersion: simVersion,
         logJson: logJson,
         logRef: logRef,
         score: score,
         outcome: outcome,
         ratingDelta: ratingDelta,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Battle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Battle copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? attackerId,
    Object? attacker = _Undefined,
    _i1.UuidValue? defenderId,
    Object? defender = _Undefined,
    int? defenseVersion,
    bool? isGhostMatch,
    String? virusDefJson,
    int? seed,
    int? simVersion,
    Object? logJson = _Undefined,
    Object? logRef = _Undefined,
    int? score,
    _i3.BattleOutcome? outcome,
    int? ratingDelta,
    DateTime? createdAt,
  }) {
    return Battle(
      id: id is _i1.UuidValue? ? id : this.id,
      attackerId: attackerId ?? this.attackerId,
      attacker: attacker is _i2.Player? ? attacker : this.attacker?.copyWith(),
      defenderId: defenderId ?? this.defenderId,
      defender: defender is _i2.Player? ? defender : this.defender?.copyWith(),
      defenseVersion: defenseVersion ?? this.defenseVersion,
      isGhostMatch: isGhostMatch ?? this.isGhostMatch,
      virusDefJson: virusDefJson ?? this.virusDefJson,
      seed: seed ?? this.seed,
      simVersion: simVersion ?? this.simVersion,
      logJson: logJson is String? ? logJson : this.logJson,
      logRef: logRef is String? ? logRef : this.logRef,
      score: score ?? this.score,
      outcome: outcome ?? this.outcome,
      ratingDelta: ratingDelta ?? this.ratingDelta,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class BattleUpdateTable extends _i1.UpdateTable<BattleTable> {
  BattleUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> attackerId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.attackerId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> defenderId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.defenderId,
    value,
  );

  _i1.ColumnValue<int, int> defenseVersion(int value) => _i1.ColumnValue(
    table.defenseVersion,
    value,
  );

  _i1.ColumnValue<bool, bool> isGhostMatch(bool value) => _i1.ColumnValue(
    table.isGhostMatch,
    value,
  );

  _i1.ColumnValue<String, String> virusDefJson(String value) => _i1.ColumnValue(
    table.virusDefJson,
    value,
  );

  _i1.ColumnValue<int, int> seed(int value) => _i1.ColumnValue(
    table.seed,
    value,
  );

  _i1.ColumnValue<int, int> simVersion(int value) => _i1.ColumnValue(
    table.simVersion,
    value,
  );

  _i1.ColumnValue<String, String> logJson(String? value) => _i1.ColumnValue(
    table.logJson,
    value,
  );

  _i1.ColumnValue<String, String> logRef(String? value) => _i1.ColumnValue(
    table.logRef,
    value,
  );

  _i1.ColumnValue<int, int> score(int value) => _i1.ColumnValue(
    table.score,
    value,
  );

  _i1.ColumnValue<_i3.BattleOutcome, _i3.BattleOutcome> outcome(
    _i3.BattleOutcome value,
  ) => _i1.ColumnValue(
    table.outcome,
    value,
  );

  _i1.ColumnValue<int, int> ratingDelta(int value) => _i1.ColumnValue(
    table.ratingDelta,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class BattleTable extends _i1.Table<_i1.UuidValue?> {
  BattleTable({super.tableRelation}) : super(tableName: 'battles') {
    updateTable = BattleUpdateTable(this);
    attackerId = _i1.ColumnUuid(
      'attackerId',
      this,
    );
    defenderId = _i1.ColumnUuid(
      'defenderId',
      this,
    );
    defenseVersion = _i1.ColumnInt(
      'defenseVersion',
      this,
    );
    isGhostMatch = _i1.ColumnBool(
      'isGhostMatch',
      this,
    );
    virusDefJson = _i1.ColumnString(
      'virusDefJson',
      this,
    );
    seed = _i1.ColumnInt(
      'seed',
      this,
    );
    simVersion = _i1.ColumnInt(
      'simVersion',
      this,
    );
    logJson = _i1.ColumnString(
      'logJson',
      this,
    );
    logRef = _i1.ColumnString(
      'logRef',
      this,
    );
    score = _i1.ColumnInt(
      'score',
      this,
    );
    outcome = _i1.ColumnEnum(
      'outcome',
      this,
      _i1.EnumSerialization.byName,
    );
    ratingDelta = _i1.ColumnInt(
      'ratingDelta',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final BattleUpdateTable updateTable;

  late final _i1.ColumnUuid attackerId;

  _i2.PlayerTable? _attacker;

  late final _i1.ColumnUuid defenderId;

  _i2.PlayerTable? _defender;

  /// The exact defense version attacked (§2.3: never a mid-edit defense).
  late final _i1.ColumnInt defenseVersion;

  /// True if the defender was matched via the ghost network (§1.5.3)
  /// rather than a live opponent — still a real snapshot, just presented
  /// anonymized to the attacker.
  late final _i1.ColumnBool isGhostMatch;

  /// The submitted virus program, as JSON (content_schema.VirusDef).
  late final _i1.ColumnString virusDefJson;

  /// sim_core seed used to resolve this battle (§2.3, §3.1) — the battle
  /// is fully reproducible from (virusDefJson, defense snapshot, seed).
  late final _i1.ColumnInt seed;

  /// sim_core / content package version this battle was resolved with
  /// (§2.7 versioning). Replays must be read with a compatible version.
  late final _i1.ColumnInt simVersion;

  /// Inline battle log JSON (BattleLog.toJson()) when small enough.
  /// Mutually exclusive with [logRef] — exactly one is set.
  late final _i1.ColumnString logJson;

  /// Object-storage key for the battle log when it's too large to store
  /// inline (§2.4: ">32 KB"). Mutually exclusive with [logJson].
  late final _i1.ColumnString logRef;

  late final _i1.ColumnInt score;

  late final _i1.ColumnEnum<_i3.BattleOutcome> outcome;

  /// Elo-like rating delta applied to the attacker (defender gets the
  /// negation). Positive = attacker gained rating.
  late final _i1.ColumnInt ratingDelta;

  late final _i1.ColumnDateTime createdAt;

  _i2.PlayerTable get attacker {
    if (_attacker != null) return _attacker!;
    _attacker = _i1.createRelationTable(
      relationFieldName: 'attacker',
      field: Battle.t.attackerId,
      foreignField: _i2.Player.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PlayerTable(tableRelation: foreignTableRelation),
    );
    return _attacker!;
  }

  _i2.PlayerTable get defender {
    if (_defender != null) return _defender!;
    _defender = _i1.createRelationTable(
      relationFieldName: 'defender',
      field: Battle.t.defenderId,
      foreignField: _i2.Player.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PlayerTable(tableRelation: foreignTableRelation),
    );
    return _defender!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    attackerId,
    defenderId,
    defenseVersion,
    isGhostMatch,
    virusDefJson,
    seed,
    simVersion,
    logJson,
    logRef,
    score,
    outcome,
    ratingDelta,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'attacker') {
      return attacker;
    }
    if (relationField == 'defender') {
      return defender;
    }
    return null;
  }
}

class BattleInclude extends _i1.IncludeObject {
  BattleInclude._({
    _i2.PlayerInclude? attacker,
    _i2.PlayerInclude? defender,
  }) {
    _attacker = attacker;
    _defender = defender;
  }

  _i2.PlayerInclude? _attacker;

  _i2.PlayerInclude? _defender;

  @override
  Map<String, _i1.Include?> get includes => {
    'attacker': _attacker,
    'defender': _defender,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => Battle.t;
}

class BattleIncludeList extends _i1.IncludeList {
  BattleIncludeList._({
    _i1.WhereExpressionBuilder<BattleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Battle.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Battle.t;
}

class BattleRepository {
  const BattleRepository._();

  final attachRow = const BattleAttachRowRepository._();

  /// Returns a list of [Battle]s matching the given query parameters.
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
  Future<List<Battle>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BattleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BattleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BattleTable>? orderByList,
    _i1.Transaction? transaction,
    BattleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Battle>(
      where: where?.call(Battle.t),
      orderBy: orderBy?.call(Battle.t),
      orderByList: orderByList?.call(Battle.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Battle] matching the given query parameters.
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
  Future<Battle?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BattleTable>? where,
    int? offset,
    _i1.OrderByBuilder<BattleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BattleTable>? orderByList,
    _i1.Transaction? transaction,
    BattleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Battle>(
      where: where?.call(Battle.t),
      orderBy: orderBy?.call(Battle.t),
      orderByList: orderByList?.call(Battle.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Battle] by its [id] or null if no such row exists.
  Future<Battle?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    BattleInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Battle>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Battle]s in the list and returns the inserted rows.
  ///
  /// The returned [Battle]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Battle>> insert(
    _i1.DatabaseSession session,
    List<Battle> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Battle>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Battle] and returns the inserted row.
  ///
  /// The returned [Battle] will have its `id` field set.
  Future<Battle> insertRow(
    _i1.DatabaseSession session,
    Battle row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Battle>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Battle]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Battle>> update(
    _i1.DatabaseSession session,
    List<Battle> rows, {
    _i1.ColumnSelections<BattleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Battle>(
      rows,
      columns: columns?.call(Battle.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Battle]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Battle> updateRow(
    _i1.DatabaseSession session,
    Battle row, {
    _i1.ColumnSelections<BattleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Battle>(
      row,
      columns: columns?.call(Battle.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Battle] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Battle?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<BattleUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Battle>(
      id,
      columnValues: columnValues(Battle.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Battle]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Battle>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<BattleUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<BattleTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BattleTable>? orderBy,
    _i1.OrderByListBuilder<BattleTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Battle>(
      columnValues: columnValues(Battle.t.updateTable),
      where: where(Battle.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Battle.t),
      orderByList: orderByList?.call(Battle.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Battle]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Battle>> delete(
    _i1.DatabaseSession session,
    List<Battle> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Battle>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Battle].
  Future<Battle> deleteRow(
    _i1.DatabaseSession session,
    Battle row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Battle>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Battle>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BattleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Battle>(
      where: where(Battle.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<BattleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Battle>(
      where: where?.call(Battle.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Battle] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<BattleTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Battle>(
      where: where(Battle.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class BattleAttachRowRepository {
  const BattleAttachRowRepository._();

  /// Creates a relation between the given [Battle] and [Player]
  /// by setting the [Battle]'s foreign key `attackerId` to refer to the [Player].
  Future<void> attacker(
    _i1.DatabaseSession session,
    Battle battle,
    _i2.Player attacker, {
    _i1.Transaction? transaction,
  }) async {
    if (battle.id == null) {
      throw ArgumentError.notNull('battle.id');
    }
    if (attacker.id == null) {
      throw ArgumentError.notNull('attacker.id');
    }

    var $battle = battle.copyWith(attackerId: attacker.id);
    await session.db.updateRow<Battle>(
      $battle,
      columns: [Battle.t.attackerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [Battle] and [Player]
  /// by setting the [Battle]'s foreign key `defenderId` to refer to the [Player].
  Future<void> defender(
    _i1.DatabaseSession session,
    Battle battle,
    _i2.Player defender, {
    _i1.Transaction? transaction,
  }) async {
    if (battle.id == null) {
      throw ArgumentError.notNull('battle.id');
    }
    if (defender.id == null) {
      throw ArgumentError.notNull('defender.id');
    }

    var $battle = battle.copyWith(defenderId: defender.id);
    await session.db.updateRow<Battle>(
      $battle,
      columns: [Battle.t.defenderId],
      transaction: transaction,
    );
  }
}
