import 'package:flutter/material.dart';
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  Color? color ;

    AppButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color = const Color(0xFF117A7A),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),

        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.018,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
