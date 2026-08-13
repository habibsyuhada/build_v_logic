import 'package:content_schema/content_schema.dart';
import 'package:flutter/material.dart';

import '../../core/theme/payload_theme.dart';
import '../workbench_controller.dart';

/// Selected-node inspector: edit params, set as entry, start a connection,
/// or delete. All actions here have an on-canvas gesture equivalent too
/// (§3.3 "Semua gesture punya alternatif tombol") — this panel *is* that
/// alternative.
class InspectorPanel extends StatelessWidget {
  final WorkbenchController controller;
  final Map<String, BlockDef> catalog;

  const InspectorPanel({super.key, required this.controller, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final node = controller.selectedNodeId == null
            ? null
            : controller.nodeById(controller.selectedNodeId!);
        if (node == null) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: Text('select a block to inspect', style: TextStyle(color: PayloadColors.textMuted)),
          );
        }
        final block = catalog[node.blockId];
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(node.blockId,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: PayloadColors.textPrimary)),
              const SizedBox(height: 8),
              if (block != null)
                for (final p in block.paramsSchema)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: TextFormField(
                      key: Key('param_${node.id}_${p.name}'),
                      initialValue: node.params[p.name]?.toString() ?? '',
                      decoration: InputDecoration(labelText: p.name, isDense: true),
                      onChanged: (value) {
                        final parsed = p.type == 'int' ? int.tryParse(value) : value;
                        controller.updateParam(node.id, p.name, parsed);
                      },
                    ),
                  ),
              Wrap(
                spacing: 8,
                children: [
                  OutlinedButton(
                    key: const Key('set_entry_button'),
                    onPressed: () => controller.setEntry(node.id),
                    child: const Text('set as entry'),
                  ),
                  OutlinedButton(
                    key: const Key('connect_button'),
                    onPressed: () => controller.startConnect(node.id),
                    child: const Text('connect from here'),
                  ),
                  OutlinedButton(
                    key: const Key('delete_button'),
                    onPressed: () => controller.deleteNode(node.id),
                    child: const Text('delete'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
