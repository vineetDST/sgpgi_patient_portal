import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

class IPPrevVitalSignsScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const IPPrevVitalSignsScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<IPPrevVitalSignsScreen> createState() => _PrevVitalSignsScreenState();
}

class _PrevVitalSignsScreenState extends State<IPPrevVitalSignsScreen> {
  int _currentTabIndex = 0; // 0 for Previous, 1 for Chart

  // --- FUNCTIONAL STATE VARIABLES ---
  String? _groupName = 'General Vital Signs';
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now().add(const Duration(days: 2));

  @override
  Widget build(BuildContext context) {

    return IpBaseScaffold(
      title: _currentTabIndex == 0 ? "Vital Signs" : "Vital SIgns Chart",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom Tabs
          _buildCustomTabs(),
          const SizedBox(height: 16),

          // Switch Content based on Tab
          _currentTabIndex == 0 ? _buildPreviousTab() : _buildChartTab(),

          const SizedBox(height: 32),

          // Show action buttons only on Previous Tab based on mockup
          if (_currentTabIndex == 0)
            SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- TABS ---
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

  // --- TAB 1: PREVIOUS VITAL SIGNS ---
  Widget _buildPreviousTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedComponents.buildFormLabel("Group Name"),
        const SizedBox(height: 8),


        FunctionalDropdown(
          value: _groupName,
          hint: "--Select--",
          items: [
            "--Select--",
            "General Vital Signs",
            "Cardio Vital Signs",
            "Neuro Vital Signs",
          ],
          onChanged: (val) => setState(() => _groupName = val),
        ),
        const SizedBox(height: 16),

        // --- UPDATED: Fixed Left, Scrollable Right Table ---
        _buildFixedLeftTable(),
      ],
    );
  }

  Widget _buildFixedLeftTable() {
    const double rowHeight =
        48.0; // Fixed row height to ensure perfect horizontal alignment

    // Left Column Header Cell Builder
    Widget leftCell(String label, {bool isLast = false}) {
      return Container(
        height: rowHeight,
        width: 140,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF9F9), // Light cyan background
          border: Border(
            right: BorderSide(color: Colors.grey.shade300),
            bottom: isLast
                ? BorderSide.none
                : BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: Colors.black87,
          ),
        ),
      );
    }

    // Right Column Data Cell Builder
    Widget dataCell(String text, {bool isHeader = false, bool isLast = false}) {
      Widget content;
      if (isHeader) {
        // Red and Teal split logic for the date/time header
        final parts = text.split(' → ');
        if (parts.length == 2) {
          content = RichText(
            text: TextSpan(
              text: parts[0],
              style: const TextStyle(
                color: Colors.red,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
              children: [
                const TextSpan(
                  text: ' → ',
                  style: TextStyle(color: Colors.black54),
                ),
                TextSpan(
                  text: parts[1],
                  style: const TextStyle(color: Color(0xFF117A7A)),
                ),
              ],
            ),
          );
        } else {
          content = Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          );
        }
      } else {
        content = Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        );
      }

      return Container(
        height: rowHeight,
        width: 160,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(color: Colors.grey.shade300),
            bottom: isLast
                ? BorderSide.none
                : BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: content,
      );
    }

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
            // FIXED LEFT COLUMN
            Column(
              children: [
                leftCell("Date → Time"),
                leftCell("HEIGHT"),
                leftCell("WEIGHT"),
                leftCell("SYSTOLIC BP"),
                leftCell("DIASTOLIC BP"),
                leftCell("TEMP"),
                leftCell("SPO2"),
                leftCell("HEART RATE"),
                leftCell("BMI", isLast: true),
              ],
            ),
            // SCROLLABLE RIGHT COLUMNS
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Data Column 1
                    Column(
                      children: [
                        dataCell("08-10-2025 → 17:20", isHeader: true),
                        dataCell(""),
                        dataCell(""),
                        dataCell("90"),
                        dataCell("70"),
                        dataCell("98"),
                        dataCell(""),
                        dataCell(""),
                        dataCell("14", isLast: true),
                      ],
                    ),
                    // Data Column 2
                    Column(
                      children: [
                        dataCell("09-10-2025 → 10:00", isHeader: true),
                        dataCell(""),
                        dataCell(""),
                        dataCell("95"),
                        dataCell("75"),
                        dataCell("98.5"),
                        dataCell(""),
                        dataCell(""),
                        dataCell("14.5", isLast: true),
                      ],
                    ),
                    // Adding an empty third column to easily show horizontal scrolling effect
                    Column(
                      children: [
                        dataCell("10-10-2025 → 09:30", isHeader: true),
                        dataCell(""),
                        dataCell(""),
                        dataCell("92"),
                        dataCell("72"),
                        dataCell("98.1"),
                        dataCell(""),
                        dataCell(""),
                        dataCell("14.2", isLast: true),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- TAB 2: VITAL SIGN CHART ---
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
                  // FUNCTIONAL DATE PICKER
                  _buildDatePickerField(
                    _fromDate,
                    (newDate) => setState(() => _fromDate = newDate),
                  ),
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
                  // FUNCTIONAL DATE PICKER
                  _buildDatePickerField(
                    _toDate,
                    (newDate) => setState(() => _toDate = newDate),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Get Chart Button
        Center(
          child: ElevatedButton(
            onPressed: () => setState(() {
                _currentTabIndex = 0;
            }),
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

        // Custom Static Chart Implementations to match UI
        _buildStaticChartSection(
          yLabels: ["140", "130", "120", "110", "100", "90"],
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
          xLabels: ["18.50.59.999", "18.51.00.000"],
          legend: "Respiratory Rate",
        ),
      ],
    );
  }

  // --- FUNCTIONAL WIDGETS ---


  Widget _buildDatePickerField(
    DateTime currentDate,
    ValueChanged<DateTime> onDateSelected,
  ) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await CustomCalendarDialog.show(
          context,
          initialDate: currentDate,
        );
        if (pickedDate != null) onDateSelected(pickedDate);
      },
      child: Container(
        height: 48,
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
              DateFormat(
                'dd-MM-yy',
              ).format(currentDate), // Format the real DateTime object
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const Icon(Icons.calendar_month, size: 20, color: Colors.black87),
          ],
        ),
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
}
