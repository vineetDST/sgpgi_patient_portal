import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog2.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/cpoes/investigation_screen.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

class IPPrevServiceOrder extends StatefulWidget {
  final String patientName;
  final String crn;
  const IPPrevServiceOrder({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<IPPrevServiceOrder> createState() => _PrevInvestigationScreenState();
}

class _PrevInvestigationScreenState extends State<IPPrevServiceOrder> {

  final TextEditingController _remarksController1 = TextEditingController();
  final TextEditingController _remarksController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Investigation",
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







  Widget _buildDataPillCell(String text, Color bgColor, ) {
    return Container(
      height: 64,
      alignment: Alignment.centerLeft,


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

  Widget _buildRemarksCell(TextEditingController ctrl,String text, {bool isLast = false}) {
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
      child: GestureDetector(
        // onTap: () => _showRemarksModal(context),
        onTap: () async {
             await RemarksDialog.show(
            context,
            ctrl,
            title: "Remarks",
            hintText: "Remarks",
          );


        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            text.isEmpty ? "Remarks" : text,
            style: TextStyle(
              color: text.isEmpty ? Colors.grey.shade400 : Colors.black87,
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
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


}

class FilterController {
  VoidCallback? onClear;
  VoidCallback? onSubmit;
}
