import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
class MainscreenRadiobutton extends StatefulWidget {
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? initialValue;

   MainscreenRadiobutton({
    super.key,
    required this.items,
    required this.onChanged,
     this.initialValue,
  });

  @override
  State<MainscreenRadiobutton> createState() => _ReusableRadioGroupState();
}

class _ReusableRadioGroupState extends State<MainscreenRadiobutton> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    // Agar initialValue aayega toh wo set hoga, warna khali string ("") set hogi
    // Jisse by-default koi bhi radio button select nahi hoga.
    selectedValue = widget.initialValue ?? "";
  }

  void _handleTap(String value) {
    setState(() {
      if (selectedValue == value) {
        selectedValue = "";          // de-select
        widget.onChanged(null);
      } else {
        selectedValue = value;       // select
        widget.onChanged(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 24,
      // runSpacing: 16,
      children: widget.items.map((item) {
        return CustomRadioButton(
          label: item,
          isSelected: selectedValue == item,
          onTap: () => _handleTap(item),
        );
      }).toList(),
    );
  }
}

class CustomRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomRadioButton({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.teal : Color(0xFFDADADA),
                  width: 1.3,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.teal,
                  ),
                ),
              )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style:  TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.015,
                color: AppColor.color1E1E1E,
                fontWeight: FontWeight.w400// static
              ),
            ),
          ],
        ),
      ),
    );
  }
}
