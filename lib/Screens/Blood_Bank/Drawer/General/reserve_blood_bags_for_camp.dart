import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class ReserveBloodBagsForCamp extends StatefulWidget {
  ReserveBloodBagsForCamp({super.key});
  @override
  State<ReserveBloodBagsForCamp> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<ReserveBloodBagsForCamp> {

  final dateOfDischargeController = TextEditingController();
  DateTime? toDate;
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }
  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Reserve Blood Bags For Camp",
      showDrawer: true,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Reserve Blood Bags For Camp',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16,),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel("Reservation Bag Count")),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText:'Reservation Bag Count' ),
          const SizedBox(height: 16),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel("Camp Date")),
          const SizedBox(height: 8),
          AppDateField(

            controller: dateOfDischargeController,
            onTap: () async {
              DateTime? pickedDate = await CustomCalendarDialog.show(
                context,
                initialDate: toDate ?? DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() {
                  toDate = pickedDate;
                  dateOfDischargeController.text = formatDate(pickedDate);
                });
              }
              ;
            },
          ),
          const SizedBox(height: 16),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel("From Blood Bag")),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText:'From Blood Bag' ),
          const SizedBox(height: 16),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel("To Blood Bag")),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText:'To Blood Bag' ),
          const SizedBox(height: 16),

          AppSaveButton(text: 'Print', onPressed: () => Navigator.of(context).pop())


        ],
      ),
    );
  }




}



