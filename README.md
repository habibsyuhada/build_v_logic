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

Requires the Flutter SDK (stable channel; bundles a matching Dart SDK).
Since `app/` joined the workspace in Phase 2 (`flutter: sdk: flutter`),
use `flutter pub get`/`flutter analyze` for the whole workspace — plain
`dart pub get` can no longer resolve it.

```bash
flutter pub get                                       # resolves the whole workspace
flutter analyze                                        # lint the whole workspace (app/ + pure-Dart packages)
dart run tools/content_lint/bin/content_lint.dart content   # validate content/
(cd packages/sim_core && dart test)                     # sim_core unit + golden tests
dart run packages/sim_core/tool/print_golden_hashes.dart    # golden hashes (run from repo root)
dart run tools/bot_harness/bin/bot_harness.dart [--seeds=1000]   # balance regression report
(cd app && flutter test)                                # workbench/Test Run widget + logic tests
(cd app && flutter run)                                 # launch the client (needs a device/emulator)
docker compose up -d postgres redis                     # local dev infra
```
