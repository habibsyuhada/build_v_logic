import 'package:content_schema/content_schema.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:sim_core/sim_core.dart';

import '../core/theme/payload_theme.dart';
import 'flame/replay_game.dart';
import 'replay_playback_controller.dart';

/// Replay playback screen (§3.4): Flame world + play/pause/speed/scrub
/// controls and a result banner once the battle is over.
class ReplayScreen extends StatefulWidget {
  final NetworkDef network;
  final BattleLog log;

  const ReplayScreen({super.key, required this.network, required this.log});

  @override
  State<ReplayScreen> createState() => _ReplayScreenState();
}

class _ReplayScreenState extends State<ReplayScreen> {
  late final ReplayPlaybackController _controller;
  late final ReplayGame _game;

  @override
  void initState() {
    super.initState();
    _controller = ReplayPlaybackController(widget.log);
    _game = ReplayGame(network: widget.network, controller: _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PayloadColors.background,
      appBar: AppBar(title: const Text('replay')),
      body: Column(
        children: [
          Expanded(child: GameWidget(game: _game, key: const Key('replay_game_widget'))),
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) => _ReplayControls(controller: _controller),
          ),
        ],
      ),
    );
  }
}

class _ReplayControls extends StatelessWidget {
  final ReplayPlaybackController controller;
  const _ReplayControls({required this.controller});

  @override
  Widget build(BuildContext context) {
    final result = controller.log.result;
    return Container(
      color: PayloadColors.surface,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              IconButton(
                key: const Key('replay_play_pause_button'),
                icon: Icon(controller.isPlaying ? Icons.pause : Icons.play_arrow),
                onPressed: controller.togglePlayPause,
              ),
              Expanded(
                child: Slider(
                  key: const Key('replay_scrubber'),
                  min: 0,
                  max: controller.maxTick.toDouble().clamp(0, double.infinity),
                  value: controller.currentTick.toDouble().clamp(0, controller.maxTick.toDouble()),
                  onChanged: (v) => controller.seekTo(v.round()),
                ),
              ),
              for (final s in [1.0, 2.0, 4.0])
                TextButton(
                  key: Key('replay_speed_${s.toInt()}x'),
                  onPressed: () => controller.setSpeed(s),
                  style: TextButton.styleFrom(
                    foregroundColor:
                        controller.speed == s ? PayloadColors.terminalGreen : PayloadColors.textMuted,
                  ),
                  child: Text('${s.toInt()}x'),
                ),
              IconButton(
                key: const Key('replay_skip_to_result_button'),
                icon: const Icon(Icons.skip_next),
                tooltip: 'skip to result',
                onPressed: controller.skipToResult,
              ),
            ],
          ),
          Text('tick ${controller.currentTick} / ${controller.maxTick}',
              style: const TextStyle(color: PayloadColors.textMuted)),
          if (controller.currentTick >= controller.maxTick)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'score: ${result.score}  ·  exfil: ${result.dataExfiltrated}  ·  '
                'survived: ${result.survivingCopies}',
                key: const Key('replay_result_banner'),
                style: const TextStyle(color: PayloadColors.terminalGreen, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
