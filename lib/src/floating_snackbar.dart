// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

void FloatingSnackBar({
  required String message,
  required BuildContext context,
  Duration? duration,
  TextStyle? textStyle,
  Color? textColor,
  Color? backgroundColor,
}) {
  var snack = SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(20),
    duration: duration ?? const Duration(milliseconds: 4000),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Text(
      message,
      textScaleFactor: 1,
      style: textStyle ?? TextStyle(color: textColor ?? Colors.white),
    ),
    backgroundColor: backgroundColor ?? Colors.black.withAlpha(200),
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
