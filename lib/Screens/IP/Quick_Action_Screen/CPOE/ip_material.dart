import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/Modals/save_order_set_modal.dart';

import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_prev_material.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/cpoes/prev_material_screen.dart';

class IPMaterialScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const IPMaterialScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<IPMaterialScreen> createState() => _MaterialScreenState();
}



class _MaterialScreenState extends State<IPMaterialScreen> {
  String? _store = "001_NEW OPD HRF PHARMACY STORE";
  final TextEditingController _materialNameCtrl = TextEditingController();

  final TextEditingController _qtyCtrl1 = TextEditingController(text: "1.0");
  final TextEditingController _qtyCtrl2 = TextEditingController(text: "1.0");

  @override
  void dispose() {
    _materialNameCtrl.dispose();
    _qtyCtrl1.dispose();
    _qtyCtrl2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Material",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Material",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IPPrevMaterialScreen(
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
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Store"),
          const SizedBox(height: 8),

          FunctionalDropdown(
            value: _store,
            hint: "--Select--",
            items: [
              "--Select--",
              "001_NEW OPD HRF PHARMACY STORE",
              "002_MAIN STORE",
            ],
            onChanged: (v) => setState(() => _store = v),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Material Name"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _materialNameCtrl,
            hintText: "Material Name",
          ),
          const SizedBox(height: 16),

          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IPPrevMaterialScreen(
                      patientName: widget.patientName,
                      crn: widget.crn,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Add Material",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          _buildSyncedTable(),
          const SizedBox(height: 24),

          _buildTotalCostTable(),
          const SizedBox(height: 24),

          _buildFullWidthButton("Save Order", isFilled: true, onTap: () {}),
          const SizedBox(height: 12),
          _buildFullWidthButton(
            "Save as Order Set",
            isFilled: false,
            onTap: () => _showSaveOrderSetModal(context),
          ),
          const SizedBox(height: 12),
          _buildFullWidthButton(
            "Investigation Order Printing",
            isFilled: false,
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

  // --- UPDATED: Uses PopupMenuButton ---
  Widget _buildDropdown(
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
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
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? "--Select--",
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

  Widget _buildFullWidthButton(
    String text, {
    required bool isFilled,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: isFilled
          ? ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.white,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
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
                  _buildLeftCell("Material Name", 60),
                  _buildDivider(),
                  _buildLeftCell("Qty", 60),
                  _buildDivider(),
                  _buildLeftCell("Unit Price", 60),
                  _buildDivider(),
                  _buildLeftCell("Store", 60),
                  _buildDivider(),
                  _buildLeftCell("Status", 60),
                  _buildDivider(),
                  _buildLeftCell("Effective From", 60),
                  _buildDivider(),
                  _buildLeftCell("Action", 60),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicWidth(
                  child: Row(
                    children: [
                      _buildItemColumn(
                        "SYRINGE INSULIN WITH\nNEEDLE 1001U",
                        _qtyCtrl1,
                        "6.8",
                        "Ordered",
                        "08-10-2025",
                      ),
                      // Container(width: 1, color: Colors.grey.shade300),
                      _buildItemColumn(
                        "SYRINGE INSULIN WITH\nNEEDLE 1001U",
                        _qtyCtrl2,
                        "6.8",
                        "Ordered",
                        "08-10-2025",
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

  Widget _buildItemColumn(
    String name,
    TextEditingController qtyCtrl,
    String price,
    String status,
    String date,
  ) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          _buildRightTextCell(name, 60),
          _buildDivider(),
          _buildRightQtyCell(qtyCtrl, 60),
          _buildDivider(),
          _buildRightTextCell(price, 60),
          _buildDivider(),
          _buildRightDropdownCell(60),
          _buildDivider(),
          _buildRightPillCell(status, 60),
          _buildDivider(),
          _buildRightTextCell(date, 60),
          _buildDivider(),
          _buildRightActionCell(60),
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
        fontSize: 12,
        color: Colors.black87,
      ),
    ),
  );

  Widget _buildRightTextCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(
      text,
      style: const TextStyle(fontSize: 12, color: Colors.black87),
    ),
  );

  Widget _buildRightPillCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
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

  Widget _buildRightActionCell(double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: [
        const Icon(Icons.print, color: Colors.black87, size: 20),
        AppDeleteIcon()
      ],
    ),
  );

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  Widget _buildRightQtyCell(TextEditingController ctrl, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              controller: ctrl,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              selectionControls: NoCursorHandleControls(),

              contextMenuBuilder: (_, __) => const SizedBox.shrink(),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 14),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text("Nos", style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  // --- UPDATED: Uses PopupMenuButton for Table Dropdown ---
  Widget _buildRightDropdownCell(double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: 38,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
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
                side: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "001_NEW OPD HRF PHARMA",
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black87,
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
              itemBuilder: (context) => ["001_NEW OPD HRF PHARMA", "MAIN STORE"]
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
