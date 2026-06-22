

import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Appbar/bloodbank_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Drawer/Blood_Bank/bloodbank_drawer.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/label_with_search.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_button.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_radiobutton.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_detail.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/Bloodbank/camp_navigationbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/Bloodbank/collection_navigationbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/Bloodbank/donor_navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filter_heading.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Core/Utils/heaading_filter.dart';
import 'package:qc_hospital/Core/Utils/Sidesheet/side_sheet_helper.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Camp/camp.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Collection/collection.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Donor/donor_details.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Donor/previous_donation_detail.dart';

import 'package:qc_hospital/Screens/Blood_Bank/Donor/right_sidefilter.dart';

import 'package:qc_hospital/Screens/Blood_Bank/Home/home.dart';

import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/blood_bank_module_shell.dart';





class Redonation extends StatefulWidget {
  Redonation({super.key});

  @override
  State<Redonation> createState() => _BloodBankDonorState();
}

class _BloodBankDonorState extends State<Redonation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? regNo = '063';


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height ;
    return BloodBankBaseScaffold(
      title: "Redonation",

      showDrawer: false,
      child: Column(
        children: [
          HeadingWithFilter(
            heading: "Redonation",
            isFilterShow: true,
            onFilterTap: (){


              AppFilterDialog.show(
                context: context,
                title: "Search",
                showFooter: true,
                child: _FilterSidebar(),
              );
            },
          ),
          SizedBox(height: height * 0.01,),
          getDetail(),
          SizedBox(height: height * 0.04,),

          AppSaveButton(text: "Add", onPressed: () {



            // bloodBankShellKey.currentState?.changeTab(2, regNo: regNo);
            Navigator.of(context).pop(regNo);


          }),

        ],
      ),





    );


  }



  Widget getDetail() {
    return DetailTableWrapper(
      children: [

         DetailRow(label: 'Donor Name',text: 'Vijay Singh',),
        DetailRow(label: 'Donor Reg.No',text: '${regNo}',),
        DetailRow(label: 'Date of Birth',text: '07-09-1998',),
        DetailRow(label: 'Last Donation Type',text: 'Whole Blood',),
        DetailRow(label: 'Donation Status',text: 'Completed',),
        DetailRow(label: 'Last Modified Date',text: '11-11-2025',isLast: true,),





      ],
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

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("First Name")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'First Name'),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Middle Name")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Middle Name'),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Last Name")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Last Name'),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Relation Name")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Relation Name'),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Registration No")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Registration No'),
        const SizedBox(height: 16),




        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel("From Date",isRequired: true)),
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
                      child: SharedComponents.buildFormLabel("To Date",isRequired: true)),
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






      ],
    );
  }


}











