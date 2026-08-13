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

/// One client telemetry event (§2.6: "Telemetry client (event funnel):
/// install → tutorial step N → first battle → D1/D7 return. Kirim
/// batched ke endpoint sendiri"). Ingested via `TelemetryEndpoint.ingest`,
/// batched client-side by `TelemetryClient` before sending.
abstract class TelemetryEvent
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  TelemetryEvent._({
    this.id,
    this.playerId,
    this.player,
    required this.eventType,
    String? propertiesJson,
    required this.occurredAt,
    DateTime? receivedAt,
  }) : propertiesJson = propertiesJson ?? '{}',
       receivedAt = receivedAt ?? DateTime.now();

  factory TelemetryEvent({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    required String eventType,
    String? propertiesJson,
    required DateTime occurredAt,
    DateTime? receivedAt,
  }) = _TelemetryEventImpl;

  factory TelemetryEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return TelemetryEvent(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      playerId: jsonSerialization['playerId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['playerId']),
      player: jsonSerialization['player'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.Player>(jsonSerialization['player']),
      eventType: jsonSerialization['eventType'] as String,
      propertiesJson: jsonSerialization['propertiesJson'] as String?,
      occurredAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['occurredAt'],
      ),
      receivedAt: jsonSerialization['receivedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['receivedAt']),
    );
  }

  static final t = TelemetryEventTable();

  static const db = TelemetryEventRepository._();

  @override
  _i1.UuidValue? id;

  _i1.UuidValue? playerId;

  /// Nullable: some funnel events (e.g. first app open) happen before a
  /// Player row exists yet.
  _i2.Player? player;

  String eventType;

  String propertiesJson;

  DateTime occurredAt;

  DateTime receivedAt;

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [TelemetryEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TelemetryEvent copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    String? eventType,
    String? propertiesJson,
    DateTime? occurredAt,
    DateTime? receivedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TelemetryEvent',
      if (id != null) 'id': id?.toJson(),
      if (playerId != null) 'playerId': playerId?.toJson(),
      if (player != null) 'player': player?.toJson(),
      'eventType': eventType,
      'propertiesJson': propertiesJson,
      'occurredAt': occurredAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TelemetryEvent',
      if (id != null) 'id': id?.toJson(),
      if (playerId != null) 'playerId': playerId?.toJson(),
      if (player != null) 'player': player?.toJsonForProtocol(),
      'eventType': eventType,
      'propertiesJson': propertiesJson,
      'occurredAt': occurredAt.toJson(),
      'receivedAt': receivedAt.toJson(),
    };
  }

  static TelemetryEventInclude include({_i2.PlayerInclude? player}) {
    return TelemetryEventInclude._(player: player);
  }

  static TelemetryEventIncludeList includeList({
    _i1.WhereExpressionBuilder<TelemetryEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TelemetryEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TelemetryEventTable>? orderByList,
    TelemetryEventInclude? include,
  }) {
    return TelemetryEventIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TelemetryEvent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(TelemetryEvent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _TelemetryEventImpl extends TelemetryEvent {
  _TelemetryEventImpl({
    _i1.UuidValue? id,
    _i1.UuidValue? playerId,
    _i2.Player? player,
    required String eventType,
    String? propertiesJson,
    required DateTime occurredAt,
    DateTime? receivedAt,
  }) : super._(
         id: id,
         playerId: playerId,
         player: player,
         eventType: eventType,
         propertiesJson: propertiesJson,
         occurredAt: occurredAt,
         receivedAt: receivedAt,
       );

  /// Returns a shallow copy of this [TelemetryEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TelemetryEvent copyWith({
    Object? id = _Undefined,
    Object? playerId = _Undefined,
    Object? player = _Undefined,
    String? eventType,
    String? propertiesJson,
    DateTime? occurredAt,
    DateTime? receivedAt,
  }) {
    return TelemetryEvent(
      id: id is _i1.UuidValue? ? id : this.id,
      playerId: playerId is _i1.UuidValue? ? playerId : this.playerId,
      player: player is _i2.Player? ? player : this.player?.copyWith(),
      eventType: eventType ?? this.eventType,
      propertiesJson: propertiesJson ?? this.propertiesJson,
      occurredAt: occurredAt ?? this.occurredAt,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }
}

class TelemetryEventUpdateTable extends _i1.UpdateTable<TelemetryEventTable> {
  TelemetryEventUpdateTable(super.table);

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> playerId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.playerId,
    value,
  );

  _i1.ColumnValue<String, String> eventType(String value) => _i1.ColumnValue(
    table.eventType,
    value,
  );

  _i1.ColumnValue<String, String> propertiesJson(String value) =>
      _i1.ColumnValue(
        table.propertiesJson,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> occurredAt(DateTime value) =>
      _i1.ColumnValue(
        table.occurredAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> receivedAt(DateTime value) =>
      _i1.ColumnValue(
        table.receivedAt,
        value,
      );
}

class TelemetryEventTable extends _i1.Table<_i1.UuidValue?> {
  TelemetryEventTable({super.tableRelation})
    : super(tableName: 'telemetry_events') {
    updateTable = TelemetryEventUpdateTable(this);
    playerId = _i1.ColumnUuid(
      'playerId',
      this,
    );
    eventType = _i1.ColumnString(
      'eventType',
      this,
    );
    propertiesJson = _i1.ColumnString(
      'propertiesJson',
      this,
    );
    occurredAt = _i1.ColumnDateTime(
      'occurredAt',
      this,
    );
    receivedAt = _i1.ColumnDateTime(
      'receivedAt',
      this,
    );
  }

  late final TelemetryEventUpdateTable updateTable;

  late final _i1.ColumnUuid playerId;

  /// Nullable: some funnel events (e.g. first app open) happen before a
  /// Player row exists yet.
  _i2.PlayerTable? _player;

  late final _i1.ColumnString eventType;

  late final _i1.ColumnString propertiesJson;

  late final _i1.ColumnDateTime occurredAt;

  late final _i1.ColumnDateTime receivedAt;

  _i2.PlayerTable get player {
    if (_player != null) return _player!;
    _player = _i1.createRelationTable(
      relationFieldName: 'player',
      field: TelemetryEvent.t.playerId,
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
    eventType,
    propertiesJson,
    occurredAt,
    receivedAt,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'player') {
      return player;
    }
    return null;
  }
}

class TelemetryEventInclude extends _i1.IncludeObject {
  TelemetryEventInclude._({_i2.PlayerInclude? player}) {
    _player = player;
  }

  _i2.PlayerInclude? _player;

  @override
  Map<String, _i1.Include?> get includes => {'player': _player};

  @override
  _i1.Table<_i1.UuidValue?> get table => TelemetryEvent.t;
}

class TelemetryEventIncludeList extends _i1.IncludeList {
  TelemetryEventIncludeList._({
    _i1.WhereExpressionBuilder<TelemetryEventTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(TelemetryEvent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => TelemetryEvent.t;
}

class TelemetryEventRepository {
  const TelemetryEventRepository._();

  final attachRow = const TelemetryEventAttachRowRepository._();

  final detachRow = const TelemetryEventDetachRowRepository._();

  /// Returns a list of [TelemetryEvent]s matching the given query parameters.
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
  Future<List<TelemetryEvent>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TelemetryEventTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TelemetryEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TelemetryEventTable>? orderByList,
    _i1.Transaction? transaction,
    TelemetryEventInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<TelemetryEvent>(
      where: where?.call(TelemetryEvent.t),
      orderBy: orderBy?.call(TelemetryEvent.t),
      orderByList: orderByList?.call(TelemetryEvent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [TelemetryEvent] matching the given query parameters.
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
  Future<TelemetryEvent?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TelemetryEventTable>? where,
    int? offset,
    _i1.OrderByBuilder<TelemetryEventTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<TelemetryEventTable>? orderByList,
    _i1.Transaction? transaction,
    TelemetryEventInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<TelemetryEvent>(
      where: where?.call(TelemetryEvent.t),
      orderBy: orderBy?.call(TelemetryEvent.t),
      orderByList: orderByList?.call(TelemetryEvent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [TelemetryEvent] by its [id] or null if no such row exists.
  Future<TelemetryEvent?> findById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    TelemetryEventInclude? include,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<TelemetryEvent>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [TelemetryEvent]s in the list and returns the inserted rows.
  ///
  /// The returned [TelemetryEvent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<TelemetryEvent>> insert(
    _i1.DatabaseSession session,
    List<TelemetryEvent> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<TelemetryEvent>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [TelemetryEvent] and returns the inserted row.
  ///
  /// The returned [TelemetryEvent] will have its `id` field set.
  Future<TelemetryEvent> insertRow(
    _i1.DatabaseSession session,
    TelemetryEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<TelemetryEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [TelemetryEvent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<TelemetryEvent>> update(
    _i1.DatabaseSession session,
    List<TelemetryEvent> rows, {
    _i1.ColumnSelections<TelemetryEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<TelemetryEvent>(
      rows,
      columns: columns?.call(TelemetryEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TelemetryEvent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<TelemetryEvent> updateRow(
    _i1.DatabaseSession session,
    TelemetryEvent row, {
    _i1.ColumnSelections<TelemetryEventTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<TelemetryEvent>(
      row,
      columns: columns?.call(TelemetryEvent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [TelemetryEvent] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<TelemetryEvent?> updateById(
    _i1.DatabaseSession session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<TelemetryEventUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<TelemetryEvent>(
      id,
      columnValues: columnValues(TelemetryEvent.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [TelemetryEvent]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<TelemetryEvent>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<TelemetryEventUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<TelemetryEventTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<TelemetryEventTable>? orderBy,
    _i1.OrderByListBuilder<TelemetryEventTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<TelemetryEvent>(
      columnValues: columnValues(TelemetryEvent.t.updateTable),
      where: where(TelemetryEvent.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(TelemetryEvent.t),
      orderByList: orderByList?.call(TelemetryEvent.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [TelemetryEvent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<TelemetryEvent>> delete(
    _i1.DatabaseSession session,
    List<TelemetryEvent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<TelemetryEvent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [TelemetryEvent].
  Future<TelemetryEvent> deleteRow(
    _i1.DatabaseSession session,
    TelemetryEvent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<TelemetryEvent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<TelemetryEvent>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TelemetryEventTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<TelemetryEvent>(
      where: where(TelemetryEvent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<TelemetryEventTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<TelemetryEvent>(
      where: where?.call(TelemetryEvent.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [TelemetryEvent] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<TelemetryEventTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<TelemetryEvent>(
      where: where(TelemetryEvent.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class TelemetryEventAttachRowRepository {
  const TelemetryEventAttachRowRepository._();

  /// Creates a relation between the given [TelemetryEvent] and [Player]
  /// by setting the [TelemetryEvent]'s foreign key `playerId` to refer to the [Player].
  Future<void> player(
    _i1.DatabaseSession session,
    TelemetryEvent telemetryEvent,
    _i2.Player player, {
    _i1.Transaction? transaction,
  }) async {
    if (telemetryEvent.id == null) {
      throw ArgumentError.notNull('telemetryEvent.id');
    }
    if (player.id == null) {
      throw ArgumentError.notNull('player.id');
    }

    var $telemetryEvent = telemetryEvent.copyWith(playerId: player.id);
    await session.db.updateRow<TelemetryEvent>(
      $telemetryEvent,
      columns: [TelemetryEvent.t.playerId],
      transaction: transaction,
    );
  }
}

class TelemetryEventDetachRowRepository {
  const TelemetryEventDetachRowRepository._();

  /// Detaches the relation between this [TelemetryEvent] and the [Player] set in `player`
  /// by setting the [TelemetryEvent]'s foreign key `playerId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> player(
    _i1.DatabaseSession session,
    TelemetryEvent telemetryEvent, {
    _i1.Transaction? transaction,
  }) async {
    if (telemetryEvent.id == null) {
      throw ArgumentError.notNull('telemetryEvent.id');
    }

    var $telemetryEvent = telemetryEvent.copyWith(playerId: null);
    await session.db.updateRow<TelemetryEvent>(
      $telemetryEvent,
      columns: [TelemetryEvent.t.playerId],
      transaction: transaction,
    );
  }
}
