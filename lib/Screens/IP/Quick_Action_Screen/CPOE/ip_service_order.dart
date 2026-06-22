import 'package:flutter/material.dart';

import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Modals/save_order_set_modal.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';

import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_prev_service_order.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/cpoes/prev_investigation_screen.dart';

// --- ADDED IMPORT FOR ACTION BOTTOM SHEET ---
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';

class IPServiceOrder extends StatefulWidget {
  final String patientName;
  final String crn;
  const IPServiceOrder({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<IPServiceOrder> createState() => _InvestigationScreenState();
}

class _InvestigationScreenState extends State<IPServiceOrder> {
  // Main Screen States
  String? _department = null;
  String? _serviceCenter = null;
  String? _consultingDoctor = null;

  final TextEditingController _serviceSearchCtrl = TextEditingController();
  Map<String, bool> selectedServices = {};

  // State for Inline Service Dropdown
  bool _isServiceDropdownOpen = false;

  // Table Data States (Mocked for 2 columns to show scrollability)
  List<Map<String, String>> tableData = [
    {
      "name": "0.1. S. Glucose (F)",
      "tariff": "85.00",
      "status": "Ordered",
      "priority": "Elective",
      "center": "Clinical Chemistry",
      "testOn": "Blood - Plain",
      "remarks": "Remarks",
    },
    {
      "name": "0.1. S. Glucose (F)",
      "tariff": "85.00",
      "status": "Ordered",
      "priority": "Elective",
      "center": "Clinical Chemistry",
      "testOn": "Blood - Plain",
      "remarks": "Remarks",
    },
  ];

  @override
  void dispose() {
    _serviceSearchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Service Order",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SharedComponents.buildFormLabel("Consulting Doctor"),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: _consultingDoctor,
            hint: "--Select--",
            items: ["--Select--", "Doctor 1", "Doctor 2"],
            onChanged: (v) => setState(() => _serviceCenter = v),
          ),
          const SizedBox(height: 24),
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Service Order",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  // --- UPDATED: Uses Navigator.push to keep this screen in the stack ---
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IPPrevServiceOrder(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Prev",
                      style: TextStyle(
                        color: Color(0xFF117A7A),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("|", style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => _showMiModal(context), // Opens MI Modal
                    child: const Text(
                      "MI",
                      style: TextStyle(
                        color: Color(0xFF117A7A),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("|", style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 8),
                  const Text(
                    "All",
                    style: TextStyle(
                      color: Color(0xFF117A7A),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Form Inputs
          SharedComponents.buildFormLabel("Department"),
          const SizedBox(height: 8),

          FunctionalDropdown(
            value: _department,
            hint: "--Select--",
            items: ["--Select--", "Endocrinology", "Cardiology"],
            onChanged: (v) => setState(() => _department = v),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Service Center"),
          const SizedBox(height: 8),

          FunctionalDropdown(
            value: _serviceCenter,
            hint: "--Select--",
            items: ["--Select--", "Clinical Chemistry", "Radiology"],
            onChanged: (v) => setState(() => _serviceCenter = v),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Service Name"),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: _serviceSearchCtrl,
              decoration: const InputDecoration(
                hintText: "Search..",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                suffixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Inline Expandable Service Name
          GestureDetector(
            onTap: () => setState(
              () => _isServiceDropdownOpen = !_isServiceDropdownOpen,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: _isServiceDropdownOpen
                    ? const BorderRadius.vertical(top: Radius.circular(8))
                    : BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Service Name",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    _isServiceDropdownOpen
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),
          if (_isServiceDropdownOpen) _buildInlineServiceDropdown(),

          const SizedBox(height: 16),

          // Add Service Button
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
              ),
              child: const Text(
                "Add Service",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Flipped Matrix Table
          _buildFlippedTable(),
          const SizedBox(height: 16),

          // Amount
          _buildTotalCostTable(),
          const SizedBox(height: 16),
          // Bottom Buttons

          AppSaveButton(text: 'Save Order',),
          const SizedBox(height: 16),
          _buildFullWidthButton(
            "Save as Order Set",
            isPrimary: false,
            onTap: () => _showSaveOrderSetModal(context),
          ),
          const SizedBox(height: 16),
          _buildFullWidthButton(
            "Investigation Order Printing",
            isPrimary: false,
            onTap: () {},
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTotalCostTable() {
    const double rowHeight = 64.0;

    return DetailTableWrapper(
      children: [
        DetailRow(
          label: "Current Order Amount",
          customWidget: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "170.00",
                  style: TextStyle(
                    color: Color(0xFF117A7A), // 🔵 Blue
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        DetailRow(
          label: "Balance Amount",
          customWidget: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "175.00",
                  style: TextStyle(
                    color: Color(0xFFFF0606), // 🔵 Blue
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        DetailRow(
          label: "Blocked Amount",
          customWidget: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "0.00",
                  style: TextStyle(
                    color: Color(0xFF117A7A), // 🔵 Blue
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        DetailRow(
          isLast: true,
          label: "Pending Amount",
          customWidget: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "170.00",
                  style: TextStyle(
                    color: Color(0xFF107500), // 🔵 Blue
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  // =========================================================================
  // UI WIDGET BUILDERS
  // =========================================================================

  Widget _buildInlineServiceDropdown() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 10, bottom: 10,right: 10),
      // margin: const EdgeInsets.only(top: 10.0, left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(color: Colors.grey.shade300),
          right: BorderSide(color: Colors.grey.shade300),
          bottom: BorderSide(color: Colors.grey.shade300),

        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Colors.grey.shade300),
            left: BorderSide(color: Colors.grey.shade300),
            right: BorderSide(color: Colors.grey.shade300),
            bottom: BorderSide(color: Colors.grey.shade300),
          ),
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(8),
            top: Radius.circular(8),
          ),
        ),

        // --- UPDATED: The entire column (header + checkboxes) is now horizontally scrollable together ---
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: const Color(0xFFEAF9F9),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    child: const Text(
                      "Service Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
                  _buildServiceCheckRow(
                    "0.1. S. Glucose",
                    "55.0",
                    "0.9. S. Sodium",
                    "55.0",
                    true,
                    false,
                  ),
                  _buildServiceCheckRow(
                    "0.2. S. Glucose, PP, 2 Hours",
                    "55.0",
                    "10. S. Potassium",
                    "55.0",
                    false,
                    false,
                  ),
                  _buildServiceCheckRow(
                    "0.3. S. Glucose (R)",
                    "55.0",
                    "11. S. Proteins, Total",
                    "55.0",
                    false,
                    false,
                  ),
                  _buildServiceCheckRow(
                    "0.4. S. Glucose, PP, 2 Hour",
                    "55.0",
                    "12. S Albumin",
                    "55.0",
                    false,
                    false,
                  ),
                  _buildServiceCheckRow(
                    "0.5. S. Creatinine",
                    "85.0",
                    "13. S. Bilirubin, Total",
                    "85.0",
                    true,
                    false,
                  ),
                  _buildServiceCheckRow(
                    "0.6. S. BUN",
                    "55.0",
                    "14. S. Bilirubin, Conjugated",
                    "55.0",
                    false,
                    false,
                  ),
                  _buildServiceCheckRow(
                    "0.7. S. Urea",
                    "30.0",
                    "15. S. AST(SGOT)",
                    "30.0",
                    false,
                    false,
                  ),
                  _buildServiceCheckRow(
                    "0.8. S. Uric Acid",
                    "55.0",
                    "16. S. ALT (SGPT)",
                    "55.0",
                    false,
                    false,
                    isLast: true
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildServiceCheckRow(
    String name1,
    String price1,
    String name2,
    String price2,
    bool isChecked1,
    bool isChecked2,
  {
    bool isLast = false,
  }
  ) {
    selectedServices.putIfAbsent(name1, () => isChecked1);
    selectedServices.putIfAbsent(name2, () => isChecked2);

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 350,
            padding: const EdgeInsets.only(left: 16, top: 8,bottom: 8,right: 40),
            child: Row(
              children: [
                Checkbox(
                  value: selectedServices[name1],
                  activeColor: const Color(0xFF117A7A),
                  onChanged: (v) {
                    setState(() {
                      selectedServices[name1] = v ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    name1,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
                Text(
                  price1,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),

          Container(width: 1, height: 70, color: Colors.grey.shade300),

          Container(
            width: 350,
            padding: const EdgeInsets.only(left: 16, top: 8,bottom: 8,right: 40),
            child: Row(
              children: [
                Checkbox(
                  value: selectedServices[name2],
                  activeColor: const Color(0xFF117A7A),
                  onChanged: (v) {
                    setState(() {
                      selectedServices[name2] = v ?? false;
                    });
                  },
                ),
                Expanded(
                  child: Text(
                    name2,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
                Text(
                  price2,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildFullWidthButton(
    String text, {
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? const Color(0xFF117A7A) : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: isPrimary ? Colors.transparent : Colors.grey.shade300,
            ),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isPrimary ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFlippedTable() {
    const double rowHeight = 60.0;
    Widget leftCell(String label, {bool isLast = false}) => Container(
      height: rowHeight,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(0xFFEAF9F9),
        border: Border(bottom: isLast ? BorderSide.none : BorderSide(color: Colors.grey.shade300),),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Colors.black87,
        ),
      ),
    );

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
              width: 130,
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  leftCell("Service Name"),
                  leftCell("Tariff"),
                  leftCell("Status"),
                  leftCell("Priority"),
                  leftCell("Service Center"),
                  leftCell("Test On"),
                  leftCell("Order Remarks"),
                  leftCell("Action",isLast: true),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: tableData
                      .map(
                        (data) => SizedBox(
                          width: 200,
                          child: Column(
                            children: [
                              _dataCell(
                                Text(
                                  data['name']!,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              _dataCell(
                                Text(
                                  data['tariff']!,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                              _dataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    data['status']!,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              _dataCell(
                                _buildInnerDropdown(data['priority']!, [
                                  "Elective",
                                  "Emergency",
                                  "Immediate",
                                ]),
                              ),
                              _dataCell(
                                _buildInnerDropdown(data['center']!, [
                                  "Clinical Chemistry",
                                  "Radiology",
                                ]),
                              ),
                              _dataCell(_buildInnerTextField(data['testOn']!)),
                              _dataCell(

                                CustomRemarksField(hintText: 'Remarks',)
                              ),
                              _dataCell(
                                  isLast: true,
                                  removePadding: true,
                                  NoPaddingCell(child: AppDeleteIcon())
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dataCell(Widget child, {bool alignCenter = false,bool isLast = false,bool removePadding = false}) {
    return Container(
      height: 60,
      padding:  EdgeInsets.symmetric(horizontal: removePadding ? 0 : 12),
      alignment: alignCenter ? Alignment.center : Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom:isLast ? BorderSide.none : BorderSide(color: Colors.grey.shade300),
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: child,
    );
  }

  Widget _buildInnerTextField(String value) {
    return Container(
      height: 38,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: TextEditingController(text: value),
        style: const TextStyle(fontSize: 11, color: Colors.black87),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildInnerDropdown(String value, List<String> items) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 38,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            onSelected: (v) {},
            offset: const Offset(0, 38),
            color: Colors.white,
            elevation: 0,
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 11,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 16,
                    color: Colors.grey,
                  ),
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
                        fontSize: 11,
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
  // MODALS & SIDEBARS
  // =========================================================================

  void _showMiModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Mandatory Information",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "0.4. S. Glucose, PP, 2 Hour",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildMiInput(
                        "Glomerulonephritis especially rapidly progressive Glomerulonephritis",
                      ),
                      _buildMiInput(
                        "Cultaneous vasculities with systemic Features",
                      ),
                      _buildMiInput("Multiple lung nodules"),
                      _buildMiInput(
                        "Chronic destructive disease of the upper airways",
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "0.8. S. Uric Acid",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildMiInput("Long-standing sinusitis or otitis"),
                      _buildMiInput("Subglottic tracheal stemoses"),
                      _buildMiInput(
                        "Mononeurifies multiplex or peripheral neuropathy",
                      ),
                      _buildMiInput("Retro-orbital mass"),
                      _buildMiInput("Scleritis"),
                      _buildMiInput("Others, please specify"),
                      _buildMiInput(
                        "Plumonary haemorrhage especially ilumonary renal syndrome",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiInput(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Container(
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _showDeleteModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 1.5),
                ),
                child: const Icon(Icons.close, color: Colors.red, size: 32),
              ),
              const SizedBox(height: 24),
              const Text(
                "Are you sure you want to\ndelete the record?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC60000),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  void _showSaveOrderSetModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          SaveOrderSetModal(onDeleteTap: () => _showDeleteModal(context)),
    );
  }


}
