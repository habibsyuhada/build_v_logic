import 'package:flutter/material.dart';

import '../../core/theme/payload_theme.dart';
import '../test_run_controller.dart';

/// Test Run debugger (§3.3): scrub the timeline, step tick-by-tick, and
/// inspect virus state (energy, memory flags) — the player's debugger for
/// their own logic.
class TestRunPanel extends StatelessWidget {
  final TestRunController controller;

  const TestRunPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        if (!controller.hasResult) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: Text('run a test to see results here', style: TextStyle(color: PayloadColors.textMuted)),
          );
        }
        final result = controller.log!.result;
        final snapshot = controller.snapshotAtCurrentTick;
        final eventsNow = controller.eventsAtCurrentTick;

        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('score: ${result.score}  ·  exfil: ${result.dataExfiltrated}'
                  '  ·  survived: ${result.survivingCopies}/${result.survivingCopies + result.deadCopies}',
                  key: const Key('test_run_summary')),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    key: const Key('step_back_button'),
                    icon: const Icon(Icons.skip_previous),
                    onPressed: controller.tick > 0 ? controller.stepBack : null,
                  ),
                  Expanded(
                    child: Slider(
                      key: const Key('timeline_scrubber'),
                      min: 0,
                      max: controller.maxTick.toDouble().clamp(0, double.infinity),
                      value: controller.tick.toDouble().clamp(0, controller.maxTick.toDouble()),
                      divisions: controller.maxTick > 0 ? controller.maxTick : null,
                      label: 'tick ${controller.tick}',
                      onChanged: (v) => controller.scrubTo(v.round()),
                    ),
                  ),
                  IconButton(
                    key: const Key('step_forward_button'),
                    icon: const Icon(Icons.skip_next),
                    onPressed: controller.tick < controller.maxTick ? controller.stepForward : null,
                  ),
                ],
              ),
              Text('tick ${controller.tick} / ${controller.maxTick}'),
              const Divider(),
              if (snapshot != null)
                for (final v in snapshot.virusCopies)
                  Text(
                    'virus#${v.virusId} @ ${v.position} — energy ${v.energy}'
                    '${v.alive ? '' : ' (dead)'} — carrying ${v.inventoryDataValue}'
                    ' — marks ${v.markedNodesCount} — counter ${v.counter}',
                    key: Key('virus_inspector_${v.virusId}'),
                    style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                  ),
              if (eventsNow.isNotEmpty) ...[
                const SizedBox(height: 6),
                const Text('events this tick:', style: TextStyle(color: PayloadColors.textMuted)),
                for (final e in eventsNow)
                  Text('  ${e.type} ${e.data}', style: const TextStyle(fontSize: 10)),
              ],
            ],
          ),
        );
      },
    );
  }
}
