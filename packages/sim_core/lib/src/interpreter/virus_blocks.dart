import '../model/sim_state.dart';
import 'virus_ctx.dart';

typedef VirusSensorFn = bool Function(VirusCtx ctx, Map<String, dynamic> params);
typedef VirusActionFn = void Function(VirusCtx ctx, Map<String, dynamic> params);

int _intParam(Map<String, dynamic> params, String name, [int fallback = 0]) {
  final v = params[name];
  return v is int ? v : fallback;
}

String? _bfsStepTowards(
    VirusCtx ctx, bool Function(NodeRuntime) isGoal, {bool excludeCurrent = true}) {
  final start = ctx.virus.position;
  if (!excludeCurrent) {
    final startNode = ctx.state.nodes[start];
    if (startNode != null && isGoal(startNode)) return null;
  }
  final visited = <String, String?>{start: null};
  final queue = <String>[start];
  while (queue.isNotEmpty) {
    final current = queue.removeAt(0);
    final node = ctx.state.nodes[current];
    if (node == null) continue;
    if (current != start && isGoal(node)) {
      var step = current;
      while (visited[step] != start) {
        step = visited[step]!;
      }
      return step;
    }
    for (final next in node.edges) {
      if (!ctx.virus.knownNodes.contains(next)) continue;
      if (visited.containsKey(next)) continue;
      visited[next] = current;
      queue.add(next);
    }
  }
  return null;
}

void _moveTo(VirusCtx ctx, String nodeId) {
  ctx.virus.pathHistory.add(ctx.virus.position);
  ctx.virus.position = nodeId;
  ctx.virus.visitedNodes.add(nodeId);
  ctx.revealFromCurrentNode();
  ctx.emit('virus_moved', {'virus_id': ctx.virus.id, 'node_id': nodeId});
}

/// §1.3 sensor family + memory sensor-like blocks (evaluate, don't mutate).
final Map<String, VirusSensorFn> virusSensorRegistry = {
  'firewall_detected': (ctx, p) => ctx.here.firewallLevel > 0,
  'firewall_level_gt': (ctx, p) => ctx.here.firewallLevel > _intParam(p, 'x'),
  'firewall_has_exploit': (ctx, p) =>
      ctx.here.exploitIds.contains(p['id'] as String? ?? ''),
  'antivirus_here': (ctx, p) => ctx.here.avRoute.isNotEmpty &&
      ctx.here.avRoute[ctx.here.avRouteIndex % ctx.here.avRoute.length] ==
          ctx.virus.position,
  'antivirus_nearby': (ctx, p) {
    if (ctx.here.avRoute.isEmpty) return false;
    final avNode = ctx.here.avRoute[ctx.here.avRouteIndex % ctx.here.avRoute.length];
    return ctx.here.edges.contains(avNode) || avNode == ctx.virus.position;
  },
  'node_has_data': (ctx, p) => ctx.here.hasData,
  'data_verified': (ctx, p) => ctx.here.dataVerified && !ctx.here.dataIsFake,
  'traffic_high': (ctx, p) => ctx.here.trafficLevel >= ctx.balance.trafficHighThreshold,
  'energy_below': (ctx, p) {
    final pct = _intParam(p, 'x', 0).clamp(0, 100);
    return ctx.virus.energy < (ctx.balance.startingEnergy * pct) ~/ 100;
  },
  'node_visited_before': (ctx, p) => ctx.virus.visitedNodes.contains(ctx.virus.position) &&
      ctx.virus.pathHistory.contains(ctx.virus.position),
  'alarm_active': (ctx, p) => ctx.state.isAlarmActive(ctx.balance.noiseAlertThreshold),
  'carrying_data': (ctx, p) => ctx.virus.inventoryDataValue > 0,
  'at_entry_node': (ctx, p) => ctx.here.type.wireName == 'entry',
  'random_chance': (ctx, p) => ctx.rng.chancePercent(_intParam(p, 'x', 0)),
  'tick_gt': (ctx, p) => ctx.tick > _intParam(p, 'x'),
  'copies_alive_gt': (ctx, p) => ctx.state.aliveCopies.length > _intParam(p, 'x'),

  // memory sensor-like
  'node_marked': (ctx, p) => ctx.virus.markedNodes.contains(ctx.virus.position),
  'counter_gt': (ctx, p) => ctx.virus.counter > _intParam(p, 'x'),
  'timer_after': (ctx, p) => (ctx.tick - ctx.virus.spawnTick) >= _intParam(p, 'x', 1),
};

/// §1.3 action family + memory action-like blocks.
final Map<String, VirusActionFn> virusActionRegistry = {
  'move_random': (ctx, p) {
    if (ctx.here.lockedDown) return;
    final edges = ctx.here.edges;
    if (edges.isEmpty) return;
    final next = edges[ctx.rng.nextInt(edges.length)];
    _moveTo(ctx, next);
  },
  'move_toward_data': (ctx, p) {
    if (ctx.here.lockedDown) return;
    final step = _bfsStepTowards(ctx, (n) => n.hasData);
    if (step != null) {
      _moveTo(ctx, step);
    } else if (ctx.here.edges.isNotEmpty) {
      _moveTo(ctx, ctx.here.edges[ctx.rng.nextInt(ctx.here.edges.length)]);
    }
  },
  'move_toward_exit': (ctx, p) {
    if (ctx.here.lockedDown) return;
    final step = _bfsStepTowards(ctx, (n) => n.type.wireName == 'entry');
    if (step != null) {
      _moveTo(ctx, step);
    } else if (ctx.here.edges.isNotEmpty) {
      _moveTo(ctx, ctx.here.edges[ctx.rng.nextInt(ctx.here.edges.length)]);
    }
  },
  'move_back': (ctx, p) {
    if (ctx.here.lockedDown) return;
    if (ctx.virus.pathHistory.isEmpty) return;
    final prev = ctx.virus.pathHistory.removeLast();
    ctx.virus.position = prev;
    ctx.revealFromCurrentNode();
    ctx.emit('virus_moved', {'virus_id': ctx.virus.id, 'node_id': prev});
  },
  'brute_force': (ctx, p) {
    if (ctx.here.firewallLevel > 0) {
      ctx.here.firewallLevel -= 1;
    }
    ctx.emit('brute_force', {'virus_id': ctx.virus.id, 'node_id': ctx.virus.position});
  },
  'exploit': (ctx, p) {
    final exploitId = p['id'] as String? ?? '';
    final success = ctx.here.exploitIds.contains(exploitId);
    if (success) {
      ctx.here.firewallLevel = 0;
    }
    ctx.emit('exploit_attempt', {
      'virus_id': ctx.virus.id,
      'node_id': ctx.virus.position,
      'exploit_id': exploitId,
      'success': success,
    });
  },
  'disguise': (ctx, p) {
    ctx.virus.disguisedUntilTick = ctx.tick + 3;
    ctx.emit('virus_disguised', {'virus_id': ctx.virus.id});
  },
  'copy_data': (ctx, p) {
    if (ctx.here.hasData) {
      final value = ctx.here.dataIsFake ? 0 : ctx.here.dataValue;
      ctx.virus.inventoryDataValue += value;
      ctx.emit('data_copied', {
        'virus_id': ctx.virus.id,
        'node_id': ctx.virus.position,
        'value': value,
      });
    }
  },
  'delete_log': (ctx, p) {
    if (ctx.here.logPresent) {
      ctx.here.logPresent = false;
      ctx.state.logsDeletedCount += 1;
      ctx.emit('log_deleted', {'virus_id': ctx.virus.id, 'node_id': ctx.virus.position});
    }
  },
  'plant_backdoor': (ctx, p) {
    ctx.emit('backdoor_planted', {'virus_id': ctx.virus.id, 'node_id': ctx.virus.position});
  },
  'replicate': (ctx, p) {
    if (ctx.state.virusCopies.length >= ctx.balance.maxVirusCopies) return;
    final share = ctx.virus.energy ~/ 2;
    ctx.virus.energy -= share;
    final copy = VirusRuntime(
      id: ctx.state.nextVirusId++,
      spawnTick: ctx.tick,
      position: ctx.virus.position,
      energy: share,
    );
    ctx.state.virusCopies.add(copy);
    ctx.emit('virus_replicated', {
      'parent_id': ctx.virus.id,
      'child_id': copy.id,
      'node_id': ctx.virus.position,
    });
  },
  'self_destruct': (ctx, p) {
    ctx.virus.alive = false;
    ctx.virus.energy = 0;
    ctx.emit('virus_died', {
      'virus_id': ctx.virus.id,
      'node_id': ctx.virus.position,
      'cause': 'self_destruct',
    });
  },
  'wait': (ctx, p) {},

  // memory action-like
  'mark_node': (ctx, p) => ctx.virus.markedNodes.add(ctx.virus.position),
  'counter_inc': (ctx, p) => ctx.virus.counter += 1,
};
