import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;

  const CustomRadioButton({
    super.key,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 20,
          width: 20,
          padding: const EdgeInsets.all(3.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected
                  ? const Color(0xFF117A7A)
                  : Colors.grey.shade400,
              width: 2,
            ),
            color: Colors.white,
          ),
          child: selected
              ? Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF117A7A),
            ),
          )
              : null,
        ),
      ),
    );
  }
}