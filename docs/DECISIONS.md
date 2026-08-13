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
- **Block balance numbers (Phase 0 authoring pass).** §1.3 specifies cost
  *ranges* (sensor 1-5KB, action 2-14KB, control flow 1-3KB, memory 3-6KB)
  but not exact per-block numbers. `content/blocks.json` assigns concrete
  values within those ranges based on relative power (e.g. `replicate` at
  14KB/20 energy/6 noise is the most expensive action; `wait`/
  `self_destruct` at 0 energy since they either do nothing or end the
  virus). These are a first pass, meant to be tuned by `tools/bot_harness`
  in Phase 1 per the §4.3 balance gate — not treated as final.
