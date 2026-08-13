import 'package:sim_core/sim_core.dart';

import '../generated/protocol.dart';

/// Derives the coarse [BattleOutcome] stored on a [Battle] row from
/// `sim_core`'s detailed [BattleResult]. Pure, no session/database
/// dependency.
class BattleOutcomeClassifier {
  static BattleOutcome classify(BattleResult result) {
    if (result.dataExfiltrated > 0) return BattleOutcome.attackerWin;
    if (result.survivingCopies == 0) return BattleOutcome.defenderWin;
    return BattleOutcome.draw; // survived, but exfiltrated nothing
  }

  static bool attackerWon(BattleOutcome outcome) => outcome == BattleOutcome.attackerWin;
}
