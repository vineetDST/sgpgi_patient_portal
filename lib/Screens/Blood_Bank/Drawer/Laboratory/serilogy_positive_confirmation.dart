import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Appbar/bloodbank_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/bottom_sheet.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog.dart';
import 'package:qc_hospital/Core/Utils/Drawer/Blood_Bank/bloodbank_drawer.dart';
import 'package:qc_hospital/Core/Utils/Drawer/drawer.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/innner_dropdown.dart';
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
import 'package:qc_hospital/Screens/OP/clinical_histories/immunization_history_screen.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/app_button.dart';

class SerilogyPositiveConfirmation extends StatefulWidget {
  SerilogyPositiveConfirmation({super.key});

  @override
  State<SerilogyPositiveConfirmation> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<SerilogyPositiveConfirmation> {
  final reportController = TextEditingController();
  DateTime? reportDate;

  String? _investigation = null;
  String? _donationType = 'Camp';
  String? _reportStatus = null;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }
  final TextEditingController _remarksController1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Serology Positive Confirmation",

      showDrawer: true,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Serology Positive Confirmation',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              GestureDetector(
                onTap: () {
                  AppFilterDialog.show(
                    context: context,
                    title: "Search",
                    showFooter: true,
                    child: _FilterSidebar(),
                  );
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
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Doc No.'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(enabled: false),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Reported Date"),
          ),
          const SizedBox(height: 8),
          AppDateField(
            controller: reportController,
            onTap: () async {
              DateTime? pickedDate = await CustomCalendarDialog.show(
                context,
                initialDate: reportDate ?? DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() {
                  reportDate = pickedDate;
                  reportController.text = formatDate(pickedDate);
                });
              }
              ;
            },
          ),
          const SizedBox(height: 16),

          AppSaveButton(),
          const SizedBox(height: 16),

          AppCancelButton(
            text: 'Create',
            onPressed: () {
              AppDialog.show(
                context: context,
                title: 'Cell Grouping Antisera Preperation',
                child: DetailTableWrapper(
                  children: [
                    DetailRow(label: 'Anti Gen'),
                    DetailRow(label: 'Store'),
                    DetailRow(label: 'Anti Sera'),
                    DetailRow(label: 'Lot No.'),
                    DetailRow(label: 'Expiry Date',isLast: true,),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          _buildSerologyDetails(),
          const SizedBox(height: 16),

          _buildSerologyPositiveConfirmation(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSerologyDetails() {
    return CustomExpansionFrame(
      actionText: 'Add', // Yahan Text add karein
      onActionPressed: () {
        // Yahan apka logic aayega jab 'Add' par click hoga
        print("Add button pressed!");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImmunizationHistoryScreen(
              patientName: 'Anil Srivastava',
              crn: '2025000635',
            ),
          ),
        );
      },

      title: 'Serology Details',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Unit No.', isRequired: true),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Unit No.'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Donation Date"),
        ),
        const SizedBox(height: 8),
        AppDateField(
          controller: reportController,
          onTap: () async {
            DateTime? pickedDate = await CustomCalendarDialog.show(
              context,
              initialDate: reportDate ?? DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                reportDate = pickedDate;
                reportController.text = formatDate(pickedDate);
              });
            }
            ;
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Investigation',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _investigation,
          items: ['Investigation 1', 'Investigation 2'],
          onChanged: (val) {
            setState(() {
              _investigation = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Donation Type',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _donationType,
          items: ['Camp', 'Investigation 2'],
          onChanged: (val) {
            setState(() {
              _donationType = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Report Status',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _reportStatus,
          items: ['Pending', 'Completed'],
          onChanged: (val) {
            setState(() {
              _reportStatus = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Details of Donor Notification Letter',
          ),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: 'Details of Donor Notification Letter',
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Contact Details'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Contact Details'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Remarks'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: "Remarks",
          maxLines: 5,
          controller: _remarksController1
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSerologyPositiveConfirmation() {
    return CustomExpansionFrame(
      title: 'Serology Positive Confirmation',
      children: [
        DetailTableWrapper(
          children: [
            DetailRow(label: 'Date Of Donation'),
            DetailRow(label: 'Unit No.'),
            DetailRow(label: 'Donor Type'),
            DetailRow(label: 'Serlogy Test'),
            DetailRow(label: 'Detail of Donor Notification Letter'),
            DetailRow(label: 'Report Status'),
            DetailRow(label: 'Contact Details'),
            DetailRow(
              label: 'Remarks',
              customWidget: CustomRemarksField(hintText: ' '),
            ),
            DetailRow(
              label: "Action",
              customWidget: Image.asset(
                'assets/editicon.png',
                height: 15,
                width: 15,
                color: Colors.black,
              ),

              isLast: true,
            ),
          ],
        ),
        const SizedBox(height: 16),
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

  String? _methodOfTesting = null;

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
                    child: SharedComponents.buildFormLabel(
                      "From Date",
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: fromController,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
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
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      "To Date",
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: toController,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
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
            ),
          ],
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Blood Bag No.'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Blood Bag No.'),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Total'),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Confirmed'),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Status'),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _methodOfTesting,
          items: ['Pending', 'Complete'],
          onChanged: (val) {
            setState(() {
              _methodOfTesting = val;
            });
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
