/// Family a block belongs to, mirrors PAYLOAD_PLAN.md §1.3.
enum BlockFamily {
  sensor,
  action,
  controlFlow,
  memory,
  defenseSensor,
  defenseAction;

  static BlockFamily parse(String raw) {
    switch (raw) {
      case 'sensor':
        return BlockFamily.sensor;
      case 'action':
        return BlockFamily.action;
      case 'control_flow':
        return BlockFamily.controlFlow;
      case 'memory':
        return BlockFamily.memory;
      case 'defense_sensor':
        return BlockFamily.defenseSensor;
      case 'defense_action':
        return BlockFamily.defenseAction;
      default:
        throw FormatException('Unknown block family: $raw');
    }
  }

  String get wireName {
    switch (this) {
      case BlockFamily.sensor:
        return 'sensor';
      case BlockFamily.action:
        return 'action';
      case BlockFamily.controlFlow:
        return 'control_flow';
      case BlockFamily.memory:
        return 'memory';
      case BlockFamily.defenseSensor:
        return 'defense_sensor';
      case BlockFamily.defenseAction:
        return 'defense_action';
    }
  }
}

/// Declares the shape of a single named parameter a block accepts.
class ParamSchema {
  final String name;
  final String type; // 'int' | 'string' | 'bool'
  final int? min;
  final int? max;

  const ParamSchema({
    required this.name,
    required this.type,
    this.min,
    this.max,
  });

  factory ParamSchema.fromJson(Map<String, dynamic> json) {
    return ParamSchema(
      name: json['name'] as String,
      type: json['type'] as String,
      min: json['min'] as int?,
      max: json['max'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        if (min != null) 'min': min,
        if (max != null) 'max': max,
      };
}

/// A single logic block definition as authored in content/blocks.json.
///
/// All balance numbers (cost/energy/noise) live here, never hardcoded in
/// `sim_core`, per PAYLOAD_PLAN.md §1.3 and §7.
class BlockDef {
  final String id;
  final BlockFamily family;
  final int sizeKb;
  final int energyCost;
  final int noise;
  final List<ParamSchema> paramsSchema;
  final String? unlockMission;

  const BlockDef({
    required this.id,
    required this.family,
    required this.sizeKb,
    this.energyCost = 0,
    this.noise = 0,
    this.paramsSchema = const [],
    this.unlockMission,
  });

  factory BlockDef.fromJson(Map<String, dynamic> json) {
    return BlockDef(
      id: json['id'] as String,
      family: BlockFamily.parse(json['family'] as String),
      sizeKb: json['size_kb'] as int,
      energyCost: (json['energy_cost'] as int?) ?? 0,
      noise: (json['noise'] as int?) ?? 0,
      paramsSchema: ((json['params_schema'] as List?) ?? const [])
          .map((e) => ParamSchema.fromJson(e as Map<String, dynamic>))
          .toList(),
      unlockMission: json['unlock_mission'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'family': family.wireName,
        'size_kb': sizeKb,
        'energy_cost': energyCost,
        'noise': noise,
        'params_schema': paramsSchema.map((p) => p.toJson()).toList(),
        if (unlockMission != null) 'unlock_mission': unlockMission,
      };
}
