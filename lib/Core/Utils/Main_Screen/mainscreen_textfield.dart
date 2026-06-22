import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainscreenTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String hintText;
  final Function(String)? onChanged;
  final Function(bool)? onFocusChange;
  final double fontSize;
  final int maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  final Color? textColor;
  final FontWeight? fontWeight;
  final Color? fillColor;

  final bool? readOnly;

  const MainscreenTextfield({
    Key? key,
     this.controller,


    required this.hintText,
    this.onChanged,
    this.onFocusChange,
    this.fontSize = 14.0,
    this.maxLength = 50,
    this.inputFormatters,
    this.keyboardType,
    this.focusNode,
    this.textColor,
    this.fontWeight,
    this.fillColor = Colors.white,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: onFocusChange ?? (_) {},
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        inputFormatters: inputFormatters ?? [LengthLimitingTextInputFormatter(maxLength)],
        style: TextStyle(
          color: textColor ?? Colors.black45,
          fontSize: MediaQuery.of(context).size.height * 0.016,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        readOnly: readOnly ?? false,
        onChanged: onChanged,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.015,
            vertical: MediaQuery.of(context).size.height * 0.013,
          ),
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0x4D111111),
            fontSize: MediaQuery.of(context).size.height * 0.014,
            fontWeight: FontWeight.w500,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: Color(0xFFEAEAEA),
                width: 1.5
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
                color: Color(0xFFEAEAEA),
                width: 1.5
            ),
          ),

        ),
      ),
    );
  }
}