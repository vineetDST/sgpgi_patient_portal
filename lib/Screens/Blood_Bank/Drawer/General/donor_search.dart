import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class DonorSearch extends StatefulWidget {
  DonorSearch({super.key});
  @override
  State<DonorSearch> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<DonorSearch> {
  String? _searchBy = 'Donor Name';

  final fromController = TextEditingController();
  final toController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Donor Search",
      showDrawer: false,
      child: Column(
        children: [

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Donor Search',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 16),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel("Search By")
          ),
          SizedBox(height: 8),
          FunctionalDropdown(
              value: _searchBy,
              hint: '--Select--',
              items: [
                '--Select--',
                'Donor Name',
                'Queue Number'
              ],
              onChanged: (val) {
                setState(() {
                   _searchBy = val ;
                });
              }
          ),
          SizedBox(height: 16),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel("Value")
          ),
          SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'Value'),
          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SharedComponents.buildFormLabel("From Date")),
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
                        child: SharedComponents.buildFormLabel("To Date")),
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


          AppSaveButton(text: 'Search', onPressed: () => Navigator.of(context).pop()),
          SizedBox(height: 16),

          DetailTableWrapper(
              children: [
                DetailRow(label: 'Donor Name',text: 'Vijay Singh',),
                DetailRow(label: 'Queue Number',text: '063',),
                DetailRow(label: 'Date Of Birth',text: '10-05-2025',),
                DetailRow(label: 'Action',customWidget: Text( 'Add', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),isLast: true,),
              ]
          ),



        ],
      ),
    );
  }


}

