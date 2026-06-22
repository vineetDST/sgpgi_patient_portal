import 'package:flutter/material.dart';

class AppSaveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isFullWidth;

  const AppSaveButton({
    super.key,
    this.text = 'Save',
    this.onPressed,
    this.backgroundColor = const Color(0xFF117A7A), // Default Teal color
    this.textColor = Colors.white, // Default White text
    this.isFullWidth = true, // Default double.infinity width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Agar isFullWidth true hai, to double.infinity lega, warna text ke hisaab se width lega
      width: isFullWidth ? double.infinity : null,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed ?? () {
          Navigator.of(context).pop();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0, // Elevation 0 rakhi hai aapke design ke according
        ),
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}