import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
class TotalCostSection extends StatelessWidget {
  const TotalCostSection({super.key});

  @override
  Widget build(BuildContext context) {
    return DetailTableWrapper(
      children: [
        DetailRow(
          label: "Balance Amount",
          customWidget: Text(
            "5075.00",
            style: TextStyle(
              color: Color(0xFF117A7A),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        DetailRow(
          label: "Blocked Amount",
          customWidget: Text(
            "0.00",
            style: TextStyle(

              color: Color(0xFFFF0606),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        DetailRow(
          label: "Current Order Amount",
          customWidget: Text(
            "1130.00",
            style: TextStyle(
              color: Color(0xFF117A7A),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        DetailRow(
          isLast: true,
          label: "Pending Amount",
          customWidget: Text(
            "0.00",
            style: TextStyle(
              color: Color(0xFF107500),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}