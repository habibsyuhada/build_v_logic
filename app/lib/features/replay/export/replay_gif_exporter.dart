import 'dart:typed_data';
import 'dart:ui' show Offset;

import 'package:content_schema/content_schema.dart';
import 'package:image/image.dart' as img;
import 'package:sim_core/sim_core.dart';

import '../flame/network_layout.dart';
import '../flame/replay_frame.dart';

/// Offline replay video export (§1.7 "Replay bisa di-export sebagai video
/// pendek (render offline di client)"), rendered client-side with no
/// server round-trip. Encodes an animated GIF rather than an MP4 — Flutter
/// has no built-in video encoder and this sandbox has no `ffmpeg`
/// available to shell out to (see docs/DECISIONS.md) — but a GIF is
/// itself a legitimate short shareable clip for the TikTok/Shorts-style
/// hook §1.7 describes, and it's fully renderable and testable in pure
/// Dart with no platform channel. Reuses the exact same layout/frame
/// reconstruction (`computeNetworkLayout`/`computeReplayFrame`) the Flame
/// replay screen uses, and the same placeholder circle/line geometry
/// (§3 "Flame renderer uses placeholder geometric shapes" — see
/// docs/DECISIONS.md Phase 3) rather than pixel-art sprites.
class ReplayGifExporter {
  static const _background = 0xFF0A0E0C;
  static const _edgeColor = 0xFF3A4A40;
  static const _nodeColor = 0xFF1B241E;
  static const _virusColor = 0xFF39FF88;
  static const _deadVirusColor = 0xFFFF4D5E;

  /// Renders [log] against [network] as an animated GIF, sampling one
  /// frame every [tickStride] ticks. Returns the encoded GIF bytes.
  static Uint8List export({
    required NetworkDef network,
    required BattleLog log,
    int width = 480,
    int height = 320,
    int tickStride = 5,
    int frameDurationMs = 100,
  }) {
    final layout = computeNetworkLayout(network);
    final project = _projector(layout, width, height);

    final maxTick = log.result.ticksUsed;
    final ticks = <int>[for (var t = 0; t <= maxTick; t += tickStride) t];
    if (ticks.isEmpty || ticks.last != maxTick) ticks.add(maxTick);

    late final img.Image base;
    for (var i = 0; i < ticks.length; i++) {
      final frame = computeReplayFrame(log, ticks[i]);
      final canvas = i == 0
          ? (base = img.Image(width: width, height: height))
          : base.addFrame();
      canvas.frameDuration = frameDurationMs;
      _renderFrame(canvas, network: network, frame: frame, layout: layout, project: project);
    }

    return Uint8List.fromList(img.encodeGif(base));
  }

  static void _renderFrame(
    img.Image canvas, {
    required NetworkDef network,
    required ReplayFrame frame,
    required Map<String, Offset> layout,
    required (int, int) Function(Offset) project,
  }) {
    img.fill(canvas, color: _color(_background));

    for (final node in network.nodes) {
      final fromOffset = layout[node.id];
      if (fromOffset == null) continue;
      final from = project(fromOffset);
      for (final edgeId in node.edges) {
        final toOffset = layout[edgeId];
        if (toOffset == null) continue;
        final to = project(toOffset);
        img.drawLine(canvas,
            x1: from.$1, y1: from.$2, x2: to.$1, y2: to.$2, color: _color(_edgeColor));
      }
    }

    for (final node in network.nodes) {
      final nodeOffset = layout[node.id];
      if (nodeOffset == null) continue;
      final p = project(nodeOffset);
      img.fillCircle(canvas, x: p.$1, y: p.$2, radius: 10, color: _color(_nodeColor));
    }

    for (final entry in frame.virusPositions.entries) {
      final nodeOffset = layout[entry.value];
      if (nodeOffset == null) continue;
      final p = project(nodeOffset);
      final dead = frame.deadVirusIds.contains(entry.key);
      img.fillCircle(canvas,
          x: p.$1, y: p.$2, radius: 6, color: _color(dead ? _deadVirusColor : _virusColor));
    }
  }

  static img.ColorInt32 _color(int argb) => img.ColorInt32.rgb(
      (argb >> 16) & 0xFF, (argb >> 8) & 0xFF, argb & 0xFF);

  static (int, int) Function(Offset) _projector(
      Map<String, Offset> layout, int width, int height) {
    if (layout.isEmpty) return (offset) => (width ~/ 2, height ~/ 2);

    var minX = double.infinity, maxX = -double.infinity;
    var minY = double.infinity, maxY = -double.infinity;
    for (final o in layout.values) {
      if (o.dx < minX) minX = o.dx;
      if (o.dx > maxX) maxX = o.dx;
      if (o.dy < minY) minY = o.dy;
      if (o.dy > maxY) maxY = o.dy;
    }

    const margin = 30.0;
    final spanX = (maxX - minX).clamp(1.0, double.infinity);
    final spanY = (maxY - minY).clamp(1.0, double.infinity);
    final scaleX = (width - 2 * margin) / spanX;
    final scaleY = (height - 2 * margin) / spanY;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    return (offset) {
      final x = margin + (offset.dx - minX) * scale;
      final y = height / 2 + (offset.dy - (minY + maxY) / 2) * scale;
      return (x.round(), y.round());
    };
  }
}
