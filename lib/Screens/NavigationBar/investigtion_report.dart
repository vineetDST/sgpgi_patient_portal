import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/custom_radio_button.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/innner_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Tab/switching_tab.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

// --- Import the Base Shell to access the Master Drawer Key ---
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// --- Imports for the routed screens ---
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/clinical_history_screen.dart';
import 'package:qc_hospital/Screens/OP/clinical_summary_screen.dart';
import 'package:qc_hospital/Screens/OP/allergy/allergy_screen.dart';
import 'package:qc_hospital/Screens/OP/vital_signs/vital_signs_screen.dart';
import 'package:qc_hospital/Screens/OP/examinations/examination_screen.dart';
import 'package:qc_hospital/Screens/OP/cpoe_screen.dart';

class InvestigtionReport extends StatefulWidget {
  final String patientName;
  final String crn;

  const InvestigtionReport({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<InvestigtionReport> createState() => _OpConsultationState();
}

class _OpConsultationState extends State<InvestigtionReport> {

  final fromController = TextEditingController();
  final toController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;

  String? _department;
  String? _service;

  String? actionDetail = null;
  String? actionDetail2 = null;

  bool isSelected = false;

  bool _action_a = true ;
  bool _action_b = false ;
  bool _action_c = false ;
  bool _action_d = false ;
  bool _action_e = true ;



  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    // 1. Screen ki total height nikal lein
    double screenHeight = MediaQuery.of(context).size.height;

    // 2. AppBar, SafeArea (notch/status bar) aur Bottom Nav ke hisaab se height minus karein.
    // (Approx 160-180 pixels top aur bottom ke UI elements le lete hain)
    double availableHeight = screenHeight - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom - 160;

    return ClinicalBaseScaffold(
      title: "Investigation Reports",
      showDrawer: true,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Admission',
      isScroll: false,

      // 3. Yahan humne ek fixed height de di hai, ab koi RenderFlex error nahi aayega!
      child: Column(
        children: [

          // 4. Upar ka content Expanded + Scrollable rahega

           Expanded(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.only(bottom: 20), // Thodi bottom padding taaki content button se na chipke
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  _buildSearchOrder(),
                  const SizedBox(height: 16),

                  _buildRequistionDetails(),
                  const SizedBox(height: 16),

                  _buildTestDetails(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
            // 5. Ye button Column ke end me, yani available height ke bottom me fix rahega
            Container(
              color: Colors.transparent,
              padding:  EdgeInsets.only(bottom: screenHeight * 0.13,top: 16 ),
              child: AppSaveButton(text: 'Print',onPressed: () {},),
            ),

        ],
      ),
    );
  }



  Widget _buildSearchOrder() {
    return CustomExpansionFrame(
      title: 'Search Orders',
      children: [


        SharedComponents.buildFormLabel('From Date'),
        const SizedBox(height: 8),
        AppDateField(
          controller: fromController,
          onTap: () async {
            DateTime? pickedDate = await CustomCalendarDialog.show(
              context,
              initialDate: fromDate ?? DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                fromDate = pickedDate;
                fromController.text = formatDate(pickedDate);
              });
            }
          },
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('To Date'),
        const SizedBox(height: 8),
        AppDateField(
          controller: toController,
          onTap: () async {
            DateTime? pickedDate = await CustomCalendarDialog.show(
              context,
              initialDate: toDate ?? DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                toDate = pickedDate;
                toController.text = formatDate(pickedDate);
              });
            }
          },
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Department',),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _department,
          hint: '--Select--',
          items: DummyData.department,
          onChanged: (val) => setState(() => _department = val),
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Service Center', ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _service,
          hint: '--Select--',
          items: ['--Select--','All','Few'],
          onChanged: (val) => setState(() => _service = val),
        ),
        const SizedBox(height: 24),

        SizedBox(
            width: 120,
            height: 40,
            child: AppSaveButton(text: 'Search',onPressed: (){},)),
        const SizedBox(height: 16),




      ],
    );
  }

  Widget _buildTestDetails() {
    return CustomExpansionFrame(
      title: 'Test Details',
      children: [
        DetailTableWrapper(
          children: [
            DetailRow(label: 'Test Name', text: '01. S. Glocuse(F)'),
            DetailRow(label: 'Service Center', text: 'Clinical Chemistry'),
            DetailRow(label: 'Test Date', text: '08-06-2025 15:00 PM'),
            DetailRow(label: 'Collected Date', text: '08-06-2025 15:00 PM'),
            DetailRow(label: 'Test On', text: 'Blood Pain'),
            DetailRow(label: 'Specimen', text: 'Blood Pain'),
            DetailRow(label: 'Test Status', text: 'Report Validated'),
            DetailRow(label: 'Lab Sample ID', text: 'L1987654334567'),
            DetailRow(
              isLast: true,
              label: 'Print',
              customWidget: CustomRadioButton(
                selected: isSelected,
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16,),
      ],
    );
  }

  Widget _buildRequistionDetails() {
    return CustomExpansionFrame(
      title: 'Requistion Details',
      children: [
        DetailTableWrapper(
          children: [
            DetailRow(
              label: 'Req. No.',
              customWidget: const Text(
                'ORDER_7654321',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 13,
                  color: Color(0xFF117A7A),
                ),
              ),
            ),
            DetailRow(label: 'Req. Date', text: '08-06-2025'),
            DetailRow(label: 'Service Center', text: 'Clinical Chemistry'),
            DetailRow(label: 'Service Department', text: 'Pathology'),
            DetailRow(
              isLast: true,
              label: 'Requested By',
              text: 'Admin',
            ),
          ],
        ),
        const SizedBox(height: 16,),
      ],
    );
  }


}


