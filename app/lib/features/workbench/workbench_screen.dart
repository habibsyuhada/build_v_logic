import 'package:content_schema/content_schema.dart';
import 'package:flutter/material.dart';

import '../core/content/content_repository.dart';
import '../core/theme/payload_theme.dart';
import '../replay/test_run_controller.dart';
import '../replay/widgets/test_run_panel.dart';
import 'widgets/block_tray.dart';
import 'widgets/budget_panel.dart';
import 'widgets/inspector_panel.dart';
import 'widgets/workbench_canvas.dart';
import 'workbench_controller.dart';

/// The workbench editor screen (§3.3, §2.2 `features/workbench`): block
/// tray, node-graph canvas, budget/lint panel, node inspector, and a Test
/// Run mode that resolves a battle locally against the training network.
class WorkbenchScreen extends StatefulWidget {
  final ContentRepository content;

  const WorkbenchScreen({super.key, required this.content});

  @override
  State<WorkbenchScreen> createState() => _WorkbenchScreenState();
}

class _WorkbenchScreenState extends State<WorkbenchScreen> {
  late final WorkbenchController _workbench;
  final TestRunController _testRun = TestRunController();
  bool _showTestRun = false;
  int _seed = 1;

  @override
  void initState() {
    super.initState();
    _workbench = WorkbenchController(
      content: widget.content,
      capacityKb: widget.content.balance.startingCapacityKb,
    );
  }

  @override
  void dispose() {
    _workbench.dispose();
    _testRun.dispose();
    super.dispose();
  }

  void _runTest() {
    final dag = _workbench.buildDagDef();
    if (dag == null) return;
    _testRun.run(
      network: widget.content.trainingNetwork,
      virusDef: VirusDef(program: dag),
      balance: widget.content.balance,
      blockCatalog: widget.content.blocks,
      seed: _seed++,
    );
    setState(() => _showTestRun = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('workbench'),
        actions: [
          ListenableBuilder(
            listenable: _workbench,
            builder: (context, _) => IconButton(
              key: const Key('run_test_button'),
              icon: const Icon(Icons.play_arrow),
              tooltip: 'Test Run',
              onPressed: _workbench.nodes.isEmpty ? null : _runTest,
            ),
          ),
        ],
      ),
      body: Row(
        children: [
          SizedBox(
            width: 220,
            child: BlockTray(blocks: widget.content.blocks, onAdd: (b) => _workbench.addNode(b.id)),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: Column(
              children: [
                BudgetPanel(controller: _workbench),
                Expanded(
                  child: WorkbenchCanvas(controller: _workbench, catalog: widget.content.blocksById),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          SizedBox(
            width: 260,
            child: _showTestRun
                ? Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            key: const Key('close_test_run_button'),
                            icon: const Icon(Icons.close),
                            onPressed: () => setState(() => _showTestRun = false),
                          ),
                        ],
                      ),
                      Expanded(child: TestRunPanel(controller: _testRun)),
                    ],
                  )
                : InspectorPanel(controller: _workbench, catalog: widget.content.blocksById),
          ),
        ],
      ),
      backgroundColor: PayloadColors.background,
    );
  }
}
