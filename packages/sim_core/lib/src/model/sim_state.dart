import 'package:content_schema/content_schema.dart';

/// Mutable runtime state of a single network node during a battle.
/// Starts from a [NetworkNodeDef] snapshot and evolves as the battle runs.
class NodeRuntime {
  final String id;
  final NodeType type;
  final List<String> edges;

  int firewallLevel;
  final Set<String> exploitIds;
  int dataValue;
  bool dataVerified;
  bool dataIsFake; // set by fake_data_swap
  int trafficLevel;
  bool logPresent;
  final List<String> avRoute;
  int avRouteIndex;
  bool lockedDown;

  NodeRuntime({
    required this.id,
    required this.type,
    required this.edges,
    required this.firewallLevel,
    required this.exploitIds,
    required this.dataValue,
    required this.dataVerified,
    required this.trafficLevel,
    required this.logPresent,
    required this.avRoute,
    this.dataIsFake = false,
    this.avRouteIndex = 0,
    this.lockedDown = false,
  });

  factory NodeRuntime.fromDef(NetworkNodeDef def) {
    return NodeRuntime(
      id: def.id,
      type: def.type,
      edges: List.of(def.edges),
      firewallLevel: def.firewall.level,
      exploitIds: def.firewall.exploitIds.toSet(),
      dataValue: def.data.value,
      dataVerified: def.data.verified,
      trafficLevel: def.trafficLevel,
      logPresent: def.logPresent,
      avRoute: List.of(def.avRoute),
    );
  }

  bool get hasData => dataValue > 0;
}

/// Mutable runtime state of one virus copy (§1.2). `programId` refers to
/// the shared [DagDef] all copies of one submitted virus execute (per §3.1
/// tick order: "tiap virus copy berdasarkan urutan spawn").
class VirusRuntime {
  final int id;
  final int spawnTick;
  String position;
  int energy;
  bool alive;
  int inventoryDataValue;
  int counter;
  int disguisedUntilTick;
  final Set<String> markedNodes = {};
  final Set<String> visitedNodes = {};
  final Set<String> knownNodes = {};
  final List<String> pathHistory = [];
  String? lastActionBlockId;

  VirusRuntime({
    required this.id,
    required this.spawnTick,
    required this.position,
    required this.energy,
  })  : alive = true,
        inventoryDataValue = 0,
        counter = 0,
        disguisedUntilTick = -1 {
    visitedNodes.add(position);
    knownNodes.add(position);
  }

  bool isDisguisedAt(int tick) => tick <= disguisedUntilTick;
}

/// Full mutable battle state for one `resolve()` call. Never shared across
/// battles/threads — a fresh instance is built per resolve so the function
/// stays pure from the caller's point of view (§3.1).
class SimState {
  int tick = 0;
  int noiseMeter = 0;
  final Map<String, NodeRuntime> nodes;
  final List<VirusRuntime> virusCopies = [];
  int tracePenalty = 0;
  int nextVirusId = 0;
  int dataExfiltrated = 0;
  int logsDeletedCount = 0;
  int cleanExitCount = 0;

  SimState({required this.nodes});

  bool isAlarmActive(int threshold) => noiseMeter >= threshold;

  Iterable<VirusRuntime> get aliveCopies => virusCopies.where((v) => v.alive);

  NodeRuntime? nodeAt(String id) => nodes[id];

  void addNoise(int amount) {
    noiseMeter = (noiseMeter + amount).clamp(0, 100);
  }

  void decayNoise(int amount) {
    noiseMeter = (noiseMeter - amount).clamp(0, 100);
  }
}
