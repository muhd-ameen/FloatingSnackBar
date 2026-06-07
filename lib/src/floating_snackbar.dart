import 'package:flutter/material.dart';

import 'floating_snackbar_api.dart';

/// Displays a minimal floating snackbar using [ScaffoldMessenger].
///
/// This is the original, dead-simple entry point and remains fully backward
/// compatible: existing calls work unchanged.
///
/// ```dart
/// floatingSnackBar(message: 'Hi there!', context: context);
/// ```
///
/// Unset visual arguments fall back to [FloatingSnackBar.theme], so global
/// theming applies here too. For variants (success/error/...), positioning,
/// actions, or context-free usage, prefer the richer [FloatingSnackBar] API.
void floatingSnackBar({
  required String message,
  required BuildContext context,
  Duration? duration,
  TextStyle? textStyle,
  Color? textColor,
  Color? backgroundColor,
}) {
  final theme = FloatingSnackBar.theme;
  final resolvedTextColor = textColor ?? theme.textColor;

  final snack = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: theme.margin,
    duration: duration ?? theme.duration,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(theme.borderRadius),
    ),
    content: Text(
      message,
      style: (theme.textStyle ?? const TextStyle())
          .copyWith(color: resolvedTextColor)
          .merge(textStyle),
    ),
    backgroundColor:
        backgroundColor ?? theme.backgroundColor ?? Colors.black.withAlpha(200),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snack);
}
