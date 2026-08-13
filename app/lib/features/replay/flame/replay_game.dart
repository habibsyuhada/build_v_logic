import 'dart:ui' hide TextStyle;

import 'package:content_schema/content_schema.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart' show TextStyle;

import '../replay_playback_controller.dart';
import 'network_layout.dart';
import 'replay_frame.dart';

Color _colorForNodeType(NodeType type) {
  switch (type) {
    case NodeType.entry:
      return const Color(0xFF39FF88);
    case NodeType.data:
      return const Color(0xFF2FE8FF);
    case NodeType.core:
      return const Color(0xFFFF2FB0);
    case NodeType.honeypot:
      return const Color(0xFFFFC145);
    case NodeType.trap:
      return const Color(0xFFFF4D5E);
    case NodeType.relay:
    case NodeType.firewallGate:
      return const Color(0xFF7FA98F);
  }
}

class _NodeComponent extends PositionComponent {
  final NetworkNodeDef node;
  _NodeComponent(this.node, Vector2 pos) : super(position: pos, anchor: Anchor.center, size: Vector2.all(36));

  @override
  Future<void> onLoad() async {
    add(CircleComponent(
      radius: 18,
      paint: Paint()..color = _colorForNodeType(node.type),
      anchor: Anchor.center,
      position: size / 2,
    ));
    add(TextComponent(
      text: node.id,
      position: Vector2(size.x / 2, size.y + 4),
      anchor: Anchor.topCenter,
      textRenderer: TextPaint(style: const TextStyle(color: Color(0xFFE6FBEF), fontSize: 10)),
    ));
  }
}

class _VirusComponent extends PositionComponent {
  final int virusId;
  _VirusComponent(this.virusId, Vector2 pos)
      : super(position: pos, anchor: Anchor.center, size: Vector2.all(14));

  @override
  Future<void> onLoad() async {
    add(CircleComponent(
      radius: 7,
      paint: Paint()..color = const Color(0xFFFF2FB0),
      anchor: Anchor.center,
      position: size / 2,
    ));
  }
}

/// Replay world (§3.4): network drawn as a circuit map, virus positions
/// reconstructed from the event log every frame and animated toward their
/// target node. Placeholder geometric shapes stand in for pixel-art sprites
/// (§1.8) — no art asset pipeline exists yet; see docs/DECISIONS.md.
class ReplayGame extends FlameGame {
  final NetworkDef network;
  final ReplayPlaybackController controller;

  late Map<String, Vector2> _nodeWorldPositions;
  final Map<String, _NodeComponent> _nodeComponents = {};
  final Map<int, _VirusComponent> _virusComponents = {};
  int _lastRenderedTick = -1;

  ReplayGame({required this.network, required this.controller});

  @override
  Future<void> onLoad() async {
    final layout = computeNetworkLayout(network);
    const margin = 80.0;
    final xs = layout.values.map((o) => o.dx);
    final ys = layout.values.map((o) => o.dy);
    final minX = xs.isEmpty ? 0.0 : xs.reduce((a, b) => a < b ? a : b);
    final minY = ys.isEmpty ? 0.0 : ys.reduce((a, b) => a < b ? a : b);

    _nodeWorldPositions = {
      for (final entry in layout.entries)
        entry.key: Vector2(entry.value.dx - minX + margin, entry.value.dy - minY + margin),
    };

    for (final node in network.nodes) {
      final pos = _nodeWorldPositions[node.id];
      if (pos == null) continue;
      final component = _NodeComponent(node, pos);
      _nodeComponents[node.id] = component;
      add(component);
    }

    controller.addListener(_syncViruses);
    _syncViruses();
  }

  void _syncViruses() {
    final frame = computeReplayFrame(controller.log, controller.currentTick);
    if (controller.currentTick == _lastRenderedTick) return;
    _lastRenderedTick = controller.currentTick;

    for (final id in frame.deadVirusIds) {
      final c = _virusComponents.remove(id);
      if (c != null) c.removeFromParent();
    }

    for (final entry in frame.virusPositions.entries) {
      if (frame.deadVirusIds.contains(entry.key)) continue;
      final targetPos = _nodeWorldPositions[entry.value];
      if (targetPos == null) continue;
      final existing = _virusComponents[entry.key];
      if (existing == null) {
        final component = _VirusComponent(entry.key, targetPos.clone());
        _virusComponents[entry.key] = component;
        add(component);
      } else {
        existing.position = targetPos.clone();
      }
    }
  }

  @override
  void onRemove() {
    controller.removeListener(_syncViruses);
    super.onRemove();
  }
}
