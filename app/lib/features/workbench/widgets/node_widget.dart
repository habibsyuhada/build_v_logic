import 'package:content_schema/content_schema.dart';
import 'package:flutter/material.dart';

import '../../core/theme/payload_theme.dart';
import '../workbench_controller.dart';
import 'block_tray.dart';

class NodeWidget extends StatelessWidget {
  final EditorNode node;
  final BlockDef? blockDef;
  final bool isEntry;
  final bool isSelected;
  final bool isConnectSource;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final void Function(Offset delta) onDrag;

  const NodeWidget({
    super.key,
    required this.node,
    required this.blockDef,
    required this.isEntry,
    required this.isSelected,
    required this.isConnectSource,
    required this.onTap,
    required this.onLongPress,
    required this.onDrag,
  });

  @override
  Widget build(BuildContext context) {
    final color = blockDef == null ? PayloadColors.dangerRed : colorForFamily(blockDef!.family);
    return Positioned(
      left: node.position.dx,
      top: node.position.dy,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        onPanUpdate: (details) => onDrag(details.delta),
        child: Container(
          key: Key('node_${node.id}'),
          width: 120,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: PayloadColors.surfaceRaised,
            border: Border.all(
              color: isConnectSource
                  ? PayloadColors.warningAmber
                  : isSelected
                      ? PayloadColors.terminalGreen
                      : color,
              width: isSelected || isConnectSource ? 2.5 : 1.5,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(width: 8, height: 8, color: color),
                  const SizedBox(width: 4),
                  if (isEntry) const Icon(Icons.flag, size: 12, color: PayloadColors.terminalGreen),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                node.blockId,
                style: const TextStyle(fontSize: 11, color: PayloadColors.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
              if (node.out.isNotEmpty)
                Text(
                  node.out.entries.map((e) => '${e.key}→${e.value}').join(', '),
                  style: const TextStyle(fontSize: 9, color: PayloadColors.textMuted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
