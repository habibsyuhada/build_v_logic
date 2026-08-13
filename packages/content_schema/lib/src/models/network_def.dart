enum NodeType {
  entry,
  relay,
  data,
  core,
  honeypot,
  trap,
  firewallGate;

  static NodeType parse(String raw) {
    switch (raw) {
      case 'entry':
        return NodeType.entry;
      case 'relay':
        return NodeType.relay;
      case 'data':
        return NodeType.data;
      case 'core':
        return NodeType.core;
      case 'honeypot':
        return NodeType.honeypot;
      case 'trap':
        return NodeType.trap;
      case 'firewall_gate':
        return NodeType.firewallGate;
      default:
        throw FormatException('Unknown node type: $raw');
    }
  }

  String get wireName {
    switch (this) {
      case NodeType.entry:
        return 'entry';
      case NodeType.relay:
        return 'relay';
      case NodeType.data:
        return 'data';
      case NodeType.core:
        return 'core';
      case NodeType.honeypot:
        return 'honeypot';
      case NodeType.trap:
        return 'trap';
      case NodeType.firewallGate:
        return 'firewall_gate';
    }
  }
}

class FirewallDef {
  final int level;
  final List<String> exploitIds;

  const FirewallDef({this.level = 0, this.exploitIds = const []});

  factory FirewallDef.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const FirewallDef();
    return FirewallDef(
      level: (json['level'] as int?) ?? 0,
      exploitIds:
          ((json['exploit_ids'] as List?) ?? const []).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
        'level': level,
        'exploit_ids': exploitIds,
      };
}

class DataDef {
  final int value;
  final bool verified;

  const DataDef({this.value = 0, this.verified = false});

  factory DataDef.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const DataDef();
    return DataDef(
      value: (json['value'] as int?) ?? 0,
      verified: (json['verified'] as bool?) ?? false,
    );
  }

  Map<String, dynamic> toJson() => {'value': value, 'verified': verified};
}

/// A node in a network graph (§1.2). `defenseLogic` is an optional DAG
/// (parsed lazily by callers via [DagDef.fromJson]) so this package doesn't
/// need to know about DAG internals for validation purposes beyond shape.
class NetworkNodeDef {
  final String id;
  final NodeType type;
  final FirewallDef firewall;
  final DataDef data;
  final int trafficLevel;
  final bool logPresent;
  final List<String> avRoute;
  final Map<String, dynamic>? defenseLogic;
  final List<String> edges;

  const NetworkNodeDef({
    required this.id,
    required this.type,
    this.firewall = const FirewallDef(),
    this.data = const DataDef(),
    this.trafficLevel = 0,
    this.logPresent = false,
    this.avRoute = const [],
    this.defenseLogic,
    this.edges = const [],
  });

  factory NetworkNodeDef.fromJson(Map<String, dynamic> json) {
    return NetworkNodeDef(
      id: json['id'] as String,
      type: NodeType.parse(json['type'] as String),
      firewall: FirewallDef.fromJson(json['firewall'] as Map<String, dynamic>?),
      data: DataDef.fromJson(json['data'] as Map<String, dynamic>?),
      trafficLevel: (json['traffic_level'] as int?) ?? 0,
      logPresent: (json['log_present'] as bool?) ?? false,
      avRoute: ((json['av_route'] as List?) ?? const []).cast<String>(),
      defenseLogic: json['defense_logic'] as Map<String, dynamic>?,
      edges: ((json['edges'] as List?) ?? const []).cast<String>(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.wireName,
        'firewall': firewall.toJson(),
        'data': data.toJson(),
        'traffic_level': trafficLevel,
        'log_present': logPresent,
        'av_route': avRoute,
        if (defenseLogic != null) 'defense_logic': defenseLogic,
        'edges': edges,
      };
}

/// A full network graph: 8-40 nodes, directed edges (§1.2).
class NetworkDef {
  final String id;
  final List<NetworkNodeDef> nodes;

  const NetworkDef({required this.id, required this.nodes});

  factory NetworkDef.fromJson(Map<String, dynamic> json) {
    return NetworkDef(
      id: json['id'] as String,
      nodes: (json['nodes'] as List)
          .map((e) => NetworkNodeDef.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nodes': nodes.map((n) => n.toJson()).toList(),
      };

  NetworkNodeDef? nodeById(String id) {
    for (final n in nodes) {
      if (n.id == id) return n;
    }
    return null;
  }
}
