import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

class IPProgressNotes extends StatefulWidget {
  final String patientName;
  final String crn;

  const IPProgressNotes({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<IPProgressNotes> createState() => _IPProgressNotesState();
}

class _IPProgressNotesState extends State<IPProgressNotes> {
  final dischargeRemarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Progress Notes",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Progress Notes",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(Icons.print, color: Colors.black87, size: 20),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Current Notes"),
          const SizedBox(height: 8),
          Stack(
            children: [
              SharedComponents.buildTextField(
                controller: dischargeRemarksController,
                hintText: "Current Notes",
                maxLines: 5,
                // height: 130,
              ),
              // Positioned(
              //   bottom: 12,
              //   right: 12,
              //   child: Image.asset(
              //     'assets/txtarea.png', // Uses the uploaded icon
              //     width: 14,
              //     height: 14,
              //     color: Colors.grey.shade400,
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 24),

          AppSaveButton(text: "Add Notes", onPressed: () {}),
          const SizedBox(height: 32),

          AppCancelButton(text: "Cancel", onPressed: () {}),
          const SizedBox(height: 32),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Progress Notes",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SharedComponents.buildFormLabel("Post by: Admin"),
              Text(
                "08-10-2025 | 10:23",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
