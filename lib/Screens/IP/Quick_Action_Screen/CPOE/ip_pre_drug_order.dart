import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_drug_order.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/cpoes/drug_screen.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

class IPPrevDrugScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const IPPrevDrugScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<IPPrevDrugScreen> createState() => _PrevDrugScreenState();
}

class _PrevDrugScreenState extends State<IPPrevDrugScreen> {
  bool _rxCheck1 = false;
  bool _rxCheck2 = false;

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Drug",
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
                "Existing Drug Order",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IPDrugScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "New Order",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => _showDrugFilterSidebar(context),
                    child: const Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.black87,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTransposedTable(),
          const SizedBox(height: 32),
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
              ),
              child: const Text(
                "Print",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTransposedTable() {
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
                color: const Color(0xFFEAF9F9),
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  _buildLeftHeaderCell("RX. No", 60),
                  _buildLeftHeaderCell("Drug Name", 80),
                  _buildLeftHeaderCell("Store", 60),
                  _buildLeftHeaderCell("In Take", 60),
                  _buildLeftHeaderCell("Total Qty", 60),
                  _buildLeftHeaderCell("Ordered on", 60),
                  _buildLeftHeaderCell("Status", 60),
                  _buildLeftHeaderCell("Re - Order", 60),
                  _buildLeftHeaderCell("Action", 60, isLast: true),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildDataColumn(
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
                      Colors.blue.shade100,
                      "Re-Order",
                    ),
                    _buildDataColumn(
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
                      Colors.blue.shade100,
                      "Re-Order",
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

  Widget _buildLeftHeaderCell(
      String text,
      double height, {
        bool isLast = false,
      }) => Container(
    height: height,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      border: Border(
        bottom: isLast
            ? BorderSide.none
            : BorderSide(color: Colors.grey.shade300),
      ),
    ),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 13,
        color: Colors.black87,
      ),
      overflow: TextOverflow.ellipsis,
    ),
  );

  Widget _buildDataColumn(
      String rxNo,
      bool isChecked,
      Function(bool?) onCheck,
      String dName1,
      String dName2,
      String store,
      String inTake,
      String tQty,
      String date,
      String status,
      Color statusColor,
      String reOrder,
      ) {
    return Container(
      width: 240,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          _buildDataCheckboxCell(rxNo, isChecked, onCheck, 60),
          _buildDataDrugNameCell(dName1, dName2, 80),
          _buildDataTextCell(store, 60),
          _buildDataTextCell(inTake, 60),
          _buildDataTextCell(tQty, 60),
          _buildDataTextCell(date, 60),
          _buildDataPillCell(status, statusColor, 60),
          _buildDataActionText(reOrder, 60),
          _buildDataActionIconsCell(60, isLast: true),
        ],
      ),
    );
  }

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
  Widget _buildDataTextCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 13, color: Colors.black87),
      maxLines: 2,
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
  Widget _buildDataActionIconsCell(double height, {bool isLast = false}) =>
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
        child: Row(
          children: [
            const Icon(Icons.print, color: Colors.black87, size: 22),
            AppDeleteIcon()
          ],
        ),
      );

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

  void _showDrugFilterSidebar(BuildContext context) {

    final controller = FilterController(); // 👈 important

    AppFilterDialog.show(
      context: context,
      title: "Search",
      showFooter: true,

      child: _FilterSidebar(controller: controller),
    );

  }
}


class _FilterSidebar extends StatefulWidget {
  final FilterController controller;

  const _FilterSidebar({required this.controller});

  @override
  State<_FilterSidebar> createState() => _FilterSidebarState();
}

class _FilterSidebarState extends State<_FilterSidebar> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;
  String? _status;
  String? _serviceCenter;
  String? _orderedDoctor;
  final _serviceNameCtrl = TextEditingController();
  final _orderedFromCtrl = TextEditingController();

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }
  @override
  void initState() {
    super.initState();

    widget.controller.onClear = () {
      setState(() {
        _status = null;
        _serviceCenter = null;
        _orderedDoctor = null;
        _serviceNameCtrl.clear();
        _orderedFromCtrl.clear();
      });
    };

    widget.controller.onSubmit = () {
      print("Search clicked");
      print(_status);
      print(_serviceCenter);
    };
  }

  @override
  void dispose() {
    _serviceNameCtrl.dispose();
    _orderedFromCtrl.dispose();
    super.dispose();
  }

  String? _searchBy = null ;
  final _valueCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel("Order From Date",)),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: fromController,
                    onTap: () async {
                      DateTime? pickedDate =
                      await CustomCalendarDialog.show(
                        context,
                        initialDate: fromDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          fromDate = pickedDate;
                          fromController.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },

                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel("To Date",)),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: toController,
                    onTap: () async {
                      DateTime? pickedDate =
                      await CustomCalendarDialog.show(
                        context,
                        initialDate: toDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          toDate = pickedDate;
                          toController.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },

                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )
          ],
        ),

        SharedComponents.buildFormLabel("Search By"),
        const SizedBox(height: 8),
        FunctionalDropdown(value: _searchBy, hint: "--Select--",
            items: ["--Select--","RX. No","Drug Name",], onChanged: (v) => setState(() => _searchBy = v)),

        const SizedBox(height: 16),
        SharedComponents.buildFormLabel("Value"),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          controller: _valueCtrl,
          hintText: "Value",
        ),
        const SizedBox(height: 16),

      ],
    );
  }


}

class FilterController {
  VoidCallback? onClear;
  VoidCallback? onSubmit;
}
