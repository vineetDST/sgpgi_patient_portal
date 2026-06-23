import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/EMR/ip_emr.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';

import 'package:qc_hospital/Screens/OP/reports_screens/emr_list_screen.dart'; // Import the List screen

class EmrInvestigationScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  final String? mode;

  const EmrInvestigationScreen({
    super.key,
    required this.patientName,
    required this.crn,
    this.mode = "op",
  });

  @override
  State<EmrInvestigationScreen> createState() => _EmrInvestigationScreenState();
}

class _EmrInvestigationScreenState extends State<EmrInvestigationScreen> {
  int _bottomNavIndex = 1;
  int _activeTabIndex = 0; // 0: Lab, 1: Old HIS, 2: PACS, 3: Proc

  final List<String> _tabs = [
    "Lab Reports",
    "Old HIS Reports",
    "PACS Reports",
    "Procedure Reports",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header & Action Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Investigation",
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
        const SizedBox(height: 16),

        // Horizontally Scrollable Tabs
        _buildTabs(),
        const SizedBox(height: 24),

        // Tab Content Switcher
        _buildTabContent(),
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

  Widget _buildTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabs.asMap().entries.map((entry) {
            int idx = entry.key;
            String title = entry.value;
            bool isActive = _activeTabIndex == idx;
            return GestureDetector(
              onTap: () => setState(() => _activeTabIndex = idx),
              child: Container(
                padding: const EdgeInsets.only(bottom: 12, right: 16, left: 16),
                decoration: BoxDecoration(
                  border: isActive
                      ? const Border(
                          bottom: BorderSide(
                            color: Color(0xFF117A7A),
                            width: 2,
                          ),
                        )
                      : null,
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    color: isActive
                        ? const Color(0xFF117A7A)
                        : Colors.grey.shade600,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_activeTabIndex) {
      case 0:
        return _buildLabReportsTab();
      case 1:
        return _buildOldHisTab();
      case 2:
        return _buildPacsTab();
      case 3:
        return _buildProcedureTab();
      default:
        return const SizedBox();
    }
  }

  // ==========================================
  // TAB 1: LAB REPORTS
  // ==========================================
  Widget _buildLabReportsTab() {
    final List<String> categories = [
      "ATC 24 Hr Clinical Chemistry",
      "ATC 24 Hr Urine Analysis",
      "Clinical Chemistry",
      "Histopathology",
      "Molecular Pathology",
    ];

    return Column(
      children: categories.map((cat) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                initiallyExpanded:
                    cat ==
                    "ATC 24 Hr Clinical Chemistry", // First one expanded as per mockup
                title: Text(
                  cat,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: _buildSyncedTable(
                      leftWidth: 140,
                      rowHeight: 55,
                      labels: [
                        "Investigation",
                        "Value",
                        "Unit",
                        "Reference Range",
                        "Order No",
                        "Received Date",
                        "Result Status",
                        "Specimen",
                        "Test On",
                        "Remarks",
                      ],
                      rightCols: [
                        _buildLabRightColumn(
                          "Alkaline Phosphatase",
                          "234",
                          "U/L",
                          "60.0-270.0",
                          "ORDER20254569871",
                          "30-04-2025 | 10:20",
                          "V",
                          "Blood-Plain",
                          "Blood-Plain",
                          "",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLabRightColumn(
    String inv,
    String val,
    String unit,
    String ref,
    String order,
    String date,
    String status,
    String spec,
    String test,
    String rem,
  ) {
    return SizedBox(
      width: 250, // Slightly wider for this data
      child: Column(
        children: [
          _buildRightTextCell(inv, 55),
          _buildDivider(),
          _buildRightTextCell(val, 55),
          _buildDivider(),
          _buildRightTextCell(unit, 55),
          _buildDivider(),
          _buildRightTextCell(ref, 55),
          _buildDivider(),
          _buildRightTextCell(order, 55),
          _buildDivider(),
          _buildRightTextCell(date, 55),
          _buildDivider(),
          Container(
            height: 55,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              status,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          _buildDivider(),
          _buildRightTextCell(spec, 55),
          _buildDivider(),
          _buildRightTextCell(test, 55),
          _buildDivider(),
          _buildRightInputCell(rem, 55),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 2: OLD HIS REPORTS
  // ==========================================
  Widget _buildOldHisTab() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Text(
          "No Record for Current visit",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // ==========================================
  // TAB 3: PACS REPORTS
  // ==========================================
  Widget _buildPacsTab() {
    return _buildSyncedTable(
      leftWidth: 130,
      rowHeight: 60,
      labels: [
        "Investigation\nName",
        "Service Center",
        "Order No",
        "Date",
        "Order Status",
        "Study Date",
        "AccessionNo",
        "Link",
        "New Link",
      ],
      rightCols: [
        _buildPacsRightColumn(
          "MRI Head",
          "MRI",
          "ORDER202500068",
          "",
          "Accepted",
          "08-10-2025",
          "MR227334",
          "Link",
          true,
        ),
      ],
    );
  }

  Widget _buildPacsRightColumn(
    String name,
    String center,
    String order,
    String date,
    String status,
    String study,
    String acc,
    String link,
    bool showPdf,
  ) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          _buildRightTextCell(name, 60),
          _buildDivider(),
          _buildRightTextCell(center, 60),
          _buildDivider(),
          _buildRightTextCell(order, 60),
          _buildDivider(),
          _buildRightTextCell(date, 60),
          _buildDivider(),
          _buildRightPillCell(status, Colors.blue.shade100, 60),
          _buildDivider(),
          _buildRightTextCell(study, 60),
          _buildDivider(),
          _buildRightTextCell(acc, 60),
          _buildDivider(),
          _buildRightActionText(link, 60),
          _buildDivider(),
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: showPdf
                ? Image.asset('assets/pdf.png', height: 24, width: 24)
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // TAB 4: PROCEDURE REPORTS
  // ==========================================
  Widget _buildProcedureTab() {
    return _buildSyncedTable(
      leftWidth: 130,
      rowHeight: 60,
      labels: [
        "Service Name",
        "Service Center",
        "Order Status",
        "Result Status",
        "Order Date",
        "View Report",
      ],
      rightCols: [
        _buildProcedureRightColumn(
          "735",
          "Cath Lab",
          "446",
          "229",
          "08-10-2025",
          true,
        ),
      ],
    );
  }

  Widget _buildProcedureRightColumn(
    String name,
    String center,
    String orderStatus,
    String resultStatus,
    String date,
    bool showPdf,
  ) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          _buildRightTextCell(name, 60),
          _buildDivider(),
          _buildRightTextCell(center, 60),
          _buildDivider(),
          _buildRightTextCell(orderStatus, 60),
          _buildDivider(),
          _buildRightTextCell(resultStatus, 60),
          _buildDivider(),
          _buildRightTextCell(date, 60),
          _buildDivider(),
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: showPdf
                ? Image.asset('assets/pdf.png', height: 24, width: 24)
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // CORE SYNCHRONIZED TABLE LOGIC
  // ==========================================
  Widget _buildSyncedTable({
    required double leftWidth,
    required double rowHeight,
    required List<String> labels,
    required List<Widget> rightCols,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Fixed Column
          Container(
            width: leftWidth,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF9F9),
              border: Border(right: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: labels.map((label) {
                return Column(
                  children: [
                    _buildLeftCell(label, rowHeight),
                    if (label != labels.last) _buildDivider(),
                  ],
                );
              }).toList(),
            ),
          ),
          // Right Scrollable Column
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicWidth(
                child: Row(
                  children: rightCols.map((col) {
                    return Row(
                      children: [
                        col,
                        if (col != rightCols.last)
                          Container(width: 1, color: Colors.grey.shade300),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Cells
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

  // Widget _buildRightInputCell(String hint, double height) {
  //   return Container(
  //     height: height,
  //     alignment: Alignment.centerLeft,
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey.shade300),
  //         borderRadius: BorderRadius.circular(6),
  //       ),
  //       child: TextField(
  //         decoration: InputDecoration(
  //           hintText: hint,
  //           hintStyle: const TextStyle(fontSize: 11, color: Colors.grey),
  //           border: InputBorder.none,
  //           contentPadding: const EdgeInsets.only(bottom: 14, left: 8),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildRightInputCell(String hint, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        height: 38, // Fixed height to prevent shrinking
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: TextField(
          // --- ADD THESE TWO LINES TO FIX THE STUCK BLACK DOT ---
          enableInteractiveSelection: false,
          contextMenuBuilder: (_, __) => const SizedBox.shrink(),
          // ------------------------------------------------------
          style: const TextStyle(fontSize: 12, color: Colors.black87),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 11, color: Colors.grey),
            border: InputBorder.none,
            isDense: true, // Use isDense instead of heavy bottom padding
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRightPillCell(String text, Color color, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildRightActionText(String text, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF117A7A),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
