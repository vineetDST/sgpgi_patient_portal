import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  final Color textColor;
  final Color backgroundColor;

  final Color borderColor;
  final double borderWidth;




  final TextStyle? textStyle;

  const FilterButton({
    super.key,
    required this.text,
    required this.onPressed,

    required this.textColor ,
    required this.backgroundColor ,

    this.borderColor = Colors.transparent,
    this.borderWidth = 1,




    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            )
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.016,
              fontWeight: FontWeight.w500,
              color: textColor,

            ),
          ),
        ),
      ),
    );
  }
}
