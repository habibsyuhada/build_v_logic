/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// One day's system-generated puzzle network (§1.5.5, §2.4
/// `daily_contracts`), deterministically seeded from its date so every
/// player faces the exact same network.
abstract class DailyContract
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  DailyContract._({
    this.id,
    required this.contractDate,
    required this.networkJson,
    required this.seed,
  });

  factory DailyContract({
    _i1.UuidValue? id,
    required String contractDate,
    required String networkJson,
    required int seed,
  }) = _DailyContractImpl;

  factory DailyContract.fromJson(Map<String, dynamic> jsonSerialization) {
    return DailyContract(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      contractDate: jsonSerialization['contractDate'] as String,
      networkJson: jsonSerialization['networkJson'] as String,
      seed: jsonSerialization['seed'] as int,
    );
  }

  static final t = DailyContractTable();

  static const db = DailyContractRepository._();

  @override
  _i1.UuidValue? id;

  /// The contract's date, as `YYYY-MM-DD` (UTC) — also the seed source.
  String contractDate;

  /// The generated network, as JSON (content_schema.NetworkDef).
  String networkJson;

  int seed;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [DailyContract]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DailyContract copyWith({
    _i1.UuidValue? id,
    String? contractDate,
    String? networkJson,
    int? seed,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DailyContract',
      if (id != null) 'id': id?.toJson(),
      'contractDate': contractDate,
      'networkJson': networkJson,
      'seed': seed,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DailyContract',
      if (id != null) 'id': id?.toJson(),
      'contractDate': contractDate,
      'networkJson': networkJson,
      'seed': seed,
    };
  }

  static DailyContractInclude include() {
    return DailyContractInclude._();
  }

  static DailyContractIncludeList includeList({
    _i1.WhereExpressionBuilder<DailyContractTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DailyContractTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DailyContractTable>? orderByList,
    DailyContractInclude? include,
  }) {
    return DailyContractIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DailyContract.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DailyContract.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DailyContractImpl extends DailyContract {
  _DailyContractImpl({
    _i1.UuidValue? id,
    required String contractDate,
    required String networkJson,
    required int seed,
  }) : super._(
         id: id,
         contractDate: contractDate,
         networkJson: networkJson,
         seed: seed,
       );

  /// Returns a shallow copy of this [DailyContract]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DailyContract copyWith({
    Object? id = _Undefined,
    String? contractDate,
    String? networkJson,
    int? seed,
  }) {
    return DailyContract(
      id: id is _i1.UuidValue? ? id : this.id,
      contractDate: contractDate ?? this.contractDate,
      networkJson: networkJson ?? this.networkJson,
      seed: seed ?? this.seed,
    );
  }
}

class DailyContractUpdateTable extends _i1.UpdateTable<DailyContractTable> {
  DailyContractUpdateTable(super.table);

  _i1.ColumnValue<String, String> contractDate(String value) => _i1.ColumnValue(
    table.contractDate,
    value,
  );

  _i1.ColumnValue<String, String> networkJson(String value) => _i1.ColumnValue(
    table.networkJson,
    value,
  );

  _i1.ColumnValue<int, int> seed(int value) => _i1.ColumnValue(
    table.seed,
    value,
  );
}

class DailyContractTable extends _i1.Table<_i1.UuidValue?> {
  DailyContractTable({super.tableRelation})
    : super(tableName: 'daily_contracts') {
    updateTable = DailyContractUpdateTable(this);
    contractDate = _i1.ColumnString(
      'contractDate',
      this,
    );
    networkJson = _i1.ColumnString(
      'networkJson',
      this,
    );
    seed = _i1.ColumnInt(
      'seed',
      this,
    );
  }

  late final DailyContractUpdateTable updateTable;

  /// The contract's date, as `YYYY-MM-DD` (UTC) — also the seed source.
  late final _i1.ColumnString contractDate;

  /// The generated network, as JSON (content_schema.NetworkDef).
  late final _i1.ColumnString networkJson;

  late final _i1.ColumnInt seed;

  @override
  List<_i1.Column> get columns => [
    id,
    contractDate,
    networkJson,
    seed,
  ];
}

class DailyContractInclude extends _i1.IncludeObject {
  DailyContractInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<_i1.UuidValue?> get table => DailyContract.t;
}

class DailyContractIncludeList extends _i1.IncludeList {
  DailyContractIncludeList._({
    _i1.WhereExpressionBuilder<DailyContractTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DailyContract.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => DailyContract.t;
}

class DailyContractRepository {
  const DailyContractRepository._();

  /// Returns a list of [DailyContract]s matching the given query parameters.
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
  Future<List<DailyContract>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DailyContractTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DailyContractTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DailyContractTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<DailyContract>(
      where: where?.call(DailyContract.t),
      orderBy: orderBy?.call(DailyContract.t),
      orderByList: orderByList?.call(DailyContract.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [DailyContract] matching the given query parameters.
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
  Future<DailyContract?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DailyContractTable>? where,
    int? offset,
    _i1.OrderByBuilder<DailyContractTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DailyContractTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<DailyContract>(
      where: where?.call(DailyContract.t),
      orderBy: orderBy?.call(DailyContract.t),
      orderByList: orderByList?.call(DailyContract.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [DailyContract] by its [id] or null if no such row exists.
  Future<DailyContract?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<DailyContract>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [DailyContract]s in the list and returns the inserted rows.
  ///
  /// The returned [DailyContract]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<DailyContract>> insert(
    _i1.DatabaseSession session,
    List<DailyContract> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<DailyContract>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [DailyContract] and returns the inserted row.
  ///
  /// The returned [DailyContract] will have its `id` field set.
  Future<DailyContract> insertRow(
    _i1.DatabaseSession session,
    DailyContract row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DailyContract>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DailyContract]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DailyContract>> update(
    _i1.DatabaseSession session,
    List<DailyContract> rows, {
    _i1.ColumnSelections<DailyContractTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DailyContract>(
      rows,
      columns: columns?.call(DailyContract.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DailyContract]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DailyContract> updateRow(
    _i1.DatabaseSession session,
    DailyContract row, {
    _i1.ColumnSelections<DailyContractTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DailyContract>(
      row,
      columns: columns?.call(DailyContract.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DailyContract] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<DailyContract?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<DailyContractUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<DailyContract>(
      id,
      columnValues: columnValues(DailyContract.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [DailyContract]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<DailyContract>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<DailyContractUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<DailyContractTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DailyContractTable>? orderBy,
    _i1.OrderByListBuilder<DailyContractTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<DailyContract>(
      columnValues: columnValues(DailyContract.t.updateTable),
      where: where(DailyContract.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DailyContract.t),
      orderByList: orderByList?.call(DailyContract.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [DailyContract]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DailyContract>> delete(
    _i1.DatabaseSession session,
    List<DailyContract> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DailyContract>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DailyContract].
  Future<DailyContract> deleteRow(
    _i1.DatabaseSession session,
    DailyContract row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DailyContract>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DailyContract>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DailyContractTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DailyContract>(
      where: where(DailyContract.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<DailyContractTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DailyContract>(
      where: where?.call(DailyContract.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [DailyContract] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<DailyContractTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<DailyContract>(
      where: where(DailyContract.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
