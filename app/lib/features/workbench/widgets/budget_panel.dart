import 'package:flutter/material.dart';

import '../../core/theme/payload_theme.dart';
import '../workbench_controller.dart';

/// Live counter (§3.3): KB used vs capacity, stealth read-out, and lint
/// warnings (reusing `content_schema.validateDag` — the same validator the
/// server runs).
class BudgetPanel extends StatelessWidget {
  final WorkbenchController controller;

  const BudgetPanel({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final over = controller.isOverBudget;
        final lint = controller.lint;
        return Container(
          padding: const EdgeInsets.all(12),
          color: PayloadColors.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                runSpacing: 4,
                children: [
                  Icon(Icons.memory, size: 14, color: over ? PayloadColors.dangerRed : PayloadColors.terminalGreen),
                  Text(
                    '${controller.totalSizeKb} / ${controller.capacityKb} KB',
                    key: const Key('budget_size_label'),
                    style: TextStyle(
                      color: over ? PayloadColors.dangerRed : PayloadColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('stealth: ${controller.stealthLabel}',
                      key: const Key('stealth_label'),
                      style: const TextStyle(color: PayloadColors.textMuted)),
                ],
              ),
              if (lint.errors.isNotEmpty || lint.warnings.isNotEmpty) ...[
                const SizedBox(height: 8),
                for (final e in lint.errors)
                  _LintRow(icon: Icons.error, color: PayloadColors.dangerRed, text: e),
                for (final w in lint.warnings)
                  _LintRow(icon: Icons.warning_amber, color: PayloadColors.warningAmber, text: w),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _LintRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const _LintRow({required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Expanded(child: Text(text, style: TextStyle(fontSize: 11, color: color))),
        ],
      ),
    );
  }
}
