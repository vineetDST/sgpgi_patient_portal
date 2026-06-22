import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/innner_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/cpoes/investigation_screen.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

class PrevInvestigationScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const PrevInvestigationScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<PrevInvestigationScreen> createState() =>
      _PrevInvestigationScreenState();
}

class _PrevInvestigationScreenState extends State<PrevInvestigationScreen> {
  List<String> remarksList = ["", ""];
  @override
  Widget build(BuildContext context) {
    return ClinicalBaseScaffold(
      title: "Investigation",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Order Status',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Existing Service Order",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  // --- UPDATED: Navigator.pop handles the return to InvestigationScreen seamlessly ---
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      minimumSize: Size.zero,
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
                  const SizedBox(width: 16),
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
            ],
          ),
          const SizedBox(height: 16),
          _buildTransposedTable(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTransposedTable() {
    return ScrollableDataTable(
      tableLabels: const [
        TableLabel(text: 'Order No', icon: Icons.unfold_more),
        TableLabel(text: 'Service\nName', icon: Icons.unfold_more),
        TableLabel(text: 'Ordered Date', icon: Icons.unfold_more),
        TableLabel(text: 'Ordered By', icon: Icons.unfold_more),
        TableLabel(text: 'Status', icon: Icons.unfold_more),
        TableLabel(text: 'Priority', icon: Icons.unfold_more),
        TableLabel(text: 'Service\nCenter', icon: Icons.unfold_more),
        TableLabel(text: 'Remarks'),
        TableLabel(text: 'Action'),
      ],
      rowValues: [
        [
          TableText('ORDER202500068'),
          TableText('ORDER202500069'),
        ],
        [
          TableText('0.1. S. Glucose (F)'),
          TableText('0.1. S. Glucose (F)'),
        ],
        [
          TableText('08-10-2025 | 10:30'),
          TableText('08-10-2025 | 10:30'),
        ],
        [
          TableText('"Doctor",'),
          TableText('"Doctor",'),
        ],
        [
          _buildDataPillCell('Ordered', Colors.blue.shade100,),
          _buildDataPillCell('Ordered', Colors.blue.shade100,),

        ],
        [
          _buildDataPillCell('Elective', const Color(0xFFFFAAAA),),
          _buildDataPillCell('Elective', const Color(0xFFFFAAAA),),
        ],
        [
          TableText('Clinical Chemistry'),
          TableText('Clinical Chemistry'),
        ],
        [
          CustomRemarksField(),
          CustomRemarksField(),
        ],
        [
          NoPaddingCell(child: AppDeleteIcon()),
          NoPaddingCell(child: AppDeleteIcon()),
        ]
      ],

    );
  }

  Widget _buildLeftHeaderCell(
    String text, {
    bool showSort = false,
    bool isLast = false,
  }) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (showSort)
            const Icon(Icons.unfold_more, size: 16, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _buildDataColumn(
    String orderNo,
    String serviceName,
    String date,
    String by,
    String status,
    Color statusColor,
    String priority,
    Color priorityColor,
    String center,
    String remarksText,
      int index,
  ) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          _buildDataTextCell(orderNo),
          _buildDataTextCell(serviceName),
          _buildDataTextCell(date),
          _buildDataTextCell(by),
          _buildDataPillCell(status, statusColor),
          _buildDataPillCell(priority, priorityColor),
          _buildDataTextCell(center),
          _buildRemarksCell(remarksText, index),
          _buildDataActionCell(isLast: true),
        ],
      ),
    );
  }

  Widget _buildDataTextCell(String text, {bool isLast = false}) {
    return Container(
      height: 64,
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
      ),
    );
  }

  Widget _buildDataPillCell(String text, Color bgColor, {bool isLast = false}) {
    return Container(
      height: 64,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ),
    );
  }

  Widget _buildRemarksCell(String text, int index, {bool isLast = false}) { // <-- index parameter add kiya
    return Container(
      height: 64,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child : GestureDetector(
        onTap: () async {
          // Controller mein existing text set karein taaki dialog me purana text show ho
          TextEditingController rowRemarksCtrl = TextEditingController(text: text);
          await _showRemarksModal(context, rowRemarksCtrl);

          setState(() {
            // Local variable ki jagah State List ko update karein
            remarksList[index] = rowRemarksCtrl.text.trim();
          });
        },
        child: Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text.isEmpty ? "Remarks" : text,
                  style: TextStyle(
                    fontSize: 11,
                    color: text.isEmpty ? Colors.grey.shade400 : Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Image.asset(
                'assets/txtarea.png',
                width: 10,
                height: 10,
                color: Colors.grey.shade400,
                errorBuilder: (c, e, s) => const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataActionCell({bool isLast = false}) {
    return Container(
      height: 64,
      alignment: Alignment.centerLeft,

      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: AppDeleteIcon(),
    );
  }

  void _showFilterSidebar(BuildContext context) {
    final controller = FilterController(); // 👈 important

    AppFilterDialog.show(
      context: context,
      title: "Search",
      showFooter: true,

      child: _FilterSidebar(controller: controller),
    );
  }

  Future<void> _showRemarksModal(BuildContext context, TextEditingController controller) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Remarks",
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
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Stack(
                  children: [
                    TextField(
                      controller: controller, // <-- Controller binded here
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: "Remarks",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Image.asset(
                        'assets/txtarea.png', // Uploaded icon
                        width: 14,
                        height: 14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now().add(const Duration(days: 10));
  String? _status;
  String? _serviceCenter;
  String? _orderedDoctor;
  final _serviceNameCtrl = TextEditingController();
  final _orderedFromCtrl = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _buildDateSection(
                "Order From Date",
                _fromDate,
                    (d) => setState(() => _fromDate = d),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDateSection(
                "To Date",
                _toDate,
                    (d) => setState(() => _toDate = d),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel("Status"),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _status,
          hint: "--Select--",
          items: ["--Select--", "Ordered", "Completed", "Pending"],
          onChanged: (v) => setState(() => _status = v),
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
        SharedComponents.buildTextField(
          controller: _serviceNameCtrl,
          hintText: "Service Name",
        ),
        const SizedBox(height: 16),
        SharedComponents.buildFormLabel("Ordered From"),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          controller: _orderedFromCtrl,
          hintText: "Ordered From",
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel("Ordered Doctor"),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _orderedDoctor,
          hint: "--Select--",
          items: ["--Select--", "Dr. Smith", "Dr. Jane"],
          onChanged: (v) => setState(() => _orderedDoctor = v),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDateSection(
      String label,
      DateTime date,
      ValueChanged<DateTime> onDateSelected,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedComponents.buildFormLabel(label),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? picked = await CustomCalendarDialog.show(
              context,
              initialDate: date,
            );
            if (picked != null) onDateSelected(picked);
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
                  DateFormat('dd-MM-yy').format(date),
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
                const Icon(
                  Icons.calendar_month,
                  size: 18,
                  color: Colors.black87,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }


}

class FilterController {
  VoidCallback? onClear;
  VoidCallback? onSubmit;
}
