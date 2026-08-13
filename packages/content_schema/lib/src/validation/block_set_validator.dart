import '../models/block_def.dart';
import 'validation_result.dart';

/// Validates the full `content/blocks.json` catalog: uniqueness, sane
/// balance numbers. This is what `tools/content_lint` runs against the
/// authored file, and what the server re-validates before trusting a
/// deployed catalog.
ValidationResult validateBlockSet(List<BlockDef> blocks) {
  final errors = <String>[];
  final warnings = <String>[];

  if (blocks.isEmpty) {
    errors.add('blocks.json must define at least one block');
  }

  final seenIds = <String>{};
  for (final b in blocks) {
    if (b.id.isEmpty) {
      errors.add('block has empty id');
      continue;
    }
    if (!seenIds.add(b.id)) {
      errors.add('duplicate block id: ${b.id}');
    }
    if (b.sizeKb <= 0) {
      errors.add('${b.id}: size_kb must be > 0 (got ${b.sizeKb})');
    }
    if (b.energyCost < 0) {
      errors.add('${b.id}: energy_cost must be >= 0 (got ${b.energyCost})');
    }
    if (b.noise < 0) {
      errors.add('${b.id}: noise must be >= 0 (got ${b.noise})');
    }
    final paramNames = <String>{};
    for (final p in b.paramsSchema) {
      if (!paramNames.add(p.name)) {
        errors.add('${b.id}: duplicate param name ${p.name}');
      }
      if (!const ['int', 'string', 'bool'].contains(p.type)) {
        errors.add('${b.id}: param ${p.name} has unknown type ${p.type}');
      }
      if (p.min != null && p.max != null && p.min! > p.max!) {
        errors.add('${b.id}: param ${p.name} min > max');
      }
    }
    if (b.family == BlockFamily.action && b.energyCost == 0) {
      warnings.add(
          '${b.id}: action block with energy_cost 0 — intentional (e.g. wait)?');
    }
  }

  return ValidationResult(errors: errors, warnings: warnings);
}
