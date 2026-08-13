# PAYLOAD

Async PvP "AI battler" + puzzle programming, hacker theme. Full production
spec: [`PAYLOAD_PLAN.md`](./PAYLOAD_PLAN.md). Execution status per phase:
[`docs/CHANGELOG.md`](./docs/CHANGELOG.md), acceptance criteria:
[`docs/ACCEPTANCE.md`](./docs/ACCEPTANCE.md), interpretation decisions:
[`docs/DECISIONS.md`](./docs/DECISIONS.md). Launch-readiness docs:
[`docs/RUNBOOK.md`](./docs/RUNBOOK.md),
[`docs/STORE_LISTING.md`](./docs/STORE_LISTING.md),
[`docs/STORE_COMPLIANCE.md`](./docs/STORE_COMPLIANCE.md),
[`docs/SOFT_LAUNCH_CHECKLIST.md`](./docs/SOFT_LAUNCH_CHECKLIST.md).

## Layout

```
packages/sim_core/       deterministic battle simulation core (pure Dart)
packages/content_schema/ models + validators for content/ JSON
packages/shared_models/  Serverpod-generated client protocol (regen via `serverpod generate` in server/)
app/                      Flutter + Flame client
server/                   Serverpod backend (auth, defense, battle endpoints)
content/                  blocks.json, missions/, networks/, balance.json
tools/                    content_lint, balance_sim, bot_harness, mission_gen
```

## Getting started

Requires the Flutter SDK (stable channel; bundles a matching Dart SDK) and
`serverpod_cli` (`dart pub global activate serverpod_cli`) if you're
touching `server/` models or endpoints. Since `app/` and `server/` both
joined the workspace (`flutter: sdk: flutter` / Serverpod's own
dependencies), use `flutter pub get`/`flutter analyze` for the whole
workspace — plain `dart pub get` can no longer resolve it.

```bash
flutter pub get                                       # resolves the whole workspace
flutter analyze                                        # lint the whole workspace
dart run tools/content_lint/bin/content_lint.dart content   # validate content/
(cd packages/sim_core && dart test)                     # sim_core unit + golden tests
dart run packages/sim_core/tool/print_golden_hashes.dart    # golden hashes (run from repo root)
dart run tools/bot_harness/bin/bot_harness.dart [--seeds=1000]   # balance regression report
dart run tools/mission_gen/bin/generate_missions.dart content    # (re)generate the 60-mission campaign
cp content/blocks.json content/balance.json app/assets/content/ && cp content/missions/*.json app/assets/content/missions/ && cp content/networks/*.json app/assets/content/networks/   # sync into the app bundle (manual for now, see docs/DECISIONS.md)
cp content/blocks.json content/balance.json content/shop.json server/content/   # sync into the server's own bundled copy
(cd app && flutter pub get)                             # also regenerates lib/l10n/app_localizations*.dart from lib/l10n/app_{en,id}.arb (flutter: generate: true)
(cd app && flutter test)                                # full app test suite (editor, campaign, replay, accessibility, l10n)
(cd app && flutter run)                                 # launch the client (needs a device/emulator)
(cd server && dart test test/business)                  # server business-logic tests (no live DB needed)
(cd server && serverpod generate)                       # regenerate protocol/db code after editing lib/src/models/*.spy.yaml
docker compose -f server/docker-compose.yaml up -d      # local Postgres + Redis for the server
(cd server && dart bin/main.dart --apply-migrations)     # run the server against the local DB (needs the compose services up)
```

**Not verifiable in this sandbox** (see `docs/DECISIONS.md`): the server
has never actually been booted here — there's no Docker daemon available
in this environment, so `docker compose` and any live-database
integration test can't run. Everything under `server/lib/src/business/`
is pure logic with no database dependency and *is* fully tested; the thin
`Endpoint` wrappers around it are correct by code review and
`dart analyze`, not by an observed successful boot.
