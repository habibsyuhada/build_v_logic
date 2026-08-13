# Soft Launch Checklist — PAYLOAD (1 country)

§5 Phase 6 deliverable ("soft-launch checklist (1 negara)"). Status
reflects what's genuinely true in this repository/environment today, not
an aspirational target. Legend: ✅ done and verified here, ⚠️ done but
unverified against a live deployment (no infra in this environment — see
`docs/DECISIONS.md`), ⛔ not done / not possible in this environment.

## Engineering readiness

| Item | Status | Note |
|---|---|---|
| `sim_core` deterministic across platforms | ✅ | Golden hash CI job diffs ubuntu-latest vs macos-latest (§4.2) |
| Client analyzes/tests clean | ✅ | `flutter analyze --fatal-infos`, all `app/` tests passing |
| Server analyzes/tests clean | ✅ | `dart analyze`, all `server/test/business` passing |
| Server boots against live Postgres/Redis | ⛔ | No Docker daemon in this environment — never executed here |
| Load test (§4.6: 500 battle/min) | ⛔ | Needs a running server |
| Balance gate (§4.3: 3 archetypes within 40-60% win-rate) | ✅ | `tools/bot_harness` passes at 1000 seeds/pair (Phase 6 balance pass) |
| Content validated (`content_lint`) | ✅ | Clean against `content/` and `server/content/` |
| CI green on GitHub Actions | ⚠️ | Config validated locally; not observed running on a GitHub-hosted runner from this sandbox |

## Store readiness

| Item | Status | Note |
|---|---|---|
| Store listing copy (EN+ID) | ✅ | `docs/STORE_LISTING.md` |
| Screenshots/icon/feature graphic | ⛔ | No art pipeline / device in this environment |
| Data Safety / Privacy Nutrition Label answers | ✅ | `docs/STORE_COMPLIANCE.md` |
| IARC rating questionnaire answers | ✅ | `docs/STORE_COMPLIANCE.md` |
| Privacy policy published at a URL | ⛔ | Content basis exists, not hosted |
| Account deletion path | ⚠️ | Server endpoint exists (`PlayerEndpoint.deleteAccount`); no client UI entry point yet |
| IAP products configured in store consoles | ⛔ | Needs live Play Console / App Store Connect access this environment doesn't have |

## Operational readiness

| Item | Status | Note |
|---|---|---|
| Ops runbook | ✅ | `docs/RUNBOOK.md` |
| Crash reporting wired client-side | ✅ | `ErrorReporter` + `CrashFreeSessionTracker`, seam ready for a real Sentry backend |
| Crash-free session dashboard | ⛔ | Needs a live Sentry/analytics backend |
| On-call rotation defined | ⛔ | No team/service exists yet to staff one |
| Remote config delivery | ✅ | `ContentEndpoint` (server) + `RemoteConfigContentSync` (client), tested independently; not yet wired end-to-end against a live server |

## Player-facing readiness

| Item | Status | Note |
|---|---|---|
| Accessibility (§1.8: colorblind palette, large text, reduce motion) | ✅ | `SettingsScreen`, tested |
| Localization EN+ID | ⚠️ | Settings screen fully localized; most other screens remain English-only — see `docs/DECISIONS.md` Phase 6 for scope |
| Tutorial / onboarding drop-off measured | ⛔ | Needs real players (§4.7 playtest gate, already ⛔ since Phase 3) |
| D1 retention measurable | ⛔ | Needs real users and a live analytics pipeline consuming `TelemetryEvent` |

## Go/no-go

**No-go for this environment**, and correctly so: soft launch requires a
live server deployment, real store accounts, and real users, none of
which exist in this sandbox. Every item above marked ⛔ is a concrete,
named blocker for a human team picking this project up — not a vague
"more work needed." Everything marked ✅ is genuinely done and covered by
passing automated tests or real, reviewable documents.
