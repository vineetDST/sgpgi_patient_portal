import 'package:flutter/material.dart';

class FloatingSearchField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final double offsetY;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry horizontalPadding;
  final ValueChanged<String>? onChanged;
  final Color fillColor;
  final IconData suffixIcon;

  const FloatingSearchField({
    super.key,
    required this.hintText,
    this.controller,
    this.offsetY = -30,
    this.elevation = 4,
    this.borderRadius = 8,
    this.horizontalPadding =
    const EdgeInsets.symmetric(horizontal: 20),
    this.onChanged,
    this.fillColor = Colors.white,
    this.suffixIcon = Icons.search,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Material(
          elevation: 4,
          shadowColor: Colors.black26,
          borderRadius: BorderRadius.circular(8),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search by CRN Number",
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              suffixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ),
    );
  }
}
