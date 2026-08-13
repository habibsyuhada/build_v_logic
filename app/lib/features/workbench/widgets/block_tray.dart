import 'package:content_schema/content_schema.dart';
import 'package:flutter/material.dart';

import '../../core/theme/payload_theme.dart';

Color colorForFamily(BlockFamily family) {
  switch (family) {
    case BlockFamily.sensor:
      return PayloadColors.cyan;
    case BlockFamily.action:
      return PayloadColors.terminalGreen;
    case BlockFamily.controlFlow:
      return PayloadColors.magenta;
    case BlockFamily.memory:
      return PayloadColors.warningAmber;
    case BlockFamily.defenseSensor:
      return PayloadColors.cyan.withValues(alpha: 0.6);
    case BlockFamily.defenseAction:
      return PayloadColors.dangerRed;
  }
}

/// Block tray (§3.3): blocks grouped by family, with search, tap to add to
/// the canvas. Tap-to-add (rather than requiring a drag) is itself the
/// accessible path — no gesture precision required.
class BlockTray extends StatefulWidget {
  final List<BlockDef> blocks;
  final void Function(BlockDef block) onAdd;

  const BlockTray({super.key, required this.blocks, required this.onAdd});

  @override
  State<BlockTray> createState() => _BlockTrayState();
}

class _BlockTrayState extends State<BlockTray> {
  String _query = '';
  BlockFamily? _familyFilter;

  @override
  Widget build(BuildContext context) {
    final filtered = widget.blocks.where((b) {
      if (_familyFilter != null && b.family != _familyFilter) return false;
      if (_query.isEmpty) return true;
      return b.id.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            key: const Key('block_tray_search'),
            decoration: const InputDecoration(
              hintText: 'search blocks…',
              prefixIcon: Icon(Icons.search),
              isDense: true,
            ),
            onChanged: (v) => setState(() => _query = v),
          ),
        ),
        SizedBox(
          height: 36,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              _FamilyChip(label: 'all', selected: _familyFilter == null, onTap: () => setState(() => _familyFilter = null)),
              for (final family in BlockFamily.values)
                _FamilyChip(
                  label: family.wireName,
                  color: colorForFamily(family),
                  selected: _familyFilter == family,
                  onTap: () => setState(() => _familyFilter = family),
                ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            key: const Key('block_tray_list'),
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              final block = filtered[i];
              return ListTile(
                dense: true,
                leading: CircleAvatar(
                  radius: 6,
                  backgroundColor: colorForFamily(block.family),
                ),
                title: Text(block.id),
                subtitle: Text('${block.sizeKb}KB'
                    '${block.energyCost > 0 ? ' · ${block.energyCost}⚡' : ''}'
                    '${block.noise > 0 ? ' · ${block.noise}🔊' : ''}'),
                onTap: () => widget.onAdd(block),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FamilyChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;

  const _FamilyChip({required this.label, required this.selected, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: FilterChip(
        label: Text(label, style: const TextStyle(fontSize: 11)),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: (color ?? PayloadColors.terminalGreen).withValues(alpha: 0.3),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
