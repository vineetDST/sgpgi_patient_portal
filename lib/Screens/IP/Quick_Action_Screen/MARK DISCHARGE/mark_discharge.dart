import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Core/Utils/Table/expand_table.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class IPMarkDischarge extends StatefulWidget {
  final String patientName;
  final String crn;
  const IPMarkDischarge({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<IPMarkDischarge> createState() => _VisitSummaryScreenState();
}

class _VisitSummaryScreenState extends State<IPMarkDischarge> {
  // Example Data
  final List<Map<String, String>> myLabData = [
    {"name": "Troponin 1", "qty": "1.0"},
    {"name": "01. HGB (M-Spectrometric)", "qty": "1.0"},
    {"name": "03. DLC (Smear Microscopy)", "qty": "1.0"},
    {"name": "02. TLC (M-Advance Mapss)", "qty": "1.0"},
    {"name": "06. PLT (Advance Mapss)", "qty": "1.0"},
    {"name": "5. S. SODIUM (M-ISE)", "qty": "1.0"},
    {"name": "6. S. POTTASIUM (M-ISE)", "qty": "1.0"},
  ];

  final List<Map<String, String>> pendingDrugOrders = [
    {"name": "Fresubin HP 400mg Tin 1mg", "qty": "1.0"},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return IpBaseScaffold(
      title: "Mark Discharge",
      quickActionLabel: "Mark Discharge",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: true,

      // We only pass the content that is unique to the Visit Summary screen below the Quick Actions
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Pending Requests",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(children: [IPActionButton()]),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            "All the pending orders will automatically get cancelled when marking for discharge",
            style: TextStyle(
              color: const Color(0xFF117A7A),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),

          DynamicExpansionTable(
            title: "Pending Service Orders",
            column1Header: "Service Name",
            column2Header: "Quantity",
            dataList: myLabData,
            patientName: widget.patientName,
            ratio1: 4,
            ratio2: 2,
          ),
          const SizedBox(height: 16),

          DynamicExpansionTable(
            title: "Pending Drug Orders",
            column1Header: "Service Name",
            column2Header: "Quantity",
            dataList: pendingDrugOrders,
            patientName: widget.patientName,
            ratio1: 4,
            ratio2: 2,
          ),
          const SizedBox(height: 16),

          AppSaveButton(text: "Yes", onPressed: () {}),
          const SizedBox(height: 16),
          AppCancelButton(text: "No", onPressed: () {}),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
