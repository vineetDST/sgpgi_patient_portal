import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filter_heading.dart';

class PreviousDonationDetailDialog extends StatelessWidget {
  const PreviousDonationDetailDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Card ke round corners
      ),
      elevation: 10,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Content ke hisab se height lega
          children: [
            // --- Header (Title + Close Button) ---
            HeadingFilter(heading: "Previous Donation Details",),
            const SizedBox(height: 20),

            // --- Details Table Container ---
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  children: [
                    _buildDetailRow(context,"Donor Name", "Vijay Singh"),
                    _buildDetailRow(context,"Donor Reg.No", "D-2025110400063"),
                    _buildDetailRow(context,"Date of Birth", ""), // Empty Field
                    _buildDetailRow(context,"Last Donation Type", "Whole Blood"),
                    _buildDetailRow(context,"Donation Status", ""), // Empty Field
                    _buildDetailRow(context,"Last Donated Date", "11-11-2024", isLast: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widget for Table Rows ---
  Widget _buildDetailRow(BuildContext context,String label, String value, {bool isLast = false}) {
    return Container(
      decoration: BoxDecoration(

        border: isLast
            ? null
            : Border(bottom: BorderSide(color: Colors.grey.shade200,width: 2)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Side: Label (Light Teal Background)
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(left: 16, ),
                color: const Color(0xFFF0FDFC), // Matching the light teal/cyan color
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style:  TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600, // Thoda bold text labels ke liye
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

            // Vertical Divider Line
            Container(width: 2, color: Colors.grey.shade200),

            // Right Side: Value (White Background)
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                color: Colors.white,
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style:  TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.015,
                    fontWeight: FontWeight.w400,
                    color: AppColor.color1E1E1E,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}