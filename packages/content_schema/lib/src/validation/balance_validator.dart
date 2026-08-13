import '../models/balance_config.dart';
import 'validation_result.dart';

ValidationResult validateBalanceConfig(BalanceConfig config) {
  final errors = <String>[];

  if (config.startingCapacityKb <= 0) {
    errors.add('starting_capacity_kb must be > 0');
  }
  if (config.maxCapacityKb < config.startingCapacityKb) {
    errors.add('max_capacity_kb must be >= starting_capacity_kb');
  }
  if (config.stealthSafeMaxKb <= 0 ||
      config.stealthSafeMaxKb >= config.stealthAutoFlagMinKb) {
    errors.add('stealth_safe_max_kb must be > 0 and < stealth_auto_flag_min_kb');
  }
  if (config.stealthAutoFlagMinKb > config.maxCapacityKb) {
    errors.add('stealth_auto_flag_min_kb must be <= max_capacity_kb');
  }
  if (config.startingEnergy <= 0) {
    errors.add('starting_energy must be > 0');
  }
  if (config.noiseAlertThreshold <= 0) {
    errors.add('noise_alert_threshold must be > 0');
  }
  if (config.maxTicksPerBattle != 600) {
    errors.add('max_ticks_per_battle must be 600 per §1.2 hard cap');
  }
  if (config.maxEvalStepsPerTick != 64) {
    errors.add('max_eval_steps_per_tick must be 64 per §3.2 hard cap');
  }
  if (config.attackEnergyMax <= 0) {
    errors.add('attack_energy_max must be > 0');
  }
  if (config.attackEnergyRegenMinutes <= 0) {
    errors.add('attack_energy_regen_minutes must be > 0');
  }

  return ValidationResult(errors: errors);
}
