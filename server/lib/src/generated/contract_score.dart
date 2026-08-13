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
import 'daily_contract.dart' as _i3;
import 'package:payload_server/src/generated/protocol.dart' as _i4;

/// A player's best score on a given [DailyContract] (§2.4
/// `contract_scores`), for the daily global leaderboard.
abstract class ContractScore
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  ContractScore._({
    this.id,
    required this.playerId,
    this.player,
    required this.contractId,
    this.contract,
    required this.score,
    DateTime? achievedAt,
  }) : achievedAt = achievedAt ?? DateTime.now();

  factory ContractScore({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue contractId,
    _i3.DailyContract? contract,
    required int score,
    DateTime? achievedAt,
  }) = _ContractScoreImpl;

  factory ContractScore.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContractScore(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      contractId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['contractId'],
      ),
      contract: jsonSerialization['contract'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.DailyContract>(
              jsonSerialization['contract'],
            ),
      score: jsonSerialization['score'] as int,
      achievedAt: jsonSerialization['achievedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['achievedAt']),
    );
  }

  static final t = ContractScoreTable();

  static const db = ContractScoreRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i2.Player? player;

  _i1.UuidValue contractId;

  _i3.DailyContract? contract;

  int score;

  DateTime achievedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [ContractScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ContractScore copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    _i1.UuidValue? contractId,
    _i3.DailyContract? contract,
    int? score,
    DateTime? achievedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContractScore',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'contractId': contractId.toJson(),
      if (contract != null) 'contract': contract?.toJson(),
      'score': score,
      'achievedAt': achievedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ContractScore',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJsonForProtocol(),
      'contractId': contractId.toJson(),
      if (contract != null) 'contract': contract?.toJsonForProtocol(),
      'score': score,
      'achievedAt': achievedAt.toJson(),
    };
  }

  static ContractScoreInclude include({
    _i2.PlayerInclude? player,
    _i3.DailyContractInclude? contract,
  }) {
    return ContractScoreInclude._(
      player: player,
      contract: contract,
    );
  }

  static ContractScoreIncludeList includeList({
    _i1.WhereExpressionBuilder<ContractScoreTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ContractScoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ContractScoreTable>? orderByList,
    ContractScoreInclude? include,
  }) {
    return ContractScoreIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ContractScore.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ContractScore.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContractScoreImpl extends ContractScore {
  _ContractScoreImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i2.Player? player,
    required _i1.UuidValue contractId,
    _i3.DailyContract? contract,
    required int score,
    DateTime? achievedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         contractId: contractId,
         contract: contract,
         score: score,
         achievedAt: achievedAt,
       );

  /// Returns a shallow copy of this [ContractScore]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ContractScore copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    _i1.UuidValue? contractId,
    Object? contract = _Undefined,
    int? score,
    DateTime? achievedAt,
  }) {
    return ContractScore(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      contractId: contractId ?? this.contractId,
      contract: contract is _i3.DailyContract?
          ? contract
          : this.contract?.copyWith(),
      score: score ?? this.score,
      achievedAt: achievedAt ?? this.achievedAt,
    );
  }
}

class ContractScoreUpdateTable extends _i1.UpdateTable<ContractScoreTable> {
  ContractScoreUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playerId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.playerId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> contractId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.contractId,
    value,
  );

  _i1.ColumnValue<int, int> score(int value) => _i1.ColumnValue(
    table.score,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> achievedAt(DateTime value) =>
      _i1.ColumnValue(
        table.achievedAt,
        value,
      );
}

class ContractScoreTable extends _i1.Table<_i1.UuidValue?> {
  ContractScoreTable({super.tableRelation})
    : super(tableName: 'contract_scores') {
    updateTable = ContractScoreUpdateTable(this);
    playerId = _i1.ColumnUuid(
      'playerId',
      this,
    );
    contractId = _i1.ColumnUuid(
      'contractId',
      this,
    );
    score = _i1.ColumnInt(
      'score',
      this,
    );
    achievedAt = _i1.ColumnDateTime(
      'achievedAt',
      this,
    );
  }

  late final ContractScoreUpdateTable updateTable;

  late final _i1.ColumnUuid playerId;

  _i2.PlayerTable? _player;

  late final _i1.ColumnUuid contractId;

  _i3.DailyContractTable? _contract;

  late final _i1.ColumnInt score;

  late final _i1.ColumnDateTime achievedAt;

  _i2.PlayerTable get player {
    if (_player != null) return _player!;
    _player = _i1.createRelationTable(
      relationFieldName: 'player',
      field: ContractScore.t.playerId,
      foreignField: _i2.Player.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.PlayerTable(tableRelation: foreignTableRelation),
    );
    return _player!;
  }

  _i3.DailyContractTable get contract {
    if (_contract != null) return _contract!;
    _contract = _i1.createRelationTable(
      relationFieldName: 'contract',
      field: ContractScore.t.contractId,
      foreignField: _i3.DailyContract.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.DailyContractTable(tableRelation: foreignTableRelation),
    );
    return _contract!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    playerId,
    contractId,
    score,
    achievedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'player') {
      return player;
    }
    if (relationField == 'contract') {
      return contract;
    }
    return null;
  }
}

class ContractScoreInclude extends _i1.IncludeObject {
  ContractScoreInclude._({
    _i2.PlayerInclude? player,
    _i3.DailyContractInclude? contract,
  }) {
    _player = player;
    _contract = contract;
  }

  _i2.PlayerInclude? _player;

  _i3.DailyContractInclude? _contract;

  @override
  Map<String, _i1.Include?> get includes => {
    'player': _player,
    'contract': _contract,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => ContractScore.t;
}

class ContractScoreIncludeList extends _i1.IncludeList {
  ContractScoreIncludeList._({
    _i1.WhereExpressionBuilder<ContractScoreTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ContractScore.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => ContractScore.t;
}

class ContractScoreRepository {
  const ContractScoreRepository._();

  final attachRow = const ContractScoreAttachRowRepository._();

  /// Returns a list of [ContractScore]s matching the given query parameters.
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
  Future<List<ContractScore>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ContractScoreTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ContractScoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ContractScoreTable>? orderByList,
    _i1.Transaction? transaction,
    ContractScoreInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ContractScore>(
      where: where?.call(ContractScore.t),
      orderBy: orderBy?.call(ContractScore.t),
      orderByList: orderByList?.call(ContractScore.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ContractScore] matching the given query parameters.
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
  Future<ContractScore?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ContractScoreTable>? where,
    int? offset,
    _i1.OrderByBuilder<ContractScoreTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ContractScoreTable>? orderByList,
    _i1.Transaction? transaction,
    ContractScoreInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ContractScore>(
      where: where?.call(ContractScore.t),
      orderBy: orderBy?.call(ContractScore.t),
      orderByList: orderByList?.call(ContractScore.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ContractScore] by its [id] or null if no such row exists.
  Future<ContractScore?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    ContractScoreInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ContractScore>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ContractScore]s in the list and returns the inserted rows.
  ///
  /// The returned [ContractScore]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ContractScore>> insert(
    _i1.DatabaseSession session,
    List<ContractScore> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ContractScore>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ContractScore] and returns the inserted row.
  ///
  /// The returned [ContractScore] will have its `id` field set.
  Future<ContractScore> insertRow(
    _i1.DatabaseSession session,
    ContractScore row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ContractScore>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [ContractScore]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ContractScore>> update(
    _i1.DatabaseSession session,
    List<ContractScore> rows, {
    _i1.ColumnSelections<ContractScoreTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ContractScore>(
      rows,
      columns: columns?.call(ContractScore.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ContractScore]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ContractScore> updateRow(
    _i1.DatabaseSession session,
    ContractScore row, {
    _i1.ColumnSelections<ContractScoreTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ContractScore>(
      row,
      columns: columns?.call(ContractScore.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ContractScore] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ContractScore?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<ContractScoreUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ContractScore>(
      id,
      columnValues: columnValues(ContractScore.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ContractScore]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ContractScore>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ContractScoreUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ContractScoreTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ContractScoreTable>? orderBy,
    _i1.OrderByListBuilder<ContractScoreTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ContractScore>(
      columnValues: columnValues(ContractScore.t.updateTable),
      where: where(ContractScore.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ContractScore.t),
      orderByList: orderByList?.call(ContractScore.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ContractScore]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ContractScore>> delete(
    _i1.DatabaseSession session,
    List<ContractScore> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ContractScore>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [ContractScore].
  Future<ContractScore> deleteRow(
    _i1.DatabaseSession session,
    ContractScore row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ContractScore>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ContractScore>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ContractScoreTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ContractScore>(
      where: where(ContractScore.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ContractScoreTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ContractScore>(
      where: where?.call(ContractScore.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ContractScore] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ContractScoreTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ContractScore>(
      where: where(ContractScore.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class ContractScoreAttachRowRepository {
  const ContractScoreAttachRowRepository._();

  /// Creates a relation between the given [ContractScore] and [Player]
  /// by setting the [ContractScore]'s foreign key `playerId` to refer to the [Player].
  Future<void> player(
    _i1.DatabaseSession session,
    ContractScore contractScore,
    _i2.Player player, {
    _i1.Transaction? transaction,
  }) async {
    if (contractScore.id == null) {
      throw ArgumentError.notNull('contractScore.id');
    }
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }

    var $contractScore = contractScore.copyWith(playerId: player.id);
    await session.db.updateRow<ContractScore>(
      $contractScore,
      columns: [ContractScore.t.playerId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [ContractScore] and [DailyContract]
  /// by setting the [ContractScore]'s foreign key `contractId` to refer to the [DailyContract].
  Future<void> contract(
    _i1.DatabaseSession session,
    ContractScore contractScore,
    _i3.DailyContract contract, {
    _i1.Transaction? transaction,
  }) async {
    if (contractScore.id == null) {
      throw ArgumentError.notNull('contractScore.id');
    }
    if (contract.id == null) {
      throw ArgumentError.notNull('contract.id');
    }

    var $contractScore = contractScore.copyWith(contractId: contract.id);
    await session.db.updateRow<ContractScore>(
      $contractScore,
      columns: [ContractScore.t.contractId],
      transaction: transaction,
    );
  }
}
