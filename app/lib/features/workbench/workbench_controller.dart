import 'dart:ui' show Offset;

import 'package:content_schema/content_schema.dart';
import 'package:flutter/foundation.dart';

import '../core/content/content_repository.dart';

/// One block instance placed on the workbench canvas: the DAG node data
/// plus its on-canvas position (position is editor-only, never part of the
/// DAG sent to `sim_core`/the server).
class EditorNode {
  final String id;
  String blockId;
  Map<String, dynamic> params;
  Offset position;
  Map<String, String> out;

  EditorNode({
    required this.id,
    required this.blockId,
    Map<String, dynamic>? params,
    required this.position,
    Map<String, String>? out,
  })  : params = params ?? {},
        out = out ?? {};
}

/// Drives the workbench editor (§3.3): add/connect/delete blocks, track
/// budget (KB vs capacity, stealth rating), and surface lint warnings by
/// reusing `content_schema`'s `validateDag` — the exact same validator the
/// server runs, so what the editor warns about is what the server would
/// reject or flag.
class WorkbenchController extends ChangeNotifier {
  final ContentRepository content;
  final int capacityKb;

  final List<EditorNode> _nodes = [];
  String? _entryNodeId;
  String? connectFromNodeId;
  String? selectedNodeId;
  int _idCounter = 0;

  WorkbenchController({required this.content, required this.capacityKb});

  List<EditorNode> get nodes => List.unmodifiable(_nodes);
  String? get entryNodeId => _entryNodeId;

  EditorNode? nodeById(String id) {
    for (final n in _nodes) {
      if (n.id == id) return n;
    }
    return null;
  }

  String addNode(String blockId, {Offset position = const Offset(40, 40)}) {
    final id = 'n${_idCounter++}';
    _nodes.add(EditorNode(id: id, blockId: blockId, position: position));
    _entryNodeId ??= id;
    notifyListeners();
    return id;
  }

  void moveNode(String id, Offset position) {
    final node = nodeById(id);
    if (node == null) return;
    node.position = position;
    notifyListeners();
  }

  void deleteNode(String id) {
    _nodes.removeWhere((n) => n.id == id);
    for (final n in _nodes) {
      n.out.removeWhere((_, target) => target == id);
    }
    if (_entryNodeId == id) {
      _entryNodeId = _nodes.isEmpty ? null : _nodes.first.id;
    }
    if (connectFromNodeId == id) connectFromNodeId = null;
    if (selectedNodeId == id) selectedNodeId = null;
    notifyListeners();
  }

  void setEntry(String id) {
    if (nodeById(id) == null) return;
    _entryNodeId = id;
    notifyListeners();
  }

  void updateParam(String nodeId, String key, Object? value) {
    final node = nodeById(nodeId);
    if (node == null) return;
    node.params = {...node.params, key: value};
    notifyListeners();
  }

  void selectNode(String? id) {
    selectedNodeId = id;
    notifyListeners();
  }

  void startConnect(String fromId) {
    connectFromNodeId = fromId;
    notifyListeners();
  }

  void cancelConnect() {
    connectFromNodeId = null;
    notifyListeners();
  }

  /// Completes a tap-to-connect gesture (§3.3's "alternatif tombol" for
  /// drag-to-connect — reliable on touch, and doubles as the accessible
  /// path since it never requires a precision drag).
  void completeConnect(String toId, {required String branch}) {
    final fromId = connectFromNodeId;
    if (fromId == null) return;
    final from = nodeById(fromId);
    if (from != null && fromId != toId) {
      from.out = {...from.out, branch: toId};
    }
    connectFromNodeId = null;
    notifyListeners();
  }

  void disconnectBranch(String fromId, String branch) {
    final from = nodeById(fromId);
    if (from == null) return;
    from.out = {...from.out}..remove(branch);
    notifyListeners();
  }

  int get totalSizeKb => _nodes.fold<int>(
      0, (sum, n) => sum + (content.blocksById[n.blockId]?.sizeKb ?? 0));

  bool get isOverBudget => totalSizeKb > capacityKb;

  /// Rough stealth read-out for the live counter (§1.3, §3.3): below the
  /// safe threshold reads "hidden", above the auto-flag threshold reads
  /// "flagged", between the two is a gradient the UI shows as a meter.
  String get stealthLabel {
    final balance = content.balance;
    if (totalSizeKb <= balance.stealthSafeMaxKb) return 'stealth';
    if (totalSizeKb >= balance.stealthAutoFlagMinKb) return 'flagged';
    return 'risky';
  }

  DagDef? buildDagDef() {
    if (_nodes.isEmpty || _entryNodeId == null) return null;
    return DagDef(
      entry: _entryNodeId!,
      nodes: _nodes
          .map((n) => DagNode(id: n.id, blockId: n.blockId, params: n.params, out: n.out))
          .toList(),
    );
  }

  ValidationResult get lint {
    final dag = buildDagDef();
    if (dag == null) {
      return const ValidationResult(errors: ['tambahkan minimal satu blok']);
    }
    return validateDag(dag, blockCatalog: content.blocksById, capacityKb: capacityKb);
  }
}
