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
import 'purchase_state.dart' as _i2;
import 'player.dart' as _i3;
import 'package:payload_server/src/generated/protocol.dart' as _i4;

/// One IAP purchase (§2.4 `purchases`, §2.5: "verifikasi receipt
/// server-side"). The receipt is always re-verified against the store's
/// own API server-side — never trusted from the client's stated
/// price/SKU. See `ReceiptValidator` for the (store-credential-gated)
/// verification seam.
abstract class Purchase
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  Purchase._({
    this.id,
    required this.playerId,
    this.player,
    required this.sku,
    required this.storeReceipt,
    _i2.PurchaseState? state,
    DateTime? createdAt,
  }) : state = state ?? _i2.PurchaseState.pending,
       createdAt = createdAt ?? DateTime.now();

  factory Purchase({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required String sku,
    required String storeReceipt,
    _i2.PurchaseState? state,
    DateTime? createdAt,
  }) = _PurchaseImpl;

  factory Purchase.fromJson(Map<String, dynamic> jsonSerialization) {
    return Purchase(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['playerId'],
      ),
      player: jsonSerialization['player'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Player>(jsonSerialization['player']),
      sku: jsonSerialization['sku'] as String,
      storeReceipt: jsonSerialization['storeReceipt'] as String,
      state: jsonSerialization['state'] == null
          ? null
          : _i2.PurchaseState.fromJson((jsonSerialization['state'] as String)),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = PurchaseTable();

  static const db = PurchaseRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue playerId;

  _i3.Player? player;

  /// content/shop.json SkuDef id.
  String sku;

  String storeReceipt;

  _i2.PurchaseState state;

  DateTime createdAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [Purchase]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Purchase copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i3.Player? player,
    String? sku,
    String? storeReceipt,
    _i2.PurchaseState? state,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Purchase',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJson(),
      'sku': sku,
      'storeReceipt': storeReceipt,
      'state': state.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Purchase',
      if (id != null) 'id': id?.toJson(),
      'playerId': playerId.toJson(),
      if (player != null) 'player': player?.toJsonForProtocol(),
      'sku': sku,
      'storeReceipt': storeReceipt,
      'state': state.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  static PurchaseInclude include({_i3.PlayerInclude? player}) {
    return PurchaseInclude._(player: player);
  }

  static PurchaseIncludeList includeList({
    _i1.WhereExpressionBuilder<PurchaseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PurchaseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PurchaseTable>? orderByList,
    PurchaseInclude? include,
  }) {
    return PurchaseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Purchase.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Purchase.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PurchaseImpl extends Purchase {
  _PurchaseImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue playerId,
    _i3.Player? player,
    required String sku,
    required String storeReceipt,
    _i2.PurchaseState? state,
    DateTime? createdAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         sku: sku,
         storeReceipt: storeReceipt,
         state: state,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Purchase]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Purchase copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? playerId,
    Object? player = _Undefined,
    String? sku,
    String? storeReceipt,
    _i2.PurchaseState? state,
    DateTime? createdAt,
  }) {
    return Purchase(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId ?? this.playerId,
      player: player is _i3.Player? ? player : this.player?.copyWith(),
      sku: sku ?? this.sku,
      storeReceipt: storeReceipt ?? this.storeReceipt,
      state: state ?? this.state,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class PurchaseUpdateTable extends _i1.UpdateTable<PurchaseTable> {
  PurchaseUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playerId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.playerId,
        value,
      );

  _i1.ColumnValue<String, String> sku(String value) => _i1.ColumnValue(
    table.sku,
    value,
  );

  _i1.ColumnValue<String, String> storeReceipt(String value) => _i1.ColumnValue(
    table.storeReceipt,
    value,
  );

  _i1.ColumnValue<_i2.PurchaseState, _i2.PurchaseState> state(
    _i2.PurchaseState value,
  ) => _i1.ColumnValue(
    table.state,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class PurchaseTable extends _i1.Table<_i1.UuidValue?> {
  PurchaseTable({super.tableRelation}) : super(tableName: 'purchases') {
    updateTable = PurchaseUpdateTable(this);
    playerId = _i1.ColumnUuid(
      'playerId',
      this,
    );
    sku = _i1.ColumnString(
      'sku',
      this,
    );
    storeReceipt = _i1.ColumnString(
      'storeReceipt',
      this,
    );
    state = _i1.ColumnEnum(
      'state',
      this,
      _i1.EnumSerialization.byName,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final PurchaseUpdateTable updateTable;

  late final _i1.ColumnUuid playerId;

  _i3.PlayerTable? _player;

  /// content/shop.json SkuDef id.
  late final _i1.ColumnString sku;

  late final _i1.ColumnString storeReceipt;

  late final _i1.ColumnEnum<_i2.PurchaseState> state;

  late final _i1.ColumnDateTime createdAt;

  _i3.PlayerTable get player {
    if (_player != null) return _player!;
    _player = _i1.createRelationTable(
      relationFieldName: 'player',
      field: Purchase.t.playerId,
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
    sku,
    storeReceipt,
    state,
    createdAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'player') {
      return player;
    }
    return null;
  }
}

class PurchaseInclude extends _i1.IncludeObject {
  PurchaseInclude._({_i3.PlayerInclude? player}) {
    _player = player;
  }

  _i3.PlayerInclude? _player;

  @override
  Map<String, _i1.Include?> get includes => {'player': _player};

  @override
  _i1.Table<_i1.UuidValue?> get table => Purchase.t;
}

class PurchaseIncludeList extends _i1.IncludeList {
  PurchaseIncludeList._({
    _i1.WhereExpressionBuilder<PurchaseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Purchase.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => Purchase.t;
}

class PurchaseRepository {
  const PurchaseRepository._();

  final attachRow = const PurchaseAttachRowRepository._();

  /// Returns a list of [Purchase]s matching the given query parameters.
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
  Future<List<Purchase>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PurchaseTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PurchaseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PurchaseTable>? orderByList,
    _i1.Transaction? transaction,
    PurchaseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Purchase>(
      where: where?.call(Purchase.t),
      orderBy: orderBy?.call(Purchase.t),
      orderByList: orderByList?.call(Purchase.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Purchase] matching the given query parameters.
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
  Future<Purchase?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PurchaseTable>? where,
    int? offset,
    _i1.OrderByBuilder<PurchaseTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PurchaseTable>? orderByList,
    _i1.Transaction? transaction,
    PurchaseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Purchase>(
      where: where?.call(Purchase.t),
      orderBy: orderBy?.call(Purchase.t),
      orderByList: orderByList?.call(Purchase.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Purchase] by its [id] or null if no such row exists.
  Future<Purchase?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    PurchaseInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Purchase>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Purchase]s in the list and returns the inserted rows.
  ///
  /// The returned [Purchase]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Purchase>> insert(
    _i1.DatabaseSession session,
    List<Purchase> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Purchase>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Purchase] and returns the inserted row.
  ///
  /// The returned [Purchase] will have its `id` field set.
  Future<Purchase> insertRow(
    _i1.DatabaseSession session,
    Purchase row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Purchase>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Purchase]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Purchase>> update(
    _i1.DatabaseSession session,
    List<Purchase> rows, {
    _i1.ColumnSelections<PurchaseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Purchase>(
      rows,
      columns: columns?.call(Purchase.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Purchase]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Purchase> updateRow(
    _i1.DatabaseSession session,
    Purchase row, {
    _i1.ColumnSelections<PurchaseTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Purchase>(
      row,
      columns: columns?.call(Purchase.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Purchase] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Purchase?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<PurchaseUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Purchase>(
      id,
      columnValues: columnValues(Purchase.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Purchase]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Purchase>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<PurchaseUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PurchaseTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PurchaseTable>? orderBy,
    _i1.OrderByListBuilder<PurchaseTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Purchase>(
      columnValues: columnValues(Purchase.t.updateTable),
      where: where(Purchase.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Purchase.t),
      orderByList: orderByList?.call(Purchase.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Purchase]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Purchase>> delete(
    _i1.DatabaseSession session,
    List<Purchase> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Purchase>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Purchase].
  Future<Purchase> deleteRow(
    _i1.DatabaseSession session,
    Purchase row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Purchase>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Purchase>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PurchaseTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Purchase>(
      where: where(Purchase.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<PurchaseTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Purchase>(
      where: where?.call(Purchase.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Purchase] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<PurchaseTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Purchase>(
      where: where(Purchase.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class PurchaseAttachRowRepository {
  const PurchaseAttachRowRepository._();

  /// Creates a relation between the given [Purchase] and [Player]
  /// by setting the [Purchase]'s foreign key `playerId` to refer to the [Player].
  Future<void> player(
    _i1.DatabaseSession session,
    Purchase purchase,
    _i3.Player player, {
    _i1.Transaction? transaction,
  }) async {
    if (purchase.id == null) {
      throw ArgumentError.notNull('purchase.id');
    }
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }

    var $purchase = purchase.copyWith(playerId: player.id);
    await session.db.updateRow<Purchase>(
      $purchase,
      columns: [Purchase.t.playerId],
      transaction: transaction,
    );
  }
}
