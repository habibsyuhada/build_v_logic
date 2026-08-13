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
- **Block balance numbers (Phase 0 authoring pass).** §1.3 specifies cost
  *ranges* (sensor 1-5KB, action 2-14KB, control flow 1-3KB, memory 3-6KB)
  but not exact per-block numbers. `content/blocks.json` assigns concrete
  values within those ranges based on relative power (e.g. `replicate` at
  14KB/20 energy/6 noise is the most expensive action; `wait`/
  `self_destruct` at 0 energy since they either do nothing or end the
  virus). These are a first pass, meant to be tuned by `tools/bot_harness`
  in Phase 1 per the §4.3 balance gate — not treated as final.
