# PAYLOAD Ops Runbook

§5 Phase 6 deliverable ("runbook ops"). Written against the real
architecture built in this repo (Serverpod 3.4.11 + Postgres + Redis,
`server/docker-compose.yaml`). **None of the procedures below have been
executed against a live deployment in this environment** — there is no
Docker daemon available here (see `docs/DECISIONS.md`, "Execution
environment constraints"), so every command is the correct one per the
Serverpod/Docker documentation and this repo's own configuration, but is
unverified end-to-end. Treat first execution in a real environment as a
dry run, not as "this has been proven to work."

## 1. Architecture at a glance

- `server/` — Serverpod app. Endpoints under `server/lib/src/endpoints/`,
  pure business logic under `server/lib/src/business/` (unit-tested
  without a database), models under `server/lib/src/models/*.spy.yaml`.
- Postgres (pgvector/pg16) — primary datastore, port 8090 (dev), 9090
  (test), per `server/docker-compose.yaml`.
- Redis — port 8091 (dev), 9091 (test). Currently unused by application
  code (`BattleEndpoint.submitAttack` resolves synchronously in-request
  rather than through a Redis queue — see `docs/DECISIONS.md` Phase 4);
  provisioned for when that changes.
- `content/*.json` — blocks/balance/shop, bundled into both `server/content/`
  and `app/assets/content/`. `ContentEndpoint` (Phase 6) serves a versioned
  copy for remote-config-style pushes without an app release.

## 2. Deploying

```bash
cd server
docker compose up -d          # starts Postgres + Redis
dart bin/main.dart --apply-migrations
```

`serverpod generate` must be re-run (and its output committed) after any
`.spy.yaml` model or endpoint signature change, before `dart bin/main.dart`
will reflect it:

```bash
cd server
serverpod generate
dart analyze     # must be clean before deploying
dart test test/business    # must be green before deploying
```

## 3. Rollback

Serverpod migrations are additive-by-default and reversible via the
migration history in `server/migrations/`. To roll back:

```bash
cd server
dart bin/main.dart --role maintenance --apply-repair-migration <migration-id>
```

Application rollback is a standard container redeploy to the previous
image tag — no in-place code hot-swap is supported.

## 4. Monitoring (§5 "Sentry/Grafana")

No live Sentry/Grafana instance exists in this environment to configure
and verify against. What's real and ready to wire up:

- **Client crash reporting**: `app/lib/features/core/diagnostics/error_reporter.dart`
  — every uncaught Flutter/Dart error already flows through the
  `ErrorReporter` interface (wired in `main.dart`'s `FlutterError.onError`
  and `PlatformDispatcher.instance.onError`). Swap `ConsoleErrorReporter`
  for a `SentryErrorReporter` implementation once a DSN exists; no other
  code changes.
- **Server-side telemetry**: `TelemetryEndpoint.ingest` (Phase 5) persists
  client funnel events (`telemetry_events` table). A Grafana dashboard
  reading that table is the natural next step — not built here, no live
  Grafana to point it at.
- **Suggested alerts once live**: battle resolution error rate, `Purchase`
  rows stuck in `pending` past a few minutes, `content_endpoint` version
  hash unexpectedly changing (accidental content drift), Postgres
  connection pool saturation.

## 5. Common incidents (playbook)

| Symptom | Likely cause | First steps |
|---|---|---|
| `serverpod generate` fails after a model edit | Invalid `.spy.yaml` relation/field syntax | Re-read the exact error — Serverpod's error messages are precise; see `docs/DECISIONS.md` Phase 4/5 for the specific syntax gotchas already hit in this codebase (nullable relation fields, `relation(optional, onDelete=...)`, bare enum names in `defaultModel=`). |
| Battles failing validation for real players | `content/blocks.json` drifted between `server/content/` and `app/assets/content/` | Diff the two copies; the server is always authoritative (§2.1) — sync the client copy to match, not the other way around. |
| Golden hash CI job fails after a content/balance change | Expected — see `sim_core/test/golden_test.dart`'s own failure message | Confirm the change was intentional, regenerate via `dart run packages/sim_core/tool/print_golden_hashes.dart`, update `expectedGoldenHashes`. Never update the hash to hide an unintended determinism regression. |
| Bot-harness balance gate fails (§4.3) | A block/balance tweak pushed an archetype's win-rate outside 40-60% | Re-run `dart run tools/bot_harness/bin/bot_harness.dart`, identify which archetype/topology flipped, adjust the specific block cost responsible (see the Phase 6 balance-pass methodology in `docs/DECISIONS.md`) rather than broad multipliers. |
| A player reports a purchase charged but not credited | `Purchase.state == failed` despite a real store charge | Check `ShopEndpoint.receiptValidator`'s actual implementation once live — this environment ships only `AlwaysRejectReceiptValidator`, which never grants an entitlement; a live deployment must swap in real store validators before this stops being expected. |

## 6. On-call

Not staffed in this environment (no live service, no users). When this
goes live: define an escalation path here (primary/secondary rotation,
paging tool, response-time SLA) before soft launch — this is a real gap,
not filled in with placeholders that would misrepresent readiness.
