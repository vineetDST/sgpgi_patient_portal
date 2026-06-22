import 'package:flutter/material.dart';

class Filterlabel extends StatelessWidget {
  final String text;
  final bool showStar;

  final Color starColor;


  const Filterlabel({
    super.key,
    required this.text,
    this.showStar = false, // ⭐ default false

    this.starColor = Colors.red,

  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Text(
            text,
            style:
                 TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.0155,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF1E1E1E),
                ),
          ),
        ),
        if (showStar) ...[

          Icon(
            Icons.star,
            color: Colors.red,
            size: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      ],
    );
  }
}
