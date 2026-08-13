# Acceptance Criteria Tracking

Status per PAYLOAD_PLAN.md §5. Legend: ✅ verified in this environment,
⚠️ verified as far as this sandboxed environment allows (see note),
⛔ not verifiable here — see `docs/DECISIONS.md` "Execution environment
constraints".

## Phase 0 — Fondasi

| AC | Status | Note |
|---|---|---|
| `dart analyze` bersih | ✅ | `dart analyze` → "No issues found!" across the whole workspace. |
| CI hijau | ⚠️ | `.github/workflows/ci.yml` runs analyze + content_lint + tests on ubuntu-latest & macos-latest; config validated locally (steps run green on this machine). Actual GitHub Actions run not observed from this sandbox — no push to a GitHub-hosted default branch has triggered it yet. |
| `tools/content_lint` memvalidasi `blocks.json` contoh | ✅ | `dart run tools/content_lint/bin/content_lint.dart content` exits 0 against the real `content/blocks.json` (49 blocks) and `content/balance.json`. |

## Phase 1 — sim_core

| AC | Status | Note |
|---|---|---|
| Seluruh unit test lulus | ✅ | 57/57 tests pass: `content_schema` (15), `sim_core` (38, incl. 10 golden), `bot_harness` (4). `dart analyze --fatal-infos` clean. |
| Golden hash identik lintas platform CI | ⚠️ | 10 scenarios pinned to SHA-256 hashes in `test/golden_test.dart`, stable across repeated local runs; `.github/workflows/ci.yml` diffs `tool/print_golden_hashes.dart` output between ubuntu-latest and macos-latest on every CI run. This sandbox only has Linux x64, so the macOS leg of that diff has not actually been observed running — the mechanism is in place and self-verifying once CI executes it. |
| 600-tick cap & 64-eval cap terbukti dengan test | ✅ | `battle_resolver_test.dart`: a `wait`-only virus runs to exactly tick 600; an unbreakable sensor/if_else loop stalls every tick (`virus_stalled` event, 0 actions) yet the battle still terminates at tick 600. `chain_walker_test.dart` unit-tests the 64-step cap directly. |

Extra, beyond the letter of the AC: `tools/bot_harness` (§4.3) is implemented and runnable (3 archetypes x 12 topologies x 1000 seeds in ~2.5s). Its first real-content run flags all three archetypes outside the 40-60% win-rate band — this is expected/correct behavior for untuned Phase-0 balance numbers, not a Phase 1 defect; see `docs/DECISIONS.md`.

## Phase 2 — Workbench + Test Run

_Pending._

## Phase 3 — Replay renderer + Campaign

_Pending._

## Phase 4 — Backend & PvP async

_Pending._

## Phase 5 — Meta & ekonomi

_Pending._

## Phase 6 — Polish, LiveOps, Launch readiness

_Pending._
