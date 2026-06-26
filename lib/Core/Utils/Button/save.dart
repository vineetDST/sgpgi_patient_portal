import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';

class AppSaveButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isFullWidth;
  final double size;
  final bool enabled;

  const AppSaveButton({
    super.key,
    this.text = 'Save',
    this.onPressed,
    this.enabled = true,
    this.backgroundColor = const Color(0xFF117A7A), // Default Teal color
    this.textColor = Colors.white, // Default White text
    this.isFullWidth = true, // Default double.infinity width
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Agar isFullWidth true hai, to double.infinity lega, warna text ke hisaab se width lega
      width: isFullWidth ? double.infinity : null,
      height: 48,
      child: ElevatedButton(
        onPressed: enabled
            ? onPressed ??
                  () {
                    Navigator.of(context).pop();
                  }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: enabled ? backgroundColor : Color(0xFFF8F9FA),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 0, // Elevation 0 rakhi hai aapke design ke according
        ),
        child: Text(
          text,
          style: TextStyle(
            color: enabled ? textColor : AppColor.color1E1E1E,
            fontSize: size,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
