import 'package:flutter/material.dart';

class TablePhysicalExamCell extends StatelessWidget {
  final List<String> options;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  final TextEditingController controller;
  final double optionsWidth;

  const TablePhysicalExamCell({
    super.key,
    required this.options,
    required this.groupValue,
    required this.onChanged,
    required this.controller,
    this.optionsWidth = 220.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: optionsWidth,

            child: Row(
              children: options.map((option) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: groupValue,
                      activeColor: const Color(0xFF117A7A),
                      visualDensity: VisualDensity.compact,
                      // onChanged: onChanged,
                      onChanged: null,
                      fillColor: MaterialStateProperty.resolveWith<Color>((
                        states,
                      ) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey.shade400; // disabled color
                        }
                        if (states.contains(MaterialState.selected)) {
                          return const Color(0xFF117A7A); // selected color
                        }
                        return Colors.grey.shade600; // normal unselected border
                      }),
                    ),
                    Text(
                      option,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                );
              }).toList(),
            ),
          ),
          const VerticalDivider(
            width: 24,
            thickness: 1,
            color: Color(0xFFE0E0E0),
          ),

          Container(
            width: 165,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              readOnly: true,
              controller: controller,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF8F9FA),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                // border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
