import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_detail.dart';
class SelectTypeExpandableSection extends StatefulWidget {

  String hintText;
  TextEditingController? controller;

  Color? hintTextColor;
  IconData? icon ;
  Color? iconColor ;

  final Widget Function(VoidCallback onClose) detailBuilder;
   SelectTypeExpandableSection({
    super.key,

    required this.hintText,
    this.controller,
    this.hintTextColor,
    this.icon = Icons.arrow_drop_down,

     required this.detailBuilder,
  });

  @override
  State<SelectTypeExpandableSection> createState() =>
      _SelectTypeExpandableSectionState();
}

class _SelectTypeExpandableSectionState
    extends State<SelectTypeExpandableSection> {

  bool isOpen = false;

  void openDetail() => setState(() => isOpen = true);
  void closeDetail() => setState(() => isOpen = false);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        if (!isOpen)
          MainscreenSelecttypeDetail(
            hintText: widget.hintText,
            hintTextColor: AppColor.color1E1E1E,
            onTap: openDetail,
            icon: Icons.arrow_drop_down,
          ),

        if (isOpen)
          widget.detailBuilder(closeDetail), // 🔥 MAGIC
      ],
    );
  }
}
