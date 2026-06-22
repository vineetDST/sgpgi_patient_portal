import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Appbar/bloodbank_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Drawer/Blood_Bank/bloodbank_drawer.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/label_with_search.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_button.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_radiobutton.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_detail.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_selecttype_dropdown.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/Bloodbank/donor_navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/Text/text.dart';
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

class DonorRegistrationCamp extends StatefulWidget {
  DonorRegistrationCamp({super.key});

  @override
  State<DonorRegistrationCamp> createState() => _BloodBankDonorState();
}

class _BloodBankDonorState extends State<DonorRegistrationCamp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _campSite = null;
  String? typeRadio3 = "Camp";
  String? typeRadio4 = "No";
  String? _donationType = null;

  final dateOfDischargeController = TextEditingController();
  final addressController = TextEditingController();
  DateTime? toDate;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  String? _relation = null;

  String? typeRadio1 = "Male";
  String? typeRadio2 = "No";

  String? _hbMethod = "--Select--";
  String? _maritalStatus = "--Select--";

  String? _occupation = null;
  String? _identity = null;
  String? _country = null;
  String? _state = null;
  String? _city = null;
  String? _often = "--Select--";

  String? _searchBy = null;
  bool _action_a = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BloodBankBaseScaffold(
      title: "Donor Registration Camp",
      showDrawer: true,
      child: Column(
        children: [
          HeadingWithFilter(heading: "Donor Registration"),
          SizedBox(height: height * 0.03),

          Image.asset("assets/centre_profile_1.png", height: height * 0.15),
          SizedBox(height: height * 0.02),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel(
              'Camp Site',
              isRequired: true,
            ),
          ),
          SizedBox(height: 8),
          FunctionalDropdown(
            value: _campSite,
            items: DummyData.campSites,
            onChanged: (val) {
              setState(() {
                _campSite = val;
              });
            },
          ),
          SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Donor Type'),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                RadioButton<String>(
                  value: "Camp",
                  label: "Camp",
                  groupValue: typeRadio3,
                  onChanged: (v) => setState(() => typeRadio3 = v),
                ),
                const SizedBox(width: 16), // Dono ke beech thoda gap
              ],
            ),
          ),
          SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel(
              'Donation Type',
              isRequired: true,
            ),
          ),
          SizedBox(height: 8),
          FunctionalDropdown(
            value: _donationType,
            items: DummyData.donationTypes,
            onChanged: (val) {
              setState(() {
                _donationType = val;
              });
            },
          ),
          SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel(
              'Donation Date',
              isRequired: true,
            ),
          ),
          SizedBox(height: 8),
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
          SizedBox(height: 16),

          _buildDonorDetails(),
          SizedBox(height: 16),

          _buildDonorContactInformation(),
          SizedBox(height: 16),

          _buildPreviousBleedingDetails(),
          SizedBox(height: 16),
          AppSaveButton(text: "Register Camp Donor", onPressed: () {}),
          SizedBox(height: 16),

          AppSaveButton(text: "New Donor Registration", onPressed: () {}),
          SizedBox(height: 16),

          AppCancelButton(text: "Re-Print", onPressed: () {}),
          SizedBox(height: 16),

          AppCancelButton(text: "Generate Blood Bank No", onPressed: () {}),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildDonorDetails() {
    return CustomExpansionFrame(
      title: 'Donor Details',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'First Name',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'First Name'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Middle Name'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Middle Name'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Last Name', isRequired: true),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Last Name'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Father\'s Name',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Father\'s Name'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Relation with CRN No.'),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _relation,
          hint: '--Select--',
          items: DummyData.relations,


          onChanged: (val) {
            setState(() {
              _relation = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Date of Birth'),
                  ),
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
                          dateOfDischargeController.text = formatDate(
                            pickedDate,
                          );
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
                      'Age',
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(
                      hintText: 'Enter Age',
                      suffix: AppText.suffixText('Years'),
                      keyboardType: TextInputType.number
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Gender'),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              RadioButton<String>(
                value: "Male",
                label: "Male",
                groupValue: typeRadio1,
                onChanged: (v) => setState(() => typeRadio1 = v!),
              ),
              const SizedBox(width: 16), // Dono ke beech thoda gap
              RadioButton<String>(
                value: "Female",
                label: "Female",
                groupValue: typeRadio1,
                onChanged: (v) => setState(() => typeRadio1 = v!),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      'HB (gms/dl)',
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(
                    hintText: 'Enter HB (gms/dl)',
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
                    child: SharedComponents.buildFormLabel('HB Method'),
                  ),
                  const SizedBox(height: 8),

                  ExpandedDropdown(
                    value: _hbMethod,
                    items: [
                      '--Select--',
                      'HB Mehtod 1',
                      'HB Mehtod 2',
                      'Cyanmethemoglobin',
                    ],
                    onChanged: (v) => setState(() => _hbMethod = v),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Marital Status'),
                  ),
                  const SizedBox(height: 8),

                  ExpandedDropdown(
                    value: _maritalStatus,
                    items: ['--Select--', 'Married', 'Single', 'Seperated'],
                    onChanged: (v) => setState(() => _maritalStatus = v),
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
                    child: SharedComponents.buildFormLabel('Weight(kg)'),
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
          child: SharedComponents.buildFormLabel('Occupation'),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _occupation,
          hint: '--Select--',
          items: DummyData.occupations,
          onChanged: (val) => setState(() {
            _occupation = val;
          }),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDonorContactInformation() {
    return CustomExpansionFrame(
      title: 'Donor Contact Information',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Address', isRequired: true),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            SharedComponents.buildTextField(
              controller: addressController,
              hintText: "Address",
              maxLines: 5,
              // height: 130,
            ),

          ],
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Country',isRequired: true),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _country,
          hint: '--Select--',
          items: ['--Select--', 'India'],
          onChanged: (val) => setState(() {
            _country = val;
          }),
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('State',isRequired: true),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _state,
          hint: '--Select--',
          items: ['--Select--', 'Uttar Pradesh'],
          onChanged: (val) => setState(() {
            _state = val;
          }),
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('City',),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _city,
          hint: '--Select--',
          items: ['--Select--', 'Prayagraj','Mirzapur'],
          onChanged: (val) => setState(() {
            _city = val;
          }),
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Pin Code'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Pin Code'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Mobile No.'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Mobile No.'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Identity Proof'),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _identity,
          hint: '--Select--',
          items: [
            '--Select--',
            'Aadhar'
                'PAN',
            'Voters Card',
          ],
          onChanged: (val) => setState(() {
            _identity = val;
          }),
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Identity No.'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Identity No.'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Issued Authority'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Issued Authority'),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPreviousBleedingDetails() {
    return CustomExpansionFrame(
      title: 'Previous Bleeding Details',
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      'Donated Blood Earlier ?',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,top: 10),
                    child: Row(
                      children: [
                        RadioButton<String>(
                          value: "Yes",
                          label: "Yes",
                          groupValue: typeRadio2,
                          onChanged: (v) => setState(() => typeRadio2 = v!),
                        ),
                        const SizedBox(width: 16), // Dono ke beech thoda gap
                        RadioButton<String>(
                          value: "No",
                          label: "No",
                          groupValue: typeRadio2,
                          onChanged: (v) => setState(() => typeRadio2 = v!),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Date'),
                  ),
                  const SizedBox(height: 8),
                  AppDateField(
                    hintText: "Select Date",
                    controller: dateOfDischargeController,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: toDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          toDate = pickedDate;
                          dateOfDischargeController.text = formatDate(
                            pickedDate,
                          );
                        });
                      }
                      ;
                    },
                  ),

                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      'Regular Voluntary Donor ?',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0,top: 10),
                    child: Row(
                      children: [
                        RadioButton<String>(
                          value: "Yes",
                          label: "Yes",
                          groupValue: typeRadio3,
                          onChanged: (v) => setState(() => typeRadio3 = v!),
                        ),
                        const SizedBox(width: 16), // Dono ke beech thoda gap
                        RadioButton<String>(
                          value: "No",
                          label: "No",
                          groupValue: typeRadio3,
                          onChanged: (v) => setState(() => typeRadio3 = v!),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('How Often ? '),
                  ),
                  const SizedBox(height: 8),
                  ExpandedDropdown(
                    value: _often,
                    items: [
                      '3 Months',
                      '6 Months',
                      '9 Months',
                      '1 Years',
                      '2 Years',
                    ],
                    onChanged: (val) => setState(() {
                      _often = val;
                    }),
                  ),

                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }


}
