import 'package:flutter/material.dart';

// This function displays a floating SnackBar with customizable properties.
void floatingSnackBar({
  required String message, // The message to display in the SnackBar
  required BuildContext context, // The BuildContext to show the SnackBar within
  Duration? duration, // Optional: Duration for which the SnackBar is displayed
  TextStyle? textStyle, // Optional: Text style for the message text
  Color? textColor, // Optional: Text color for the message text
  Color? backgroundColor, // Optional: Background color of the SnackBar
}) {
  // Create a SnackBar widget with specified properties
  var snack = SnackBar(
    behavior: SnackBarBehavior.floating, // Make the SnackBar floating
    margin: const EdgeInsets.all(20), // Set margin around the SnackBar
    duration: duration ??
        const Duration(milliseconds: 4000), // Default duration if not provided
    shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10)), // Rounded corners for the SnackBar
    content: Text(
      message, // Display the provided message text
      style: textStyle ??
          TextStyle(
              color: textColor ??
                  Colors.white), // Apply provided or default text style
    ),
    backgroundColor: backgroundColor ??
        Colors.black.withAlpha(200), // Default background color if not provided
  );

  // Hide any currently displayed SnackBar
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  // Show the created SnackBar
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
