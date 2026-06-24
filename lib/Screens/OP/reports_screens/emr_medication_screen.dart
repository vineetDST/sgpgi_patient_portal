import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';

import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';

import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_list_screen.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';

class EmrMedicationScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  final String? mode;

  const EmrMedicationScreen({
    super.key,
    required this.patientName,
    required this.crn,
    this.mode = "op",
  });

  @override
  State<EmrMedicationScreen> createState() => _EmrMedicationScreenState();
}

class _EmrMedicationScreenState extends State<EmrMedicationScreen> {
  int _bottomNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Medication",
              style: AppTextStyles.RegH3.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                _buildBlackButton(
                  "List",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmrListScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                          mode: widget.mode,
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                // const SizedBox(width: 8),
                // widget.mode == "op"
                //     ? _buildBlackButton(
                //         "Action",
                //         onTap: () {
                //           showModalBottomSheet(
                //             context: context,
                //             isScrollControlled: true,
                //             useRootNavigator: true,
                //             backgroundColor: Colors.transparent,
                //             builder: (context) => OpActionBottomSheet(
                //               patientName: widget.patientName,
                //               crn: widget.crn,
                //             ),
                //           );
                //         },
                //       )
                //     : IPActionButton(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),

        const DetailTableWrapper(
          children: [
            DetailRow(
              label: "Drug Name",
              customWidget: Text(
                "Aldopam 25 mg Inj 1 Drop for 0 Days",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            DetailRow(
              label: "In Take",
              customWidget: Text(
                "1",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            DetailRow(
              label: "Total Qty",
              customWidget: Text(
                "0",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            DetailRow(

              label: "Ordered On",
              customWidget: Text(
                "08-Jun-2026",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            DetailRow(
              isLast: true,
              label: "Instruction",
              customWidget: Text(
                "08-10-2025",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
    if (widget.mode == "ip") {
      return IpBaseScaffold(
        title: "EMR",
        quickActionLabel: "EMR",
        showDrawer: false,
        patientName: widget.patientName,
        crn: widget.crn,
        activeQuickAction: true,
        child: content,
      );
    } else {
      return ClinicalBaseScaffold(
        title: "EMR",
        showDrawer: false,
        patientName: widget.patientName,
        crn: widget.crn,
        activeQuickAction: 'EMR',
        child: content,
      );
    }
  }

  Widget _buildBlackButton(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
