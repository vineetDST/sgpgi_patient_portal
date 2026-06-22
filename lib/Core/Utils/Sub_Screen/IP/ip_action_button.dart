import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_bottom_sheet.dart';
import 'package:qc_hospital/Screens/IP/shared_componenet.dart';

class IPActionButton extends StatelessWidget {
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final String patientName; // final banayein
  final String crn;         // final banayein

  const IPActionButton({ // const constructor
    super.key,
    this.onTap,
    this.padding,
    this.patientName = "Anil",
    this.crn = "2025000783",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
              () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useRootNavigator: true,
              backgroundColor: Colors.transparent,
              builder: (context) =>  IpActionBottomSheet(crn: crn,patientName: patientName),
            );
          },
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 8,
            ),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A), // fixed color
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Text(
          "Action",
          style: TextStyle(
            color: Colors.white, // fixed text color
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}