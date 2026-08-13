import 'package:content_schema/content_schema.dart';

/// A named, saved virus build (§2.4 `virus_presets`). Locally persisted in
/// Phase 2; Phase 4 adds server sync on top of the same shape.
class VirusPreset {
  final String id;
  final String name;
  final DagDef program;
  final DateTime updatedAt;

  const VirusPreset({
    required this.id,
    required this.name,
    required this.program,
    required this.updatedAt,
  });

  int sizeKb(Map<String, BlockDef> catalog) => program.nodes.fold<int>(
      0, (sum, n) => sum + (catalog[n.blockId]?.sizeKb ?? 0));

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'program': program.toJson(),
        'updated_at': updatedAt.toIso8601String(),
      };

  factory VirusPreset.fromJson(Map<String, dynamic> json) => VirusPreset(
        id: json['id'] as String,
        name: json['name'] as String,
        program: DagDef.fromJson(json['program'] as Map<String, dynamic>),
        updatedAt: DateTime.parse(json['updated_at'] as String),
      );

  VirusPreset copyWith({String? name, DagDef? program, DateTime? updatedAt}) => VirusPreset(
        id: id,
        name: name ?? this.name,
        program: program ?? this.program,
        updatedAt: updatedAt ?? this.updatedAt,
      );
}
