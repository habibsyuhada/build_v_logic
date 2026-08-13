# Decisions

Per PAYLOAD_PLAN.md §7: when the spec is ambiguous, pick the simplest
interpretation that doesn't violate the design pillars (§0), and record it
here.

## Execution environment constraints (all phases)

This project is being executed by an autonomous coding agent in a sandboxed
cloud container with no physical Android/iOS devices, no device farm, no
live users, and no real Google Play / App Store developer accounts. Several
acceptance criteria in PAYLOAD_PLAN.md §5 assume a human team with that
infrastructure (device profiling, 10 real playtesters, IAP sandbox on both
stores, live soft-launch metrics). For those specific ACs, this project:

- Implements everything that *is* environment-independent (the code, the
  automated tests, the CI config, the scripts a human would run).
- Explicitly marks the AC as **not verifiable in this environment** in
  `docs/ACCEPTANCE.md`, rather than claiming a pass that didn't happen.
- Leaves a runnable procedure (script/checklist) so a human with the right
  environment can complete the verification later.

This is treated as the simplest interpretation of §7's ambiguity rule
applied to "the spec assumes infrastructure the executor doesn't have."

## Phase 0

- **Monorepo root.** §2.2 shows the tree rooted at `payload/`. Since this
  git repository *is* the project (not a parent folder containing it), the
  `payload/` wrapper is dropped and the tree is rooted at the repo root
  directly. Structure below `packages/`, `app/`, `server/`, `content/`,
  `tools/`, `.github/workflows/` otherwise matches §2.2 exactly.
- **Dart workspaces over Melos.** The plan doesn't name a monorepo tool.
  Dart 3.6+ has native `pubspec.yaml` workspaces (a single lockfile, `dart
  pub get` at the root resolves every member). Chosen over adding Melos as
  an extra dependency, since native workspaces cover everything Phase 0-4
  need (shared versions, single `dart test`/`dart analyze` pass) with zero
  extra tooling.
- **No `package:lints` dependency.** `analysis_options.yaml` lists linter
  rules directly instead of `include: package:lints/recommended.yaml`, so
  `dart analyze` never depends on an extra pub resolution succeeding. Rule
  set covers the same class of bugs (unused code, obvious const/final
  opportunities, equality/type mistakes).
- **`content_schema` owns `VirusDef`/`DagDef`.** §2.2 describes
  `content_schema` as "Model + validator untuk semua JSON konten (blocks,
  missions, networks)" without mentioning the virus/defense DAG format from
  §3.2. Since a DAG program *is* content (JSON, versioned, validated before
  a battle runs), its model lives in `content_schema` too, so both
  `sim_core` and the server validate against the same `DagDef` type.
- **DAG cycle validation is advisory, not a hard reject.** §2.5 says the
  server validates a DAG is "bebas siklus tak berujung (statik)"
  (statically free of unterminated cycles), but §3.2 separately describes
  the 64-eval-step-per-tick cap turning a runaway loop into a single-tick
  "stall" and explicitly frames that as *intended, in-fiction feedback*
  ("lucu dan mendidik" — funny and instructive), not an error state. A hard
  static reject would make that documented behavior unreachable. Resolution
  chosen: `validateDag` hard-rejects only structurally invalid DAGs
  (dangling references, unknown/locked blocks, over budget); a pure-sensor
  cycle is left to the runtime stall mechanism, with the editor lint (§3.3)
  surfacing "no out edge" / "unreachable node" as warnings so players catch
  it before running.
- **Defense block `size_kb` is nominal.** Defense-logic budget is a block
  *count* cap (max 6 per node, §1.4), not a KB cap — defenders don't have
  the attacker's capacity system. `content_schema`'s `BlockDef.sizeKb` is
  still required to be `> 0` for schema consistency, so defense blocks in
  `content/blocks.json` all carry `size_kb: 1` as a nominal placeholder
  that plays no role in defense validation.
## Phase 4

- **Real Serverpod 3.4.11 project, not a hand-rolled server.** `serverpod
  create` scaffolded `server/` and `packages/shared_models` (renamed from
  the generated `payload_client`/`payload_server`); the generated auth
  scaffolding (JWT sessions, email identity provider) was kept as-is since
  it's official, correct, tooling-generated code, not something to
  second-guess without the ability to test it live.
- **`server/endpoints/` and `server/jobs/` (Phase 0's illustrative
  top-level dirs) were dropped** in favor of Serverpod's real convention:
  endpoints live under `server/lib/src/endpoints/`, models under
  `server/lib/src/models/*.spy.yaml`, business logic under
  `server/lib/src/business/`. §2.2's tree was a simplified illustration,
  not literal tooling — the simplest interpretation consistent with §7 is
  to follow the actual framework's convention over the plan's shorthand.
- **Only guest auth is wired up end-to-end; Google/Apple are not.**
  `PlayerEndpoint.createGuest` creates a `serverpod_auth` `AuthUser` with
  no login method attached (via `AuthUsers().create`) plus a `Player`
  row, then issues a real JWT session token. Google/Apple sign-in need
  live OAuth client credentials this environment doesn't have and can't
  safely fabricate — see "Execution environment constraints". "Upgrading"
  a guest later is architecturally just linking an email/Google/Apple
  credential to the *same* `AuthUser` (a `serverpod_auth`-provided
  operation) — `Player` rows key off `authUserId`, not the login method,
  so no data model change is needed when that's wired up.
- **Almost all endpoint logic lives in `server/lib/src/business/` as pure,
  `Session`-free functions/classes** (`RatingCalculator`,
  `BattleOutcomeClassifier`, `Matchmaker`, `VirusSubmissionValidator`,
  `DefenseSubmissionValidator`, `BattleWorker`, `SimVersionGate`,
  `LogStorageDecision`), each with real unit tests (39 total). The
  `Endpoint` classes (`PlayerEndpoint`, `DefenseEndpoint`,
  `BattleEndpoint`) are kept intentionally thin — auth/lookup/persist
  glue around those pure functions — both because that's good design
  and because it's the only way to get real test coverage without a
  live database in this environment (see below).
- **`BattleEndpoint.submitAttack` resolves synchronously in-request,
  not through a Redis-backed queue + separate worker process.** §2.3
  describes "enqueue ke battle queue (Redis) → worker: ...". This
  environment has no live Redis to verify a hand-written queue
  producer/consumer protocol against (no Docker daemon — see "Execution
  environment constraints"), and shipping unverified wire-protocol code
  would be worse than being explicit about the simplification.
  `BattleWorker.process(...)` — the actual resolution logic — is exactly
  the function a real queue consumer would call per job; wiring a
  Redis-backed queue on top is a deployment/infra change, not a rewrite
  of the resolution logic itself.
- **Object storage for >32KB battle logs (§2.4 `log_ref`) is a documented
  seam, not implemented.** `LogStorageDecision` correctly *decides*
  inline-vs-external based on size (tested), but the actual S3-compatible
  upload needs live credentials this environment doesn't have.
  `BattleEndpoint.submitAttack` currently always stores the log inline
  (`logJson`); `logRef` stays unused until that upload call is added.
- **Rating: Elo-like with an adjustable K-factor** (§1.5: "Elo-like, K
  disesuaikan") — K=40 for players under 10 games played, K=20 after,
  the standard "provisional period" pattern. `RatingCalculator` is pure
  and fully tested (7 tests) rather than tuned against real match data,
  which doesn't exist yet.
- **`BattleOutcomeClassifier`'s win/loss/draw rule is a first pass**:
  attackerWin if `dataExfiltrated > 0`; defenderWin if the attacker's
  virus was fully wiped out (`survivingCopies == 0`) with nothing gained;
  draw otherwise (survived, exfiltrated nothing). Simple, testable, and
  consistent with §1.2's scoring inputs — not claimed as final balance.
- **Matchmaking (`Matchmaker.selectDefender`) is a pure function over a
  candidate list**, not a live database query — real matchmaking would
  build that candidate list from a live-players-first, ghost-fallback
  query and hand it to this same function. Modeled this way specifically
  so the "never empty, ghost network from day one" guarantee (§1.5.3) is
  directly unit-testable without a live database.
- **Server bundles its own `content/blocks.json` +`content/balance.json`
  copy** (`server/content/`), same pattern as `app/assets/content/` —
  same manual-sync caveat noted in the Phase 2 entry above applies here
  too.
- **The server has never actually been booted in this environment.**
  There is no Docker daemon available (confirmed: `dockerd` refuses to
  start — no systemd, restricted ulimits), so `docker compose up`,
  `dart bin/main.dart --apply-migrations`, and any live-database
  integration test are unverified here. What *is* verified: `serverpod
  generate` succeeds against the real model/endpoint files (proving the
  `.spy.yaml` schema and endpoint code are syntactically and
  type-correct per Serverpod's own toolchain), `dart analyze` is clean
  across `server/` and `packages/shared_models`, and all business logic
  has real passing unit tests. See `docs/ACCEPTANCE.md` for exactly
  which Phase 4 AC items this does and doesn't satisfy.

- **Block balance numbers (Phase 0 authoring pass).** §1.3 specifies cost
  *ranges* (sensor 1-5KB, action 2-14KB, control flow 1-3KB, memory 3-6KB)
  but not exact per-block numbers. `content/blocks.json` assigns concrete
  values within those ranges based on relative power (e.g. `replicate` at
  14KB/20 energy/6 noise is the most expensive action; `wait`/
  `self_destruct` at 0 energy since they either do nothing or end the
  virus). These are a first pass, meant to be tuned by `tools/bot_harness`
  in Phase 1 per the §4.3 balance gate — not treated as final.

## Phase 1

- **Interpreter branching model.** §3.2 gives the DAG node shape
  (`{id, block_id, params, out}`) but not a formal execution grammar, and
  §1.3 lists `if_else`/`priority`/`repeat`/`random_branch`/`sequence` as a
  family separate from sensors — implying sensors don't branch on their
  own, contrary to the naive reading of "Sensor (kondisi, hasil ya/tidak)."
  Resolution: sensor-family (and sensor-like memory: `node_marked`,
  `counter_gt`, `timer_after`) blocks evaluate a predicate, store it as the
  walk's `lastSensorResult` register, and always continue to `out['next']`
  — sensors never branch themselves. Only control-flow blocks branch:
  `if_else` reads the register; `random_branch` flips the shared seeded
  RNG; `priority` tries numbered candidates (`out['1']`, `out['2']`, ...)
  as bounded sub-chains in order, taking the first whose sub-chain executes
  an action; `repeat(x)` runs `out['body']` as a sub-chain `x` times then
  continues at `out['after']`. All sub-chains share the parent's 64-step
  eval budget for that tick. This is the simplest grammar consistent with
  every block staying a plain flowchart node, and it makes `if_else`
  meaningfully different from a bare sensor's own branching (which doesn't
  exist in this model). See `packages/sim_core/lib/src/interpreter/chain_walker.dart`.
- **Tick order & disguise timing.** §3.1 fixes the per-tick order as
  defense sensors → defense actions → virus copies → world update. Taken
  literally, this means a defense sensor at tick T sees the virus's state
  as of *before* the virus acts that tick — so a virus that disguises
  every tick is only actually hidden starting the tick *after* its first
  disguise (see the two `resolveBattle: defense logic` tests in
  `battle_resolver_test.dart`). This is intentional: it makes "arrive
  already disguised" a real skill (disguise before you're in detection
  range), not a free always-on cloak.
- **Defense blocks reuse `energy_cost`/`noise` as effect magnitude, not
  cost.** Defenders have no energy pool (only virus copies do), so
  `quarantine`'s `energy_cost` is the damage it deals to an intruder,
  `raise_alarm`'s `noise` is the global noise bump it applies, and
  `trace`'s `energy_cost` is the score penalty it inflicts — all still
  sourced from `content/blocks.json`, never hardcoded, just reinterpreted
  per-action rather than auto-applied like a virus action's cost.
- **Scoring formula (§1.2 "f(data value, log dihapus, exit bersih vs
  mati, tick efisiensi)").** The plan names the four inputs but not the
  formula. First pass: `score = dataExfiltrated + logsDeleted *
  scoreLogDeletedBonus + cleanExits * scoreCleanExitBonus - deadCopies *
  scoreDeadPenalty - tracePenalty - ticksUsed / scoreTickEfficiencyDivisor`,
  clamped at 0. All four bonus/penalty weights live in
  `content/balance.json`, not code, so `tools/bot_harness` can be used to
  retune them later without touching `sim_core`.
- **`tools/bot_harness` topology generator is a first pass, not the 12
  curated topologies from Phase 3.** It currently generates 12
  parametrized single-path chain networks (varying length, firewall
  level, guard presence, data value). Because each node in a chain has
  exactly one outgoing edge, `move_random`'s "randomness" is not actually
  random on these topologies (only one legal move exists), so seed
  variation only matters for archetypes/programs that call
  `random_chance`/`random_branch` directly. This is fine for smoke-testing
  the harness end-to-end and for surfacing an obviously broken archetype
  (see below), but a real branching topology set is needed before its
  win-rate numbers are meaningful balance data — that arrives with Phase
  3's curated topologies.
- **First bot_harness run surfaces `Hydra` as badly out of balance by
  design, not by bug.** With today's numbers, `replicate` costs 20 energy
  and halves the copy's remaining energy on top of that, so an
  opening burst of replication (as Hydra's DAG does deliberately) leaves
  every copy with too little energy left to ever reach a data node — 0%
  global win-rate. `Ghost`/`Bulldozer` also sit outside the 40-60% band on
  this first pass (both ~67%). Per §4.3 this is exactly what the harness
  is for; per the Phase roadmap, closing this gap is Phase 6's "balance
  pass via bot harness," not a Phase 1 blocker — Phase 1's AC only
  requires the tool and the sim to exist and be correct, not for
  first-draft balance numbers to already be tuned.

## Phase 2

- **State management: no Riverpod/Bloc, just `ChangeNotifier` +
  `ListenableBuilder`.** The plan doesn't mandate a state library. Given
  the workbench's state (a node list + a few scalars) is simple and
  entirely local to one screen, adding a code-gen-based state framework
  would be scope creep for Phase 2. `provider`/`go_router` are still used
  for what they're actually needed for (DI plumbing, routing); revisit if
  Phase 3+ cross-screen state sharing gets complex enough to warrant it.
- **Tap-to-connect instead of drag-a-rope.** §3.3 asks for "drag untuk
  sambung" (drag to connect) plus a required accessible button
  alternative. Implemented as tap-source → tap-target → pick-branch
  instead of a live drag-line renderer: it needs no gesture-tracking
  precision (touch or mouse), and it *is* its own accessibility fallback
  by construction, rather than needing a second parallel implementation.
  A drag-line visualization can be layered on top later without changing
  the underlying `WorkbenchController` API.
- **Branch keys are fixed per control-flow block type, not freeform.**
  `if_else`/`random_branch` → `true`/`false`; `repeat` → `body`/`after`;
  `priority` → `1`/`2`/`3`/`after` (capped at 3 candidates for the Phase 2
  UI); everything else → `next`. This mirrors `chain_walker.dart` exactly
  (`packages/sim_core/lib/src/interpreter/chain_walker.dart`), so a
  program built in the editor and one built directly as a `DagDef` behave
  identically. See `app/lib/features/workbench/branch_options.dart`.
- **`sim_core.resolveBattle` gained an opt-in `includeSnapshots` param**
  (`packages/sim_core/lib/src/replay/virus_snapshot.dart`) rather than the
  app reconstructing per-tick energy/memory state from events. Events
  don't carry every state mutation (e.g. energy spend isn't its own
  event), so exact reconstruction from events alone isn't possible; a
  resolver-side snapshot hook is the smallest change that keeps
  `resolveBattle` the single source of truth. Defaults to `false` (and is
  never requested by the PvP path) so wire logs stay small per §2.3; this
  doesn't change the golden hashes (verified: all 10 still match).
- **Local content is a bundled snapshot copied into `app/assets/content/`,
  not a build-time symlink/generation step.** Flutter's asset bundler
  needs real files inside the package; for Phase 2 (offline-only) a
  straight copy of `content/blocks.json`/`balance.json`/one training
  network is enough. A content-sync build step (so `app/assets/content/`
  can't silently drift from `content/`) is a Phase 3/4 concern once the
  remote-config path exists — noted here so it isn't forgotten.
- **One built-in training network (`content/networks/training_01.json`),
  not a network picker.** §3.3 allows testing "vs jaringan latihan
  pilihan" (a *choice* of training networks) — Phase 2 ships exactly one,
  since the curated topology set is Phase 3 scope (§5). The Test Run flow
  is built to take any `NetworkDef`, so adding more later is additive.
- **`BattleResult` gained `peakNoiseMeter` in Phase 3.** Mission "senyap"
  (silent) star criteria (§1.5) need to compare against the noise level
  reached during a run, but `BattleResult` only had score-derived
  aggregates. Added `peakNoiseMeter` (tracked in `SimState.addNoise`,
  highest value reached — not the final value, since noise decays over
  time and a late-battle lull would otherwise hide an earlier spike that
  should have failed the star). This changes `BattleResult`'s JSON shape,
  so **all 10 golden hashes were regenerated and re-pinned** in this same
  change (`tool/print_golden_hashes.dart` output verified stable across
  repeated runs before updating `expectedGoldenHashes`) — this is the
  "intentional balance/behavior update" path the golden test's own
  failure message describes, not a determinism regression.
- **`flutter analyze`/`flutter test` are what's actually verifiable
  here, not on-device performance.** "60fps di device mid-range" (§5
  Phase 2 AC) requires physical hardware profiling this sandbox doesn't
  have — see "Execution environment constraints" above. What's
  substituted: `flutter analyze` clean, and 21 passing tests covering the
  editor's logic layer (`WorkbenchController`, `TestRunController`,
  `PresetRepository`) plus widget tests exercising the real screen (add a
  block, budget counter updates, Test Run produces a scrubbable result).

## Phase 3

- **60 missions are generated, not hand-authored.** §3.5 explicitly allows
  this ("boleh generate draft lalu curated"). `tools/mission_gen` is a
  small deterministic generator: it assigns each of the 44 non-starter
  blocks an `unlock_mission` (chapters 1-5, ~1 unlock per mission,
  chapter 6 is a pure mastery gauntlet), and emits one procedurally-varied
  network per mission (chapter-scaled node count/firewall level, a simple
  quarantine-on-brute-force guard from chapter 3 onward). Re-running it is
  idempotent. This is a first-pass draft per the plan's own framing —
  hand-curation (real narrative writing, hand-designed topologies,
  difficulty tuning) is future work, not a Phase 3 blocker.
- **Starter kit includes `copy_data`.** The first generator draft starter
  set (wait/move_random/if_else/sequence/firewall_detected) had no way to
  actually exfiltrate data — chapter 1 would only ever earn the "selesai"
  star via surviving, never via a real objective. `copy_data` was moved
  into the starter kit so early missions have a genuine, completable
  attack loop from mission 1. Caught by `real_content_smoke_test.dart`
  asserting the starter kit contains it.
- **Mission "senyap" (silent) star needs `BattleResult.peakNoiseMeter`**,
  which didn't exist before Phase 3 — added to `sim_core`, all 10 golden
  hashes re-pinned accordingly (see the sim_core-specific note above).
- **Mission progression is strictly linear**, not a per-chapter unlock
  tree: mission N is available once mission N-1 has ≥1 star (chapter
  boundaries are cosmetic groupings in the UI, not separate gates). Simpler
  than modeling chapter-level gates for a first playable pass; revisit if
  playtesting (once real playtesters exist) shows players want to skip
  around within a chapter.
- **Flame renderer uses placeholder geometric shapes, not pixel-art
  sprites.** §1.8 specifies 16x16 pixel-art virus sprites, 32x32 node
  tiles, and per-action VFX (brute force = shake+spark, disguise = fade,
  etc.). No art asset pipeline or artist exists in this environment — see
  "Execution environment constraints" above. What's real and tested: a
  working Flame `FlameGame` (`ReplayGame`) that lays out the actual
  network graph (BFS-layered, left-to-right), reconstructs virus
  positions tick-by-tick purely from the `BattleLog` event stream (same
  approach a real PvP replay would use, no snapshot dependency), and
  drives play/pause/speed/scrub/skip-to-result — verified via a widget
  test that pumps the real `GameWidget`. Swapping circles for sprites and
  adding per-action VFX is additive once art exists.
- **No camera auto-follow / cinematic cuts to key events (§3.4).** The
  Phase 3 renderer uses a static camera over the whole laid-out network.
  Auto-follow-with-cuts is a real feature gap versus §3.4, not something
  this pass claims to have — noted here rather than silently dropped.
- **Playtest gate (§4.7: 10 non-gamer testers, <25% tutorial drop-off) is
  not verifiable in this environment** — it requires real human
  playtesters. See "Execution environment constraints" above;
  `docs/ACCEPTANCE.md` marks it ⛔ rather than claiming a pass.

## Phase 5

- **All six new meta/economy systems keep the Phase 4 pattern**: pure,
  `Session`-free business logic in `server/lib/src/business/`
  (`ProfanityFilter`, `ReverseEngineerProgress`, `DailyContractGenerator`,
  `SeasonRollover`, `BattlePassTierCalculator`, `ReceiptValidator`), each
  with real unit tests (41 new tests, 80 total in `server/test/business/`
  including Phase 4's), with thin `Endpoint` classes
  (`BlueprintEndpoint`, `ContractEndpoint`, `SeasonEndpoint`,
  `ShopEndpoint`, `TelemetryEndpoint`) doing only auth/lookup/persist glue
  around them. Same reasoning as Phase 4: it's the only way to get real
  coverage without a live database here.
- **Blueprint moderation only reaches `pending`→ automated states.**
  §2.5 describes filtering "melalui filter profanity + laporan pemain +
  moderation_state" — `BlueprintEndpoint.publish` runs the profanity
  filter on the title (rejecting outright via
  `BlueprintTitleRejectedException` rather than publishing then flagging,
  since that's strictly safer and just as simple), and every blueprint
  starts `moderationState=pending`. The player-report queue and a human
  moderator UI to move a blueprint to `approved`/`rejected`/`flagged` are
  out of scope here — there's no moderator dashboard to build that
  workflow against, and a fake one would just be unverified surface area.
  The schema (`BlueprintModerationState` enum, indexed column) is real
  and ready for that queue to be layered on.
- **`SimpleWordlistProfanityFilter.defaultFilter`'s banned-word set is a
  small placeholder**, not a production moderation wordlist/ML
  classifier. It's the intentionally-swappable seam (constructor takes
  any `Set<String>`), same spirit as `ReceiptValidator`.
- **Reverse-engineer progress counts total DAG nodes as "blocks"**
  (`VirusDef.program.nodes.length`), not distinct block *types* — matches
  §1.5.4's "replay 3x untuk 1 blok" read literally as one reveal unit per
  block instance in the design, which is also the simpler and
  monotonically-increasing definition (a design can't lose blocks between
  reveals).
- **Daily contract network topology is a fixed 8-node template**
  (entry → 3 relays → firewalled gate → data node, plus 2 unused spare
  relays for visual variety), with only firewall level (1-4) and data
  value (20-49) varying by date-derived seed. `DailyContractGenerator` is
  a pure function of the date string, verified deterministic and collision-
  free across dates in tests. A richer topology generator (varying node
  count/shape) is future work, not required for the "one puzzle per day,
  same for everyone" AC.
- **Season rollover is endpoint-triggered (`SeasonEndpoint.rolloverIfDue`),
  not cron-triggered.** §1.5.2 implies a scheduled 4-week rollover; this
  environment has no live deployment to attach a real Serverpod
  `FutureCall`/cron job to (same "never booted" constraint as Phase 4).
  `rolloverIfDue` is pure-logic-backed (`SeasonRollover.isDue`) and
  idempotent to call repeatedly, so wiring it to an actual scheduler
  later is a one-line addition, not a rewrite.
- **Battle pass premium track purchase grants immediately and
  permanently** for whichever season is current at purchase time — no
  handling of "buy premium mid-season vs next season" nuance beyond
  "premium applies to the season you bought it in." Simplest reading of
  §1.6 consistent with "no blok/kapasitas di track premium, cosmetics
  only."
- **IAP purchases always persist a `Purchase` row recording the outcome**,
  successful or not, and only grant the entitlement (keys credited,
  premium track flagged) when `ReceiptValidator.verify` reports valid.
  `ShopEndpoint.receiptValidator` defaults to
  `AlwaysRejectReceiptValidator` — see the Phase 4-referenced pattern in
  `receipt_validator.dart`'s own doc comment: this environment has no
  live Google Play / App Store service-account credentials, and a
  validator that silently approved everything would be a dangerous
  default to ship. The AC "purchase sandbox berhasil dua platform store
  API" is therefore **not verifiable in this environment** — see
  `docs/ACCEPTANCE.md`.
- **Telemetry events are ingested and stored, not visualized.**
  `TelemetryEndpoint.ingest` accepts a batch of client-shaped
  `TelemetryEvent` rows (attaching the authenticated player if any —
  events like first app open predate login) and persists them. §2.6's
  "event funnel tampil di dashboard analitik" needs a live
  analytics/BI tool (Grafana, Amplitude, etc.) reading this table, which
  doesn't exist in this environment — marked **not verifiable** in
  `docs/ACCEPTANCE.md`. The ingestion path itself, which is the part
  code can own, is real and covered by `dart analyze`.
- **`content/shop.json` (5 keys-pack SKUs + 1 battle-pass SKU) is bundled
  into `server/content/` like `blocks.json`/`balance.json`** (same
  manual-sync caveat as the Phase 2/4 entries), and validated by
  `tools/content_lint` via the new `validateSkuSet` check. It is *not*
  copied into `app/assets/content/` — no shop UI was built this phase
  (see below), so there's nothing client-side to consume it yet.
- **No client-side UI was built for blueprints, contracts, season/battle
  pass, or the shop.** Given the scope of six new backend systems, effort
  went into real, tested business logic and endpoints over placeholder
  screens with nothing behind them. The existing Phase 3 "coming soon"
  routes for these features are unchanged. This is a genuine gap against
  §5's Phase 5 scope, not a completed-but-untested corner — recorded
  here rather than silently left implicit.

## Phase 6

- **Balance pass methodology (§5 "balance pass via bot harness").**
  Phase 1 left all three `tools/bot_harness` archetypes outside the
  40-60% win-rate band (Ghost/Bulldozer at 66.7%, Hydra at 0%) — expected
  for untuned first-pass numbers. Rather than guessing at numbers,
  balance was tuned by instrumenting individual battles
  (`resolveBattle`'s event log) against the specific archetype/topology
  pairs that were winning/losing 100% of the time (results are
  deterministic per pair in this harness — no per-topology randomness
  affects win/loss, only which topologies an archetype can complete at
  all), identifying the exact mechanical cause of each all-or-nothing
  result, then adjusting the one block-cost lever closest to that cause:
  `disguise` energy cost 5→16 (Ghost was completing every chain length
  including the longest, undercosted for a strategy that pays it every
  tick), `brute_force` energy cost 8→35 (Bulldozer was affordably
  breaking every firewall level with margin to spare), `replicate`
  energy cost 20→2 (Hydra's flat replication tax plus the halving-per-
  split mechanic was leaving spawned copies with too little energy to
  ever reach data — even a near-zero flat cost still leaves the halving
  as the real, intentional "numbers over precision" tax the archetype's
  own doc comment describes), and `starting_energy` 100→160 (a shared
  buff needed to bring Hydra up at all, offset by the two nerfs above so
  Ghost/Bulldozer didn't just rise back out of band). Final state: all
  three archetypes land in [41.7%, 58.3%], verified stable at the full
  1000-seeds-per-pair run (`bot_harness: OK`). Changing `content/blocks.json`
  and `content/balance.json` this way is exactly the "content as data,
  no hardcoded balance" principle (§2.1) doing its job — no `sim_core`
  code changed, only data.
- **Balance pass re-pinned all 10 `sim_core` golden hashes** (7 of 10
  actually changed; `04_wait_forever_tick_cap`, `05_infinite_sensor_loop_stalls`,
  `06_self_destruct_immediately` didn't, since none of those scenarios'
  outcomes depend on disguise/brute_force/replicate/starting_energy).
  Same "intentional balance/behavior update" path as Phase 3's
  `peakNoiseMeter` addition: regenerated via
  `dart run packages/sim_core/tool/print_golden_hashes.dart`, confirmed
  stable across repeated runs, then updated `expectedGoldenHashes`.
- **Accessibility (§1.8) is a real, tested settings system**, not just
  the `colorblindSafe` theme parameter that already existed unused since
  Phase 0: `AccessibilitySettings` (colorblind palette, large text,
  reduce motion, CRT scanline toggle) persisted via `shared_preferences`
  (same `JsonBlobStorage` pattern as campaign/preset storage), wired live
  into `MaterialApp` (theme, `TextScaler`, `disableAnimations`, a
  `ScanlineOverlay`). Reduce-motion forcibly disables the scanline
  regardless of its own toggle, matching §1.8's "reduce-motion mode
  (matikan screen-shake/scanline)" literally. No screen-shake effect
  exists yet to disable (Phase 3 documented no VFX exists) — the toggle
  is real and ready for when one does.
- **Locale preference lives in the same `AccessibilitySettings` blob**
  rather than a second persisted settings object — simplest interpretation
  consistent with "one opaque settings blob mirrors `Player.settingsJson`
  server-side" already established in Phase 4's `PlayerEndpoint.updateSettings`
  doc comment, even though "locale" isn't strictly an accessibility
  concern. Revisit if the settings blob grows enough to warrant splitting.
- **Localization (§1.8/§5 "lokalisasi EN+ID") covers the Settings screen
  only, not the whole app.** Real `flutter gen-l10n` wiring (ARB files,
  `AppLocalizations`, `localizationsDelegates`/`supportedLocales` on
  `MaterialApp`, a working EN/ID picker) — verified via a decode-both-
  locales smoke test — but every other screen's strings (workbench,
  campaign, replay, etc.) remain hardcoded English. Full-app localization
  is a mechanical extension of this same pattern, not a redesign; scoped
  down here the same way Phase 3 scoped down pixel-art sprites to
  placeholder shapes — recorded as a known gap, not silently claimed.
- **Remote config (§2.1, §5) is a real, independently-tested mechanism on
  both sides, not wired end-to-end.** Server: `ContentEndpoint.currentVersion`/
  `fetchBundle`, versioned by `ContentVersion.hashFor` (a pure SHA-256 over
  the serialized blocks/balance/shop JSON — changes iff content actually
  changes, not a manually-bumped counter). Client:
  `RemoteConfigContentSync` (check version → skip or fetch → cache →
  never throw, falls back to whatever's cached on failure), tested
  against a fake `RemoteContentFetcher` with zero network dependency. Not
  wired into `ContentRepository.load()`'s boot path or connected to a
  real Serverpod-generated client — the app has never called the live
  server in this environment (same constraint as every other endpoint
  since Phase 4) and `app/` doesn't depend on `packages/shared_models` at
  all yet. The seam is real; the transport isn't verified.
- **Crash reporting (§5 "Sentry/Grafana") is a real capture path with no
  live backend.** `ErrorReporter` interface, wired into
  `FlutterError.onError`/`PlatformDispatcher.instance.onError` in
  `main.dart` so every uncaught error already flows through it;
  `ConsoleErrorReporter` is the shipped default (safe, requires no
  credentials); `CrashFreeSessionTracker` wraps it to count fatal errors
  per session — the client-side signal a real crash-free-sessions metric
  would aggregate across users. No `SentryErrorReporter` is implemented
  — no live DSN to send to or verify against in this environment — same
  "seam real, backend not" pattern as `ReceiptValidator` (Phase 5).
- **Video replay export (§1.7) encodes an animated GIF, not an MP4.**
  Flutter has no built-in video encoder and this sandbox has no `ffmpeg`
  binary to shell out to. `ReplayGifExporter` reuses the exact same
  `computeNetworkLayout`/`computeReplayFrame` the Flame renderer uses and
  the same placeholder circle/line geometry (§3, Phase 3's "no pixel-art
  sprites yet" decision), rasterizing each sampled tick via `package:image`
  and encoding a real multi-frame GIF — verified by decoding it back and
  checking frame count/dimensions, not just checking the byte count is
  nonzero. A GIF is a legitimate short shareable clip for the same
  TikTok/Shorts hook §1.7 describes, just not the literal container
  format named. The replay screen's export button renders the clip and
  reports its size; it does not yet save to disk or open a share sheet
  (`path_provider`/`share_plus` aren't dependencies here) — documented as
  the next step, not silently absent.
- **`PlayerEndpoint.deleteAccount` was added mid-phase**, discovered as a
  genuine gap while writing `docs/STORE_COMPLIANCE.md` (both major
  stores require an in-app account/data deletion path). It deletes the
  `AuthUser`; every owned table cascades via its own already-declared
  `relation(onDelete=Cascade)` back through `Player`, so this is a
  one-line business operation, not a manual sweep. No client UI calls it
  yet — recorded as a pre-launch blocker in `docs/SOFT_LAUNCH_CHECKLIST.md`,
  not silently left undone.
- **`docs/RUNBOOK.md`, `docs/STORE_LISTING.md`, `docs/STORE_COMPLIANCE.md`,
  `docs/SOFT_LAUNCH_CHECKLIST.md` are real, complete documents**, not
  placeholders — every status marker in them (✅/⚠️/⛔) reflects something
  actually verifiable in this repository, cross-checked against the
  actual data models and endpoints rather than written generically. Items
  that need infrastructure this environment doesn't have (live store
  consoles, a hosted privacy policy, a device to capture screenshots) are
  marked ⛔ with the specific missing precondition named, per the
  "Execution environment constraints" rule at the top of this file.
- **The AC items requiring live users are still not verifiable here**:
  "crash-free sessions >99.5% di soft launch" and "D1 retention terukur"
  both need real installs and a live analytics backend aggregating
  `TelemetryEvent` rows over real time — the ingestion/tracking mechanism
  on both is real and tested (see above); the metric itself cannot exist
  without users. Marked ⛔ in `docs/ACCEPTANCE.md`, consistent with every
  prior phase's handling of this same category of AC.
