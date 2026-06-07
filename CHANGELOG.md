# [2.0.0]

A major, **fully backward-compatible** upgrade. Existing `floatingSnackBar()`
calls keep working unchanged.

### Added
- New `FloatingSnackBar` API with `show()` plus `success()`, `error()`,
  `warning()`, and `info()` variant helpers (default colors + icons).
- Top / bottom positioning via `FloatingSnackBarPosition`.
- Rich content: optional title, leading widget, and trailing action button
  (`FloatingSnackBarAction`).
- Optional countdown progress bar (`showProgress`).
- Tap-to-dismiss and swipe-to-dismiss.
- Entrance/exit animations: `slide`, `fade`, `scale`.
- Global theming via `FloatingSnackBar.theme` (`FloatingSnackBarTheme`).
- Context-free display through `FloatingSnackBar.navigatorKey` (overlay-based),
  so snackbars can be shown from services/blocs without a `BuildContext`.
- `FloatingSnackBar.dismiss()` to clear the current snackbar.
- Real widget test suite and GitHub Actions CI (analyze + format + test).
- Revamped example app demonstrating every feature.

### Changed
- Reworked the package into a clean, **pure-Dart** package: removed unused
  `android/`, `ios/`, `windows/`, and `web/` platform folders.
- Modernized tooling: Dart 3 (`sdk: >=3.0.0`), Flutter `>=3.10.0`,
  `flutter_lints: ^5.0.0`.
- The legacy `floatingSnackBar()` now respects `FloatingSnackBar.theme`
  defaults.
- Rewritten README with correct import path, full API reference, and examples.

# [1.0.0+1]

- Inital release
- Set Android minSdkVersion to 16
- Refactor Android Plugin

# [1.0.2]

- ReadMe release
- Project Structure Update

# [1.0.3]
- Added Example App
- Added the badge for the pub.dev
- Added the badge for the tests
- Updated the functionality of the plugin to change the background color of the snackbar

# [1.0.4]
- Updated the ReadMe.md
- Added the image for the snackbar

# [1.0.5]
- Updated the ReadMe.md
- Added the image for the snackbar
- Updated plugin to hide the current snackbar
- Updated the example app to show the snackbar with a different background color
- Updated the environment sdk to ">=2.16.2 <4.0.0"

