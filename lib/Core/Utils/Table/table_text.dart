import 'package:flutter/material.dart';

class TableText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  const TableText(
      this.text, { // Pela parameter direct text string lega
        super.key,
        this.fontSize = 13.0, // Default size 13 rakha hai
        this.fontWeight,
        this.color,
        this.textAlign,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: color ?? const Color(0xFF1E1E1E), // Aapka default dark color
      ),
    );
  }
}