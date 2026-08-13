/// Which `out` branch keys a node type accepts, driving both the connect
/// picker UI and matching the interpreter's branching model exactly (see
/// docs/DECISIONS.md "Interpreter branching model" and
/// `packages/sim_core/lib/src/interpreter/chain_walker.dart`).
List<String> branchOptionsFor(String blockId) {
  switch (blockId) {
    case 'if_else':
    case 'random_branch':
      return const ['true', 'false'];
    case 'repeat':
      return const ['body', 'after'];
    case 'priority':
      return const ['1', '2', '3', 'after'];
    case 'sequence':
    default:
      return const ['next'];
  }
}
