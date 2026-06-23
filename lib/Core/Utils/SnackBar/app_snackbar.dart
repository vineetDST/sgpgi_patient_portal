import 'package:flutter/material.dart';

enum SnackbarType { error, info, warning, success }

class AppSnackbar {
  /// Displays a custom floating snackbar.
  /// Call this from any screen using:
  /// AppSnackbar.show(context, title: "Error", message: "...", type: SnackbarType.error);
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required SnackbarType type,
  }) {
    Color backgroundColor;
    Color textColor = Colors.white;

    // Apply the exact hex colors requested
    switch (type) {
      case SnackbarType.error:
        backgroundColor = const Color(0xFFEB5757);
        break;
      case SnackbarType.info:
        backgroundColor = const Color(0xFF5458F7);
        break;
      case SnackbarType.warning:
        backgroundColor = const Color(0xFFF2C94C);
        textColor =
            Colors.black87; // Dark text provides better contrast on yellow
        break;
      case SnackbarType.success:
        backgroundColor = const Color(0xFF00CC99);
        break;
    }

    final snackBar = SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      // Adjust the bottom margin so it floats above your custom bottom navigation bar
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 90),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          24,
        ), // Pill-shaped matching the design
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    color: textColor.withOpacity(0.95),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              color: Colors.transparent, // Increases touch target area
              child: Icon(Icons.close, color: textColor, size: 20),
            ),
          ),
        ],
      ),
    );

    // Clear any existing snackbar before showing the new one
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}




// --------------------------- HOW TO USE IT ---------------------------

// AppSnackbar.show(
//   context,
//   title: "Error",
//   message: "Unable to read Barcode: Z:\\patientimage\\REG0\\56\\Barcode.jpg(The user name or password)",
//   type: SnackbarType.error,
// );

// AppSnackbar.show(
//   context,
//   title: "Success",
//   message: "Record has been saved successfully.",
//   type: SnackbarType.success,
// );