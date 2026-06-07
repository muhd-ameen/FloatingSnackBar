import 'package:flutter/material.dart';

import 'floating_snackbar_controller.dart';
import 'floating_snackbar_enums.dart';
import 'floating_snackbar_theme.dart';
import 'floating_snackbar_widget.dart';

/// The entry point for the rich floating snackbar API.
///
/// Use the static helpers to display snackbars:
///
/// ```dart
/// FloatingSnackBar.success(context, 'Saved!');
/// FloatingSnackBar.error(context, 'Something went wrong');
/// FloatingSnackBar.show(context, message: 'Custom', title: 'Heads up');
/// ```
///
/// ### Global defaults
/// Set [theme] once to style every snackbar without repeating arguments.
///
/// ### Context-free usage
/// Assign [navigatorKey] to your `MaterialApp.navigatorKey` and you can then
/// pass `null` for `context` to show snackbars from anywhere (services, blocs,
/// etc.):
///
/// ```dart
/// MaterialApp(navigatorKey: FloatingSnackBar.navigatorKey, ...);
/// FloatingSnackBar.info(null, 'No context needed!');
/// ```
abstract final class FloatingSnackBar {
  FloatingSnackBar._();

  /// The app-wide default styling/behavior. Mutate this once at startup.
  static FloatingSnackBarTheme theme = const FloatingSnackBarTheme();

  /// Optional global navigator key enabling context-free calls. Assign it to
  /// `MaterialApp.navigatorKey` (or `WidgetsApp.navigatorKey`).
  ///
  /// If your app already owns a navigator key, set this to the same instance
  /// (`FloatingSnackBar.navigatorKey = myExistingKey;`).
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final Map<OverlayState, FloatingSnackBarController> _controllers = {};

  /// Displays a fully customizable floating snackbar.
  ///
  /// [context] may be null when [navigatorKey] has been wired into the app.
  /// Any non-null argument overrides the corresponding value from [theme].
  ///
  /// Returns true if the snackbar was scheduled, or false when no overlay could
  /// be resolved (no valid context and no navigator key attached).
  static bool show(
    BuildContext? context,
    String message, {
    String? title,
    FloatingSnackBarType type = FloatingSnackBarType.normal,
    FloatingSnackBarPosition? position,
    FloatingSnackBarAnimation? animation,
    Duration? duration,
    Widget? leading,
    FloatingSnackBarAction? action,
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
    TextStyle? titleStyle,
    bool? dismissOnTap,
    bool? showProgress,
    bool replace = true,
  }) {
    final overlay = _resolveOverlay(context);
    if (overlay == null) {
      assert(() {
        debugPrint(
          'FloatingSnackBar: could not find an Overlay. Pass a valid '
          'BuildContext, or set FloatingSnackBar.navigatorKey on your '
          'MaterialApp.',
        );
        return true;
      }());
      return false;
    }

    final resolvedTheme = theme;
    final controller = _controllers.putIfAbsent(
        overlay, () => FloatingSnackBarController(overlay));

    controller.enqueue(
      FloatingSnackBarRequest(
        (onDismiss) => FloatingSnackBarWidget(
          message: message,
          theme: resolvedTheme,
          type: type,
          position: position ?? resolvedTheme.defaultPosition,
          animation: animation ?? resolvedTheme.animation,
          duration: duration ?? resolvedTheme.duration,
          onDismiss: onDismiss,
          title: title,
          leading: leading,
          action: action,
          backgroundColor: backgroundColor,
          textColor: textColor,
          textStyle: textStyle,
          titleStyle: titleStyle,
          dismissOnTap: dismissOnTap ?? resolvedTheme.dismissOnTap,
          showProgress: showProgress ?? resolvedTheme.showProgress,
        ),
      ),
      replace: replace,
    );
    return true;
  }

  /// Shows a success-styled snackbar. See [show] for parameter details.
  static bool success(
    BuildContext? context,
    String message, {
    String? title,
    FloatingSnackBarPosition? position,
    FloatingSnackBarAnimation? animation,
    Duration? duration,
    Widget? leading,
    FloatingSnackBarAction? action,
    bool? dismissOnTap,
    bool? showProgress,
    bool replace = true,
  }) =>
      show(
        context,
        message,
        title: title,
        type: FloatingSnackBarType.success,
        position: position,
        animation: animation,
        duration: duration,
        leading: leading,
        action: action,
        dismissOnTap: dismissOnTap,
        showProgress: showProgress,
        replace: replace,
      );

  /// Shows an error-styled snackbar. See [show] for parameter details.
  static bool error(
    BuildContext? context,
    String message, {
    String? title,
    FloatingSnackBarPosition? position,
    FloatingSnackBarAnimation? animation,
    Duration? duration,
    Widget? leading,
    FloatingSnackBarAction? action,
    bool? dismissOnTap,
    bool? showProgress,
    bool replace = true,
  }) =>
      show(
        context,
        message,
        title: title,
        type: FloatingSnackBarType.error,
        position: position,
        animation: animation,
        duration: duration,
        leading: leading,
        action: action,
        dismissOnTap: dismissOnTap,
        showProgress: showProgress,
        replace: replace,
      );

  /// Shows a warning-styled snackbar. See [show] for parameter details.
  static bool warning(
    BuildContext? context,
    String message, {
    String? title,
    FloatingSnackBarPosition? position,
    FloatingSnackBarAnimation? animation,
    Duration? duration,
    Widget? leading,
    FloatingSnackBarAction? action,
    bool? dismissOnTap,
    bool? showProgress,
    bool replace = true,
  }) =>
      show(
        context,
        message,
        title: title,
        type: FloatingSnackBarType.warning,
        position: position,
        animation: animation,
        duration: duration,
        leading: leading,
        action: action,
        dismissOnTap: dismissOnTap,
        showProgress: showProgress,
        replace: replace,
      );

  /// Shows an info-styled snackbar. See [show] for parameter details.
  static bool info(
    BuildContext? context,
    String message, {
    String? title,
    FloatingSnackBarPosition? position,
    FloatingSnackBarAnimation? animation,
    Duration? duration,
    Widget? leading,
    FloatingSnackBarAction? action,
    bool? dismissOnTap,
    bool? showProgress,
    bool replace = true,
  }) =>
      show(
        context,
        message,
        title: title,
        type: FloatingSnackBarType.info,
        position: position,
        animation: animation,
        duration: duration,
        leading: leading,
        action: action,
        dismissOnTap: dismissOnTap,
        showProgress: showProgress,
        replace: replace,
      );

  /// Dismisses the current snackbar (and clears the queue) for the overlay
  /// resolved from [context] or the global [navigatorKey].
  static void dismiss([BuildContext? context]) {
    final overlay = _resolveOverlay(context);
    if (overlay != null) _controllers[overlay]?.dismiss();
  }

  static OverlayState? _resolveOverlay(BuildContext? context) {
    if (context != null) {
      final overlay = Overlay.maybeOf(context, rootOverlay: true);
      if (overlay != null) return overlay;
    }
    return navigatorKey.currentState?.overlay;
  }
}
