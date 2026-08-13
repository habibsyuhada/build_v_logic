/// Global balance knobs that aren't per-block (§1.3, §2.6 remote config).
/// Lives in content/balance.json — never hardcoded, so it can be hotfixed
/// without a client release.
class BalanceConfig {
  final int startingCapacityKb;
  final int maxCapacityKb;
  final int stealthSafeMaxKb;
  final int stealthAutoFlagMinKb;
  final int startingEnergy;
  final int noiseAlertThreshold;
  final int maxTicksPerBattle;
  final int maxEvalStepsPerTick;
  final int attackEnergyMax;
  final int attackEnergyRegenMinutes;
  final int trafficHighThreshold;
  final int maxVirusCopies;
  final int noiseDecayPerTick;
  final int scoreLogDeletedBonus;
  final int scoreCleanExitBonus;
  final int scoreDeadPenalty;
  final int scoreTickEfficiencyDivisor;

  const BalanceConfig({
    required this.startingCapacityKb,
    required this.maxCapacityKb,
    required this.stealthSafeMaxKb,
    required this.stealthAutoFlagMinKb,
    required this.startingEnergy,
    required this.noiseAlertThreshold,
    required this.maxTicksPerBattle,
    required this.maxEvalStepsPerTick,
    required this.attackEnergyMax,
    required this.attackEnergyRegenMinutes,
    required this.trafficHighThreshold,
    required this.maxVirusCopies,
    required this.noiseDecayPerTick,
    required this.scoreLogDeletedBonus,
    required this.scoreCleanExitBonus,
    required this.scoreDeadPenalty,
    required this.scoreTickEfficiencyDivisor,
  });

  factory BalanceConfig.fromJson(Map<String, dynamic> json) {
    return BalanceConfig(
      startingCapacityKb: json['starting_capacity_kb'] as int,
      maxCapacityKb: json['max_capacity_kb'] as int,
      stealthSafeMaxKb: json['stealth_safe_max_kb'] as int,
      stealthAutoFlagMinKb: json['stealth_auto_flag_min_kb'] as int,
      startingEnergy: json['starting_energy'] as int,
      noiseAlertThreshold: json['noise_alert_threshold'] as int,
      maxTicksPerBattle: json['max_ticks_per_battle'] as int,
      maxEvalStepsPerTick: json['max_eval_steps_per_tick'] as int,
      attackEnergyMax: json['attack_energy_max'] as int,
      attackEnergyRegenMinutes: json['attack_energy_regen_minutes'] as int,
      trafficHighThreshold: json['traffic_high_threshold'] as int,
      maxVirusCopies: json['max_virus_copies'] as int,
      noiseDecayPerTick: json['noise_decay_per_tick'] as int,
      scoreLogDeletedBonus: json['score_log_deleted_bonus'] as int,
      scoreCleanExitBonus: json['score_clean_exit_bonus'] as int,
      scoreDeadPenalty: json['score_dead_penalty'] as int,
      scoreTickEfficiencyDivisor: json['score_tick_efficiency_divisor'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'starting_capacity_kb': startingCapacityKb,
        'max_capacity_kb': maxCapacityKb,
        'stealth_safe_max_kb': stealthSafeMaxKb,
        'stealth_auto_flag_min_kb': stealthAutoFlagMinKb,
        'starting_energy': startingEnergy,
        'noise_alert_threshold': noiseAlertThreshold,
        'max_ticks_per_battle': maxTicksPerBattle,
        'max_eval_steps_per_tick': maxEvalStepsPerTick,
        'attack_energy_max': attackEnergyMax,
        'attack_energy_regen_minutes': attackEnergyRegenMinutes,
        'traffic_high_threshold': trafficHighThreshold,
        'max_virus_copies': maxVirusCopies,
        'noise_decay_per_tick': noiseDecayPerTick,
        'score_log_deleted_bonus': scoreLogDeletedBonus,
        'score_clean_exit_bonus': scoreCleanExitBonus,
        'score_dead_penalty': scoreDeadPenalty,
        'score_tick_efficiency_divisor': scoreTickEfficiencyDivisor,
      };

  /// Default values matching PAYLOAD_PLAN.md §1.3 / §3.2 exactly. Used as a
  /// fallback and as the seed for content/balance.json.
  static const BalanceConfig defaults = BalanceConfig(
    startingCapacityKb: 40,
    maxCapacityKb: 90,
    stealthSafeMaxKb: 25,
    stealthAutoFlagMinKb: 60,
    startingEnergy: 100,
    noiseAlertThreshold: 70,
    maxTicksPerBattle: 600,
    maxEvalStepsPerTick: 64,
    attackEnergyMax: 5,
    attackEnergyRegenMinutes: 30,
    trafficHighThreshold: 7,
    maxVirusCopies: 8,
    noiseDecayPerTick: 1,
    scoreLogDeletedBonus: 5,
    scoreCleanExitBonus: 20,
    scoreDeadPenalty: 15,
    scoreTickEfficiencyDivisor: 10,
  );
}
