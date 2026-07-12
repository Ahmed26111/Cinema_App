<div align="center">

<img src="images/app_logo.png" alt="Cinema App logo" width="96"/>

# 🎬 Cinema App

A Flutter movie discovery and ticket-booking app powered by **The Movie Database (TMDB) API**.
Browse popular, top-rated, and upcoming movies, view full details and cast, search, save favorites/watchlists, and reserve seats for a screening — all with a clean, offline-friendly UI.

**License:** MIT · **Platforms:** Android · iOS · Web · Windows · Linux · macOS

</div>

---

## Table of Contents

1. [Overview & Goals](#overview--goals)
2. [Tech Stack & Dependencies](#tech-stack--dependencies)
3. [Features & Screenshots](#features--screenshots)
4. [Setup & Installation](#setup--installation)
5. [Build & Run](#build--run)
6. [Project Structure](#project-structure)
7. [Usage & Testing](#usage--testing)
8. [Known Issues & Troubleshooting](#known-issues--troubleshooting)
9. [Contributing](#contributing)
10. [License, Status & Maintainer](#license-status--maintainer)
11. [Changelog](#changelog)

---

## Overview & Goals

Cinema App is a personal/portfolio Flutter project that reproduces the core experience of a movie-streaming companion app: discovering movies, learning about them, and booking a seat to watch them. It was built to practice a clean, scalable Flutter architecture — Cubit-based state management, a repository/service data layer, local persistence with Hive, and route management with `go_router` — while integrating a real third-party API (TMDB).

**Goals:**
- Demonstrate a layered architecture (`ui` / `data` / `constants` / `utils` / `routes`) that separates presentation, business logic, and data access.
- Consume a real REST API (TMDB) with caching, error handling, and loading skeletons for a polished UX.
- Support full account flows (sign up, log in, edit profile, change/reset password, delete account, log out) with local persistence — no backend server required.
- Provide an end-to-end movie → seat selection → ticket flow with a generated QR ticket.

## Tech Stack & Dependencies

| Category | Choice |
|---|---|
| Language | Dart |
| Framework | Flutter (SDK constraint `^3.9.2`, `stable` channel) |
| State management | [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) (Cubit pattern) |
| Routing | [`go_router`](https://pub.dev/packages/go_router) |
| Networking | [`dio`](https://pub.dev/packages/dio) + [`dio_cache_interceptor`](https://pub.dev/packages/dio_cache_interceptor) + [`pretty_dio_logger`](https://pub.dev/packages/pretty_dio_logger) |
| Local storage | [`hive_flutter`](https://pub.dev/packages/hive_flutter) (users, active session, tickets) |
| Environment/config | [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) |
| Loading UI | [`skeletonizer`](https://pub.dev/packages/skeletonizer) |
| Images | [`cached_network_image`](https://pub.dev/packages/cached_network_image) |
| Ticketing | [`qr_flutter`](https://pub.dev/packages/qr_flutter) |
| Misc | `uuid`, `date_format`, `equatable`, `cupertino_icons` |
| App icon generation | [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) |
| Linting | `flutter_lints` |
| External API | [TMDB API](https://developer.themoviedb.org/docs) |

Full, exact versions are pinned in [`pubspec.yaml`](pubspec.yaml) / [`pubspec.lock`](pubspec.lock).

## Features & Screenshots

All screenshots below live in [`/screenshots`](screenshots), organized into one folder per screen/flow, with lowercase `snake_case` folder and file names for consistency. These are **documentation assets only** — they are not bundled into the app itself (see [Build notes](#build-notes-on-screenshots) below).

<details open>
<summary><strong>Onboarding & Splash</strong></summary>
<br>

| Splash | Onboarding 1 | Onboarding 2 | Onboarding 3 |
|---|---|---|---|
| <img src="screenshots/splash_screen/splash_screen.png" width="160"/> | <img src="screenshots/onboarding_screens/onboarding_screen_1.png" width="160"/> | <img src="screenshots/onboarding_screens/onboarding_screen_2.png" width="160"/> | <img src="screenshots/onboarding_screens/onboarding_screen_3.png" width="160"/> |

</details>

<details open>
<summary><strong>Authentication</strong> — sign up, log in, reset/change password, log out, delete account</summary>
<br>

| Login | Login (error) | Sign up | Sign up (step 2) |
|---|---|---|---|
| <img src="screenshots/login_screens/login_screen_main.png" width="160"/> | <img src="screenshots/login_screens/login_screen_when_show_error.png" width="160"/> | <img src="screenshots/signup_screens/signup_screen_main_1.png" width="160"/> | <img src="screenshots/signup_screens/signup_screen_main_2.png" width="160"/> |

| Reset password | Reset password (no account) | Change password | Log out dialog |
|---|---|---|---|
| <img src="screenshots/reset_password_screens/reset_password_screen_main.png" width="160"/> | <img src="screenshots/reset_password_screens/reset_password_email_doesnot_exist.png" width="160"/> | <img src="screenshots/change_password_screens/change_password_successfully.png" width="160"/> | <img src="screenshots/logout_screens/log_out_dialog.png" width="160"/> |

Additional flows captured: `create_new_password_screens/`, `delete_account_screens/`, `logout_screens/`.

</details>

<details open>
<summary><strong>Home, Search & Discovery</strong></summary>
<br>

| Home | Home (scrolled) | Search | Search results |
|---|---|---|---|
| <img src="screenshots/home_screens/home_screen.png" width="160"/> | <img src="screenshots/home_screens/home_screen_2.png" width="160"/> | <img src="screenshots/search_screens/search_screen_1.png" width="160"/> | <img src="screenshots/search_result_screens/search_result_screen_1.png" width="160"/> |

Also see: `see_all_screens/` (full category lists) and additional variants in `search_screens/` and `search_result_screens/`.

</details>

<details open>
<summary><strong>Movie Details</strong></summary>
<br>

| Details 1 | Details 2 | Details 3 |
|---|---|---|
| <img src="screenshots/details_screen/details_screen_1.png" width="160"/> | <img src="screenshots/details_screen/details_screen_2.png" width="160"/> | <img src="screenshots/details_screen/details_screen_3.png" width="160"/> |

Cast, similar movies, and certification sections are covered in `details_screen/details_screen_4.png` and `_5.png`.

</details>

<details open>
<summary><strong>Favorites & Watchlist</strong></summary>
<br>

| Favorites | Favorites (empty) | Watchlist | Watchlist (empty) |
|---|---|---|---|
| <img src="screenshots/favourite_screens/favourite_screen_main.png" width="160"/> | <img src="screenshots/favourite_screens/favourite_screen_empty.png" width="160"/> | <img src="screenshots/watchlist_screens/watchlist_screen_main.png" width="160"/> | <img src="screenshots/watchlist_screens/watchlist_screen_empty.png" width="160"/> |

</details>

<details open>
<summary><strong>Seat Reservation & Tickets</strong></summary>
<br>

| Reserve seats 1 | Reserve seats 2 | Purchase success | My tickets |
|---|---|---|---|
| <img src="screenshots/ticket_reserve_screens/ticket_reserve_screen_1.png" width="160"/> | <img src="screenshots/ticket_reserve_screens/ticket_reserve_screen_2.png" width="160"/> | <img src="screenshots/ticket_reserve_screens/ticket_reserve_successfull_buy_tickets.png" width="160"/> | <img src="screenshots/ticket_screens/ticket_screen_main.png" width="160"/> |

Additional views: `ticket_reserve_screens/ticket_reserve_screen_3.png` & `_4.png`, and `ticket_screens/ticket_screen_main_show_your_seat.png`, `ticket_screen_main_show_ticket_details.png`, `ticket_screen_empty.png`.

</details>

<details open>
<summary><strong>Profile & Settings</strong></summary>
<br>

| Profile | Edit profile | About us | Privacy policy |
|---|---|---|---|
| <img src="screenshots/profile_screens/profile_screen_main.png" width="160"/> | <img src="screenshots/edit_profile_screens/edit_profile_screen_1.png" width="160"/> | <img src="screenshots/about_us_screen/about_us_screen.png" width="160"/> | <img src="screenshots/privacy_policy_screen/privacy_policy_screen.png" width="160"/> |

</details>

**Other features covered by the app (see full gallery in [`/screenshots`](screenshots)):**

- **Onboarding flow** — a 3-screen animated introduction shown to first-time users.
- **Authentication** — sign up, log in, forgot/reset password, change password, delete account, and log out, backed by local Hive storage rather than a remote auth server.
- **Home feed** — independently-loading sections for **Upcoming**, **Popular**, and **Top Rated** movies, each with its own Cubit, using `skeletonizer` placeholders while loading.
- **Movie details** — full details screen with cast list, certification/rating, and a "similar movies" carousel.
- **Search** — debounced search with a dedicated results screen.
- **Favorites & Watchlist** — persisted locally via Hive.
- **Seat reservation & tickets** — interactive seat map, hall/period selection, and a generated QR-code ticket.
- **Profile management** — view/edit profile with avatar selection.
- **About & legal screens** — static "About Us" and "Privacy Policy" screens.

## Setup & Installation

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) matching Dart SDK `^3.9.2` (stable channel recommended — this repo was created against Flutter stable revision `adc90106...`, so a recent Flutter stable release is best).
- A configured platform toolchain for whichever target you build:
    - **Android:** Android Studio + Android SDK (min SDK 21, per `flutter_launcher_icons` config).
    - **iOS/macOS:** Xcode + CocoaPods, on macOS.
    - **Web:** any modern Chrome-based browser for debugging.
    - **Windows/Linux:** the respective desktop build toolchains (Visual Studio Build Tools / GCC + GTK dev libraries).
- A free [TMDB API account](https://www.themoviedb.org/signup) and API key/read access token.

### 1. Clone the repository

```bash
git clone https://github.com/Ahmed26111/Cinema_App.git
cd Cinema_App
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure environment variables (required — the app will not fetch any data without this)

The app loads all API configuration from a `keys.env` file at the project root via `flutter_dotenv` (see `lib/main.dart` and `lib/constants/api constants/api_constants.dart`). This file is git-ignored (`*.env` in `.gitignore`) and is **not** included in the repo, so you must create it yourself:

```bash
touch keys.env
```

Populate `keys.env` with the following keys (values are TMDB endpoint paths and your personal API key):

```env
Api_key=your_tmdb_api_key_here
BaseUrl=https://api.themoviedb.org/3/
BaseImageUrl=https://image.tmdb.org/t/p/w500
MoviePopularEndPoint=movie/popular
MovieTopRatedEndPoint=movie/top_rated
MovieUpComingEndPoint=movie/upcoming
MovieIdEndPoint=movie/
SearchMovieEndPoint=search/movie
MovieCreditsEndPoint1=movie/
MovieCreditsEndPoint2=/credits
MovieSimilarEndPoint1=movie/
MovieSimilarEndPoint2=/similar
DiscoverMovieEndPoint=discover/movie
MovieCertificateEndPoint1=movie/
MovieCertificateEndPoint2=/release_dates
PopularDescending=popularity.desc
TopRatedDescending=vote_average.desc
UpcomingDescending=primary_release_date.desc
```

> ⚠️ The exact endpoint path strings above reflect the standard TMDB v3 API and the keys read in `ApiConstants`. Double-check them against the [TMDB API reference](https://developer.themoviedb.org/reference/intro/getting-started) since TMDB occasionally revises endpoint paths.

`keys.env` is already declared as a Flutter asset in `pubspec.yaml`, so once it exists at the project root, no further wiring is needed.

### 4. Platform-specific notes

- **Android:** no extra setup needed beyond a configured SDK; `applicationId`/`namespace` is `com.example.cinema_app`.
- **iOS:** run `cd ios && pod install` if CocoaPods dependencies aren't resolved automatically on first build; bundle identifier is `com.example.cinemaApp`.
- **Web/Desktop:** no special config, but note the app locks device orientation to portrait, which has no effect on web/desktop windows.

## Build & Run

Run `flutter doctor` first to confirm your environment is ready.

### Run locally (debug)

```bash
# List available devices
flutter devices

# Run on a connected device/emulator
flutter run

# Run on a specific platform
flutter run -d chrome     # Web
flutter run -d windows    # Windows desktop
flutter run -d macos      # macOS desktop
flutter run -d linux      # Linux desktop
```

### Build release artifacts

```bash
# Android APK
flutter build apk --release

# Android App Bundle (for Play Store)
flutter build appbundle --release

# iOS (requires macOS + Xcode, then archive via Xcode)
flutter build ios --release

# Web
flutter build web --release

# Windows / Linux / macOS desktop
flutter build windows --release
flutter build linux --release
flutter build macos --release
```

### Regenerate app launcher icons

The project uses `flutter_launcher_icons`, configured in `pubspec.yaml`:

```bash
dart run flutter_launcher_icons
```

### Build notes on screenshots

The `/screenshots` folder is **documentation only** — it is intentionally **not** listed under `flutter: assets:` in `pubspec.yaml` and is **not** bundled into the compiled app. Including it as an app asset would bloat every build (APK/IPA/web bundle) with 20+ MB of PNGs that the running app never uses. Only `keys.env` and `images/` (real in-app assets like the logo, onboarding art, avatars, and placeholder illustrations) remain declared as assets.

## Project Structure

```
Cinema_App/
├── lib/
│   ├── main.dart                  # App entrypoint: Hive init, dotenv load, orientation lock, MultiBlocProvider
│   ├── routes/
│   │   └── routes_manager.dart    # go_router route table for all screens
│   ├── constants/                 # Static constants: API endpoints, colors, enums, Hive keys, routes
│   ├── data/
│   │   ├── models/                # Data models + Hive TypeAdapters (movie, user, ticket, genre, company, cast, seat)
│   │   ├── repositories/          # MovieRepository, ValidationRepository — talk to services, return models
│   │   └── services/
│   │       └── dio_helper.dart    # Dio client: base options, response caching, pretty logging
│   ├── ui/                        # One folder per screen, each with its screen widget + Cubit(s)/state
│   └── utils/
│       ├── components/            # Reusable widgets (snack bars, error/empty states, etc.)
│       └── shared/                # Hive handler, validation, debouncer, date/seat utilities
├── images/                        # In-app assets: logo, onboarding art, avatars, empty/error state illustrations
├── screenshots/                   # Documentation-only screenshots (NOT a Flutter asset) — see Features & Screenshots
│   ├── onboarding_screens/  home_screens/  details_screen/  search_screens/  search_result_screens/
│   ├── login_screens/  signup_screens/  reset_password_screens/  change_password_screens/
│   ├── create_new_password_screens/  delete_account_screens/  logout_screens/
│   ├── favourite_screens/  watchlist_screens/  ticket_screens/  ticket_reserve_screens/
│   ├── profile_screens/  edit_profile_screens/  about_us_screen/  privacy_policy_screen/
│   ├── splash_screen/  see_all_screens/
├── fonts/                          # Custom "AG Schoolbook" font
├── test/
│   └── widget_test.dart           # Default Flutter counter smoke test (placeholder — see Known Issues)
├── android/ ios/ web/ windows/ linux/ macos/   # Platform runner projects
├── pubspec.yaml                    # Now documents MIT license (see License section)
└── keys.env                        # NOT committed — you create this locally (see Setup)
```

The architecture follows a consistent pattern per feature: **Screen widget → Cubit → Repository → DioHelper/Hive**, keeping UI, state, and data access cleanly separated.

## Usage & Testing

### Running the app

After completing [Setup](#setup--installation), launch with `flutter run` and select a device. On first launch you'll see the onboarding flow, then can sign up or log in (stored locally via Hive — there is no remote auth backend, so accounts are device-local).

### Running tests

```bash
flutter test
```

> ⚠️ **Note:** the repository currently ships only the default Flutter-generated `test/widget_test.dart`, which tests a counter app scaffold that no longer matches `MyApp` (the app now boots into `MaterialApp.router`, not a counter). This test will fail as-is and should be replaced with real widget/unit tests for the app's actual screens and Cubits. See [Known Issues](#known-issues--troubleshooting).

### Code analysis / linting

```bash
flutter analyze
```

Lint rules come from `flutter_lints`, configured in `analysis_options.yaml`.

## Known Issues & Troubleshooting

| Issue | Cause / Fix |
|---|---|
| App builds but shows no movies / network errors | `keys.env` is missing or has incorrect/empty values. Confirm the file exists at the project root and contains a valid `Api_key`. Also confirm `keys.env` and `images/` remain listed under `flutter: assets:` in `pubspec.yaml`. |
| `flutter test` fails immediately | The included `test/widget_test.dart` is the default counter-app template and doesn't match this app's `MyApp` widget. Replace it with tests relevant to actual screens, or delete it until real tests are added. |
| Build fails with missing Hive adapter / type errors after modifying a model | Hive adapters (`*_adapter.dart`) are hand-written in this project (no `build_runner`/codegen is configured). If you add fields to a model, update its corresponding adapter manually, and keep `typeId`s unique across all adapters registered in `hive_handler.dart`. |
| iOS build fails on pods | Run `cd ios && pod repo update && pod install`, then rebuild. |
| Blank/incorrect movie posters or backdrops | Check `BaseImageUrl` in `keys.env` — TMDB image paths returned by the API must be appended to a valid base image URL (e.g. `https://image.tmdb.org/t/p/w500`). |
| Orientation issues on tablets/desktop | The app force-locks to `DeviceOrientation.portraitUp` in `main.dart`; this is intentional for the mobile-first UI but means the app won't rotate to landscape even on larger screens. |
| API rate limiting / stale data | Requests are cached via `dio_cache_interceptor` with a 2-hour `maxStale` policy; if you need fresher data while developing, clear the cache or temporarily lower `maxStale` in `dio_helper.dart`. |
| README images don't render after cloning | Screenshots use relative paths (`screenshots/<folder>/<file>.png`). Make sure the `/screenshots` folder is present at the repo root and wasn't excluded by a custom `.gitignore` rule. |

If you hit an issue not listed here, please open a GitHub Issue with your Flutter version (`flutter --version`), target platform, and steps to reproduce.

## Contributing

Contributions are welcome. Suggested workflow:

1. **Fork** the repository and create a feature branch from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
2. **Follow existing conventions:**
    - Match the existing per-screen structure: a `*_screen.dart` widget paired with its own Cubit/state files where state is needed.
    - Run `flutter analyze` and resolve any `flutter_lints` warnings before committing.
    - Run `dart format .` to keep formatting consistent.
    - Add/extend tests for any new Cubit or repository logic under `test/`.
    - If you add a new screen, add matching screenshots under `screenshots/<new_screen>_screens/` using lowercase `snake_case` naming, matching the convention used throughout this folder.
3. **Commit** with clear, descriptive messages (e.g. `feat: add sort-by-rating to search results`, `fix: correct seat status enum for reserved seats`).
4. **Open a Pull Request** against `main` describing:
    - What the change does and why.
    - Any new environment variables or dependencies introduced.
    - Screenshots/GIFs for UI changes.
5. Keep PRs focused and reasonably small — separate unrelated changes into different PRs.

Please don't commit real API keys, `keys.env`, or other secrets in a PR.

## License, Status & Maintainer

- **License:** MIT. The license is currently documented via a `# License: MIT` comment in [`pubspec.yaml`](pubspec.yaml) at the project maintainer's request. Note that `pubspec.yaml` has no formal `license:` field recognized by the Dart/Flutter tooling — this comment is informational only. For the license to be legally binding and to show up as a GitHub license badge, add a standalone `LICENSE` file at the repo root (e.g. from [choosealicense.com/licenses/mit](https://choosealicense.com/licenses/mit/)) — this hasn't been done yet.
- **CI/CD:** No CI/CD workflows (e.g. GitHub Actions) are currently configured in the repository.
- **Status:** Active development / portfolio project. Core movie browsing, auth, favorites/watchlist, and ticket booking flows are implemented and now documented with screenshots; automated test coverage is a known gap (see [Known Issues](#known-issues--troubleshooting)).
- **Maintainer:** [Ahmed Refaay](https://github.com/Ahmed26111) — Computer Science student & Flutter developer.
- **Data source:** This product uses the [TMDB API](https://www.themoviedb.org/) but is not endorsed or certified by TMDB.

## Changelog

### [Unreleased]

**Added**
- Full screenshot gallery (`/screenshots`, 55 images across 22 screens/flows) covering onboarding, authentication, home/search, movie details, favorites/watchlist, ticket reservation, and profile/settings — normalized to lowercase `snake_case` folder and file names.
- Screenshot references embedded throughout the README's [Features & Screenshots](#features--screenshots) section.
- Explicit `# License: MIT` documentation in `pubspec.yaml`.
- README "Build notes on screenshots" clarifying that `/screenshots` is documentation-only and intentionally excluded from `flutter: assets:`.
- README Changelog section (this section).

**Changed**
- Reorganized the original `ScreenShots/` folder (mixed-case names) into a consistent lowercase `screenshots/` structure for cross-platform/git-friendly paths.

**Notes**
- No functional app code was modified in this update — changes are documentation and metadata only.
- A standalone `LICENSE` file is still recommended for the MIT license to be legally binding and GitHub-recognized (see [License, Status & Maintainer](#license-status--maintainer)).

---

<div align="center">Made with Flutter 💙</div>
