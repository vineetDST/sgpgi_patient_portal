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

class InvestigationOrder extends StatefulWidget {
  final String patientName;
  final String crn;

  const InvestigationOrder({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<InvestigationOrder> createState() => _OpConsultationState();
}

class _OpConsultationState extends State<InvestigationOrder> {

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
      title: "Investigation Order",
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

        SharedComponents.buildFormLabel('Department',  ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _department,
          hint: '--Select--',
          items: DummyData.department,
          onChanged: (val) => setState(() => _department = val),
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Service Center',  ),
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

        ScrollableDataTable(
            labels: [
              'Test Name',
              'Service Center',
              'Test Date',
              'Collected Date',
              'Test On',
              'Specimen',
              'Test Status',
              'Lab Sample ID',
              'Print',
            ],
            rowValues: [
              [
                TableText('01. S. Glocuse(F)'),
                TableText('01. S. Glocuse(F)'),
              ],
              [
                TableText('Clinical Chemistry'),
                TableText('85.00'),
              ],
              [
                TableText('08-06-2025 15:00 PM'),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFBDDAFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const TableText('Ordered'),
                ),
              ],
              [
                TableText('08-06-2025 15:00 PM'),
                InnnerDropdown(
                    value: actionDetail,
                    items: [
                      'Elective',
                      'Emergency',
                      'Immediate'

                    ],
                    onChanged: (val) {
                      setState(() {
                        actionDetail = val;
                      });
                    }
                ),
              ],
              [
                TableText('Blood Pain'),
                InnnerDropdown(
                    value: actionDetail2,
                    items: [
                      'Radiology',
                      'Clinical Chemistry',

                    ],
                    onChanged: (val) {
                      setState(() {
                        actionDetail2 = val;
                      });
                    }
                ),
              ],
              [
                TableText('Blood Pain'),
                CustomRemarksField(

                  title: "Blood Pain",
                  hintText: "Blood Pain",
                  onChanged: (value) {
                    print("User ne type kiya: $value");
                    // Yahan aap value ko apne API model ya variables me save kar sakte hain
                  },
                ),
              ],
              [
                TableText('Report Validated'),
                CustomRemarksField(

                  title: "Order Remarks",
                  hintText: "Order Remarks",
                  onChanged: (value) {
                    print("User ne type kiya: $value");
                    // Yahan aap value ko apne API model ya variables me save kar sakte hain
                  },
                ),
              ],
              [
                TableText('L1987654334567'),
                const SizedBox()
              ],
              [
                CustomRadioButton(
                  selected: isSelected,
                  onTap: () {
                    setState(() {
                      isSelected = !isSelected;
                    });
                  },
                ),
              ],

            ]),
        const SizedBox(height: 16,),

      ],
    );
  }

  Widget _buildRequistionDetails() {
    return CustomExpansionFrame(
      title: 'Requistion Details',
      children: [

        ScrollableDataTable(
            labels: [
              'Req. No.',
              'Req. Date',
              'Service Center',
              'Service Department',
              'Requested By',
              'Print',
            ],
            rowValues: [
              [
                Text(
                  'ORDER_7654321',

                  style: TextStyle(decoration: TextDecoration.underline,fontSize: 13, color: const Color(0xFF117A7A)),

                ),
                Text(
                  'ORDER_7654321',

                  style: TextStyle(decoration: TextDecoration.underline,fontSize: 13, color: const Color(0xFF117A7A)),

                ),
                Text(
                  'ORDER_7654321',

                  style: TextStyle(decoration: TextDecoration.underline,fontSize: 13, color: const Color(0xFF117A7A)),

                ),
                Text(
                  'ORDER_7654321',

                  style: TextStyle(decoration: TextDecoration.underline,fontSize: 13, color: const Color(0xFF117A7A)),

                ),
                Text(
                  'ORDER_7654321',

                  style: TextStyle(decoration: TextDecoration.underline,fontSize: 13, color: const Color(0xFF117A7A)),

                ),
              ],
              [
                TableText('08-06-2025'),
                TableText('08-06-2025'),
                TableText('08-06-2025'),
                TableText('08-06-2025'),
                TableText('08-06-2025'),
              ],
              [
                TableText('Clinical Chemistry'),
                TableText('Cross Match'),
                TableText('Clinical Chemistry'),
                TableText('Dialysis'),
                TableText('CR/Pain X-Ray'),
              ],
              [
                TableText('Pathology'),
                TableText('Transfusion Medicine'),
                TableText('Pathology'),
                TableText('Nephrology'),
                TableText('Radiodiagnosis'),

              ],
              [
                TableText('Admin'),
                TableText('Admin'),
                TableText('Admin'),
                TableText('Admin'),
                TableText('Admin'),

              ],
              [
                GlobalCheckbox(
                  label: '', // Label blank hai kyunki hum text par alag action chahte hain
                  value: _action_a ?? false,
                  onChanged: (bool newValue) {
                    setState(() {

                      _action_a = newValue; // Checkbox ka state update
                    });
                  },
                ),
                GlobalCheckbox(
                  label: '', // Label blank hai kyunki hum text par alag action chahte hain
                  value: _action_b ?? false,
                  onChanged: (bool newValue) {
                    setState(() {

                      _action_b = newValue; // Checkbox ka state update
                    });
                  },
                ),
                GlobalCheckbox(
                  label: '', // Label blank hai kyunki hum text par alag action chahte hain
                  value: _action_c ?? false,
                  onChanged: (bool newValue) {
                    setState(() {

                      _action_c = newValue; // Checkbox ka state update
                    });
                  },
                ),
                GlobalCheckbox(
                  label: '', // Label blank hai kyunki hum text par alag action chahte hain
                  value: _action_d ?? false,
                  onChanged: (bool newValue) {
                    setState(() {

                      _action_d = newValue; // Checkbox ka state update
                    });
                  },
                ),
                GlobalCheckbox(
                  label: '', // Label blank hai kyunki hum text par alag action chahte hain
                  value: _action_e ?? false,
                  onChanged: (bool newValue) {
                    setState(() {

                      _action_e = newValue; // Checkbox ka state update
                    });
                  },
                ),
              ],


            ]),
        const SizedBox(height: 16,),

      ],
    );
  }


}


