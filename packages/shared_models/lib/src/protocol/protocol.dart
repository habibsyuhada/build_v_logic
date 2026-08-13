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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'attack_validation_exception.dart' as _i2;
import 'battle.dart' as _i3;
import 'battle_outcome.dart' as _i4;
import 'defense.dart' as _i5;
import 'defense_not_found_exception.dart' as _i6;
import 'defense_validation_exception.dart' as _i7;
import 'not_authenticated_exception.dart' as _i8;
import 'player.dart' as _i9;
import 'sim_version_mismatch_exception.dart' as _i10;
import 'unlock.dart' as _i11;
import 'virus_preset.dart' as _i12;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i13;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i14;
export 'attack_validation_exception.dart';
export 'battle.dart';
export 'battle_outcome.dart';
export 'defense.dart';
export 'defense_not_found_exception.dart';
export 'defense_validation_exception.dart';
export 'not_authenticated_exception.dart';
export 'player.dart';
export 'sim_version_mismatch_exception.dart';
export 'unlock.dart';
export 'virus_preset.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AttackValidationException) {
      return _i2.AttackValidationException.fromJson(data) as T;
    }
    if (t == _i3.Battle) {
      return _i3.Battle.fromJson(data) as T;
    }
    if (t == _i4.BattleOutcome) {
      return _i4.BattleOutcome.fromJson(data) as T;
    }
    if (t == _i5.Defense) {
      return _i5.Defense.fromJson(data) as T;
    }
    if (t == _i6.DefenseNotFoundException) {
      return _i6.DefenseNotFoundException.fromJson(data) as T;
    }
    if (t == _i7.DefenseValidationException) {
      return _i7.DefenseValidationException.fromJson(data) as T;
    }
    if (t == _i8.NotAuthenticatedException) {
      return _i8.NotAuthenticatedException.fromJson(data) as T;
    }
    if (t == _i9.Player) {
      return _i9.Player.fromJson(data) as T;
    }
    if (t == _i10.SimVersionMismatchException) {
      return _i10.SimVersionMismatchException.fromJson(data) as T;
    }
    if (t == _i11.Unlock) {
      return _i11.Unlock.fromJson(data) as T;
    }
    if (t == _i12.VirusPreset) {
      return _i12.VirusPreset.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AttackValidationException?>()) {
      return (data != null
              ? _i2.AttackValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i3.Battle?>()) {
      return (data != null ? _i3.Battle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.BattleOutcome?>()) {
      return (data != null ? _i4.BattleOutcome.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.Defense?>()) {
      return (data != null ? _i5.Defense.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.DefenseNotFoundException?>()) {
      return (data != null ? _i6.DefenseNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i7.DefenseValidationException?>()) {
      return (data != null
              ? _i7.DefenseValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i8.NotAuthenticatedException?>()) {
      return (data != null
              ? _i8.NotAuthenticatedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.Player?>()) {
      return (data != null ? _i9.Player.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.SimVersionMismatchException?>()) {
      return (data != null
              ? _i10.SimVersionMismatchException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i11.Unlock?>()) {
      return (data != null ? _i11.Unlock.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.VirusPreset?>()) {
      return (data != null ? _i12.VirusPreset.fromJson(data) : null) as T;
    }
    try {
      return _i13.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i14.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AttackValidationException => 'AttackValidationException',
      _i3.Battle => 'Battle',
      _i4.BattleOutcome => 'BattleOutcome',
      _i5.Defense => 'Defense',
      _i6.DefenseNotFoundException => 'DefenseNotFoundException',
      _i7.DefenseValidationException => 'DefenseValidationException',
      _i8.NotAuthenticatedException => 'NotAuthenticatedException',
      _i9.Player => 'Player',
      _i10.SimVersionMismatchException => 'SimVersionMismatchException',
      _i11.Unlock => 'Unlock',
      _i12.VirusPreset => 'VirusPreset',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('payload.', '');
    }

    switch (data) {
      case _i2.AttackValidationException():
        return 'AttackValidationException';
      case _i3.Battle():
        return 'Battle';
      case _i4.BattleOutcome():
        return 'BattleOutcome';
      case _i5.Defense():
        return 'Defense';
      case _i6.DefenseNotFoundException():
        return 'DefenseNotFoundException';
      case _i7.DefenseValidationException():
        return 'DefenseValidationException';
      case _i8.NotAuthenticatedException():
        return 'NotAuthenticatedException';
      case _i9.Player():
        return 'Player';
      case _i10.SimVersionMismatchException():
        return 'SimVersionMismatchException';
      case _i11.Unlock():
        return 'Unlock';
      case _i12.VirusPreset():
        return 'VirusPreset';
    }
    className = _i13.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i14.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AttackValidationException') {
      return deserialize<_i2.AttackValidationException>(data['data']);
    }
    if (dataClassName == 'Battle') {
      return deserialize<_i3.Battle>(data['data']);
    }
    if (dataClassName == 'BattleOutcome') {
      return deserialize<_i4.BattleOutcome>(data['data']);
    }
    if (dataClassName == 'Defense') {
      return deserialize<_i5.Defense>(data['data']);
    }
    if (dataClassName == 'DefenseNotFoundException') {
      return deserialize<_i6.DefenseNotFoundException>(data['data']);
    }
    if (dataClassName == 'DefenseValidationException') {
      return deserialize<_i7.DefenseValidationException>(data['data']);
    }
    if (dataClassName == 'NotAuthenticatedException') {
      return deserialize<_i8.NotAuthenticatedException>(data['data']);
    }
    if (dataClassName == 'Player') {
      return deserialize<_i9.Player>(data['data']);
    }
    if (dataClassName == 'SimVersionMismatchException') {
      return deserialize<_i10.SimVersionMismatchException>(data['data']);
    }
    if (dataClassName == 'Unlock') {
      return deserialize<_i11.Unlock>(data['data']);
    }
    if (dataClassName == 'VirusPreset') {
      return deserialize<_i12.VirusPreset>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i13.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i14.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i13.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i14.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
