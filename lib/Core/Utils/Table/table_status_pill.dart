import 'package:flutter/material.dart';

class TableStatusPill extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const TableStatusPill(
    this.text, {
    super.key,
    this.backgroundColor = const Color(0xFFC0F4BA),
    this.textColor = const Color(0xFF1E6C16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}