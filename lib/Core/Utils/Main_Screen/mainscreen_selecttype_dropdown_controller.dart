import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_dropdown_value.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_dropdown.dart';

class MainscreenSelecttypeDropdownController extends StatefulWidget {

  String? hintText;
  Color? hintTextColor;
  IconData? icon ;
  Color? iconColor ;

  final List<String> items;

  final Function(String) onItemTap ;

   MainscreenSelecttypeDropdownController({
    super.key,
    this.hintText,
    this.hintTextColor,
    this.icon,
    this.iconColor,
    required this.items,

    required this.onItemTap
  });

  @override
  State<MainscreenSelecttypeDropdownController> createState() =>
      _SelectTypeDropdownControllerState();
}

class _SelectTypeDropdownControllerState
    extends State<MainscreenSelecttypeDropdownController> {

  bool isDropdownOpen = false;
  String? selectedValue;
  final TextEditingController controller = TextEditingController();

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  void onItemSelected(String value) {
    setState(() {
      selectedValue = value;
      controller.text = value;
      isDropdownOpen = false;
    });

    widget.onItemTap(value);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// 🔹 TOP FIELD
        if (!isDropdownOpen)
          MainscreenSelecttypeDropdown(
            controller: controller,
            hintText: widget.hintText ?? "--Select--",
            hintTextColor: widget.hintTextColor ?? AppColor.colorB7B7B7,
            iconColor: widget.iconColor ?? AppColor.colorB7B7B7,
            onTap: toggleDropdown,
            icon: Icons.arrow_drop_down,
          ),

        /// 🔹 DROPDOWN LIST
        if (isDropdownOpen)
          MainscreenDropdownValue(
            items: widget.items,
            onItemTap: onItemSelected,
          ),

        SizedBox(height: height * 0.015),
      ],
    );
  }
}
