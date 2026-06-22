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
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/General/donor_search.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class DonorBloodBleedingDetails extends StatefulWidget {
  DonorBloodBleedingDetails({super.key});
  @override
  State<DonorBloodBleedingDetails> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<DonorBloodBleedingDetails> {
  String? _gender = "";
  String? _bloodBagType = null;
  String? _storeOfBloodBag = null;
  String? _lotNo = null;
  String? _collectionSite = 'PGI Lucknow';

  String? _collectionType = 'NA';
  String? _type = null;
  String? _timeOfOccurence = null;

  final dateOfDischargeController = TextEditingController();
  DateTime? toDate;
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  String? typeRadio3 = "Less than 10 min";
  String? typeRadio4 = "Yes";

  final TextEditingController _managementController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Donor Blood Bleeding Details",
      showDrawer: true,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Donor Blood Bleeding Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 16),
          DonationCard(),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Donor Reg.No"),
          ),
          SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'Donor Reg.No'),
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SharedComponents.buildFormLabel("Donor Name"),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return DonorSearch();
                      },
                    ),
                  );
                },
                child: const Icon(Icons.search, color: Colors.black, size: 22),
              ),
            ],
          ),
          SizedBox(height: 8),
          SharedComponents.buildTextField(),
          SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Donation Type"),
          ),
          SizedBox(height: 8),
          SharedComponents.buildTextField(),
          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel("Age"),
                    ),
                    SizedBox(height: 8),
                    SharedComponents.buildTextField(
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel("Gender"),
                    ),
                    SizedBox(height: 8),
                    ExpandedDropdown(
                      hint: '',
                      value: _gender,
                      items: ['--Select--', 'Male', 'Female', 'Others'],
                      onChanged: (v) => setState(() => _gender = v),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),

          _buildBleedingDetails(),
          SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Anesthesia Details"),
          ),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: GlobalCheckboxGroup(
              items: const ['Local Anesthesia Used'],
              onSelectionChanged: (selectedList) {
                print("Selected Items: $selectedList");
              },
            ),
          ),

          _buildSampleDetails(),
          SizedBox(height: 16),

          AppSaveButton(
            text: 'Save/Print',
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 16),

          AppCancelButton(
            text: 'Reprint',
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 16),

          AppCancelButton(
            text: 'New',
            onPressed: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBleedingDetails() {
    return CustomExpansionFrame(
      title: 'Bleeding Details',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Blood Bag No."),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(enabled: false),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Blood Bag Type"),
        ),
        SizedBox(height: 8),
        FunctionalDropdown(
          value: _bloodBagType,
          hint: '--Select--',
          items: [
            '--Select--',
            'BREAST SURGERY DRAPE SET (GAMMA IRRADIATED) (AMARYLIUS)',
            'Diclofenac Sodium (Volitra Plus Spray) Do Not Use',
          ],
          onChanged: (val) => setState(() {
            _bloodBagType = val;
          }),
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Store of Blood Bag"),
        ),
        SizedBox(height: 8),
        FunctionalDropdown(
          value: _storeOfBloodBag,
          hint: '--Select--',
          items: ['--Select--', 'Store Of Blood Bag 1', 'Store Of Blood Bag 2'],
          onChanged: (val) => setState(() {
            _storeOfBloodBag = val;
          }),
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Lot No."),
        ),
        SizedBox(height: 8),
        FunctionalDropdown(
          value: _lotNo,
          hint: '--Select--',
          items: ['--Select--', 'Lot 1', 'Lot 2'],
          onChanged: (val) => setState(() {
            _lotNo = val;
          }),
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Expiry Date"),
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

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Collection Site"),
        ),
        SizedBox(height: 8),
        FunctionalDropdown(
          value: _collectionSite,
          hint: '--Select--',
          items: ['--Select--', 'Collection 1', 'PGI Lucknow'],
          onChanged: (val) => setState(() {
            _collectionSite = val;
          }),
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            "Volume(ml)",
            isRequired: true,
          ),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            "Duration(min)",
            isRequired: true,
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: RadioButton<String>(
                  value: "Less than 10 min",
                  label: "Less than 10 min",
                  groupValue: typeRadio3,
                  onChanged: (v) => setState(() => typeRadio3 = v),
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              Expanded(
                child: RadioButton<String>(
                  value: "Greater than 10 min",
                  label: "Greater than 10 min",
                  groupValue: typeRadio3,
                  onChanged: (v) => setState(() => typeRadio3 = v),
                  textStyle: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Collection Type"),
        ),
        SizedBox(height: 8),
        FunctionalDropdown(
          value: _collectionType,
          hint: '--Select--',
          items: ['--Select--', 'NA'],
          onChanged: (val) => setState(() {
            _collectionType = val;
          }),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSampleDetails() {
    return CustomExpansionFrame(
      title: 'Sample Detials',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Sample ID"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(enabled: false),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("No. Of Container"),
        ),
        SizedBox(height: 8),
        FunctionalDropdown(
          value: _bloodBagType,
          hint: '--Select--',
          items: [
            '--Select--',
            'BREAST SURGERY DRAPE SET (GAMMA IRRADIATED) (AMARYLIUS)',
            'Diclofenac Sodium (Volitra Plus Spray) Do Not Use',
          ],
          onChanged: (val) => setState(() {
            _bloodBagType = val;
          }),
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Remarks"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: "Remarks",
          maxLines: 5,
            controller:  _remarksController
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Complications/Reactions"),
        ),

        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              RadioButton<String>(
                value: "Yes",
                label: "Yes",
                groupValue: typeRadio4,
                onChanged: (v) => setState(() => typeRadio4 = v),
              ),
              const SizedBox(width: 16), // Dono ke beech thoda gap
              RadioButton<String>(
                value: "No",
                label: "No",
                groupValue: typeRadio4,
                onChanged: (v) => setState(() => typeRadio4 = v),
              ),
            ],
          ),
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Type"),
        ),
        SizedBox(height: 8),
        FunctionalDropdown(
          value: _type,
          hint: '--Select--',
          items: ['Type 1', 'Type 2', 'Type 3'],
          onChanged: (val) => setState(() {
            _type = val;
          }),
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Time of Occurrence"),
        ),
        SizedBox(height: 8),
        FunctionalDropdown(
          value: _timeOfOccurence,
          hint: '--Select--',
          items: ['During Bleeding', 'After Bleeding', 'Outside Hospital'],
          onChanged: (val) => setState(() {
            _timeOfOccurence = val;
          }),
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Management"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: "Management",
          maxLines: 5,
          // height: 130,
          controller: _managementController
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Time of Relieving"),
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
      ],
    );
  }
}

class DonationCard extends StatelessWidget {
  const DonationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16), // Card ke rounded corners
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 5),
        ],
      ),
      child: Row(
        children: [
          // Left Side: Image
          Image.asset(
            "assets/profile_1.png",
            height: MediaQuery.of(context).size.height * 0.15,
          ),

          // Right Side: Content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD5EFEE), // Light teal color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.035,
                      fontWeight: FontWeight.bold,
                      color: AppColor.color1E1E1E.withOpacity(
                        0.2,
                      ), // Muted grey text color
                    ),
                  ),
                ),

                const SizedBox(height: 12), // Space between box and button
              ],
            ),
          ),
        ],
      ),
    );
  }
}
