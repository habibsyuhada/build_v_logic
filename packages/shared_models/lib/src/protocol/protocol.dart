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
import 'battle_pass_progress.dart' as _i5;
import 'blueprint.dart' as _i6;
import 'blueprint_moderation_state.dart' as _i7;
import 'blueprint_not_found_exception.dart' as _i8;
import 'blueprint_not_revealed_exception.dart' as _i9;
import 'blueprint_reveal.dart' as _i10;
import 'blueprint_title_rejected_exception.dart' as _i11;
import 'blueprint_validation_exception.dart' as _i12;
import 'contract_score.dart' as _i13;
import 'daily_contract.dart' as _i14;
import 'defense.dart' as _i15;
import 'defense_not_found_exception.dart' as _i16;
import 'defense_validation_exception.dart' as _i17;
import 'not_authenticated_exception.dart' as _i18;
import 'player.dart' as _i19;
import 'purchase.dart' as _i20;
import 'purchase_state.dart' as _i21;
import 'season.dart' as _i22;
import 'season_result.dart' as _i23;
import 'sim_version_mismatch_exception.dart' as _i24;
import 'sku_not_found_exception.dart' as _i25;
import 'telemetry_event.dart' as _i26;
import 'unlock.dart' as _i27;
import 'virus_preset.dart' as _i28;
import 'package:shared_models/src/protocol/blueprint.dart' as _i29;
import 'package:shared_models/src/protocol/contract_score.dart' as _i30;
import 'package:shared_models/src/protocol/telemetry_event.dart' as _i31;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i32;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i33;
export 'attack_validation_exception.dart';
export 'battle.dart';
export 'battle_outcome.dart';
export 'battle_pass_progress.dart';
export 'blueprint.dart';
export 'blueprint_moderation_state.dart';
export 'blueprint_not_found_exception.dart';
export 'blueprint_not_revealed_exception.dart';
export 'blueprint_reveal.dart';
export 'blueprint_title_rejected_exception.dart';
export 'blueprint_validation_exception.dart';
export 'contract_score.dart';
export 'daily_contract.dart';
export 'defense.dart';
export 'defense_not_found_exception.dart';
export 'defense_validation_exception.dart';
export 'not_authenticated_exception.dart';
export 'player.dart';
export 'purchase.dart';
export 'purchase_state.dart';
export 'season.dart';
export 'season_result.dart';
export 'sim_version_mismatch_exception.dart';
export 'sku_not_found_exception.dart';
export 'telemetry_event.dart';
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
    if (t == _i5.BattlePassProgress) {
      return _i5.BattlePassProgress.fromJson(data) as T;
    }
    if (t == _i6.Blueprint) {
      return _i6.Blueprint.fromJson(data) as T;
    }
    if (t == _i7.BlueprintModerationState) {
      return _i7.BlueprintModerationState.fromJson(data) as T;
    }
    if (t == _i8.BlueprintNotFoundException) {
      return _i8.BlueprintNotFoundException.fromJson(data) as T;
    }
    if (t == _i9.BlueprintNotRevealedException) {
      return _i9.BlueprintNotRevealedException.fromJson(data) as T;
    }
    if (t == _i10.BlueprintReveal) {
      return _i10.BlueprintReveal.fromJson(data) as T;
    }
    if (t == _i11.BlueprintTitleRejectedException) {
      return _i11.BlueprintTitleRejectedException.fromJson(data) as T;
    }
    if (t == _i12.BlueprintValidationException) {
      return _i12.BlueprintValidationException.fromJson(data) as T;
    }
    if (t == _i13.ContractScore) {
      return _i13.ContractScore.fromJson(data) as T;
    }
    if (t == _i14.DailyContract) {
      return _i14.DailyContract.fromJson(data) as T;
    }
    if (t == _i15.Defense) {
      return _i15.Defense.fromJson(data) as T;
    }
    if (t == _i16.DefenseNotFoundException) {
      return _i16.DefenseNotFoundException.fromJson(data) as T;
    }
    if (t == _i17.DefenseValidationException) {
      return _i17.DefenseValidationException.fromJson(data) as T;
    }
    if (t == _i18.NotAuthenticatedException) {
      return _i18.NotAuthenticatedException.fromJson(data) as T;
    }
    if (t == _i19.Player) {
      return _i19.Player.fromJson(data) as T;
    }
    if (t == _i20.Purchase) {
      return _i20.Purchase.fromJson(data) as T;
    }
    if (t == _i21.PurchaseState) {
      return _i21.PurchaseState.fromJson(data) as T;
    }
    if (t == _i22.Season) {
      return _i22.Season.fromJson(data) as T;
    }
    if (t == _i23.SeasonResult) {
      return _i23.SeasonResult.fromJson(data) as T;
    }
    if (t == _i24.SimVersionMismatchException) {
      return _i24.SimVersionMismatchException.fromJson(data) as T;
    }
    if (t == _i25.SkuNotFoundException) {
      return _i25.SkuNotFoundException.fromJson(data) as T;
    }
    if (t == _i26.TelemetryEvent) {
      return _i26.TelemetryEvent.fromJson(data) as T;
    }
    if (t == _i27.Unlock) {
      return _i27.Unlock.fromJson(data) as T;
    }
    if (t == _i28.VirusPreset) {
      return _i28.VirusPreset.fromJson(data) as T;
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
    if (t == _i1.getType<_i5.BattlePassProgress?>()) {
      return (data != null ? _i5.BattlePassProgress.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.Blueprint?>()) {
      return (data != null ? _i6.Blueprint.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.BlueprintModerationState?>()) {
      return (data != null ? _i7.BlueprintModerationState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.BlueprintNotFoundException?>()) {
      return (data != null
              ? _i8.BlueprintNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i9.BlueprintNotRevealedException?>()) {
      return (data != null
              ? _i9.BlueprintNotRevealedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i10.BlueprintReveal?>()) {
      return (data != null ? _i10.BlueprintReveal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.BlueprintTitleRejectedException?>()) {
      return (data != null
              ? _i11.BlueprintTitleRejectedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i12.BlueprintValidationException?>()) {
      return (data != null
              ? _i12.BlueprintValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i13.ContractScore?>()) {
      return (data != null ? _i13.ContractScore.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.DailyContract?>()) {
      return (data != null ? _i14.DailyContract.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Defense?>()) {
      return (data != null ? _i15.Defense.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.DefenseNotFoundException?>()) {
      return (data != null
              ? _i16.DefenseNotFoundException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i17.DefenseValidationException?>()) {
      return (data != null
              ? _i17.DefenseValidationException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i18.NotAuthenticatedException?>()) {
      return (data != null
              ? _i18.NotAuthenticatedException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i19.Player?>()) {
      return (data != null ? _i19.Player.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.Purchase?>()) {
      return (data != null ? _i20.Purchase.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.PurchaseState?>()) {
      return (data != null ? _i21.PurchaseState.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.Season?>()) {
      return (data != null ? _i22.Season.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.SeasonResult?>()) {
      return (data != null ? _i23.SeasonResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.SimVersionMismatchException?>()) {
      return (data != null
              ? _i24.SimVersionMismatchException.fromJson(data)
              : null)
          as T;
    }
    if (t == _i1.getType<_i25.SkuNotFoundException?>()) {
      return (data != null ? _i25.SkuNotFoundException.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.TelemetryEvent?>()) {
      return (data != null ? _i26.TelemetryEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.Unlock?>()) {
      return (data != null ? _i27.Unlock.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.VirusPreset?>()) {
      return (data != null ? _i28.VirusPreset.fromJson(data) : null) as T;
    }
    if (t == List<_i29.Blueprint>) {
      return (data as List).map((e) => deserialize<_i29.Blueprint>(e)).toList()
          as T;
    }
    if (t == List<_i30.ContractScore>) {
      return (data as List)
              .map((e) => deserialize<_i30.ContractScore>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.TelemetryEvent>) {
      return (data as List)
              .map((e) => deserialize<_i31.TelemetryEvent>(e))
              .toList()
          as T;
    }
    try {
      return _i32.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i33.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AttackValidationException => 'AttackValidationException',
      _i3.Battle => 'Battle',
      _i4.BattleOutcome => 'BattleOutcome',
      _i5.BattlePassProgress => 'BattlePassProgress',
      _i6.Blueprint => 'Blueprint',
      _i7.BlueprintModerationState => 'BlueprintModerationState',
      _i8.BlueprintNotFoundException => 'BlueprintNotFoundException',
      _i9.BlueprintNotRevealedException => 'BlueprintNotRevealedException',
      _i10.BlueprintReveal => 'BlueprintReveal',
      _i11.BlueprintTitleRejectedException => 'BlueprintTitleRejectedException',
      _i12.BlueprintValidationException => 'BlueprintValidationException',
      _i13.ContractScore => 'ContractScore',
      _i14.DailyContract => 'DailyContract',
      _i15.Defense => 'Defense',
      _i16.DefenseNotFoundException => 'DefenseNotFoundException',
      _i17.DefenseValidationException => 'DefenseValidationException',
      _i18.NotAuthenticatedException => 'NotAuthenticatedException',
      _i19.Player => 'Player',
      _i20.Purchase => 'Purchase',
      _i21.PurchaseState => 'PurchaseState',
      _i22.Season => 'Season',
      _i23.SeasonResult => 'SeasonResult',
      _i24.SimVersionMismatchException => 'SimVersionMismatchException',
      _i25.SkuNotFoundException => 'SkuNotFoundException',
      _i26.TelemetryEvent => 'TelemetryEvent',
      _i27.Unlock => 'Unlock',
      _i28.VirusPreset => 'VirusPreset',
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
      case _i5.BattlePassProgress():
        return 'BattlePassProgress';
      case _i6.Blueprint():
        return 'Blueprint';
      case _i7.BlueprintModerationState():
        return 'BlueprintModerationState';
      case _i8.BlueprintNotFoundException():
        return 'BlueprintNotFoundException';
      case _i9.BlueprintNotRevealedException():
        return 'BlueprintNotRevealedException';
      case _i10.BlueprintReveal():
        return 'BlueprintReveal';
      case _i11.BlueprintTitleRejectedException():
        return 'BlueprintTitleRejectedException';
      case _i12.BlueprintValidationException():
        return 'BlueprintValidationException';
      case _i13.ContractScore():
        return 'ContractScore';
      case _i14.DailyContract():
        return 'DailyContract';
      case _i15.Defense():
        return 'Defense';
      case _i16.DefenseNotFoundException():
        return 'DefenseNotFoundException';
      case _i17.DefenseValidationException():
        return 'DefenseValidationException';
      case _i18.NotAuthenticatedException():
        return 'NotAuthenticatedException';
      case _i19.Player():
        return 'Player';
      case _i20.Purchase():
        return 'Purchase';
      case _i21.PurchaseState():
        return 'PurchaseState';
      case _i22.Season():
        return 'Season';
      case _i23.SeasonResult():
        return 'SeasonResult';
      case _i24.SimVersionMismatchException():
        return 'SimVersionMismatchException';
      case _i25.SkuNotFoundException():
        return 'SkuNotFoundException';
      case _i26.TelemetryEvent():
        return 'TelemetryEvent';
      case _i27.Unlock():
        return 'Unlock';
      case _i28.VirusPreset():
        return 'VirusPreset';
    }
    className = _i32.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i33.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'BattlePassProgress') {
      return deserialize<_i5.BattlePassProgress>(data['data']);
    }
    if (dataClassName == 'Blueprint') {
      return deserialize<_i6.Blueprint>(data['data']);
    }
    if (dataClassName == 'BlueprintModerationState') {
      return deserialize<_i7.BlueprintModerationState>(data['data']);
    }
    if (dataClassName == 'BlueprintNotFoundException') {
      return deserialize<_i8.BlueprintNotFoundException>(data['data']);
    }
    if (dataClassName == 'BlueprintNotRevealedException') {
      return deserialize<_i9.BlueprintNotRevealedException>(data['data']);
    }
    if (dataClassName == 'BlueprintReveal') {
      return deserialize<_i10.BlueprintReveal>(data['data']);
    }
    if (dataClassName == 'BlueprintTitleRejectedException') {
      return deserialize<_i11.BlueprintTitleRejectedException>(data['data']);
    }
    if (dataClassName == 'BlueprintValidationException') {
      return deserialize<_i12.BlueprintValidationException>(data['data']);
    }
    if (dataClassName == 'ContractScore') {
      return deserialize<_i13.ContractScore>(data['data']);
    }
    if (dataClassName == 'DailyContract') {
      return deserialize<_i14.DailyContract>(data['data']);
    }
    if (dataClassName == 'Defense') {
      return deserialize<_i15.Defense>(data['data']);
    }
    if (dataClassName == 'DefenseNotFoundException') {
      return deserialize<_i16.DefenseNotFoundException>(data['data']);
    }
    if (dataClassName == 'DefenseValidationException') {
      return deserialize<_i17.DefenseValidationException>(data['data']);
    }
    if (dataClassName == 'NotAuthenticatedException') {
      return deserialize<_i18.NotAuthenticatedException>(data['data']);
    }
    if (dataClassName == 'Player') {
      return deserialize<_i19.Player>(data['data']);
    }
    if (dataClassName == 'Purchase') {
      return deserialize<_i20.Purchase>(data['data']);
    }
    if (dataClassName == 'PurchaseState') {
      return deserialize<_i21.PurchaseState>(data['data']);
    }
    if (dataClassName == 'Season') {
      return deserialize<_i22.Season>(data['data']);
    }
    if (dataClassName == 'SeasonResult') {
      return deserialize<_i23.SeasonResult>(data['data']);
    }
    if (dataClassName == 'SimVersionMismatchException') {
      return deserialize<_i24.SimVersionMismatchException>(data['data']);
    }
    if (dataClassName == 'SkuNotFoundException') {
      return deserialize<_i25.SkuNotFoundException>(data['data']);
    }
    if (dataClassName == 'TelemetryEvent') {
      return deserialize<_i26.TelemetryEvent>(data['data']);
    }
    if (dataClassName == 'Unlock') {
      return deserialize<_i27.Unlock>(data['data']);
    }
    if (dataClassName == 'VirusPreset') {
      return deserialize<_i28.VirusPreset>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i32.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i33.Protocol().deserializeByClassName(data);
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
      return _i32.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i33.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
