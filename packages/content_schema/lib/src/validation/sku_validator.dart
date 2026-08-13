import '../models/sku_def.dart';
import 'validation_result.dart';

ValidationResult validateSkuSet(List<SkuDef> skus) {
  final errors = <String>[];
  final seenIds = <String>{};

  for (final s in skus) {
    if (!seenIds.add(s.id)) {
      errors.add('duplicate sku id: ${s.id}');
    }
    if (s.priceUsdCents <= 0) {
      errors.add('${s.id}: price_usd_cents must be > 0');
    }
    if (s.type == SkuType.keysPack && (s.keysAmount == null || s.keysAmount! <= 0)) {
      errors.add('${s.id}: keys_pack must have a positive keys_amount');
    }
  }

  return ValidationResult(errors: errors);
}
