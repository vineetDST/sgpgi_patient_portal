import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/list_button.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';

import 'package:qc_hospital/Screens/OP/reports_screens/emr_list_screen.dart';

class EmrPrevVitalSignsScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  final String? mode;

  const EmrPrevVitalSignsScreen({
    super.key,
    required this.patientName,
    required this.crn,
    this.mode = "op",
  });

  @override
  State<EmrPrevVitalSignsScreen> createState() =>
      _EmrPrevVitalSignsScreenState();
}

class _EmrPrevVitalSignsScreenState extends State<EmrPrevVitalSignsScreen> {
  int _bottomNavIndex = 1;
  int _currentTabIndex = 0; // 0: Previous Vital Sign, 1: Vital Sign Chart

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
              "Vital Signs",
              style: AppTextStyles.RegH3.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            EmrListButton(patientName: widget.patientName, crn: widget.crn,mode: widget.mode,)
          ],
        ),
        const SizedBox(height: 16),

        _buildCustomTabs(),
        const SizedBox(height: 16),

        _currentTabIndex == 0 ? _buildPreviousTab() : _buildChartTab(),

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

  Widget _buildCustomTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          _buildTabItem("Previous Vital Sign", 0),
          _buildTabItem("Vital Sign Chart", 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isActive = _currentTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTabIndex = index),
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

  Widget _buildPreviousTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedComponents.buildFormLabel("Group Name"),
        const SizedBox(height: 8),
        SharedComponents.buildDropdown(hintText: "All"),
        const SizedBox(height: 16),

        Container(
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
                    border: Border(
                      right: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildLeftCell("Date \u2192 Time", 60),
                      _buildDivider(),
                      _buildLeftCell("HEIGHT", 60),
                      _buildDivider(),
                      _buildLeftCell("WEIGHT", 60),
                      _buildDivider(),
                      _buildLeftCell("SYSTOLIC BP", 60),
                      _buildDivider(),
                      _buildLeftCell("DIASTOLIC BP", 60),
                      _buildDivider(),
                      _buildLeftCell("TEMP", 60),
                      _buildDivider(),
                      _buildLeftCell("SPO2", 60),
                      _buildDivider(),
                      _buildLeftCell("HEART RATE", 60),
                      _buildDivider(),
                      _buildLeftCell("BMI", 60),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: IntrinsicWidth(
                      // 1. IntrinsicHeight lagaya taaki divider ko poori height mil sake
                      child: IntrinsicHeight(
                        child: Row(
                          children: [
                            _buildRightColumn(
                              "08-10-2025",
                              "17:20",
                              "",
                              "",
                              "90",
                              "70",
                              "98",
                              "",
                              "",
                              "14",
                            ),

                            // 2. Container ko hata kar VerticalDivider lagaya
                            VerticalDivider(
                              width: 1,
                              thickness: 1,
                              color: Colors.grey.shade300,
                            ),

                            _buildRightColumn(
                              "09-10-2025",
                              "10:00",
                              "",
                              "",
                              "95",
                              "75",
                              "98.5",
                              "",
                              "",
                              "14.5",
                              isSecondCol: true,
                            ),
                            // Last column ke baad koi divider nahi hai, toh ye clean dikhega!
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightColumn(
    String d1,
    String d2,
    String h,
    String w,
    String sys,
    String dia,
    String temp,
    String spo2,
    String hr,
    String bmi, {
    bool isSecondCol = false,
  }) {
    return SizedBox(
      width: 160,
      child: Column(
        children: [
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: RichText(
              text: TextSpan(
                text: d1,
                style: TextStyle(
                  color: isSecondCol ? Colors.red : Colors.red,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(
                    text: ' \u2192 ',
                    style: TextStyle(color: Colors.black54),
                  ),
                  TextSpan(
                    text: d2,
                    style: TextStyle(
                      color: isSecondCol
                          ? Colors.black87
                          : const Color(0xFF117A7A),
                      fontWeight: isSecondCol
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildDivider(),
          _buildRightTextCell(h, 60),
          _buildDivider(),
          _buildRightTextCell(w, 60),
          _buildDivider(),
          _buildRightTextCell(sys, 60),
          _buildDivider(),
          _buildRightTextCell(dia, 60),
          _buildDivider(),
          _buildRightTextCell(temp, 60),
          _buildDivider(),
          _buildRightTextCell(spo2, 60),
          _buildDivider(),
          _buildRightTextCell(hr, 60),
          _buildDivider(),
          _buildRightTextCell(bmi, 60),
        ],
      ),
    );
  }

  Widget _buildChartTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SharedComponents.buildFormLabel("From Date"),
                  const SizedBox(height: 8),
                  _buildDatePickerField("08-10-25"),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SharedComponents.buildFormLabel("To Date"),
                  const SizedBox(height: 8),
                  _buildDatePickerField("18-10-25"),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF117A7A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: const Text(
              "Get Chart",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),

        _buildStaticChartSection(
          yLabels: ["140", "139", "120", "110", "100", "90"],
          xLabels: ["18.50.08.998", "18.51.00.000"],
          legend: "BP - SYTOLIC",
        ),
        const SizedBox(height: 40),
        _buildStaticChartSection(
          yLabels: ["110", "100", "90", "80", "70", "60"],
          xLabels: ["18.50.59.999", "18.51.00.000"],
          legend: "BP - DIASTOLIC",
        ),
        const SizedBox(height: 40),
        _buildStaticChartSection(
          yLabels: ["99.25", "99", "98.75", "98.50", "98.25", "98"],
          xLabels: ["18.50.59.999", "18.51.00.000"],
          legend: "Temperature",
        ),
        const SizedBox(height: 40),
        _buildStaticChartSection(
          yLabels: ["16.5", "16.0", "15.5", "15.0", "14.5", "14.0"],
          xLabels: ["19.50.59.999", "19.51.00.000"],
          legend: "Respiratory Rate",
        ),
      ],
    );
  }

  Widget _buildDatePickerField(String date) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const Icon(Icons.calendar_month, size: 18, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _buildStaticChartSection({
    required List<String> yLabels,
    required List<String> xLabels,
    required String legend,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: yLabels
                  .map(
                    (label) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Text(
                        label,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: List.generate(
                  yLabels.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 26, top: 4),
                    child: Divider(height: 1, color: Colors.grey.shade300),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: xLabels
              .map(
                (label) => Text(
                  label,
                  style: const TextStyle(fontSize: 10, color: Colors.black87),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "-- MIN -- MAX -- ",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            Text(
              legend,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ],
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
        fontSize: 11,
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
      style: const TextStyle(fontSize: 12, color: Colors.black87),
    ),
  );
  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);
}
