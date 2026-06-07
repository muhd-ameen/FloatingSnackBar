/// Where a floating snackbar is anchored on the screen.
enum FloatingSnackBarPosition {
  /// Anchored near the top of the screen (below the status bar).
  top,

  /// Anchored near the bottom of the screen (above the system inset).
  bottom,
}

/// The semantic style of a floating snackbar.
///
/// Each type maps to a default color and a default leading icon defined on the
/// active [FloatingSnackBarTheme].
enum FloatingSnackBarType {
  /// A neutral message with no semantic color (uses the default background).
  normal,

  /// A positive/confirmation message (green by default).
  success,

  /// An error/failure message (red by default).
  error,

  /// A cautionary message (amber by default).
  warning,

  /// An informational message (blue by default).
  info,
}

/// The entrance/exit animation used when a floating snackbar appears.
enum FloatingSnackBarAnimation {
  /// Slides in from the anchored edge.
  slide,

  /// Fades in/out.
  fade,

  /// Scales up from the center.
  scale,
}
