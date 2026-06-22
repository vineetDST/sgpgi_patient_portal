import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';

class OpSearchField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTapSearch;

  const OpSearchField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onTapSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColor.colorB7B7B7,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Text Input
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: AppTextStyles.RegH3.copyWith(fontSize: 14),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.RegH3.copyWith(
                  color: AppColor.colorB7B7B7,
                  fontSize: 13,
                ),
                border: InputBorder.none,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              ),
            ),
          ),

          // Search Icon Button
          InkWell(
            onTap: onTapSearch,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                Icons.search,
                size: 20,
                color: AppColor.colorB7B7B7,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
