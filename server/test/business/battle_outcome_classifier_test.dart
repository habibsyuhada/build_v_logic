import 'package:payload_server/src/business/battle_outcome_classifier.dart';
import 'package:payload_server/src/generated/protocol.dart';
import 'package:sim_core/sim_core.dart';
import 'package:test/test.dart';

BattleResult _result({int dataExfiltrated = 0, int survivingCopies = 0}) => BattleResult(
      ticksUsed: 10,
      dataExfiltrated: dataExfiltrated,
      logsDeleted: 0,
      cleanExits: 0,
      survivingCopies: survivingCopies,
      deadCopies: 0,
      tracePenalty: 0,
      score: 0,
      peakNoiseMeter: 0,
    );

void main() {
  test('exfiltrating any data is always an attacker win', () {
    final outcome = BattleOutcomeClassifier.classify(_result(dataExfiltrated: 1, survivingCopies: 0));
    expect(outcome, BattleOutcome.attackerWin);
  });

  test('fully wiped out with nothing gained is a defender win', () {
    final outcome = BattleOutcomeClassifier.classify(_result(dataExfiltrated: 0, survivingCopies: 0));
    expect(outcome, BattleOutcome.defenderWin);
  });

  test('surviving but exfiltrating nothing is a draw', () {
    final outcome = BattleOutcomeClassifier.classify(_result(dataExfiltrated: 0, survivingCopies: 1));
    expect(outcome, BattleOutcome.draw);
  });

  test('attackerWon() is true only for attackerWin', () {
    expect(BattleOutcomeClassifier.attackerWon(BattleOutcome.attackerWin), isTrue);
    expect(BattleOutcomeClassifier.attackerWon(BattleOutcome.defenderWin), isFalse);
    expect(BattleOutcomeClassifier.attackerWon(BattleOutcome.draw), isFalse);
  });
}
