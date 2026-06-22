import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

class FluidBalanceChartScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const FluidBalanceChartScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<FluidBalanceChartScreen> createState() =>
      _FluidBalanceChartScreenState();
}

class _FluidBalanceChartScreenState extends State<FluidBalanceChartScreen> {
  // --- STATE VARIABLES ---
  DateTime? _recordDate = DateTime(2025, 10, 10);

  // Intake Fields
  final TextEditingController _timeCtrl = TextEditingController(
    text: "01:12 PM",
  );
  final TextEditingController _fluidCtrl = TextEditingController();
  String? _route;
  final TextEditingController _volumeCtrl = TextEditingController(text: "2");

  // Summary Search Dates
  DateTime? _fromDate = DateTime(2025, 10, 8);
  DateTime? _toDate = DateTime(2025, 10, 18);

  @override
  void dispose() {
    _timeCtrl.dispose();
    _fluidCtrl.dispose();
    _volumeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Fluid Balance Chart",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fluid Balance Chart",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // 1. Intake Output Record Date
          _buildLabel("Intake Output Record"),
          const SizedBox(height: 8),
          _buildDatePickerField(
            date: _recordDate,
            onDateSelected: (d) => setState(() => _recordDate = d),
          ),
          const SizedBox(height: 16),

          // 2. Intake Section (Expandable)
          _buildIntakeSection(),
          const SizedBox(height: 16),

          // 3. Output Section (Expandable)
          _buildOutputSection(),
          const SizedBox(height: 24),

          // 4. Summary Table
          Text(
            "Summary",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildSummaryTable(),
          const SizedBox(height: 24),

          // 5. Date Range Search
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("From Date"),
                    const SizedBox(height: 8),
                    _buildDatePickerField(
                      date: _fromDate,
                      onDateSelected: (d) => setState(() => _fromDate = d),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("To Date"),
                    const SizedBox(height: 8),
                    _buildDatePickerField(
                      date: _toDate,
                      onDateSelected: (d) => setState(() => _toDate = d),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Search Button
          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Search",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // 6. Details Section
          Text(
            "Details",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailsTable(),
          const SizedBox(height: 32),

          // Action Buttons
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Save Fluid Balance",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                side: BorderSide(color: Colors.grey.shade400),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 0),
        ],
      ),
    );
  }

  // =========================================================================
  // SECTIONS & COMPONENTS
  // =========================================================================

  Widget _buildIntakeSection() {
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
          title: Row(
            children: [
              const Text(
                "Intake",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const Spacer(),
              const Icon(Icons.add_circle, color: Color(0xFF4CAF50), size: 22),
              const SizedBox(
                width: 8,
              ), // Spacing before the standard dropdown arrow
            ],
          ),
          iconColor: Colors.black87,
          collapsedIconColor: Colors.black87,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Time (HH:MM AM/PM)"),
                            const SizedBox(height: 8),
                            _buildTextField(controller: _timeCtrl),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabelWithStar("Fluid"),
                            const SizedBox(height: 8),
                            _buildTextField(controller: _fluidCtrl),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Route"),
                            const SizedBox(height: 8),
                            _buildFunctionalDropdown(
                              value: _route,
                              hint: "--Select--",
                              items: [
                                "Intra Arterial",
                                "IntraBursal",
                                "Intramuscular",
                                "Intraveneous",
                                "Oral",
                              ],
                              onChanged: (val) => setState(() => _route = val),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Volume (ml)"),
                            const SizedBox(height: 8),
                            _buildTextField(controller: _volumeCtrl),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutputSection() {
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
          title: Row(
            children: [
              const Text(
                "Output",
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const Spacer(),
              const Icon(Icons.add_circle, color: Color(0xFF4CAF50), size: 22),
              const SizedBox(
                width: 8,
              ), // Spacing before the standard dropdown arrow
            ],
          ),
          iconColor: Colors.black87,
          collapsedIconColor: Colors.black87,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Time (HH:MM AM/PM)"),
                            const SizedBox(height: 8),
                            _buildTextField(controller: _timeCtrl),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabelWithStar("Fluid"),
                            const SizedBox(height: 8),
                            _buildTextField(controller: _fluidCtrl),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Route"),
                            const SizedBox(height: 8),
                            _buildFunctionalDropdown(
                              value: _route,
                              hint: "--Select--",
                              items: ["Urinal Tract"],
                              onChanged: (val) => setState(() => _route = val),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Volume (ml)"),
                            const SizedBox(height: 8),
                            _buildTextField(controller: _volumeCtrl),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryTable() {
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
            // Fixed Left Column
            Container(
              width: 130,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF9F9),
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  _buildMatrixCell("Summary", isHeader: true),
                  _buildDivider(),
                  _buildMatrixCell("Intake (ml)", isHeader: true),
                  _buildDivider(),
                  _buildMatrixCell("Output (ml)", isHeader: true),
                  _buildDivider(),
                  _buildMatrixCell("Balance (ml)", isHeader: true),
                ],
              ),
            ),
            // Horizontally Scrollable Data Columns
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildSummaryDataColumn(
                      "8 AM - 8 PM",
                      "20.0",
                      "20.0",
                      "10.00",
                    ),
                    _buildSummaryDataColumn(
                      "8 PM - 8 AM",
                      "15.0",
                      "10.0",
                      "5.00",
                    ),
                    _buildSummaryDataColumn("Total", "35.0", "30.0", "15.00"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryDataColumn(
    String header,
    String intake,
    String output,
    String balance,
  ) {
    return Container(
      width: 130,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          _buildMatrixCell(header),
          _buildDivider(),
          _buildMatrixCell(intake),
          _buildDivider(),
          _buildMatrixCell(output),
          _buildDivider(),
          _buildMatrixCell(balance),
        ],
      ),
    );
  }

  Widget _buildDetailsTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            _buildDetailsRow("Intake (ml)", "20.0"),
            _buildDivider(),
            _buildDetailsRow("Output (ml)", "20.0"),
            _buildDivider(),
            _buildDetailsRow("Balance (ml)", "10.00"),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsRow(String label, String value) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: const Color(0xFFEAF9F9),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          Container(width: 1, color: Colors.grey.shade300),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- COMMON WIDGETS ---

  Widget _buildMatrixCell(String text, {bool isHeader = false}) {
    return Container(
      height: 54,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 13, color: Colors.black87),
    );
  }

  Widget _buildLabelWithStar(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
        children: const [
          TextSpan(
            text: "*",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _buildDatePickerField({
    required DateTime? date,
    required Function(DateTime) onDateSelected,
  }) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await CustomCalendarDialog.show(
          context,
          initialDate: date ?? DateTime.now(),
        );
        if (pickedDate != null) onDateSelected(pickedDate);
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null ? DateFormat('dd-MM-yy').format(date) : "",
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const Icon(Icons.calendar_month, size: 20, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionalDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            onSelected: onChanged,
            offset: const Offset(0, 48),
            color: Colors.white,
            elevation: 0,
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? hint,
                      style: TextStyle(
                        color: value == null || value.isEmpty
                            ? Colors.grey.shade400
                            : Colors.black87,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
            itemBuilder: (context) => items
                .map(
                  (item) => PopupMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
