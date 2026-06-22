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

class PrintInvestRequisitionScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const PrintInvestRequisitionScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<PrintInvestRequisitionScreen> createState() =>
      _PrintInvestRequisitionScreenState();
}

class _PrintInvestRequisitionScreenState
    extends State<PrintInvestRequisitionScreen> {
  @override
  Widget build(BuildContext context) {
    return ClinicalBaseScaffold(
      title: "Print Invest Report Requisition",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Print Invest Report Requisition',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Print Invest Report Requisition",
                  style: AppTextStyles.RegH3.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

          // --- REQUISITION DETAILS MATRIX (Variant6.png) ---
          _buildRequisitionDetailsTile(),
          const SizedBox(height: 16),

          // --- TEST DETAILS MATRIX (Variant5.png) ---
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
  // REQUISITION DETAILS MATRIX (Variant6.png) - NON-SCROLLABLE
  // =========================================================================
  Widget _buildRequisitionDetailsTile() {
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
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
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
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
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
                  // Expanded Data Column (No Scrolling)
                  Expanded(
                    child: Column(
                      children: [
                        _buildMatrixCell(
                          "ORDER202500082",
                          textColor: const Color(0xFF117A7A),
                        ),
                        _buildDivider(),
                        _buildMatrixCell("24-10-2025 | 10:33"),
                        _buildDivider(),
                        _buildMatrixCell("Clinical Chemistry"),
                        _buildDivider(),
                        _buildMatrixCell("Pathology"),
                        _buildDivider(),
                        _buildMatrixCell("Admin", isLast: true),
                      ],
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
  // TEST DETAILS MATRIX (Variant5.png) - NON-SCROLLABLE
  // =========================================================================
  Widget _buildTestDetailsTile() {
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
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
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
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
                    ),
                    child: Column(
                      children: [
                        _buildMatrixCell("Test Name", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Test Date", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Test On", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Specimen", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Lab ID", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell("Test Status", isHeader: true),
                        _buildDivider(),
                        _buildMatrixCell(
                          "New Link",
                          isHeader: true,
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  // Expanded Data Column (No Scrolling)
                  Expanded(
                    child: Column(
                      children: [
                        _buildMatrixCell("Serum Iron Studies"),
                        _buildDivider(),
                        _buildMatrixCell("24-10-2025 | 10:33"),
                        _buildDivider(),
                        _buildMatrixCell("Blood-Plain"),
                        _buildDivider(),
                        _buildMatrixCell("Blood-Plain"),
                        _buildDivider(),
                        _buildMatrixCell("L1504241025000001"),
                        _buildDivider(),
                        _buildMatrixCell("Report Validated"),
                        _buildDivider(),
                        _buildPdfIconCell(isLast: true),
                      ],
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

  Widget _buildPdfIconCell({bool isLast = false}) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          // Handle PDF view action
        },
        child: Image.asset(
          'assets/pdf.png', // 👈 your image path
          height: 24,
          width: 24,
        ),
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);
}
