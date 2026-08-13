# PAYLOAD — Production Plan

> Game mobile pixel-art bertema hacker: pemain **memprogram virus** dari blok logika visual, melepasnya ke jaringan pertahanan pemain lain (async PvP), dan menonton hasilnya sebagai replay. Pemain juga mendesain pertahanan yang diprogram dengan bahasa blok yang sama.
>
> Dokumen ini adalah **spesifikasi produksi lengkap** (bukan MVP). Ditulis untuk dieksekusi bertahap oleh AI coding agent (Claude Code). Kerjakan fase secara berurutan; setiap fase punya *acceptance criteria* yang harus lulus sebelum lanjut.

---

## 0. Ringkasan Eksekutif

| Aspek | Keputusan |
|---|---|
| Genre | Async PvP "AI battler" + puzzle programming, tema hacker |
| Platform | Android (rilis pertama), iOS (menyusul, arsitektur harus siap sejak awal) |
| Art style | Pixel art, estetika terminal/CRT, dark theme default |
| Sesi target | 3–15 menit per sesi |
| Model bisnis | Free-to-play; monetisasi kosmetik + battle pass. **Tidak ada pay-to-win.** Semua blok logika dibuka lewat gameplay |
| Client | Flutter + Flame engine (Dart) |
| Backend | Dart (Serverpod) — satu bahasa untuk client, server, dan simulation core |
| Database | PostgreSQL (via Serverpod) + Redis (cache/queue/leaderboard) |
| Prinsip teknis inti | **Simulasi deterministik** — satu package `sim_core` dipakai client & server; server otoritatif untuk PvP |

### Pilar desain (jangan dilanggar oleh keputusan apa pun)

1. **"Aku pintar" bukan "aku beruntung"** — hasil pertarungan 100% ditentukan logika yang dirakit pemain (PRNG selalu seeded dan bisa direplay).
2. **Menonton harus seru** — replay adalah panggung; virus adalah karakter. Animasi, kegagalan konyol, dan momen dramatis adalah konten.
3. **Tidak ada satu virus terbaik** — sistem biaya (ukuran/energi/kebisingan) menjaga meta batu-gunting-kertas.
4. **Onboarding tanpa terasa belajar** — blok baru diperkenalkan lewat misi yang mustahil tanpa blok itu; nol dinding teks.

---

## 1. Game Design Specification

### 1.1 Loop inti

```
RAKIT virus di workbench
  → UJI di simulator lokal (jaringan latihan / replay lama)
  → LEPAS ke target (kampanye PvE, atau jaringan pemain lain via matchmaking async)
  → TONTON replay (server-generated, deterministik)
  → PELAJARI kegagalan → tambal logika → ulangi
Paralel: BANGUN pertahanan (topologi + defense-logic) → diserang saat offline → tonton replay pagi hari
```

### 1.2 Model dunia simulasi

- **Jaringan** = graph berarah dari **node** (8–40 node per jaringan). Node punya tipe: `entry`, `relay`, `data`, `core`, `honeypot`, `trap`, `firewall_gate`.
- **Virus** = agen yang berpindah antar node per **tick**. Satu battle maksimal **600 tick** (hard cap, anti infinite-loop).
- Properti node: `firewall(level, exploit_ids[])`, `data(value, verified)`, `traffic_level`, `log_present`, `av_route (untuk antivirus patroli)`.
- Properti virus runtime: `energy`, `noise_meter (global per battle)`, `position`, `memory_flags`, `inventory (data yang dibawa)`, `alive`.
- **Alarm global**: `noise_meter` naik dari aksi bising; melewati threshold → jaringan masuk mode alert (antivirus lebih agresif, firewall menguat).
- **Skor battle** = f(data value dibawa keluar, log dihapus, exit bersih vs mati, tick efisiensi).

### 1.3 Sistem blok logika

Virus dan pertahanan diprogram dengan **flowchart blok** (drag & drop, tanpa mengetik). Representasi internal: **DAG JSON** (lihat §3.3), dieksekusi interpreter di `sim_core`.

#### Keluarga blok — daftar lengkap rilis (final content list)

**Sensor (kondisi, hasil ya/tidak)** — biaya 1–5 KB:
`firewall_detected`, `firewall_level_gt(x)`, `firewall_has_exploit(id)`, `antivirus_here`, `antivirus_nearby`, `node_has_data`, `data_verified`, `traffic_high`, `energy_below(x%)`, `node_visited_before`*, `alarm_active`, `carrying_data`, `at_entry_node`, `random_chance(x%)`, `tick_gt(x)`, `copies_alive_gt(x)`

**Aksi** — biaya 2–14 KB, masing-masing punya `energy_cost` dan `noise`:
`move_random`, `move_toward_data`†, `move_toward_exit`†, `move_back`, `brute_force`, `exploit(id)`, `disguise`, `copy_data`, `delete_log`, `plant_backdoor`, `replicate`, `self_destruct`, `wait`

† pathfinding hanya berdasarkan info yang sudah "terlihat" virus (fog of war) — bukan omniscient.
\* butuh slot memori.

**Kontrol alur** — biaya 1–3 KB:
`if_else`, `priority(try A→B→C)`, `repeat(x)`, `random_branch(50/50)`, `sequence`

**Memori & timer** — biaya 3–6 KB:
`mark_node`, `node_marked?`, `counter_inc / counter_gt(x)`, `timer_after(x ticks)`

**Blok pertahanan (dipakai di node defender)**:
sensor: `intruder_detected`, `intruder_copying`, `intruder_bruteforcing`, `noise_gt(x)`
aksi: `quarantine`, `lockdown_node`, `raise_alarm`, `reroute_av`, `fake_data_swap`, `trace(mengurangi skor penyerang)`

#### Aturan biaya & kapasitas

- Kapasitas virus awal 40 KB → naik bertahap via progression sampai **90 KB** (hard cap rilis).
- **Ukuran total menentukan deteksi pasif**: `stealth_rating = f(size)`; ≤25 KB = di bawah radar antivirus standar; ≥60 KB = auto-flag saat masuk node ber-antivirus.
- Energi awal 100; setiap aksi mengkonsumsi; energi 0 = virus mati di tempat (log tertinggal → skor minus).
- Semua angka biaya/energi/noise berada di **satu file balance data** (`content/blocks.json`) — bukan hardcode — agar bisa di-tune tanpa release baru (remote config).

### 1.4 Sisi bertahan

- Pemain menyusun **topologi jaringan** dari budget poin: memilih layout node (dari pola dasar + kustomisasi edge), menempatkan data, honeypot, trap, firewall (level & jenis exploit-hole), rute patroli antivirus.
- Node `core` menyimpan resource pemain; jaringan **selalu punya minimal 1 jalur valid entry→data** (validator otomatis, anti "turtle" tak tersentuh).
- Defense-logic per node maksimal 6 blok — pertahanan sengaja lebih sederhana dari serangan agar meta tetap menyerang-dominan (lebih seru).
- Saat diserang offline: hasil dihitung server, defender dapat notifikasi + replay.

### 1.5 Progresi & mode

1. **Kampanye PvE** — 6 chapter × 10 misi (60 misi rilis). Fungsi: tutorial terdistribusi (tiap blok baru = 1 misi pengenalan), narasi ringan (kamu hacker lepas menaiki tangga dunia bawah), sumber unlock blok & kapasitas. Misi 3-star: selesai / senyap (noise < X) / efisien (tick < Y).
2. **PvP async ladder** — matchmaking berdasar rating (Elo-like, K disesuaikan), musim 4 minggu, reward kosmetik. Serangan memakai "attack energy" (regen 1/30 menit, max 5) — pacing, bukan paywall.
3. **Ghost network** — bot defender yang meniru snapshot pertahanan pemain nyata (anonymized) supaya matchmaking tidak pernah kosong sejak hari pertama.
4. **Blueprint sharing** — publish desain virus; pemain lain melihat *hasilnya* tapi harus **reverse-engineer** (mini-puzzle: replay virus tersebut 3x untuk "membaca" 1 blok) sebelum bisa meng-copy. Blueprint punya halaman, like, dan leaderboard mingguan.
5. **Daily contract** — 1 jaringan puzzle harian buatan sistem (seeded dari tanggal), leaderboard skor global.

### 1.6 Ekonomi & monetisasi

- **Soft currency** `credits`: dari misi, kontrak harian, PvP. Dipakai untuk unlock slot preset virus, respec topologi.
- **Premium currency** `keys`: dibeli / battle pass. **Hanya untuk kosmetik**: skin virus (sprite + trail effect), tema jaringan/terminal, banner profil, emote replay.
- **Battle pass** musiman (free track + premium): progres dari XP battle. Tidak ada blok/kapasitas di track premium.
- IAP: paket keys 5 tier + battle pass. Tanpa iklan interstitial; opsional rewarded ad untuk +1 attack energy (max 3/hari).

### 1.7 Retensi & sosial

- Push notification: "jaringanmu diserang (berhasil bertahan/dibobol)", "virusmu menyelesaikan serangan", kontrak harian reset, musim berakhir.
- Replay bisa di-export sebagai video pendek (render offline di client) — hook viral TikTok/Shorts.
- Friend list + serang-teman (unranked), clan ringan (chat + leaderboard internal) di post-launch backlog, **bukan** scope rilis.

### 1.8 Art direction

- Pixel art 1x asset di grid 16px, render scale integer; palet gelap + neon (hijau terminal, magenta, cyan).
- Virus = sprite 16×16 dengan 4 frame idle + 4 frame move + death animation; skin mengganti sprite sheet.
- Node = tile 32×32; jaringan digambar sebagai peta sirkuit; replay memakai kamera auto-follow virus.
- UI: font monospace pixel, efek CRT scanline *opsional* (toggle, off by default demi baterai & aksesibilitas).
- Aksesibilitas: colorblind-safe palette alternatif, ukuran font L, reduce-motion mode (matikan screen-shake/scanline), semua info warna selalu didampingi ikon.

---

## 2. Arsitektur Teknis

### 2.1 Prinsip

1. **`sim_core` adalah satu-satunya sumber kebenaran gameplay.** Package Dart murni (tanpa dependensi Flutter/IO), deterministik: integer/fixed-point math saja, PRNG xoshiro seeded, iterasi collection selalu terurut stabil. Client memakainya untuk mode uji & merender replay; server memakainya untuk resolusi otoritatif.
2. **Server otoritatif untuk semua yang bernilai kompetitif.** Client tidak pernah mengirim "hasil", hanya mengirim *input* (definisi virus + target). Server menjalankan sim, menyimpan `battle_log`, mengirim log ke client untuk dirender.
3. **Replay = event log, bukan video.** `battle_log` adalah array event per tick; client mem-playback dengan `sim_core` + layer animasi. Ukuran kecil, bisa dibagikan.
4. **Content as data.** Semua definisi blok, misi, balance, topologi preset = JSON di `content/`, diversioning, dan bisa dipush via remote config tanpa app update.

### 2.2 Struktur monorepo

```
payload/
├── packages/
│   ├── sim_core/            # Dart murni. Interpreter blok, world model, battle resolver, replay codec
│   ├── content_schema/      # Model + validator untuk semua JSON konten (blocks, missions, networks)
│   └── shared_models/       # DTO client<->server (digenerate Serverpod)
├── app/                     # Flutter + Flame client
│   ├── lib/features/
│   │   ├── workbench/       # editor blok drag&drop
│   │   ├── network_builder/ # editor pertahanan
│   │   ├── replay/          # playback + render Flame
│   │   ├── campaign/  pvp/  blueprints/  profile/  shop/  settings/
│   │   └── core/            # routing, DI, theme, telemetry
│   └── assets/
├── server/                  # Serverpod project
│   ├── endpoints/           # auth, battle, defense, blueprint, season, shop, contract
│   ├── jobs/                # battle worker (queue), season rollover, ghost snapshot
│   └── migrations/
├── content/                 # blocks.json, missions/, networks/, balance.json, localization/
├── tools/                   # balance simulator CLI, content linter, bot-vs-bot harness
└── .github/workflows/       # CI
```

### 2.3 Alur battle PvP (async)

```
Client: submit AttackRequest {virus_def, target_defense_id, client_version}
Server: validasi virus_def (schema + budget + blok yang sudah di-unlock pemain)
      → enqueue ke battle queue (Redis)
      → worker: load defense snapshot → sim_core.resolve(seed = server random) → battle_log + skor
      → simpan battle, update rating & loot, kirim push ke defender
Client: fetch battle_log → render replay
```

- Defense yang diserang adalah **snapshot** (versi tersimpan saat defender terakhir save) — defender tidak bisa di-grief saat sedang mengedit.
- Idempotency key pada submit; retry-safe.

### 2.4 Skema data inti (PostgreSQL)

- `players(id, auth_provider, handle, created_at, rating, season_rating, credits, keys, capacity_kb, settings_json)`
- `unlocks(player_id, block_id, unlocked_at)`
- `virus_presets(id, player_id, name, def_json, size_kb, updated_at)` — max 12 preset/pemain
- `defenses(id, player_id, def_json, version, is_active, validated_at)`
- `battles(id, attacker_id, defender_id, defense_version, virus_def_json, seed, log_ref, score, result, rating_delta, created_at)` — `log_ref` menunjuk object storage (S3-compatible) untuk log >32 KB
- `blueprints(id, player_id, virus_def_json, title, likes, plays, published_at, moderation_state)`
- `missions_progress(player_id, mission_id, stars, best_score)`
- `seasons(id, starts_at, ends_at)` + `season_results`
- `daily_contracts(date, network_json, seed)` + `contract_scores`
- `purchases(player_id, sku, store_receipt, state)` — verifikasi receipt server-side (Google Play Developer API / App Store Server API)

### 2.5 Keamanan & anti-cheat

- Auth: Sign in with Google/Apple + guest account (upgradeable). JWT Serverpod session.
- Semua battle diresolusi server; client hanya renderer → cheat klasik (memory edit) tidak berpengaruh pada hasil.
- Validasi server: ukuran virus ≤ kapasitas pemain, hanya blok yang di-unlock, DAG bebas siklus tak berujung (statik) + hard cap 600 tick (runtime).
- Rate limiting per endpoint (Redis token bucket). Receipt validation untuk IAP. Blueprint text (judul) melalui filter profanity + laporan pemain + moderation_state.
- Privasi: tidak menyimpan PII selain yang diwajibkan auth; data pemain bisa dihapus (GDPR delete endpoint); kepatuhan Play "Data safety" & App Store privacy labels.

### 2.6 Observability & LiveOps

- Telemetry client (event funnel): install → tutorial step N → first battle → D1/D7 return. Kirim batched ke endpoint sendiri → ClickHouse/BigQuery (pilih satu; default: PostHog self-host untuk kesederhanaan).
- Server: structured logging (JSON), metrics Prometheus + Grafana, error tracking Sentry (client & server).
- Remote config + feature flag sederhana (tabel `config_kv` + cache) untuk balance hotfix & kill-switch fitur.
- Runbook insiden + backup Postgres harian (PITR) — tulis di `docs/ops.md`.

### 2.7 CI/CD

- GitHub Actions: lint (`dart analyze`, custom content linter), unit test, **golden determinism test** (lihat §4), build APK/AAB + TestFlight via Fastlane, deploy server via Docker → VPS/managed (default: Docker Compose di VPS + Cloudflare; siapkan path migrasi ke k8s bila perlu).
- Versioning: client & server memakai `sim_core` versi tersinkron; server menolak battle dari client dengan `sim_version` beda (paksa update untuk PvP; PvE offline tetap jalan).

---

## 3. Spesifikasi Detail untuk Implementasi

### 3.1 Determinisme `sim_core` (wajib)

- Tidak ada `double` dalam state — gunakan int (energi ×100 bila perlu presisi).
- PRNG: xoshiro128**, seed disimpan di battle record. Fungsi `resolve(networkDef, virusDef, defenseLogic, seed) → BattleLog` harus **pure**.
- Urutan eksekusi tick terdokumentasi tetap: (1) defense sensors, (2) defense actions, (3) tiap virus copy berdasarkan urutan spawn: sensors→flow→action, (4) world update (alarm decay, AV move), (5) emit events.
- Replay codec: event list versi-ber-tag; codec lama tetap bisa dibaca minimal 2 versi ke belakang.

### 3.2 Interpreter blok

- Definisi virus = JSON DAG: `{nodes:[{id, block_id, params, out:{true:idB, false:idC}}], entry:idA}`.
- Eksekusi per tick dibatasi **64 langkah evaluasi** (anti loop-dalam-tick); melewati batas → virus `stall` 1 tick (feedback visual "hang", lucu dan mendidik).
- Setiap `block_id` merujuk `content/blocks.json`: `{id, family, size_kb, energy_cost, noise, params_schema, unlock_mission}`.

### 3.3 Editor workbench (client)

- Kanvas node-graph touch-first: tap-tambah blok dari tray (dikelompokkan per keluarga + search), drag untuk sambung, long-press hapus, pinch zoom. Semua gesture punya alternatif tombol (aksesibilitas).
- Live counter: ukuran KB / kapasitas, estimasi stealth rating, lint warning ("blok tak terhubung", "tidak ada aksi keluar").
- Mode **Test Run**: jalankan sim lokal vs jaringan latihan pilihan / vs snapshot pertahanan sendiri / vs replay musuh terakhir; scrub timeline, step per tick, inspector state virus (energi, memory flags) — ini debugger-nya pemain.

### 3.4 Replay renderer (Flame)

- Input `BattleLog` → world Flame: tilemap jaringan, sprite virus, efek aksi (brute force = getar+spark, disguise = fade, dsb), kamera auto-follow dengan cut ke event penting, speed 1×/2×/4×, skip-to-result.
- Export video: render off-screen ke frame PNG → encode MP4 (plugin ffmpeg_kit), watermark logo, share sheet.

### 3.5 Konten rilis (checklist produksi)

- 60 misi kampanye (JSON + skrip dialog ringkas), 45+ blok, 12 topologi dasar pertahanan, 8 skin virus + 4 tema terminal (launch shop), 30 hari kontrak harian pertama (generator + curated), lokalisasi **EN + ID** (struktur i18n siap bahasa lain), toko: screenshot, ikon, feature graphic, trailer 30 detik dari replay export.

---

## 4. Testing & Quality Gates

1. **Unit**: interpreter blok (setiap blok punya test), world rules, validator konten.
2. **Golden determinism**: ±50 skenario battle tersimpan (input + expected log hash). CI menjalankan di Linux x64 + macOS arm64 — hash harus identik. Ini gate paling penting; kegagalan = blocker.
3. **Bot-vs-bot harness** (`tools/`): 3 arketipe virus (Ghost/Bulldozer/Hydra) × 12 topologi × 1000 seed → laporan win-rate & rata-rata skor. Target keseimbangan: tidak ada arketipe dengan win-rate global >60% atau <40%. Jalankan tiap perubahan `blocks.json`.
4. **Integration**: endpoint battle end-to-end (submit→worker→log→fetch) dengan Postgres+Redis di docker-compose CI.
5. **Client widget/golden test** untuk workbench & replay HUD; smoke test device farm (min. 3 device Android low/mid/high) sebelum tiap rilis.
6. **Load test** server: target 500 battle resolve/menit pada 1 worker node; queue harus degradasi anggun (antrian, bukan error).
7. **Playtest gate**: 10 pengguna baru non-gamer harus bisa menyelesaikan misi 1–5 tanpa bantuan verbal; funnel drop-off tutorial <25% per step. Kalau gagal → revisi onboarding sebelum fase berikut.

---

## 5. Roadmap Eksekusi (fase untuk Claude Code)

> Tiap fase: kerjakan → jalankan test → penuhi acceptance criteria → commit → baru lanjut. Jangan menggabungkan fase.

**Fase 0 — Fondasi (repo & tooling)**
Monorepo sesuai §2.2, CI dasar, lint, `content_schema` + linter konten, docker-compose dev (Postgres, Redis, Serverpod).
✅ AC: `dart analyze` bersih; CI hijau; `tools/content_lint` memvalidasi `blocks.json` contoh.

**Fase 1 — `sim_core`**
World model, interpreter, semua blok §1.3, resolver, replay codec, PRNG, golden test pertama (10 skenario).
✅ AC: seluruh unit test lulus; golden hash identik lintas platform CI; 600-tick cap & 64-eval cap terbukti dengan test.

**Fase 2 — Workbench + Test Run (client offline)**
Flutter app skeleton, tema, editor blok penuh (§3.3), sim lokal + debugger timeline, penyimpanan preset lokal.
✅ AC: rakit virus 15 blok di device mid-range 60fps; lint editor bekerja; test run scrub/step berfungsi.

**Fase 3 — Replay renderer + Kampanye**
Renderer Flame (§3.4), loader misi, 60 misi (boleh generate draft lalu curated), sistem bintang, unlock progression, save lokal + cloud-sync stub.
✅ AC: kampanye playable end-to-end offline; playtest gate §4.7 dijalankan minimal pada misi 1–10.

**Fase 4 — Backend & PvP async**
Serverpod endpoints, auth, defense builder client, battle queue + worker, rating, ghost network, notifikasi push, versioning sim.
✅ AC: e2e attack→replay di staging; load test §4.6; server menolak virus ilegal (blok belum unlock / over budget) dengan test.

**Fase 5 — Meta & ekonomi**
Blueprint sharing + reverse-engineer loop, daily contract, season, shop + IAP + receipt validation, battle pass, telemetry funnel penuh.
✅ AC: purchase sandbox berhasil dua platform store API; moderation state blueprint berfungsi; event funnel tampil di dashboard analitik.

**Fase 6 — Polish, LiveOps, Launch readiness**
Export video replay, aksesibilitas penuh (§1.8), lokalisasi EN+ID, remote config, Sentry/Grafana, runbook ops, store listing, soft-launch checklist (1 negara), balance pass via bot harness.
✅ AC: crash-free sessions >99.5% di soft launch; D1 retention terukur; checklist store compliance (Play Data Safety, rating IARC) lengkap.

---

## 6. Risiko Utama & Mitigasi

| Risiko | Mitigasi |
|---|---|
| Onboarding programming terlalu sulit | Playtest gate wajib (§4.7); blok diperkenalkan satu per satu; misi awal 3 blok linear |
| Determinisme pecah lintas platform | Larangan float di state, golden test CI multi-arch sebagai blocker |
| PvP sepi di awal | Ghost network sejak hari pertama; PvE & daily contract berdiri sendiri |
| Balance meta rusak oleh 1 blok | Semua angka di data + remote config; bot-harness sebagai regression balance |
| Scope creep | Clan, real-time mode, user-generated network sharing = post-launch backlog, bukan rilis |

---

## 7. Konvensi untuk Claude Code

- Bahasa kode & komentar: **English**. Dokumentasi pemain & UI string: i18n (EN, ID).
- Ikuti struktur §2.2 persis; satu PR/commit per unit kerja logis; tulis test bersamaan dengan fitur, bukan setelahnya.
- Jangan menaruh angka balance di kode — selalu `content/*.json`.
- Setiap fase selesai: update `docs/CHANGELOG.md` + tandai AC yang lulus di `docs/ACCEPTANCE.md`.
- Bila spesifikasi ambigu: pilih interpretasi paling sederhana yang tidak melanggar Pilar Desain (§0), catat keputusan di `docs/DECISIONS.md`.
