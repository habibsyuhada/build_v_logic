import '../models/mission_def.dart';
import 'validation_result.dart';

/// Validates a single mission definition (§1.5): chapter/index bounds and
/// sane star thresholds. Cross-mission checks (60 missions total, unique
/// ids) are done by [validateMissionSet].
ValidationResult validateMission(MissionDef mission) {
  final errors = <String>[];

  if (mission.chapter < 1 || mission.chapter > 6) {
    errors.add('mission ${mission.id}: chapter must be 1-6');
  }
  if (mission.indexInChapter < 1 || mission.indexInChapter > 10) {
    errors.add('mission ${mission.id}: index_in_chapter must be 1-10');
  }
  if (mission.starCriteria.maxNoiseForStar < 0) {
    errors.add('mission ${mission.id}: max_noise_for_star must be >= 0');
  }
  if (mission.starCriteria.maxTickForStar <= 0) {
    errors.add('mission ${mission.id}: max_tick_for_star must be > 0');
  }

  return ValidationResult(errors: errors);
}

ValidationResult validateMissionSet(List<MissionDef> missions) {
  final errors = <String>[];
  final warnings = <String>[];
  var result = const ValidationResult();
  final seenIds = <String>{};
  final seenSlots = <String>{};

  for (final m in missions) {
    result = result.merge(validateMission(m));
    if (!seenIds.add(m.id)) {
      errors.add('duplicate mission id: ${m.id}');
    }
    final slot = '${m.chapter}.${m.indexInChapter}';
    if (!seenSlots.add(slot)) {
      errors.add('duplicate mission slot chapter/index: $slot');
    }
  }

  if (missions.length != 60) {
    warnings.add(
        'mission set has ${missions.length} missions, release target is 60 (§1.5)');
  }

  return result.merge(ValidationResult(errors: errors, warnings: warnings));
}
