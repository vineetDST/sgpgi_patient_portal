import 'package:flutter/material.dart';
class RadioButton<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String label;
  final Color activeColor;
  final TextStyle? textStyle;

  const RadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
    this.activeColor = const Color(0xFF117A7A),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Requirement 3: De-select Logic (Text par click hone par)
        if (value == groupValue) {
          onChanged(null);
        } else {
          onChanged(value);
        }
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 20,
            width: 20,
            child: Radio<T>(
              value: value,
              groupValue: groupValue,
              activeColor: activeColor,
              onChanged: onChanged,
              toggleable: true, // Requirement 3: De-select Logic (Radio par click hone par)
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: textStyle ??
                  const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}