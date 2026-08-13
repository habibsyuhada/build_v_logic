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

| AC | Status | Note |
|---|---|---|
| Rakit virus 15 blok di device mid-range 60fps | ⛔ | Requires physical Android hardware for FPS profiling — not available in this sandboxed environment. Substituted verification: `flutter analyze` clean, and a widget test builds/interacts with the real workbench screen without runtime errors. See `docs/DECISIONS.md` "Execution environment constraints". |
| Lint editor bekerja | ✅ | `BudgetPanel` surfaces `content_schema.validateDag`'s errors/warnings live (same validator the server uses); covered by `workbench_controller_test.dart` ("lint surfaces the same validateDag errors...") and a widget test. |
| Test run scrub/step berfungsi | ✅ | `TestRunController` (scrub/step/back, clamped to `[0, maxTick]`) + per-tick snapshot inspector, covered by `test_run_controller_test.dart` (5 tests) and a widget test that runs a real battle and asserts the scrubber/summary render. |

21/21 `app/` tests pass, `flutter analyze` clean across the whole workspace (including `app/`).

## Phase 3 — Replay renderer + Campaign

| AC | Status | Note |
|---|---|---|
| Kampanye playable end-to-end offline | ✅ | Full loop works with no network calls: chapter list → mission → briefing → build a virus from unlocked blocks → launch attack (`resolveBattle` locally) → stars awarded & persisted → Flame replay. Verified by `campaign_screen_test.dart`'s end-to-end widget test and `real_content_smoke_test.dart` against the real bundled 60-mission content. |
| Playtest gate §4.7 dijalankan minimal pada misi 1–10 | ⛔ | Requires 10 real non-gamer human testers — not available in this sandboxed environment. See `docs/DECISIONS.md` "Execution environment constraints". Substituted: automated widget/logic test coverage of the same mission-1 flow (build → attack → result), which verifies the mechanism works, not that humans find it intuitive. |

53/53 `app/` tests pass (up from 21), `flutter analyze` clean across the whole workspace. All 10 `sim_core` golden hashes re-verified after the `peakNoiseMeter` addition (see `docs/DECISIONS.md`).

Known gaps vs. the letter of §3.4/§1.8 (tracked, not silently dropped — see `docs/DECISIONS.md` "Phase 3"): Flame renderer uses placeholder geometric shapes instead of pixel-art sprites (no art pipeline exists), and has no camera auto-follow/cinematic cuts (static camera over the whole network).

## Phase 4 — Backend & PvP async

_Pending._

## Phase 5 — Meta & ekonomi

_Pending._

## Phase 6 — Polish, LiveOps, Launch readiness

_Pending._
