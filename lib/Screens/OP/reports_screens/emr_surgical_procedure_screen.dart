import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';

import 'emr_list_screen.dart';

class EmrSurgicalProcedureScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  final String? mode;
  const EmrSurgicalProcedureScreen({
    super.key,
    required this.patientName,
    required this.crn,
    this.mode = "op",
  });
  @override
  State<EmrSurgicalProcedureScreen> createState() =>
      _EmrSurgicalProcedureScreenState();
}

class _EmrSurgicalProcedureScreenState
    extends State<EmrSurgicalProcedureScreen> {
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
              "Surgical Procedure",
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
                const SizedBox(width: 8),
                widget.mode == "op"
                    ? _buildBlackButton(
                        "Action",
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useRootNavigator: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => OpActionBottomSheet(
                              patientName: widget.patientName,
                              crn: widget.crn,
                            ),
                          );
                        },
                      )
                    : IPActionButton(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        _buildSyncedTable(),
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

  Widget _buildSyncedTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF9F9),
              border: Border(right: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                _buildLeftCell("Request Details", 75),
                _buildDivider(),
                _buildLeftCell("Surgery Details", 60),
                _buildDivider(),
                _buildLeftCell("Status", 60),
                _buildDivider(),
                _buildLeftCell("PAC Status", 60),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicWidth(
                child: SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      _buildRightRequestDetails(75),
                      _buildDivider(),
                      _buildRightTextCell(
                        "Permanent Pacemaker Implantation",
                        60,
                      ),
                      _buildDivider(),
                      _buildRightTextCell("Settled", 60),
                      _buildDivider(),
                      _buildRightYellowPillCell("Pending", 60),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
        color: Colors.black87,
      ),
    ),
  );
  Widget _buildRightTextCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      text,
      style: const TextStyle(fontSize: 13, color: Colors.black87),
    ),
  );
  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  Widget _buildRightRequestDetails(double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "PROCREQ-20148173",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          Text(
            "Operation Notes | Anaesthietist Notes",
            style: TextStyle(fontSize: 12, color: Color(0xFF117A7A)),
          ),
        ],
      ),
    );
  }

  Widget _buildRightYellowPillCell(String text, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF3CD),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF856404),
          ),
        ),
      ),
    );
  }
}
