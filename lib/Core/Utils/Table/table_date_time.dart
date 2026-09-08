import 'package:flutter/material.dart';

class TableDateTime extends StatelessWidget {
  final String date;
  final String time;

  const TableDateTime({
    super.key,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: date,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
            const TextSpan(
              text: ' → ',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
            TextSpan(
              text: time,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF117A7A),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}