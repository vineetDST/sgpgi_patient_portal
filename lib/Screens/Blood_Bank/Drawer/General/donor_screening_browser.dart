import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Appbar/bloodbank_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Drawer/Blood_Bank/bloodbank_drawer.dart';
import 'package:qc_hospital/Core/Utils/Drawer/drawer.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/label_with_search.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_button.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_dropdown_value.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_radiobutton.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_detail.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_detail_bodystructure.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_dropdown_controller.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_expandable_section.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_textfield.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/Bloodbank/collection_navigationbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/Bloodbank/blood_bank_navigation_bar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/Bloodbank/donor_navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filter_heading.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Core/Utils/heaading_filter.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Camp/camp.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Collection/donor_details.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Donor/donor.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Home/home.dart';

import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/app_button.dart';

class DonorScreeningBrowser extends StatefulWidget {
  DonorScreeningBrowser({super.key});

  @override
  State<DonorScreeningBrowser> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<DonorScreeningBrowser> {




  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BloodBankBaseScaffold(
      title: "Donor Screening Browser",

      showDrawer: true,
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Donor Screening Browser',
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
          _buildTable(),


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

  Widget _buildTable() {
    return ScrollableDataTable(



      tableLabels: const [
        TableLabel(text: 'Queue No', icon: Icons.unfold_more),
        TableLabel(text: 'Donor Name', icon: Icons.unfold_more),
        TableLabel(text: 'Donor Type', icon: Icons.unfold_more),
        TableLabel(text: 'Donation\nType', icon: Icons.unfold_more),
        TableLabel(text: 'Mobile No.', icon: Icons.unfold_more),
        TableLabel(text: 'CR No.', icon: Icons.unfold_more),
        TableLabel(text: 'Identity No.', icon: Icons.unfold_more),
        TableLabel(text: 'Status', icon: Icons.unfold_more),
        TableLabel(text: 'Action'), // 👈 Action mein icon nahi diya, sirf text dikhega
      ],
      // Har array me 2 values hain, jo horizontally scroll hongi
      rowValues: [
        // 1. Investigation Name Row
        [
          const TableText("063"),
          const TableText("100"),
          const TableText("089"),
          const TableText("101"),
        ],

        [
          const TableText("Vijay Singh"),
          const TableText("Vikash"),
          const TableText("Aakash"),
          const TableText("Vishal Gupta"),
        ],

        [
          const TableText("Replacement"),
          const TableText("Replacement"),
          const TableText("Replacement"),
          const TableText("Replacement"),
        ],

        [
          const TableText("Whole Blood"),
          const TableText("Whole Blood"),
          const TableText("Whole Blood"),
          const TableText("Whole Blood"),

        ],

        [
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),

        ],
        [
          const TableText("2025102413"),
          const TableText("2025102413"),
          const TableText("2025102413"),
          const TableText("2025102413"),

        ],
        [
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),

        ],
        [
          const TableText("Pending"),
          const TableText("Pending"),
          const TableText("Pending"),
          const TableText("Pending"),

        ],
        [
          Text( 'Create', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
          Text( 'Create', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
          Text( 'Create', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
          Text( 'Create', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),

        ],
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

  String? _donorType = null ;
  String? _donationType =  null;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  String? _radioStatus = 'Pending';

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

        SharedComponents.buildFormLabel('Queue No'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Queue No'),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Donor Reg.No'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Donor Reg.No'),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Donor Name'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Donor Name'),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Donor Type'),
        const SizedBox(height: 8),
        FunctionalDropdown(
            value: _donorType,
            hint: '--Select--',
            items: DummyData.donorTypes,
            onChanged: (val) {
               setState(() {
                  _donorType = val ;
               });
            }
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Donation Type'),
        const SizedBox(height: 8),
        FunctionalDropdown(
            value: _donationType,
            hint: '--Select--',
            items: DummyData.donationTypes,
            onChanged: (val) {
              setState(() {
                _donationType = val ;
              });
            }
        ),
        const SizedBox(height: 16),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel('Status',)),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      children: [
                        RadioButton<String>(
                          value: "Done",
                          label: "Done",
                          groupValue: _radioStatus,
                          onChanged: (v) => setState(() => _radioStatus = v),
                          textStyle: TextStyle(
                            fontSize: 11,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12), // Dono ke beech thoda gap
                        RadioButton<String>(
                          value: "Pending",
                          label: "Pending",
                          groupValue: _radioStatus,
                          onChanged: (v) => setState(() => _radioStatus = v),
                          textStyle: TextStyle(
                            fontSize: 11,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Total'),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),


      ],
    );
  }
}


