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


      // 3. Yahan humne ek fixed height de di hai, ab koi RenderFlex error nahi aayega!
      child: Column(
        children: [



          _buildPatientBillList(),
          const SizedBox(height: 16),

          _buildinvestigationRefund(),
          const SizedBox(height: 16),

          _buildDischarge(),



        ],
      ),
    );
  }

  Widget _buildPatientBillList() {
    return CustomExpansionFrame(
      title: 'Patient Bill List',
      children: [
        DetailTableWrapper(
          children: [
            DetailRow(
              label: 'CR No.',
              text: '4567890',
            ),
            DetailRow(
              label: 'Name',
              text: 'Atul Yadav',
            ),
            DetailRow(
              label: 'Receipt No.',
              text: '26-7654321',
            ),
            DetailRow(
              label: 'Bill Date',
              text: '08-06-2025 15:00 PM',
            ),
            DetailRow(
              label: 'Bill Amount',
              text: '190.00',
            ),
            DetailRow(
              label: 'Receipt Type',
              text: 'Investigation',
            ),
            // Print icon ke liye customWidget use kiya hai
            DetailRow(
              label: 'Print',
              isLast: true, // Last item me bottom border hatane ke liye
              customWidget: const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.print, color: Colors.black87, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16,),
      ],
    );
  }



  Widget _buildinvestigationRefund() {
    return CustomExpansionFrame(
      title: 'Investigation Refund Bill List',
      children: [
        DetailTableWrapper(
          children: [
            DetailRow(label: 'CR No.', text: '--'),
            DetailRow(label: 'Name', text: '--'),
            DetailRow(label: 'Refund No.', text: '--'),
            DetailRow(label: 'Refund Date', text: '--'),
            DetailRow(label: 'Refund Amount', text: '--'),
            DetailRow(label: 'Service Center', text: '--'),
            DetailRow(
              isLast: true,
              label: 'Print',
              customWidget: const Icon(Icons.print, color: Colors.black87, size: 20),
            ),
          ],
        ),
        const SizedBox(height: 16,),
      ],
    );
  }

  Widget _buildDischarge() {
    return CustomExpansionFrame(
      title: 'Discharge Bill List',
      children: [
        DetailTableWrapper(
          children: [
            DetailRow(label: 'CR No.', text: '45678'),
            DetailRow(label: 'Name', text: 'Atul Yadav'),
            DetailRow(label: 'Invoice No.', text: 'REF-87654321'),
            DetailRow(label: 'Invoice Date', text: '08-Jun-2026'),
            DetailRow(label: 'Invoice Amount', text: '1,240.00'),
            DetailRow(label: 'Service Center', text: '1604 Endrocine Surgery Ward 2'),
            DetailRow(
              isLast: true,
              label: 'Print',
              customWidget: const Icon(Icons.print, color: Colors.black87, size: 20),
            ),
          ],
        ),
        const SizedBox(height: 16,),
      ],
    );
  }

}


