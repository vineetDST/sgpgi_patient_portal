import 'package:flutter/material.dart';

class AppCancelButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color textColor;
  final Color borderColor;
  final Color backgroundColor;
  final bool isFullWidth;

  const AppCancelButton({
    super.key,
    this.text = 'Cancel',
    this.onPressed,
    this.textColor = Colors.black87, // Default Black text
    this.borderColor = const Color(0xFFE0E0E0), // Equivalent to Colors.grey.shade300
    this.backgroundColor = Colors.white, // Default White background
    this.isFullWidth = true, // Default poori width
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Agar isFullWidth true hai, to double.infinity lega, warna text ke hisaab se width lega
      width: isFullWidth ? double.infinity : null,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed ?? () {
          Navigator.of(context).pop();
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          side: BorderSide(color: borderColor), // Border ka color yahan se control hoga
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
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