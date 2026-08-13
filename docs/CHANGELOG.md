# Changelog

All notable changes to the PAYLOAD project, organized by execution phase
(PAYLOAD_PLAN.md §5).

## Phase 0 — Fondasi (repo & tooling)

- Monorepo scaffolded per §2.2: `packages/` (`sim_core`, `content_schema`,
  `shared_models`), `app/`, `server/`, `content/`, `tools/`,
  `.github/workflows/`, `docs/`.
- Dart-native pubspec workspace wiring every package/tool into one
  `dart pub get` / lockfile.
- `content_schema`: models (`BlockDef`, `DagDef`/`VirusDef`, `NetworkDef`,
  `MissionDef`, `BalanceConfig`) + validators (block catalog, network
  anti-turtle reachability, DAG integrity/budget/unlocks, mission set,
  balance config), with unit tests.
- `tools/content_lint`: CLI validating the full `content/` tree.
- `content/blocks.json`: all 49 blocks from §1.3's release content list,
  with balance numbers as data (never hardcoded), plus `content/balance.json`.
- `docker-compose.yml`: Postgres + Redis dev services (Serverpod service
  slot reserved for Phase 4).
- `.github/workflows/ci.yml`: analyze + content_lint + test matrix
  (ubuntu-latest, macos-latest) with a cross-platform golden-hash diff job
  wired up ahead of Phase 1's golden determinism tests.

## Phase 1 — sim_core

- `sim_core`: xoshiro128** PRNG (integer-only, seeded, reproducible), world
  model (`SimState`/`NodeRuntime`/`VirusRuntime`), a shared DAG interpreter
  (`ChainWalker`) implementing all 49 blocks from §1.3 (16 sensors, 13
  actions, 5 control-flow, 5 memory, 4 defense sensors, 6 defense actions),
  the tick-ordered battle resolver (`resolveBattle`), and a versioned
  replay codec (`BattleLog`/`BattleEvent`/`BattleResult`).
- 600-tick hard cap and 64-eval-step-per-tick stall cap both implemented
  and covered by dedicated tests (an infinite sensor loop stalls every
  tick with zero actions; a `wait`-only virus runs exactly to tick 600).
- 10 golden determinism scenarios (`lib/src/golden/golden_scenarios.dart`,
  `test/golden_test.dart`) pinned to SHA-256 hashes of their full
  `BattleLog` JSON; `tool/print_golden_hashes.dart` is what CI diffs
  between ubuntu-latest and macos-latest.
- `tools/bot_harness`: 3 archetypes (Ghost/Bulldozer/Hydra) x 12 topologies
  x configurable seed count (default 1000) win-rate/avg-score report per
  §4.3. First run flags all three archetypes outside the 40-60% band —
  expected for untuned Phase-0 balance numbers; tracked as a Phase 6
  balance-pass item, see `docs/DECISIONS.md`.
- 57 tests total across `content_schema` (15), `sim_core` (38, including
  the 10 golden scenarios), and `bot_harness` (4); `dart analyze
  --fatal-infos` clean across the whole workspace.

## Phase 2 — Workbench + Test Run (client offline)

- `app/`: Flutter project scaffolded (Android + iOS platform folders),
  wired into the Dart pub workspace (`flutter pub get` resolves
  everything from the repo root now, including the pure-Dart packages).
- Dark terminal theme (§1.8) with a colorblind-safe palette variant.
- `go_router` routing skeleton across all §2.2 feature folders (workbench
  is live; campaign/pvp/blueprints/network_builder/profile/shop/settings
  are placeholder routes, filled in from Phase 3 onward).
- Full workbench editor (§3.3): block tray (grouped by family, searchable),
  pinch-zoom/pan node canvas, drag-to-reposition, tap-to-connect (doubles
  as the required accessible alternative to a drag gesture), long-press
  delete, live KB/capacity/stealth counter, and lint warnings reusing
  `content_schema.validateDag` — the exact same validator the server will
  run in Phase 4.
- Test Run mode: resolves a battle locally via `sim_core.resolveBattle`
  against a bundled training network, with a scrubbable timeline, step
  forward/back, and a per-tick state inspector (energy, memory flags,
  inventory) — powered by a new opt-in `includeSnapshots` param on
  `resolveBattle` (`packages/sim_core/lib/src/replay/virus_snapshot.dart`).
- Local preset storage (§2.4, capped at 12/player) behind a
  storage-agnostic interface, backed by `shared_preferences` on-device and
  an in-memory fake for tests.
- `content/networks/training_01.json`: first authored network, validated
  by `tools/content_lint`.
- 21 tests in `app/` (widget tests exercising the real screen + pure
  logic tests for the three controllers), `flutter analyze` clean.
  CI (`.github/workflows/ci.yml`) switched from `dart-lang/setup-dart` to
  `subosito/flutter-action`, since `app/`'s `flutter: sdk: flutter`
  dependency requires `flutter pub get` to resolve the workspace at all.

## Phase 3 — Replay renderer + Campaign

- `sim_core`: `BattleResult.peakNoiseMeter` added (drives the mission
  "senyap" star); all 10 golden hashes regenerated and re-pinned.
- `tools/mission_gen`: generates the full 60-mission campaign (6 chapters
  x 10 missions) — one procedurally-varied training network per mission,
  block unlock progression across chapters 1-5, chapter 6 as a mastery
  gauntlet. `content/missions/*.json` + `content/networks/mission_*.json`
  all validated by `tools/content_lint`.
- Flame replay renderer (`app/lib/features/replay/flame/`): BFS-layered
  network layout, virus positions reconstructed from the `BattleLog`
  event stream (no snapshot dependency — matches how a real PvP replay
  would work), play/pause/1x-2x-4x speed/scrub/skip-to-result controls.
- Campaign system: `CampaignController` (linear mission availability,
  3-star scoring — selesai/senyap/efisien per §1.5, block unlocks),
  local persistence via `shared_preferences`, chapter/mission list UI,
  and a mission attack screen that reuses the Phase 2 workbench
  restricted to the player's currently-unlocked blocks.
- Full offline loop is playable end-to-end: chapter list → mission →
  briefing → build a virus from unlocked blocks → launch attack →
  stars awarded → view Flame replay.
- 53 tests in `app/` (up from 21), `flutter analyze` clean across the
  whole workspace. New coverage: network layout, replay frame
  reconstruction, playback controller, the real Flame `GameWidget`
  rendering, campaign progression logic, and a full end-to-end campaign
  widget test (chapter → mission → attack → stars → replay).

## Phase 4 — Backend & PvP async

- Real Serverpod 3.4.11 project (`server/` + `packages/shared_models` as
  the generated client), scaffolded via `serverpod create` and folded
  into the monorepo workspace.
- Data models (`server/lib/src/models/*.spy.yaml`): `Player`, `Unlock`,
  `VirusPreset`, `Defense`, `Battle` (+ `BattleOutcome` enum), wired to
  `serverpod_auth`'s `AuthUser` — `serverpod generate` runs clean.
- Guest auth end-to-end (`PlayerEndpoint.createGuest`): creates an
  `AuthUser` + `Player` and issues a real signed session token.
  Google/Apple sign-in are architecturally ready to add (same `AuthUser`
  the guest flow already uses) but need live OAuth credentials this
  environment doesn't have — see `docs/DECISIONS.md`.
- `DefenseEndpoint.save`: validates a submitted defense (topology +
  per-node defense-logic, 6-block cap per §1.4) via
  `content_schema.validateNetwork`/`validateDag`, versions and activates
  it, deactivating the previous version.
- `BattleEndpoint.submitAttack`/`getBattle`: validates a submitted virus
  (never trusts the client's own unlock bookkeeping), checks the sim
  version gate (§2.7), resolves the battle via `sim_core.resolveBattle`,
  classifies the outcome, computes an Elo-like rating delta (§1.5,
  K-factor adjusted by games played), and persists the result.
- All endpoint business logic extracted into pure, `Session`-free classes
  in `server/lib/src/business/` (`RatingCalculator`,
  `BattleOutcomeClassifier`, `Matchmaker`, `VirusSubmissionValidator`,
  `DefenseSubmissionValidator`, `BattleWorker`, `SimVersionGate`,
  `LogStorageDecision`) — 39 passing unit tests, none requiring a live
  database.
- `server/Dockerfile` updated to build from the monorepo root (the
  scaffolded version only knew about `server/`, but `server/` depends on
  the local `content_schema`/`sim_core`/`shared_models` workspace
  packages, not published ones).
- Root `docker-compose.yml` replaced by Serverpod's own generated
  `server/docker-compose.yaml` (Postgres + Redis, dev + test instances) —
  the canonical one going forward.
- `dart analyze` clean across `server/` and `packages/shared_models`.
  **Not verified**: the server booting against a live database — no
  Docker daemon is available in this environment. See
  `docs/ACCEPTANCE.md` and `docs/DECISIONS.md`.

## Phase 5 — Meta & economy

- `content_schema`: `SkuDef`/`SkuType` model + `validateSkuSet` validator
  (5 tests). `content/shop.json` authored (5 keys-pack SKUs + 1
  battle-pass SKU), validated by `tools/content_lint`'s new shop.json
  check, bundled into `server/content/` alongside `blocks.json`/
  `balance.json`.
- New data models (`server/lib/src/models/*.spy.yaml`): `Blueprint`,
  `BlueprintReveal`, `BlueprintModerationState` (enum); `DailyContract`,
  `ContractScore`; `Season`, `SeasonResult`; `Purchase`, `PurchaseState`
  (enum); `BattlePassProgress`; `TelemetryEvent` — plus exceptions
  `BlueprintNotFoundException`, `BlueprintNotRevealedException`,
  `BlueprintTitleRejectedException`, `BlueprintValidationException`,
  `SkuNotFoundException`. `serverpod generate` runs clean.
- Six new pure business-logic classes in `server/lib/src/business/`,
  each with real unit tests (41 new tests total, none needing a live
  database): `ProfanityFilter`/`SimpleWordlistProfanityFilter`,
  `ReverseEngineerProgress`, `DailyContractGenerator`, `SeasonRollover`,
  `BattlePassTierCalculator`, `ReceiptValidator`/
  `AlwaysRejectReceiptValidator`, plus a new `ServerContent` test for the
  bundled `shop.json`.
- New endpoints, following the Phase 4 thin-glue-over-pure-logic pattern:
  - `BlueprintEndpoint`: `publish` (profanity filter + virus validation),
    `listApproved`, `watchReplay` (reverse-engineer progress),
    `copy` (gated on full reveal).
  - `ContractEndpoint`: `today` (generates/persists the date-seeded daily
    contract), `submitScore` (best-score upsert), `leaderboard`.
  - `SeasonEndpoint`: `current` (get-or-create), `rolloverIfDue`
    (snapshots ranked `SeasonResult`s and resets `seasonRating`),
    `myProgress`/`addXp`/`myTier` (battle pass).
  - `ShopEndpoint`: `listSkus`, `purchase` (verifies via
    `ReceiptValidator`, grants keys or premium track only on success).
  - `TelemetryEndpoint`: `ingest` (batched event persistence).
- `dart analyze --fatal-infos` clean across `server/`. **Not verified**:
  any of the new endpoints against a live database (same no-Docker-daemon
  constraint as Phase 4), real store IAP sandboxes, or a live analytics
  dashboard for the telemetry funnel. See `docs/ACCEPTANCE.md` and
  `docs/DECISIONS.md`.
- **Known gap**: no client-side UI for any of these five systems this
  phase — see `docs/DECISIONS.md` "Phase 5".

## Phase 6 — Polish, LiveOps, Launch readiness

- **Balance pass (§4.3/§5)**: tuned `content/blocks.json` (`disguise`
  5→16, `brute_force` 8→35, `replicate` 20→2) and `content/balance.json`
  (`starting_energy` 100→160) so all 3 `tools/bot_harness` archetypes land
  within the 40-60% win-rate band (verified at 1000 seeds/pair). All 10
  `sim_core` golden hashes re-pinned; app/server bundled content copies
  re-synced.
- **Accessibility (§1.8)**: new `app/lib/features/core/accessibility/`
  (`AccessibilitySettings`, `AccessibilityController`,
  `shared_preferences`-backed storage) — colorblind-safe palette, large
  text, reduce-motion, CRT scanline toggle. Wired live into `PayloadApp`
  (theme, `TextScaler`, `disableAnimations`, `ScanlineOverlay`). Real
  `SettingsScreen` replacing the placeholder, with 10 new passing tests.
- **Localization EN+ID (§1.8/§5)**: `flutter_localizations`/`intl` wired
  up, `l10n.yaml` + `lib/l10n/app_{en,id}.arb`, `AppLocalizations`
  generated and used throughout `SettingsScreen`; an EN/ID/follow-system
  locale picker persisted in the same settings blob. 2 new locale smoke
  tests.
- **Remote config (§2.1/§5)**: new server `ContentEndpoint`
  (`currentVersion`/`fetchBundle`, versioned via a pure `ContentVersion.hashFor`
  SHA-256 over the content JSON, 3 new tests) and new client
  `RemoteConfigContentSync` (`app/lib/features/core/remote_config/`,
  version-check/cache/fallback, 6 new tests against a fake fetcher).
- **Crash reporting seam (§5)**: new `app/lib/features/core/diagnostics/`
  (`ErrorReporter`, `ConsoleErrorReporter`, `CrashFreeSessionTracker`),
  wired into `main.dart`'s `FlutterError.onError`/
  `PlatformDispatcher.instance.onError`. 4 new tests.
- **Video replay export (§1.7)**: new `ReplayGifExporter`
  (`app/lib/features/replay/export/`) renders an animated GIF from a real
  `BattleLog`, reusing the Flame renderer's own layout/frame
  reconstruction. New export button on `ReplayScreen`. 3 new tests
  (including an encode→decode round trip).
- **`PlayerEndpoint.deleteAccount`**: new endpoint, cascades through every
  owned table via existing `relation(onDelete=Cascade)` declarations.
- Ops docs: `docs/RUNBOOK.md`, `docs/STORE_LISTING.md`,
  `docs/STORE_COMPLIANCE.md`, `docs/SOFT_LAUNCH_CHECKLIST.md`.
- 83/83 `server/test/business` tests pass (3 new), `dart analyze` clean.
  75/75 `app/` tests pass (22 new), `flutter analyze --fatal-infos` clean
  workspace-wide.
- **Known gaps** (see `docs/DECISIONS.md` "Phase 6"): localization covers
  Settings only; remote config isn't wired into the app boot path or a
  live transport; no live Sentry/Grafana backend; GIF export has no
  save-to-disk/share-sheet wiring; `deleteAccount` has no client UI entry
  point yet; no on-call rotation defined.
