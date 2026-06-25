import 'package:flutter/material.dart';

import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class PedBalance extends StatefulWidget {
  final String patientName;
  final String crn;

  const PedBalance({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<PedBalance> createState() => _OpConsultationState();
}

class _OpConsultationState extends State<PedBalance> {


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ClinicalBaseScaffold(
      title: "Ped Balance",
      showDrawer: true,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Admission',

      // ONLY pass the content that is unique to this screen
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Patient - Sponsor Order for Fund Usage',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16,),
          _buildTable(context),
          const SizedBox(height: 16,),
          AppSaveButton(text: 'Print',onPressed: (){},),
          const SizedBox(height: 16,),

        ],
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    return DetailTableWrapper(
      children: [
        DetailRow(label: 'Account No', text: 'PATIENT_ACCOUNT-2345678'),
        DetailRow(label: 'Organisation Name', text: 'Cash Account'),
        DetailRow(label: 'Letter No', text: '--'),
        DetailRow(label: 'Letter Amount', text: '0.00'),
        DetailRow(label: 'Authorisation Amount', text: '0.00'),
        DetailRow(label: 'Balance Amount', text: '0.00'),
        DetailRow(label: 'Balance Amount', text: '0.00'), // Image me ye do baar hai
        DetailRow(label: 'Order', text: '1'),
        DetailRow(label: 'Created By', text: 'Admin, 08/09/2025 12:00 AM'),
        DetailRow(label: 'Approved By', text: 'Admin, 08/09/2025 12:00 AM'),

        DetailRow(

          isLast: true,
          label: "Total Balance (Rs.)",
          removePadding: true, // 🔥 important
          customWidget: Container(
            padding: EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: double.infinity,

            color: Colors.yellow,
            child: const Text(
              "0.00",
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }


}


