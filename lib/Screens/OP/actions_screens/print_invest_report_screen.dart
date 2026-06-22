import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

class PrintInvestReportScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const PrintInvestReportScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<PrintInvestReportScreen> createState() =>
      _PrintInvestReportScreenState();
}

class _PrintInvestReportScreenState extends State<PrintInvestReportScreen> {
  // --- FUNCTIONAL STATE VARIABLES ---
  int? _selectedPrintTestIndex; // Tracks which test column is selected to print

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Print Invest Report",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Print Invest Report',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Print Invest Report",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: _showFilterSidebar,
                child: const Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // --- UPDATED: Requisition Details Expandable Matrix ---
          _buildRequisitionDetailsTile(),
          const SizedBox(height: 16),

          // --- Test Details Expandable Matrix ---
          _buildTestDetailsTile(),
          const SizedBox(height: 32),

          // Custom Print/Cancel Buttons
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Print",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.white,
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

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // =========================================================================
  // FILTER SIDEBAR
  // =========================================================================
  void _showFilterSidebar() {
    DateTime reqDateFrom = DateTime.now();
    DateTime reqDateTo = DateTime.now().add(const Duration(days: 10));
    String? selectedDepartment = "All Department";
    String? selectedServiceCenter = "All";

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Filter",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: double.infinity,
              color: Colors.white,
              child: SafeArea(
                child: StatefulBuilder(
                  builder: (context, setSidebarState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Search",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Req Date From",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          _buildSidebarDatePicker(
                                            reqDateFrom,
                                            (date) => setSidebarState(
                                              () => reqDateFrom = date,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Req Date To",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          _buildSidebarDatePicker(
                                            reqDateTo,
                                            (date) => setSidebarState(
                                              () => reqDateTo = date,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  "Request Department",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildSidebarDropdown(
                                  value: selectedDepartment,
                                  items: [
                                    "All Department",
                                    "Cardiology",
                                    "Neurology",
                                    "Pathology",
                                  ],
                                  onChanged: (val) => setSidebarState(
                                    () => selectedDepartment = val,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const Text(
                                  "Service Center",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                _buildSidebarDropdown(
                                  value: selectedServiceCenter,
                                  items: [
                                    "All",
                                    "Clinical Chemistry",
                                    "24 Hr Lab EMRTC",
                                  ],
                                  onChanged: (val) => setSidebarState(
                                    () => selectedServiceCenter = val,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                          side: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: const Text(
                                          "Clear",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF117A7A,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Search",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  Widget _buildSidebarDatePicker(
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
              DateFormat('dd-MM-yy').format(currentDate),
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const Icon(Icons.calendar_month, size: 20, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarDropdown({
    required String? value,
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
            offset: const Offset(0, 48), // Drops down exactly below the field
            color: Colors.white,
            elevation: 0, // Flat look
            constraints: BoxConstraints(
              minWidth: constraints
                  .maxWidth, // Matches the exact width of the container
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5,
              ), // THE OUTLINE BORDER
            ),
            // The visible button part
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? items.first,
                      style: TextStyle(
                        color: value == null
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
            // The dropdown menu items
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

  // =========================================================================
  // REQUISITION DETAILS MATRIX (requisition details.png)
  // =========================================================================
  Widget _buildRequisitionDetailsTile() {
    final List<Map<String, String>> reqData = [
      {
        "reqNo": "ORDER202500082",
        "reqDate": "24-10-2025 | 10:33",
        "center": "24 Hr Clinical Chemistry EMRTC",
        "dept": "24 Hr Lab EMRTC",
        "requestedBy": "Admin",
      },
      {
        "reqNo": "ORDER202500014",
        "reqDate": "24-10-2025 | 10:33",
        "center": "Clinical Chemistry",
        "dept": "Pathology",
        "requestedBy": "Aniket Anand",
      },
      {
        "reqNo": "ORDER202500036",
        "reqDate": "24-10-2025 | 10:33",
        "center": "Clinical Chemistry",
        "dept": "Pathology",
        "requestedBy": "Aniket Anand",
      },
      {
        "reqNo": "ORDER202500123",
        "reqDate": "24-10-2025 | 10:33",
        "center": "24 Hr Clinical Chemistry EMRTC",
        "dept": "Pathology",
        "requestedBy": "Aniket Anand",
      },
    ];

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
            "Requisition Details",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              // decoration: BoxDecoration(
              //   border: Border(top: BorderSide(color: Colors.grey.shade300)),
              // ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed Left Column (Headers)
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF9F9),
                      border: Border(
                        right: BorderSide(color: Colors.grey.shade300),
                      ),

                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        )
                    ),
                    child: Column(
                      children: [
                        _buildMatrixCell("Req. No.", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Req. Date", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Service Center", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Service\nDepartment", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell(
                          "Requested By",
                          isHeader: true,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  // Horizontally Scrollable Data Columns
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: reqData.asMap().entries.map((entry) {
                          int idx = entry.key;
                          var req = entry.value;
                          bool isLastCol = idx == reqData.length - 1;

                          return Container(
                            width: 220,
                            decoration: BoxDecoration(
                              border: Border(
                                right: isLastCol
                                    ? BorderSide.none
                                    : BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildMatrixCell(
                                  req["reqNo"]!,
                                  textColor: const Color(0xFF117A7A),
                                ),
                                _buildDivider(),
                                _buildMatrixCell(req["reqDate"]!),
                                _buildDivider(),
                                _buildMatrixCell(req["center"]!),
                                _buildDivider(),
                                _buildMatrixCell(req["dept"]!),
                                _buildDivider(),
                                _buildMatrixCell(
                                  req["requestedBy"]!,
                                  isLast: true,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // TEST DETAILS MATRIX (test details.png)
  // =========================================================================
  Widget _buildTestDetailsTile() {
    final List<Map<String, String>> testsData = [
      {
        "name": "Serum Iron Studies",
        "center": "Clinical Chemistry",
        "testDate": "24-10-2025 | 10:33",
        "colDate": "24-10-2025 | 10:37",
        "testOn": "Blood-Plain",
        "specimen": "Blood-Plain",
        "status": "Report Validated",
        "labId": "EMRTC_L150424102500001",
      },
      {
        "name": "1. S. Glucose(M-God-POD)",
        "center": "24 Hr Coagulation EMRTC",
        "testDate": "24-10-2025 | 10:33",
        "colDate": "24-10-2025 | 10:37",
        "testOn": "Blood-Citrate",
        "specimen": "Blood-Citrate",
        "status": "Report Validated",
        "labId": "EMRTC_L1504241025000654",
      },
      {
        "name": "03. TLC",
        "center": "Clinical Chemistry",
        "testDate": "24-10-2025 | 10:33",
        "colDate": "24-10-2025 | 10:37",
        "testOn": "Blood-EDTA",
        "specimen": "Blood-EDTA",
        "status": "Report Validated",
        "labId": "EMRTC_L1504241025000789",
      },
      {
        "name": "01. HGB",
        "center": "24 Hr Hematology EMRTC",
        "testDate": "24-10-2025 | 10:33",
        "colDate": "24-10-2025 | 10:37",
        "testOn": "Blood-EDTA",
        "specimen": "Blood-EDTA",
        "status": "Report Validated",
        "labId": "EMRTC_L1504241025000145",
      },
    ];

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
            "Requisition Details",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fixed Left Column (Headers)
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF9F9),
                      border: Border(
                        right: BorderSide(color: Colors.grey.shade300),
                      ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          topLeft: Radius.circular(8),
                        )
                    ),
                    child: Column(
                      children: [
                        _buildMatrixCell("Test Name", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Service Center", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Test Date", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Collected Date", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Test On", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Specimen", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Test Status", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Lab ID", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Print", isHeader: true, isLast: true),
                      ],
                    ),
                  ),
                  // Horizontally Scrollable Data Columns
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: testsData.asMap().entries.map((entry) {
                          int idx = entry.key;
                          var test = entry.value;
                          bool isLastCol = idx == testsData.length - 1;

                          return Container(
                            width: 220,
                            decoration: BoxDecoration(
                              border: Border(
                                right: isLastCol
                                    ? BorderSide.none
                                    : BorderSide(color: Colors.grey.shade300),
                              ),
                            ),
                            child: Column(
                              children: [
                                _buildMatrixCell(test["name"]!),
                                _buildDivider(),
                                _buildMatrixCell(test["center"]!),
                                _buildDivider(),
                                _buildMatrixCell(test["testDate"]!),
                                _buildDivider(),
                                _buildMatrixCell(test["colDate"]!),
                                _buildDivider(),
                                _buildMatrixCell(test["testOn"]!),
                                _buildDivider(),
                                _buildMatrixCell(test["specimen"]!),
                                _buildDivider(),
                                _buildMatrixCell(test["status"]!),
                                _buildDivider(),
                                _buildMatrixCell(test["labId"]!),
                                _buildDivider(),
                                _buildMatrixRadioCell(idx, isLast: true),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // SHARED MATRIX BUILDERS
  // =========================================================================
  Widget _buildMatrixCell(
    String text, {
    bool isHeader = false,
    bool isLast = false,
    Color? textColor,
  }) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
          color: textColor ?? Colors.black87,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildMatrixRadioCell(int index, {bool isLast = false}) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Radio<int>(
        value: index,
        groupValue: _selectedPrintTestIndex,
        activeColor: const Color(0xFF117A7A),
        onChanged: (val) => setState(() => _selectedPrintTestIndex = val),
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);
}
