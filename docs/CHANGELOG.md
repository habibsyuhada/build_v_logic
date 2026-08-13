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
