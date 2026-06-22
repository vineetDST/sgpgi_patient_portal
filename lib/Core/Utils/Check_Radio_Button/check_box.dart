import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
// import 'global_checkbox.dart'; // Agar purana widget alag file mein hai to import karein


class GlobalCheckboxGroup extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onSelectionChanged;
  final bool isTwoColumns; // <-- NAYA PARAMETER ADD KIYA HAI

  const GlobalCheckboxGroup({
    Key? key,
    required this.items,
    required this.onSelectionChanged,
    this.isTwoColumns = false, // Default false rakha hai (natural placement ke liye)
  }) : super(key: key);

  @override
  _GlobalCheckboxGroupState createState() => _GlobalCheckboxGroupState();
}

class _GlobalCheckboxGroupState extends State<GlobalCheckboxGroup> {
  List<String> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double spacing = 16.0; // Horizontal gap dono ke beech

        return SizedBox(
          width: double.infinity,
          child: Wrap(
            // Agar normal hai to spaceBetween, agar 2-column hai to start se align
            alignment: widget.isTwoColumns ? WrapAlignment.start : WrapAlignment.spaceBetween,
            spacing: widget.isTwoColumns ? spacing : 0.0, // Natural placement me khud adjust hoga
            runSpacing: 12.0,
            children: widget.items.map((item) {

              // Pehle checkbox widget bana lete hain
              Widget checkboxWidget = GlobalCheckbox(
                label: item,
                value: _selectedItems.contains(item),
                onChanged: (bool isSelected) {
                  setState(() {
                    if (isSelected) {
                      _selectedItems.add(item);
                    } else {
                      _selectedItems.remove(item);
                    }
                  });
                  widget.onSelectionChanged(_selectedItems);
                },
              );

              // Agar requirement 2 column ki hai, to width fix kar denge
              if (widget.isTwoColumns) {
                // Total width me se spacing minus karke aadha kar diya
                double itemWidth = (constraints.maxWidth - spacing) / 2.01;
                return SizedBox(
                  width: itemWidth,
                  child: checkboxWidget,
                );
              }

              // Agar requirement natural flow ki hai, to jaisa hai waisa return kar denge
              return checkboxWidget;

            }).toList(),
          ),
        );
      },
    );
  }
}

class GlobalCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  const GlobalCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    // Image ke matching teal color ka hex code
    this.activeColor = const Color(0xFF157F7F),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value); // Tap karne par value toggle hogi
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Checkbox Box UI
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: value ? activeColor : Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: value ? activeColor : Colors.grey.shade400,
                width: 1.5,
              ),
            ),
            child: value
                ? const Icon(
              Icons.check,
              size: 16,
              color: Colors.white, // Check icon ka color
            )
                : null, // Unchecked par khali rahega
          ),
          const SizedBox(width: 8), // Checkbox aur text ke beech ka space

          // Checkbox Label
          Flexible(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}