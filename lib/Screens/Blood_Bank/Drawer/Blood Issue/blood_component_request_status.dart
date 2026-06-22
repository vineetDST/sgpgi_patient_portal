import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/innner_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/IP/in_patient_screen.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

class BloodComponentRequestStatus extends StatefulWidget {
  const BloodComponentRequestStatus({
    super.key,
  });
  @override
  State<BloodComponentRequestStatus> createState() => _IPInfectionRecState();
}

class _IPInfectionRecState extends State<BloodComponentRequestStatus> {
  bool _isPatientFound = false; // State to handle toggle
  void _handleSearch() {
    setState(() {
      _isPatientFound = true;
    });
  }
  Widget _buildSearchBar() {
    return GestureDetector(

      onTap:() {
        print("tap");
        _handleSearch();
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search by CRN Number',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
            const Icon(Icons.search, color: Colors.grey),

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(

      title: "Blood Component Request Status",
      showDrawer: true,

      isPatientCard: _isPatientFound,
      customOverlapWidget: _isPatientFound ? null : _buildSearchBar(),

      patientName: 'Ram Sharma',
      crn: '2025000653',


      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Blood Component Request Status',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16,),

          _buildBloodRequistionDetails(),
          const SizedBox(height: 16,),

        ],
      ),
    );
  }



  Widget _buildBloodRequistionDetails() {
    return DetailTableWrapper(
      showPagination: true,
        children: [
          DetailRow(label: 'Requested Date',),
          DetailRow(label: 'Blood / Componenet',),
          DetailRow(label: 'Req Quantity',),
          DetailRow(label: 'Issued Quantity',),
          DetailRow(label: 'Issued Blood Bag',),
          DetailRow(label: 'Cross Match',),
          DetailRow(label: 'Irradiated',),
          DetailRow(label: 'Is Request Cancelled',),
          DetailRow(label: 'Transfered Status',isLast: true,),

        ]
    );
  }
}


