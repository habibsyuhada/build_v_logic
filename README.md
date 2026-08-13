# PAYLOAD

Async PvP "AI battler" + puzzle programming, hacker theme. Full production
spec: [`PAYLOAD_PLAN.md`](./PAYLOAD_PLAN.md). Execution status per phase:
[`docs/CHANGELOG.md`](./docs/CHANGELOG.md), acceptance criteria:
[`docs/ACCEPTANCE.md`](./docs/ACCEPTANCE.md), interpretation decisions:
[`docs/DECISIONS.md`](./docs/DECISIONS.md).

## Layout

```
packages/sim_core/       deterministic battle simulation core (pure Dart)
packages/content_schema/ models + validators for content/ JSON
packages/shared_models/  client<->server DTOs (populated in Phase 4)
app/                      Flutter + Flame client
server/                   Serverpod backend (Phase 4)
content/                  blocks.json, missions/, networks/, balance.json
tools/                    content_lint, balance_sim, bot_harness
```

## Getting started

Requires the Dart SDK (`^3.9.0`).

```bash
dart pub get                                          # resolves the whole workspace
dart analyze                                           # lint the whole workspace
dart run tools/content_lint/bin/content_lint.dart content   # validate content/
(cd packages/sim_core && dart test)                     # sim_core unit + golden tests
docker compose up -d postgres redis                     # local dev infra
```
