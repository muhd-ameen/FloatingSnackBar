import 'package:flutter/material.dart';

import 'floating_snackbar_enums.dart';

/// Global, app-wide defaults for floating snackbars.
///
/// Set this once (typically before `runApp`) to control how every snackbar
/// looks and behaves without passing the same arguments at each call site:
///
/// ```dart
/// FloatingSnackBar.theme = const FloatingSnackBarTheme(
///   defaultPosition: FloatingSnackBarPosition.top,
///   borderRadius: 16,
///   successColor: Colors.teal,
/// );
/// ```
///
/// Any argument passed directly to [FloatingSnackBar.show] (or the variant
/// helpers) overrides the matching value from the active theme.
@immutable
class FloatingSnackBarTheme {
  /// Creates a theme describing default snackbar styling and behavior.
  const FloatingSnackBarTheme({
    this.backgroundColor,
    this.textColor = Colors.white,
    this.textStyle,
    this.titleStyle,
    this.borderRadius = 10,
    this.margin = const EdgeInsets.all(20),
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    this.duration = const Duration(milliseconds: 4000),
    this.defaultPosition = FloatingSnackBarPosition.bottom,
    this.animation = FloatingSnackBarAnimation.slide,
    this.animationDuration = const Duration(milliseconds: 350),
    this.elevation = 6,
    this.dismissOnTap = false,
    this.showProgress = false,
    this.successColor = const Color(0xFF2E7D32),
    this.errorColor = const Color(0xFFC62828),
    this.warningColor = const Color(0xFFF9A825),
    this.infoColor = const Color(0xFF1565C0),
    this.successIcon = Icons.check_circle_rounded,
    this.errorIcon = Icons.error_rounded,
    this.warningIcon = Icons.warning_rounded,
    this.infoIcon = Icons.info_rounded,
  });

  /// Background color for [FloatingSnackBarType.normal].
  ///
  /// When null, a translucent black (`Colors.black.withAlpha(200)`) is used,
  /// matching the original `floating_snackbar` look.
  final Color? backgroundColor;

  /// Default color for the message (and title) text.
  final Color textColor;

  /// Default text style for the message. Merged over the resolved [textColor].
  final TextStyle? textStyle;

  /// Default text style for the optional title (defaults to a bold variant of
  /// [textStyle] when null).
  final TextStyle? titleStyle;

  /// Corner radius of the snackbar card.
  final double borderRadius;

  /// Outer margin between the snackbar and the screen edges.
  final EdgeInsets margin;

  /// Inner padding around the snackbar content.
  final EdgeInsets padding;

  /// How long the snackbar stays visible before auto-dismissing.
  final Duration duration;

  /// Default screen anchor.
  final FloatingSnackBarPosition defaultPosition;

  /// Default entrance/exit animation.
  final FloatingSnackBarAnimation animation;

  /// Duration of the entrance/exit animation.
  final Duration animationDuration;

  /// Material elevation (shadow) of the card.
  final double elevation;

  /// Whether tapping the snackbar dismisses it.
  final bool dismissOnTap;

  /// Whether a countdown progress bar is shown along the bottom edge.
  final bool showProgress;

  /// Background color used for [FloatingSnackBarType.success].
  final Color successColor;

  /// Background color used for [FloatingSnackBarType.error].
  final Color errorColor;

  /// Background color used for [FloatingSnackBarType.warning].
  final Color warningColor;

  /// Background color used for [FloatingSnackBarType.info].
  final Color infoColor;

  /// Default leading icon for [FloatingSnackBarType.success].
  final IconData successIcon;

  /// Default leading icon for [FloatingSnackBarType.error].
  final IconData errorIcon;

  /// Default leading icon for [FloatingSnackBarType.warning].
  final IconData warningIcon;

  /// Default leading icon for [FloatingSnackBarType.info].
  final IconData infoIcon;

  /// The resolved background color for the given [type].
  Color backgroundColorFor(FloatingSnackBarType type) {
    switch (type) {
      case FloatingSnackBarType.success:
        return successColor;
      case FloatingSnackBarType.error:
        return errorColor;
      case FloatingSnackBarType.warning:
        return warningColor;
      case FloatingSnackBarType.info:
        return infoColor;
      case FloatingSnackBarType.normal:
        return backgroundColor ?? Colors.black.withAlpha(200);
    }
  }

  /// The resolved default leading icon for the given [type], or null for
  /// [FloatingSnackBarType.normal].
  IconData? iconFor(FloatingSnackBarType type) {
    switch (type) {
      case FloatingSnackBarType.success:
        return successIcon;
      case FloatingSnackBarType.error:
        return errorIcon;
      case FloatingSnackBarType.warning:
        return warningIcon;
      case FloatingSnackBarType.info:
        return infoIcon;
      case FloatingSnackBarType.normal:
        return null;
    }
  }

  /// Returns a copy of this theme with the given fields replaced.
  FloatingSnackBarTheme copyWith({
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
    TextStyle? titleStyle,
    double? borderRadius,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Duration? duration,
    FloatingSnackBarPosition? defaultPosition,
    FloatingSnackBarAnimation? animation,
    Duration? animationDuration,
    double? elevation,
    bool? dismissOnTap,
    bool? showProgress,
    Color? successColor,
    Color? errorColor,
    Color? warningColor,
    Color? infoColor,
    IconData? successIcon,
    IconData? errorIcon,
    IconData? warningIcon,
    IconData? infoIcon,
  }) {
    return FloatingSnackBarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      textStyle: textStyle ?? this.textStyle,
      titleStyle: titleStyle ?? this.titleStyle,
      borderRadius: borderRadius ?? this.borderRadius,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      duration: duration ?? this.duration,
      defaultPosition: defaultPosition ?? this.defaultPosition,
      animation: animation ?? this.animation,
      animationDuration: animationDuration ?? this.animationDuration,
      elevation: elevation ?? this.elevation,
      dismissOnTap: dismissOnTap ?? this.dismissOnTap,
      showProgress: showProgress ?? this.showProgress,
      successColor: successColor ?? this.successColor,
      errorColor: errorColor ?? this.errorColor,
      warningColor: warningColor ?? this.warningColor,
      infoColor: infoColor ?? this.infoColor,
      successIcon: successIcon ?? this.successIcon,
      errorIcon: errorIcon ?? this.errorIcon,
      warningIcon: warningIcon ?? this.warningIcon,
      infoIcon: infoIcon ?? this.infoIcon,
    );
  }
}
