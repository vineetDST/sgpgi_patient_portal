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

class DuplicateRecepits extends StatefulWidget {
  final String patientName;
  final String crn;

  const DuplicateRecepits({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<DuplicateRecepits> createState() => _OpConsultationState();
}

class _OpConsultationState extends State<DuplicateRecepits> {

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
      title: "Duplicate Recepits",
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
                  _buildPatientBillList(),
                  const SizedBox(height: 16),

                  _buildinvestigationRefund(),
                  const SizedBox(height: 16),

                  _buildDischarge(),
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

  Widget _buildPatientBillList() {
    return CustomExpansionFrame(
      title: 'Patient Bill List',
      children: [

        ScrollableDataTable(
            labels: [
              'CR No.',
              'Name',
              'Receipt No.',
              'Bill Date',
              'Bill Amount',
              'Receipt Type',
              'Print',
            ],
            rowValues: [
              [
                TableText('4567890'),
                TableText('0.1. S. Glucose(F)'),
              ],
              [
                TableText('Atul Yadav'),
                TableText('85.00'),
              ],
              [
                TableText('26-7654321'),

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
                TableText('190.00'),
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
                TableText('Investigation'),
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
                const Icon(Icons.print, color: Colors.black87, size: 20),
                CustomRemarksField(

                  title: "Order Remarks",
                  hintText: "Order Remarks",
                  onChanged: (value) {
                    print("User ne type kiya: $value");
                    // Yahan aap value ko apne API model ya variables me save kar sakte hain
                  },
                ),
              ],



            ]),
        const SizedBox(height: 16,),
      ],
    );
  }



  Widget _buildinvestigationRefund() {
    return CustomExpansionFrame(
      title: 'Investigation Refund Bill List',
      children: [

        ScrollableDataTable(
            labels: [
              'CR No.',
              'Name',
              'Refund No.',
              'Refund Date',
              'Refund Amount',
              'Service Center',
              'Print',
            ],
            rowValues: [
              [
                TableText('--'),
                TableText('0.1. S. Glucose(F)'),
              ],
              [
                TableText('--'),
                TableText('85.00'),
              ],
              [
                TableText('--'),

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
                TableText('--'),
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
                TableText('--'),
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
                TableText('--'),
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
                const Icon(Icons.print, color: Colors.black87, size: 20),
                CustomRemarksField(

                  title: "Order Remarks",
                  hintText: "Order Remarks",
                  onChanged: (value) {
                    print("User ne type kiya: $value");
                    // Yahan aap value ko apne API model ya variables me save kar sakte hain
                  },
                ),
              ],



            ]),
        const SizedBox(height: 16,),

      ],
    );
  }

  Widget _buildDischarge() {
    return CustomExpansionFrame(
      title: 'Discharge Bill List',
      children: [

        ScrollableDataTable(
            labels: [
              'CR No.',
              'Name',
              'Invoice No.',
              'Invoice Date',
              'Invoice Amount',
              'Service Center',
              'Print',
            ],
            rowValues: [
              [
                TableText('45678'),
                TableText('0.1. S. Glucose(F)'),
              ],
              [
                TableText('Atul Yadav'),
                TableText('85.00'),
              ],
              [
                TableText('REF-87654321'),

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
                TableText('08-Jun-2026'),
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
                TableText('1,240.00'),
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
                TableText('1604 Endrocine Surgery Ward 2'),
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
                const Icon(Icons.print, color: Colors.black87, size: 20),
                CustomRemarksField(

                  title: "Order Remarks",
                  hintText: "Order Remarks",
                  onChanged: (value) {
                    print("User ne type kiya: $value");
                    // Yahan aap value ko apne API model ya variables me save kar sakte hain
                  },
                ),
              ],



            ]),
        const SizedBox(height: 16,),

      ],
    );
  }

}


