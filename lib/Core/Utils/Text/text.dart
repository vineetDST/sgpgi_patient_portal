import 'package:flutter/material.dart';

class AppText {

  static Widget suffixText(
      String text, { // Sirf ye mandatory hai
        EdgeInsetsGeometry? padding,
        TextStyle? textStyle,
        MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
        MainAxisSize mainAxisSize = MainAxisSize.min,
      }) {
    return Padding(

      padding: padding ?? const EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: CrossAxisAlignment.end,

        children: [
          Text(
            text,

            style: textStyle ?? const TextStyle(color: Colors.black, fontSize: 14),
          ),
        ],
      ),
    );
  }

}