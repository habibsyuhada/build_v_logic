import 'package:content_schema/content_schema.dart';
import 'package:flutter/material.dart';

import '../branch_options.dart';
import '../workbench_controller.dart';
import 'node_widget.dart';

/// The touch-first node-graph canvas (§3.3): pinch-zoom/pan via
/// [InteractiveViewer], drag to reposition, tap-to-connect (the
/// accessible alternative to a drag-a-rope connector), long-press to
/// delete.
class WorkbenchCanvas extends StatelessWidget {
  final WorkbenchController controller;
  final Map<String, BlockDef> catalog;

  const WorkbenchCanvas({super.key, required this.controller, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        return InteractiveViewer(
          minScale: 0.4,
          maxScale: 2.5,
          constrained: false,
          boundaryMargin: const EdgeInsets.all(400),
          child: SizedBox(
            width: 1600,
            height: 1200,
            child: Stack(
              children: [
                for (final node in controller.nodes)
                  NodeWidget(
                    node: node,
                    blockDef: catalog[node.blockId],
                    isEntry: node.id == controller.entryNodeId,
                    isSelected: node.id == controller.selectedNodeId,
                    isConnectSource: node.id == controller.connectFromNodeId,
                    onDrag: (delta) => controller.moveNode(
                        node.id, node.position.translate(delta.dx, delta.dy)),
                    onTap: () => _handleTap(context, node),
                    onLongPress: () => _confirmDelete(context, node.id),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleTap(BuildContext context, EditorNode node) {
    if (controller.connectFromNodeId != null) {
      if (controller.connectFromNodeId == node.id) {
        controller.cancelConnect();
        return;
      }
      _pickBranchAndConnect(context, node.id);
      return;
    }
    controller.selectNode(node.id);
  }

  Future<void> _pickBranchAndConnect(BuildContext context, String toId) async {
    final fromId = controller.connectFromNodeId!;
    final fromBlockId = controller.nodeById(fromId)?.blockId;
    if (fromBlockId == null) return;
    final options = branchOptionsFor(fromBlockId);
    final branch = options.length == 1
        ? options.first
        : await showDialog<String>(
            context: context,
            builder: (context) => SimpleDialog(
              title: const Text('connect via branch'),
              children: [
                for (final option in options)
                  SimpleDialogOption(
                    onPressed: () => Navigator.of(context).pop(option),
                    child: Text(option),
                  ),
              ],
            ),
          );
    if (branch != null) {
      controller.completeConnect(toId, branch: branch);
    } else {
      controller.cancelConnect();
    }
  }

  Future<void> _confirmDelete(BuildContext context, String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('delete block?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('cancel')),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('delete')),
        ],
      ),
    );
    if (confirmed == true) controller.deleteNode(id);
  }
}
