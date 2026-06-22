import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class DonorCapturePhoto extends StatefulWidget {
  DonorCapturePhoto({super.key});

  @override
  State<DonorCapturePhoto> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<DonorCapturePhoto> {


  final dateOfDischargeController = TextEditingController();
  final addressController = TextEditingController();


  DateTime? toDate;


  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  String typeRadio1 = "Male";
  String typeRadio2 = "Yes";
  String typeRadio3 = "Yes";


  @override
  Widget build(BuildContext context) {

    return BloodBankBaseScaffold(
      title: "Blood Donor List",

      showDrawer: false,
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Blood Donor List',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showFilterSidebar(context);
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    top: MediaQuery.of(context).size.height * 0.01,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: const Icon(Icons.filter_alt_outlined),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16,),
          DetailTableWrapper(
            children: [
              DetailRow(label: 'Donor Reg.No',text: '',),
              DetailRow(label: 'Queue No',text: '',),
              DetailRow(label: 'Donor Name',text: '',),
              DetailRow(label: 'Action',text: '',isLast: true,),

            ],
          )

        ],
      ),
      // bottomNavigationBar: BloodBankCollectionNavigationBar(index: 2,page: 2,onTap : _navigateToPage),

    );
  }

  void _showFilterSidebar(BuildContext context) {


    AppFilterDialog.show(
      context: context,
      title: "Search",
      showFooter: true,
      child: _FilterSidebar(),
    );
  }

}

class _FilterSidebar extends StatefulWidget {
  const _FilterSidebar();
  @override
  State<_FilterSidebar> createState() => _OrderSetFilterSidebarState();
}

class _OrderSetFilterSidebarState extends State<_FilterSidebar> {
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
        
        SharedComponents.buildFormLabel('Donor Name'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Donor Name'),
        const SizedBox(height: 24),



      ],
    );
  }
}


