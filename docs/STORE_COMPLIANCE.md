# Store Compliance Checklist — PAYLOAD

§5 Phase 6 deliverable ("checklist store compliance (Play Data Safety,
rating IARC) lengkap"). Answers below are derived directly from what the
codebase actually does — the data models in `server/lib/src/models/`, the
endpoints in `server/lib/src/endpoints/`, and the client code in `app/` —
not filled in generically. Where the repo genuinely doesn't do something
(ads, location, third-party analytics SDKs), it's marked "not collected",
truthfully, because it isn't implemented.

## Google Play — Data Safety form

### Does your app collect or share any of the required user data types?

**Yes.** Summary of what's actually persisted server-side, by table:

| Data type | Collected? | Where | Purpose | Shared with third parties? |
|---|---|---|---|---|
| Account info (handle/display name) | Yes | `Player.handle` | App functionality (identify the player) | No |
| User IDs | Yes | `Player.id`, `AuthUser` (via `serverpod_auth`) | App functionality, account management | No |
| App activity (in-app actions: battles, missions, purchases) | Yes | `Battle`, `ContractScore`, `SeasonResult`, `Purchase`, `BlueprintReveal` | App functionality, analytics (own, not third-party) | No |
| App interactions (telemetry funnel events) | Yes | `TelemetryEvent.eventType`/`propertiesJson` | Analytics (own dashboard, §2.6) | No |
| Purchase history | Yes | `Purchase.sku`, `Purchase.state` | App functionality (entitlement grants), fraud prevention | Store receipt itself is sent to the platform's own store API for verification — see "Third-party sharing" below |
| User-generated content (blueprint titles, virus designs) | Yes | `Blueprint.title`, `Blueprint.virusDefJson` | App functionality (the blueprint-sharing feature itself) | Visible to other players in-app by design, once `moderationState == approved` |
| Precise/approximate location | **No** | — | Not collected | — |
| Contacts | **No** | — | Not collected | — |
| Photos/videos/audio | **No** | — | Not collected. The client-side GIF replay export (§1.7) is rendered and would be shared by the *user*, at their own action — the app itself never reads the device's media library. | — |
| Financial info beyond purchase history (e.g. card numbers) | **No** | — | Payment handled entirely by the platform's own IAP flow; `Purchase.storeReceipt` is an opaque receipt token, not card data | — |
| Health/fitness | **No** | — | Not collected | — |
| Advertising ID | **No** | — | No ad SDK is integrated (§1.6: "Tanpa iklan interstitial") | — |
| Device/other IDs | Only what `serverpod_auth`'s session/JWT tokens require for auth | — | App functionality (keeping a login session valid) | No |

### Is all of the user data collected by your app encrypted in transit?

Required: **Yes** (Serverpod's HTTP API must be served over TLS in
production — this is a deployment configuration item, not a code change;
flag it explicitly in the pre-launch checklist below rather than assuming
it's automatic).

### Does your app provide a way for users to request data deletion?

**Yes.** `PlayerEndpoint.deleteAccount` deletes the underlying `AuthUser`;
every owned row (`Unlock`, `Defense`, `Battle`, `Blueprint`, `Purchase`,
`BattlePassProgress`, `ContractScore`, `SeasonResult`, `VirusPreset`)
cascades via each model's `relation(onDelete=Cascade)` back to `Player`,
which itself cascades from `AuthUser` the same way. Not yet exposed in
the client UI (no account/settings screen calls it yet) — the server-side
capability required by store policy exists; wiring a "delete my account"
button into `SettingsScreen` is the remaining client-side step.

## Apple App Store — Privacy Nutrition Label

Same underlying data as the Play Data Safety table above, categorized
per Apple's taxonomy: **Contact Info** (handle — "linked to you", used
for App Functionality), **Identifiers** (user ID — linked, App
Functionality), **Purchases** (linked, App Functionality), **User
Content** (blueprint titles/designs — linked, App Functionality),
**Usage Data** (telemetry events — linked, Analytics). No data in Apple's
"Data Used to Track You" category — there is no cross-app/cross-site
tracking, no advertising SDK.

## IARC / content rating questionnaire

Answers reflect the actual game content (§1: hacking-themed visual
programming PvP, no real-world violence):

| Question | Answer | Basis |
|---|---|---|
| Violence — realistic | No | Combat is abstract (data exfiltration/firewall breach), no depicted injury |
| Violence — cartoon/fantasy | Minor | Virus/defense "combat" is symbolic (network nodes, not characters) |
| Blood/gore | None | Not depicted |
| Sexual content | None | Not present |
| Profanity/crude humor | Handled, not authored | Player-generated blueprint titles pass through `SimpleWordlistProfanityFilter` (§2.5) before publishing — see `server/lib/src/business/profanity_filter.dart` |
| Controlled substances | None | Not present |
| Gambling — simulated | No | No slot-machine/loot-box-with-odds mechanic; `content/shop.json` SKUs are fixed-price, fixed-quantity keys packs and a battle pass, not randomized loot |
| User-generated content shared with others | Yes | Blueprint titles + designs (moderated — see above) |
| In-app purchases | Yes | 5 keys-pack tiers + 1 battle pass SKU, cosmetic-only per §1.6 |
| Users can interact/communicate | Limited | No free-text chat exists in this build; blueprint titles are the only free-text field visible to other players, and it's profanity-filtered |
| Shares location | No | — |

**Likely resulting rating band**: PEGI 7 / ESRB Everyone or Everyone 10+
equivalent — final determination is made by the platform's own IARC
questionnaire submission, not by this document; the answers above are
what should be entered into it truthfully.

## Pre-launch blockers (not yet done, tracked honestly)

1. A "delete my account" button in the client UI calling the (already
   implemented) `PlayerEndpoint.deleteAccount` — the server-side capability
   exists, the client-side entry point doesn't yet.
2. Privacy policy needs to be drafted in full legal form and hosted at a
   real URL (this doc's data table is the factual basis for it, not a
   substitute for it).
3. TLS termination confirmed in front of the production Serverpod
   deployment.
4. Terms of Service for the blueprint-sharing / user-generated-content
   feature (required once UGC is visible to other users).
