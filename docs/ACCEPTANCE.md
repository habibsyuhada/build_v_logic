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

_Pending — filled in as Phase 1 completes._

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
