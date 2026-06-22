import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Modals/save_order_set_modal.dart';

import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Sidesheet/side_sheet_helper.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class IPOrderSetScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const IPOrderSetScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<IPOrderSetScreen> createState() => _OrderSetScreenState();
}

class _OrderSetScreenState extends State<IPOrderSetScreen> {
  final TextEditingController _srvRemarks1 = TextEditingController();
  final TextEditingController _srvRemarks2 = TextEditingController();

  bool _rxCheck1 = false;
  bool _rxCheck2 = false;
  Map<String, bool> testSelections = {};

  final TextEditingController _matQty1 = TextEditingController(text: "1.0");
  final TextEditingController _matQty2 = TextEditingController(text: "1.0");

  @override
  void dispose() {
    _srvRemarks1.dispose();
    _srvRemarks2.dispose();
    _matQty1.dispose();
    _matQty2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Order Set",
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
                "Order Set",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => _showFilterSidebar(context),
                child: const Icon(
                  Icons.filter_alt_outlined,
                  color: Colors.black87,
                  size: 26,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildExpandedTestTile(),
          const SizedBox(height: 12),
          _buildFormTile("Service", _buildTransposedServiceTable()),
          const SizedBox(height: 12),
          _buildFormTile("Drug", _buildTransposedDrugTable()),
          const SizedBox(height: 12),
          _buildFormTile("Material", _buildTransposedMaterialTable()),
          const SizedBox(height: 24),
          _buildFormTile("Total Cost", _buildTotalCostTable()),
          const SizedBox(height: 24),
          _buildFullWidthButton("Save Order", isFilled: true, onTap: () {}),
          const SizedBox(height: 12),
          _buildFullWidthButton(
            "Save as Order Set",
            isFilled: false,
            onTap: () => _showSaveOrderSetModal(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // =========================================================================
  // 1. SERVICE TABLE
  // =========================================================================
  Widget _buildTransposedServiceTable() {
    return Row(
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
              _buildLeftCell("Service Name", 60),
              _buildLeftCell("Tariff", 60),
              _buildLeftCell("Status", 60),
              _buildLeftCell("Priority", 60),
              _buildLeftCell("Service Center", 60),
              _buildLeftCell("Test On", 60),
              _buildLeftCell("Order Remarks", 60),
              _buildLeftCell("Action", 60, isLast: true),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildServiceColumn(
                  "0.1. S. Glucose (F)",
                  "85.00",
                  "Ordered",
                  "Elective",
                  "Clinical Chemistry",
                  "Blood - Plain",
                  _srvRemarks1,
                ),
                _buildServiceColumn(
                  "0.1. S. Glucose (F)",
                  "85.00",
                  "Ordered",
                  "Elective",
                  "Clinical Chemistry",
                  "Blood - Plain",
                  _srvRemarks2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceColumn(
    String name,
    String tariff,
    String status,
    String priority,
    String center,
    String testOn,
    TextEditingController remarksCtrl,
  ) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          _buildDataTextCell(name, 60),
          _buildDataTextCell(tariff, 60),
          _buildDataPillCell(status, Colors.blue.shade100, 60),
          _buildDataDropdownCell(priority, 60),
          _buildDataDropdownCell(center, 60),
          _buildDataDropdownCell(testOn, 60),
          _buildDataInputCell("Order Remarks", remarksCtrl, 60),
          _buildDataActionCell(isLast: true, height: 60),
        ],
      ),
    );
  }

  // =========================================================================
  // 2. DRUG TABLE
  // =========================================================================
  Widget _buildTransposedDrugTable() {
    return Row(
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
              _buildLeftCell("RX. No", 60),
              _buildLeftCell("Drug Name", 80),
              _buildLeftCell("Store", 80),
              _buildLeftCell("In Take", 60),
              _buildLeftCell("Total Qty", 60),
              _buildLeftCell("Ordered on", 60),
              _buildLeftCell("Status", 60),
              _buildLeftCell("Re - Order", 60),
              _buildLeftCell("Action", 60, isLast: true),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildDrugColumn(
                  "42612276",
                  _rxCheck1,
                  (v) => setState(() => _rxCheck1 = v!),
                  "Heparin Low Mol. 40mg Inj",
                  "(LMWX PF) Abbott",
                  "001_NEW OPD HRF PHARMACY STORE",
                  "1.0 Nos",
                  "1.0 Nos",
                  "08-10-2025",
                  "Ordered",
                  "Re-Order",
                ),
                _buildDrugColumn(
                  "42612276",
                  _rxCheck2,
                  (v) => setState(() => _rxCheck2 = v!),
                  "Paracetamol 500mg Tab",
                  "(Calpol 500)",
                  "001_NEW OPD HRF PHARMACY STORE",
                  "1.0 Nos",
                  "1.0 Nos",
                  "08-10-2025",
                  "Ordered",
                  "Re-Order",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDrugColumn(
    String rx,
    bool isChecked,
    Function(bool?) onCheck,
    String dName1,
    String dName2,
    String store,
    String intake,
    String tQty,
    String date,
    String status,
    String reorder,
  ) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          _buildDataCheckboxCell(rx, isChecked, onCheck, 60),
          _buildDataDrugNameCell(dName1, dName2, 80),
          _buildDataTextCell(store, 80),
          _buildDataTextCell(intake, 60),
          _buildDataTextCell(tQty, 60),
          _buildDataTextCell(date, 60),
          _buildDataPillCell(status, Colors.blue.shade100, 60),
          _buildDataActionText(reorder, 60),
          _buildDataPrintActionCell(isLast: true, height: 60),
        ],
      ),
    );
  }

  // =========================================================================
  // 3. MATERIAL TABLE
  // =========================================================================
  Widget _buildTransposedMaterialTable() {
    return Row(
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
              _buildLeftCell("Material Name", 80),
              _buildLeftCell("Qty", 60),
              _buildLeftCell("Unit Price", 60),
              _buildLeftCell("Store", 60),
              _buildLeftCell("Status", 60),
              _buildLeftCell("Effective From", 60),
              _buildLeftCell("Action", 60, isLast: true),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildMaterialColumn(
                  "SYRINGE INSULIN WITH\nNEEDLE 1001U",
                  _matQty1,
                  "6.8",
                  "001_NEW OPD HRF PHARMA",
                  "Ordered",
                  "08-10-2025",
                ),
                _buildMaterialColumn(
                  "SYRINGE INSULIN WITH\nNEEDLE 1001U",
                  _matQty2,
                  "6.8",
                  "001_NEW OPD HRF PHARMA",
                  "Ordered",
                  "08-10-2025",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialColumn(
    String name,
    TextEditingController qtyCtrl,
    String price,
    String store,
    String status,
    String date,
  ) {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          _buildDataTextCell(name, 80),
          _buildDataQtyCell(qtyCtrl, 60),
          _buildDataTextCell(price, 60),
          _buildDataDropdownCell(store, 60),
          _buildDataPillCell(status, Colors.blue.shade100, 60),
          _buildDataTextCell(date, 60),
          _buildDataPrintActionCell(isLast: true, height: 60),
        ],
      ),
    );
  }

  // =========================================================================
  // UNIVERSAL TABLE CELL BUILDERS
  // =========================================================================
  Widget _buildLeftCell(String text, double height, {bool isLast = false}) =>
      Container(
        height: height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
      );

  Widget _buildDataTextCell(
    String text,
    double height, {
    bool isLast = false,
  }) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      border: Border(
        bottom: isLast
            ? BorderSide.none
            : BorderSide(color: Colors.grey.shade300),
      ),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 13, color: Colors.black87),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),
  );

  Widget _buildDataPillCell(String text, Color color, double height) =>
      Container(
        height: height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      );

  Widget _buildDataInputCell(
    String hint,
    TextEditingController controller,
    double height,
  ) => Container(
    height: height,
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
    ),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(bottom: 12, left: 12),
              ),
            ),
          ),
          // Positioned(
          //   bottom: 12,
          //   right: 12,
          //   child: Image.asset(
          //     'assets/txtarea.png', // Uses the uploaded icon
          //     width: 10,
          //     height: 10,
          //     color: Colors.grey.shade400,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, top: 8),
            child: Image.asset(
              'assets/txtarea.png', // Uses the uploaded icon
              width: 10,
              height: 10,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    ),
  );

  // --- UPDATED: Uses PopupMenuButton for Inner Table Dropdowns ---
  Widget _buildDataDropdownCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
    ),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      text,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            itemBuilder: (context) => [text, "Alternative"]
                .map(
                  (item) => PopupMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
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

  Widget _buildDataActionCell({required double height, bool isLast = false}) =>
      Container(
        height: height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child: GestureDetector(
          onTap: () => _showDeleteModal(context),
          child: Image.asset(
            'assets/deleteicon.png',
            height: 15,
            width: 15,
            color: Colors.red,
          ),
        ),
      );

  Widget _buildDataPrintActionCell({
    required double height,
    bool isLast = false,
  }) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      border: Border(
        bottom: isLast
            ? BorderSide.none
            : BorderSide(color: Colors.grey.shade300),
      ),
    ),
    child: Row(
      children: [
        const Icon(Icons.print, color: Colors.black87, size: 22),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: () => _showDeleteModal(context),
          child: Image.asset(
            'assets/deleteicon.png',
            height: 15,
            width: 15,
            color: Colors.red,
          ),
        ),
      ],
    ),
  );

  Widget _buildDataCheckboxCell(
    String text,
    bool isChecked,
    Function(bool?) onChanged,
    double height,
  ) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.only(left: 8),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
    ),
    child: Row(
      children: [
        Checkbox(
          value: isChecked,
          activeColor: const Color(0xFF117A7A),
          onChanged: onChanged,
        ),
        Text(text, style: const TextStyle(fontSize: 13, color: Colors.black87)),
      ],
    ),
  );

  Widget _buildDataDrugNameCell(String line1, String line2, double height) =>
      Container(
        height: height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              line1,
              style: const TextStyle(color: Colors.red, fontSize: 13),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "$line2 ",
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                  const TextSpan(
                    text: "mg PFS",
                    style: TextStyle(color: Color(0xFF117A7A), fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildDataActionText(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Color(0xFF117A7A),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  Widget _buildDataQtyCell(TextEditingController ctrl, double height) =>
      Container(
        height: height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
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
                style: const TextStyle(fontSize: 13),
                selectionControls: NoCursorHandleControls(),

                contextMenuBuilder: (_, __) => const SizedBox.shrink(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 14),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text("Nos", style: TextStyle(fontSize: 13)),
          ],
        ),
      );

  // =========================================================================
  // CONTAINERS AND BUTTONS
  // =========================================================================

  Widget _buildFormTile(String title, Widget tableContent) {
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
          title: Text(
            title,
            style: const TextStyle(
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
              child: tableContent,
            ),
          ],
        ),
      ),
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

  Widget _buildExpandedTestTile() {
    List<List<String>> testGrid = [
      [
        "Blood Culture Arobic & Anarobic",
        "New Fever Profile",
        "EMRTC Fever Profile",
        "EMRTC Full Lab",
        "New Patient Full EMRTC Lab",
        "Viral Marker EMRTC Lab",
        "Morning Lab + ABG5",
      ],
      [
        "Centeral line Material",
        "Iron Profile",
        "New Admission Red Zone 2 Material",
        "Red Zone - 2 Fever Profile",
        "EMRTC (ELECTROLYTS)",
        "Thyroid Profile",
        "",
      ],
      [
        "Culture Profile Red Zone - 2 Updated",
        "Morning Lab - Red Zone 2, Tuesday, Friday",
        "Dengue Profile 2024",
        "Complete EMRTC Lab",
        "Routine Old Lab",
        "Red Zone 2 (Wednesday & Saturday)",
        "",
      ],
      [
        "Red Zone 2 Intubation Drug & Material",
        "Material Order set after admission",
        "EMRTC - LFT",
        "EMRTC - CBC + KFT",
        "New Morning Lab",
        "Anemia Profile",
        "",
      ],
    ];
    for (var row in testGrid) {
      for (var item in row) {
        if (item.isNotEmpty) {
          testSelections.putIfAbsent(
            item,
            () =>
                item.contains("Blood Culture") || item.contains("New Patient"),
          );
        }
      }
    }

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
            "Test",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: testGrid.asMap().entries.map((entry) {
                        return Container(
                          width: 250,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 45,
                                color: const Color(0xFFEAF9F9),
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: entry.key == 0
                                    ? const Text(
                                        "Test",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey.shade300,
                              ),
                              ...entry.value
                                  .map(
                                    (item) => Column(
                                      children: [
                                        Container(
                                          height: 50,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          child: item.isEmpty
                                              ? const SizedBox()
                                              : Row(
                                                  children: [
                                                    SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: Checkbox(
                                                        value:
                                                            testSelections[item],
                                                        activeColor:
                                                            const Color(
                                                              0xFF117A7A,
                                                            ),
                                                        onChanged: (v) {
                                                          setState(() {
                                                            testSelections[item] =
                                                                v ?? false;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.black87,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ),
                                        Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // MODALS & SIDEBARS
  // =========================================================================

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

  void _showFilterSidebar(BuildContext context) {
    // showGeneralDialog(
    //   context: context,
    //   barrierDismissible: true,
    //   barrierLabel: "Filter",
    //   transitionDuration: const Duration(milliseconds: 300),
    //   pageBuilder: (context, animation, secondaryAnimation) {
    //     return Align(
    //       alignment: Alignment.centerRight,
    //       child: SizedBox(
    //         width: MediaQuery.of(context).size.width * 0.85,
    //         child: const _OrderSetFilterSidebar(),
    //       ),
    //     );
    //   },
    //   transitionBuilder: (context, anim1, anim2, child) {
    //     return SlideTransition(
    //       position: Tween(
    //         begin: const Offset(1, 0),
    //         end: const Offset(0, 0),
    //       ).animate(anim1),
    //       child: child,
    //     );
    //   },
    // );

    AppFilterDialog.show(
      context: context,
      title: "Search",
      showFooter: true,
      child: _OrderSetFilterSidebar(),
    );
  }

  Widget _buildTotalCostTable() {
    const double rowHeight = 64.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),

      child: ClipRRect(
        child: Column(
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
        ),
      ),
    );
  }
}

class _OrderSetFilterSidebar extends StatefulWidget {
  const _OrderSetFilterSidebar();
  @override
  State<_OrderSetFilterSidebar> createState() => _OrderSetFilterSidebarState();
}

class _OrderSetFilterSidebarState extends State<_OrderSetFilterSidebar> {
  String? _department;
  String? _type;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedComponents.buildFormLabel("Order Set Wise"),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _department,
          hint: "--Select--",
          items: ["--Select--", "Department", "Consultant"],
          onChanged: (v) => setState(() => _department = v),
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel("Types"),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _type,
          hint: "--Select--",
          items: ["--Select--", "Emergency", "Elective"],
          onChanged: (v) => setState(() => _type = v),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
