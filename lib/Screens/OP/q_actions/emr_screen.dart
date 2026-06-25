import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/list_button.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';

import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';

// --- Import the Standalone EMR List Screen ---
import 'package:qc_hospital/Screens/OP/reports_screens/emr_list_screen.dart';
// Adjust path if needed

class EmrScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  final String? mode;

  const EmrScreen({
    super.key,
    required this.patientName,
    required this.crn,
    this.mode = "op",
  });

  @override
  State<EmrScreen> createState() => _EmrScreenState();
}

class _EmrScreenState extends State<EmrScreen> {
  int _activeTabIndex = 0;

  @override
  Widget build(BuildContext context) {


    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Consultation Details",
              style: AppTextStyles.RegH3.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            EmrListButton(patientName: widget.patientName, crn: widget.crn,mode: widget.mode,)
          ],
        ),
        const SizedBox(height: 16),

        // Tabs
        _buildTabs(),
        const SizedBox(height: 24),

        // Tab Content
        _activeTabIndex == 0 ? _buildSummaryTab() : _buildClinicalDetailsTab(),

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
        showDrawer: true,
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
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

  Widget _buildTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          _buildTabItem("Summary", 0),
          _buildTabItem("Clinical Details", 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isActive = _activeTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTabIndex = index),
      child: Container(
        padding: const EdgeInsets.only(bottom: 12, right: 16, left: 8),
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
                  bottom: BorderSide(color: Color(0xFF117A7A), width: 2),
                )
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? const Color(0xFF117A7A) : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  // ==========================================
  // TAB 1: SUMMARY TAB
  // ==========================================
  Widget _buildSummaryTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedComponents.buildFormLabel("Clinical Notes"),
        const SizedBox(height: 8),
        _buildGreyTextArea("Process", 100),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel("Provisional Diagnosis"),
        const SizedBox(height: 8),
        _buildGreyTextArea(
          "K90-K93:K90-K93: Other diseases of the digestive System",
          100,
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel("Final Diagnosis"),
        const SizedBox(height: 8),
        _buildGreyTextArea(
          "K90-K93:K90-K93: Other diseases of the digestive System",
          100,
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Last Modified: Admin\nTime: 07-11-2025 | 10:25 AM",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreyTextArea(String text, double height) {
    return Stack(
      children: [
        Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
        ),
        Positioned(
          bottom: 12,
          right: 12,
          child: Image.asset(
            'assets/txtarea.png',
            width: 14,
            height: 14,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // TAB 2: CLINICAL DETAILS TAB
  // ==========================================
  Widget _buildClinicalDetailsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildClinicalHistoryTile(),
        const SizedBox(height: 12),
        _buildHistoryTile("Medication History", _buildMedicationHistoryTable()),
        const SizedBox(height: 12),
        _buildHistoryTile(
          "Immunization History",
          _buildImmunizationHistoryTable(),
        ),
        const SizedBox(height: 12),
        _buildHistoryTile("Family History", _buildFamilyHistoryTable()),
        const SizedBox(height: 12),
        _buildHistoryTile("Allergy History", _buildAllergyHistoryTable()),
      ],
    );
  }

  Widget _buildHistoryTile(String title, Widget tableContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: tableContent,
            ),
          ],
        ),
      ),
    );
  }

  // --- Clinical History Area (Text Areas) ---
  Widget _buildClinicalHistoryTile() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: const Text(
            "Clinical History",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Chief Complaints",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildGreyTextArea(
                    "The 10 yrs old Male has a complaint of Ulcer foot from 2 days",
                    100,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "History of Present Illness",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildGreyTextArea("Ulcer foot from 2 days", 100),
                  const SizedBox(height: 16),
                  const Text(
                    "Social History",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildGreyTextArea("Null", 100),
                  const SizedBox(height: 16),
                  const Text(
                    "Past History",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildGreyTextArea("Null", 100),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // SYNCHRONIZED SCROLLING TABLES
  // ==========================================

  Widget _buildMedicationHistoryTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF9F9),
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  _buildLeftCell("Medication", 60),
                  _buildDivider(),
                  _buildLeftCell("Dosages", 60),
                  _buildDivider(),
                  _buildLeftCell("Frequency", 60),
                  _buildDivider(),
                  _buildLeftCell("Status", 60),
                  _buildDivider(),
                  _buildLeftCell("Duration", 60),
                  _buildDivider(),
                  _buildLeftCell("Remarks", 60),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            _buildRightTextCell("Diabetics", 60),
                            _buildDivider(),
                            _buildRightTextCell("500 mg", 60),
                            _buildDivider(),
                            _buildRightTextCell("Daily", 60),
                            _buildDivider(),
                            _buildRightGreenPill("Active", 60),
                            _buildDivider(),
                            _buildRightTextCell("1 Week", 60),
                            _buildDivider(),
                            _buildRightTextCell("-", 60),
                          ],
                        ),
                      ),
                      Container(width: 1, color: Colors.grey.shade300),
                      SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            _buildRightTextCell("Diabetics", 60),
                            _buildDivider(),
                            _buildRightTextCell("500 mg", 60),
                            _buildDivider(),
                            _buildRightTextCell("Daily", 60),
                            _buildDivider(),
                            _buildRightGreenPill("Active", 60),
                            _buildDivider(),
                            _buildRightTextCell("1 Week", 60),
                            _buildDivider(),
                            _buildRightTextCell("-", 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImmunizationHistoryTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 160,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF9F9),
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  _buildLeftCell("Immunization", 60),
                  _buildDivider(),
                  _buildLeftCell("Status", 60),
                  _buildDivider(),
                  _buildLeftCell("Age at\nImmunization(Yrs)", 75),
                  _buildDivider(),
                  _buildLeftCell("Duration(Yrs)", 60),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            _buildRightTextCell("Heptatitis A", 60),
                            _buildDivider(),
                            _buildRightGreenPill("Given", 60),
                            _buildDivider(),
                            _buildRightTextCell("62", 75),
                            _buildDivider(),
                            _buildRightTextCell("1 Year", 60),
                          ],
                        ),
                      ),
                      Container(width: 1, color: Colors.grey.shade300),
                      SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            _buildRightTextCell("Heptatitis B", 60),
                            _buildDivider(),
                            _buildRightGreenPill("Given", 60),
                            _buildDivider(),
                            _buildRightTextCell("62", 75),
                            _buildDivider(),
                            _buildRightTextCell("1 Year", 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyHistoryTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
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
                  _buildLeftCell("Relationship", 60),
                  _buildDivider(),
                  _buildLeftCell("Survival Status", 60),
                  _buildDivider(),
                  _buildLeftCell("Age(Yrs)", 60),
                  _buildDivider(),
                  _buildLeftCell("Illness", 60),
                  _buildDivider(),
                  _buildLeftCell("Duration(Yrs)", 60),
                  _buildDivider(),
                  _buildLeftCell("Age at Death(Yrs)", 60),
                  _buildDivider(),
                  _buildLeftCell("Cause of Death", 60),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            _buildRightTextCell("Father", 60),
                            _buildDivider(),
                            _buildRightGreenPill("Alive", 60),
                            _buildDivider(),
                            _buildRightTextCell("62", 60),
                            _buildDivider(),
                            _buildRightTextCell("Cancer", 60),
                            _buildDivider(),
                            _buildRightTextCell("1 Year", 60),
                            _buildDivider(),
                            _buildRightTextCell("-", 60),
                            _buildDivider(),
                            _buildRightTextCell("-", 60),
                          ],
                        ),
                      ),
                      Container(width: 1, color: Colors.grey.shade300),
                      SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            _buildRightTextCell("Mother", 60),
                            _buildDivider(),
                            _buildRightGreenPill("Alive", 60),
                            _buildDivider(),
                            _buildRightTextCell("62", 60),
                            _buildDivider(),
                            _buildRightTextCell("Cancer", 60),
                            _buildDivider(),
                            _buildRightTextCell("1 Year", 60),
                            _buildDivider(),
                            _buildRightTextCell("-", 60),
                            _buildDivider(),
                            _buildRightTextCell("-", 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllergyHistoryTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
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
                  _buildLeftCell("Visit No", 60),
                  _buildDivider(),
                  _buildLeftCell("Allergy Category", 60),
                  _buildDivider(),
                  _buildLeftCell("Allergic To", 60),
                  _buildDivider(),
                  _buildLeftCell("Status", 60),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            _buildRightTextCell("OP-003", 60),
                            _buildDivider(),
                            _buildRightTextCell("Drug", 60),
                            _buildDivider(),
                            _buildRightTextCell("PROPANOL OL", 60),
                            _buildDivider(),
                            _buildRightGreenPill("Active", 60),
                          ],
                        ),
                      ),
                      Container(width: 1, color: Colors.grey.shade300),
                      SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            _buildRightTextCell("OP-003", 60),
                            _buildDivider(),
                            _buildRightTextCell("Food", 60),
                            _buildDivider(),
                            _buildRightTextCell("Gluten", 60),
                            _buildDivider(),
                            _buildRightGreenPill("Active", 60),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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

  Widget _buildRightGreenPill(String text, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFC0F4BA),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E6C16),
          ),
        ),
      ),
    );
  }
}
