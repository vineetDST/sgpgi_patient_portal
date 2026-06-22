import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Appbar/bloodbank_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
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
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/Text/text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Core/Utils/heaading_filter.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Camp/camp.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Collection/donor_details.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Donor/donor.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Home/home.dart';

import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/app_button.dart';

class DonorScreening extends StatefulWidget {
  DonorScreening({super.key});

  @override
  State<DonorScreening> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<DonorScreening> {

  final dateOfDischargeController = TextEditingController();

  DateTime? toDate;
  String? _gender = "--Select--";

  bool isOption1 = false;
  bool isOption2 = true;
  bool isOption3 = true;
  bool isOption4 = false;


  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }
  @override
  Widget build(BuildContext context) {

    return BloodBankBaseScaffold(
      title: "Donor Screening",
      showDrawer: true,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Donor Screening',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(height: 16,),
          DonationCard(),
          const SizedBox(height: 16,),
          
          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('Donor Reg No.')),
          const SizedBox(height: 8,),
          SharedComponents.buildTextField(hintText: 'Donor Reg No.'),
          const SizedBox(height: 16,),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('Donor Name')),
          const SizedBox(height: 8,),
          SharedComponents.buildTextField(enabled: false),
          const SizedBox(height: 16,),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('Donation Type')),
          const SizedBox(height: 8,),
          SharedComponents.buildTextField(enabled: false),
          const SizedBox(height: 16,),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('Donor Type')),
          const SizedBox(height: 8,),
          SharedComponents.buildTextField(enabled: false),
          const SizedBox(height: 16,),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SharedComponents.buildFormLabel('Age')),
                    const SizedBox(height: 8,),
                    SharedComponents.buildTextField(enabled: false),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SharedComponents.buildFormLabel('Mobile No.')),
                    const SizedBox(height: 8,),
                    SharedComponents.buildTextField(enabled: false),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
            ],
          ),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SharedComponents.buildFormLabel('Registration Date')),
                    const SizedBox(height: 8,),
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
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SharedComponents.buildFormLabel('Gender')),
                    const SizedBox(height: 8,),
                    ExpandedDropdown(
                        value: _gender,
                        items: ['--Select--','Male','Female','Others'],
                        onChanged: (v) => setState(() => _gender = v)
                    ),
                    const SizedBox(height: 16,),
                  ],
                ),
              ),
            ],
          ),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('Female Information')),
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlobalCheckboxGroup(
              items: const ['Menstrual', 'Pregnant', 'Lactating', 'Other'],
              onSelectionChanged: (selectedList) {

                print("Selected Items: $selectedList");

              },
            ),
          ),
          const SizedBox(height: 16,),

          _buildGeneralPhysicalInformation(),
          const SizedBox(height: 16,),

          _buildDrugInformation(),
          const SizedBox(height: 16,),
          _buildDiseaseInformation(),
          const SizedBox(height: 16,),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('Surgery')),
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlobalCheckboxGroup(
              items: const ['Major Surgery', 'Minor Surgery', 'Blood Trasfusion', 'Other History'],
              isTwoColumns: true, // Yahan TRUE pass karein
              onSelectionChanged: (selectedList) {
                print("Selected Items: $selectedList");
              },
            ),
          ),
          const SizedBox(height: 24,),

          AppSaveButton(text: 'Accept', onPressed: (){}),
          const SizedBox(height: 16,),

          AppCancelButton(text: 'Reject', onPressed: (){}),
          const SizedBox(height: 16,),

          AppCancelButton(text: 'Defer', onPressed: (){}),
          const SizedBox(height: 16,),

        ],
      ),


    );
  }

  Widget _buildGeneralPhysicalInformation() {
     return CustomExpansionFrame(
         title: 'General Physical Information',
         children: [
           Row(
             children: [
               Expanded(
                 child: Column(
                   children: [
                     Align(
                         alignment: Alignment.centerLeft,
                         child: SharedComponents.buildFormLabel('Weight')),
                     const SizedBox(height: 8,),
                     SharedComponents.buildTextField(
                       // suffix: const Padding(
                       //   padding: EdgeInsets.only(right: 10.0),
                       //   child: Column(
                       //     mainAxisAlignment: MainAxisAlignment.center,
                       //     mainAxisSize: MainAxisSize.min,
                       //     children: [
                       //       Text("Kg", style: TextStyle(color: Colors.black, fontSize: 14)),
                       //     ],
                       //   ),
                       // ),
                       
                       suffix: AppText.suffixText('kg')
                     ),
                     const SizedBox(height: 16,),
                   ],
                 ),
               ),
               const SizedBox(width: 16,),
               Expanded(
                 child: Column(
                   children: [
                     Align(
                         alignment: Alignment.centerLeft,
                         child: SharedComponents.buildFormLabel('Height')),
                     const SizedBox(height: 8,),
                     SharedComponents.buildTextField(suffix: AppText.suffixText('cms')),
                     const SizedBox(height: 16,),
                   ],
                 ),
               ),
             ],
           ),

           Align(
               alignment: Alignment.centerLeft,
               child: SharedComponents.buildFormLabel('Hb Pulse')),
           const SizedBox(height: 8,),
           SharedComponents.buildTextField(hintText: 'Hb Pulse'),
           const SizedBox(height: 16,),

           Align(
               alignment: Alignment.centerLeft,
               child: SharedComponents.buildFormLabel('Hb Method BP Systolic / Diastoic')),
           const SizedBox(height: 8,),
           SharedComponents.buildTextField(suffix: AppText.suffixText('mm/Hg')),
           const SizedBox(height: 16,),

           Align(
               alignment: Alignment.centerLeft,
               child: SharedComponents.buildFormLabel('Temperature')),
           const SizedBox(height: 8,),
           SharedComponents.buildTextField(suffix: AppText.suffixText('c')),
           const SizedBox(height: 16,),


         ]
     );
  }

  Widget _buildDrugInformation() {
    return CustomExpansionFrame(
        title: 'Drug Information',
        children: [

          GlobalCheckboxGroup(
            isTwoColumns: true,
            items: const [
              'Antibiotics',
              'Aspirin',
              'Alcohol',
              'Steriods',
              'Vacacinations',
              'Other Drugs',


            ],
            onSelectionChanged: (selectedList) {

              print("Selected Items: $selectedList");

            },
          ),
          const SizedBox(height: 14,),
          GlobalCheckboxGroup(

            items: const [

              'Ayurvedic/Homeopathic Medicine',

            ],
            onSelectionChanged: (selectedList) {

              print("Selected Items: $selectedList");

            },
          ),

          const SizedBox(height: 16,)

        ]
    );
  }

  Widget _buildDiseaseInformation() {
    return CustomExpansionFrame(
        title: 'Diseases Information',
        children: [

          GlobalCheckboxGroup(
            isTwoColumns: true,
            items: const [
              'Heart Disease',
              'Lung Disease',
              'Kidney Disease',
              'Cancer',
              'Epilepsy',
              'Diabetes',
              'Tuberculosis',
              'UnExplained Weight Loss',
              'Hypertension',
              'Abn. Bleeding Tendency',
              'Tattoo',
              'Sexually Transmitted Dis.',
              'Allergic Disease',
              'Jaundise/Hepatasis',
              'Malaria',
              'Other Disease',



            ],
            onSelectionChanged: (selectedList) {

              print("Selected Items: $selectedList");

            },
          ),
          const SizedBox(height: 16,)

        ]
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
                const SizedBox(height: 20,),
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
