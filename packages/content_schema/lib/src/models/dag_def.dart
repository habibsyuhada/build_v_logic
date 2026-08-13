/// DAG node as defined in PAYLOAD_PLAN.md §3.2: a block instance wired to
/// its successors. `out` maps a named branch (e.g. "true"/"false", or
/// "next" for actions/sequence) to the id of the next node. A branch with
/// no successor terminates that path for the tick.
class DagNode {
  final String id;
  final String blockId;
  final Map<String, dynamic> params;
  final Map<String, String> out;

  const DagNode({
    required this.id,
    required this.blockId,
    this.params = const {},
    this.out = const {},
  });

  factory DagNode.fromJson(Map<String, dynamic> json) {
    return DagNode(
      id: json['id'] as String,
      blockId: json['block_id'] as String,
      params: (json['params'] as Map?)?.cast<String, dynamic>() ?? const {},
      out: (json['out'] as Map?)?.cast<String, String>() ?? const {},
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'block_id': blockId,
        'params': params,
        'out': out,
      };
}

/// A full logic program: either a virus definition or a per-node defense
/// program. Both share the same DAG JSON shape (§3.2, §1.4).
class DagDef {
  final List<DagNode> nodes;
  final String entry;

  const DagDef({required this.nodes, required this.entry});

  factory DagDef.fromJson(Map<String, dynamic> json) {
    return DagDef(
      nodes: (json['nodes'] as List)
          .map((e) => DagNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      entry: json['entry'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'nodes': nodes.map((n) => n.toJson()).toList(),
        'entry': entry,
      };

  DagNode? nodeById(String id) {
    for (final n in nodes) {
      if (n.id == id) return n;
    }
    return null;
  }
}

/// A submitted virus build: the DAG program plus its declared size, used by
/// the workbench, the server validator, and `sim_core`.
class VirusDef {
  final String? name;
  final DagDef program;

  const VirusDef({this.name, required this.program});

  factory VirusDef.fromJson(Map<String, dynamic> json) {
    return VirusDef(
      name: json['name'] as String?,
      program: DagDef.fromJson(json['program'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        'program': program.toJson(),
      };
}
