import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/innner_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Core/Utils/scaffold_messenger.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/Login/login.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class OnlineRegistration extends StatefulWidget {
  OnlineRegistration({super.key});
  @override
  State<OnlineRegistration> createState() => _OnlineRegistrationState();
}

class _OnlineRegistrationState extends State<OnlineRegistration> {
  // --- Global Declaration Checkbox ---
  bool _action_a = true;
  bool _action_b = true;
  bool _action_c = true;

  // ================= DEMOGRAPHICS VARIABLES =================
  final dateOfDischargeController = TextEditingController();
  DateTime? toDate;

  final dobController = TextEditingController();
  DateTime? dobDate;

  String? _department;
  String? _prefix;
  String? _sex;
  String? _maritalStatus;
  String? _ageUnit;
  String? _religion;
  String? _relationShip;
  String? _relationShip2;
  String? _referringDepartment;
  String? _identity;


  String _addressType = 'Urban'; // Radio Button value (Urban / Rural)
  String typeRadio1 = "Urban";

  // Variables declare karein
  String? _country = '--Select--';
  String? _state = '--Select--';
  String? _city = '--Select--';

  // Dynamic lists jo UI me show hongi
  List<String> _availableStates = ['--Select--'];
  List<String> _availableCities = ['--Select--'];



  bool _sameAsPresentAddress = true; // Correspondence Checkbox

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  final _mobileCtrl = TextEditingController();
  final _mobileCtrl2 = TextEditingController();

  final _ageCtrl = TextEditingController();
  final _localityCtrl = TextEditingController();
  final _rlyStnCtrl = TextEditingController();
  final _emgNameCtrl = TextEditingController();
  final _refDoctorCtrl = TextEditingController();
  final _refHospitalCtrl = TextEditingController();

  final ExpansionTileController _demoController = ExpansionTileController();
  final ExpansionTileController _contactController = ExpansionTileController();
  final ExpansionTileController _emergencyController = ExpansionTileController();
  final ExpansionTileController _referralController = ExpansionTileController();
  final ExpansionTileController _identityController = ExpansionTileController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Online Registration',
          style: TextStyle(
            color: Colors.black,

            fontSize: 16,
          ),
        ),
        centerTitle: true,
        // Gradient background set karne ke liye flexibleSpace
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFC6F2D6), // Light Greenish
                Color(0xFFBCEBEB), // Light Bluish
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      // ================= BODY =================
      // Baad me aap apne ExpansionFrames yahan daal sakte hain
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:16.0),
        child: Column(
          children: [
            const SizedBox(height: 16,),
            Expanded(child: ListView(
              children: [
                _buildDemographicsSection(),
                _buildContactDetailsSection(),
                _buildEmergencyContact(),
                _buildReferralDetails(),
                _buildIdentity(),
              ],

            )),
            const SizedBox(height: 10,),

          ],
        ),
      ),

      // ================= BOTTOM SECTION =================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ye column ko shrink karke bottom me rakhega
          children: [
            GlobalCheckbox(
              crossAxisAlignment: CrossAxisAlignment.center,
              label: 'I Hereby declare that all the above information is correct and complete',
              value: _action_a,
              onChanged: (bool newValue) {
                setState(() {
                  _action_a = newValue;
                });
              },
            ),
            const SizedBox(height: 8),
            AppSaveButton(
              text: 'Register',
              onPressed: () {
                // Ye button dabte hi pehle validation check hoga.
                // Agar error hua, toh wahi ruk jayega aur alert dega.
                // Agar pass hua, toh aage bhej dega.
                _validateAndSubmit();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget _buildDemographicsSection() {
    return CustomExpansionFrame(
      controller: _demoController,
      title: 'Demographics',
      children: [
        SharedComponents.buildFormLabel('Reference No.'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Auto Generated',enabled: true,readOnly: true),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Date'),
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
          },
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Department', isRequired: true),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _department,
          hint: '--Select--',
          items: DummyData.department,
          onChanged: (val) => setState(() => _department = val),
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Prefix', isRequired: true),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _prefix,
          hint: '--Select--',
          items: DummyData.prefix,
          onChanged: (val) => setState(() => _prefix = val),
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('First Name'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Enter First Name'),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Middle Name'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Enter the Middle Name'),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Last Name'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Enter the Last Name'),
        const SizedBox(height: 16),



        SharedComponents.buildFormLabel('Sex', isRequired: true),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _sex,
          hint: '--Select--',
          items: DummyData.sex ?? ['Male', 'Female', 'Other'],
          onChanged: (val) => setState(() => _sex = val),
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Date of Birth', isRequired: true),
        const SizedBox(height: 8),
        AppDateField(
          controller: dobController,
          onTap: () async {
            DateTime? pickedDate = await CustomCalendarDialog.show(
              context,
              initialDate: dobDate ?? DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                dobDate = pickedDate;
                dobController.text = formatDate(pickedDate);
              });
            }
          },
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Marital Status'),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _maritalStatus,
          hint: '--Select--',
          items: DummyData.maritalStatus ?? ['Married', 'Unmarried'],
          onChanged: (val) => setState(() => _maritalStatus = val),
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Age', isRequired: true),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: SharedComponents.buildTextField(controller: _ageCtrl,hintText: 'Enter Age')),
            const SizedBox(width: 8),


            Expanded(
              child: ExpandedDropdown(
                value: _ageUnit,
                items: DummyData.ageUnits,
                onChanged: (v) => setState(() => _ageUnit = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Religion'),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _religion,
          hint: '--Select--',
          items: DummyData.religion ?? ['Christian', 'Hindu', 'Muslim', 'Other'],
          onChanged: (val) => setState(() => _religion = val),
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Occupation'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Enter Occupation'),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Mobile'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          controller: _mobileCtrl,
          hintText: '+91 Enter Mobile Number',
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(14),

          ],
          onChanged: (value) {
            if (value.isNotEmpty &&
                !value.startsWith("+91 ")) {
              _mobileCtrl.text =
                  "+91 " + value;
              _mobileCtrl.selection =
                  TextSelection.fromPosition(
                    TextPosition(
                        offset:
                        _mobileCtrl
                            .text.length),
                  );
            }
            if (value == "+91 ") {
              _mobileCtrl.clear();
            }



          },
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('E-mail'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Enter E-mail ID'),
        const SizedBox(height: 16),
      ],
    );
  }


  Widget _buildContactDetailsSection() {
    return CustomExpansionFrame(
      controller: _contactController,

      titleWidget: RichText(
        text: const TextSpan(
          text: 'Contact Details ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
              text: '*',
              style: TextStyle(
                color: Colors.red, // Asterisk ko red kar diya
              ),
            ),
          ],
        ),
      ),
      children: [
        SharedComponents.buildFormLabel('Address (Permanent)'),
        const SizedBox(height: 8),
        Row(
          children: [
            RadioButton<String>(
              value: "Urban",
              label: "Urban",
              groupValue: typeRadio1,
              onChanged: (v) => setState(() => typeRadio1 = v!),
            ),
            const SizedBox(width: 16), // Dono ke beech thoda gap
            RadioButton<String>(
              value: "Rural",
              label: "Rural",
              groupValue: typeRadio1,
              onChanged: (v) => setState(() => typeRadio1 = v!),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            GlobalCheckbox(
              crossAxisAlignment: CrossAxisAlignment.center,
              label: 'Active',
              value: _action_b,
              onChanged: (bool newValue) {
                setState(() {
                  _action_b = newValue;
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 16),


        // --- House No ---
        SharedComponents.buildFormLabel('House No'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Enter the House No'),
        const SizedBox(height: 16),

        // --- Street ---
        SharedComponents.buildFormLabel('Street'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Enter the Street'),
        const SizedBox(height: 16),

        // --- Locality ---
        SharedComponents.buildFormLabel('Locality', isRequired: true),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(controller: _localityCtrl,hintText: 'Enter the Locality'),
        const SizedBox(height: 16),

        // --- Country ---
        SharedComponents.buildFormLabel('Country', isRequired: true),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _country,
          hint: '--Select--',
          items: DummyData.countries1,
          onChanged: (val) {
            setState(() {
              _country = val;

              // Jaise hi country change ho, State aur City ko reset karein
              _state = '--Select--';
              _city = '--Select--';
              _availableCities = ['--Select--']; // City list bhi reset

              // Nayi state list fetch karein
              if (val != null && val != '--Select--') {
                _availableStates = DummyData.statesByCountry1[val] ?? ['--Select--'];
              } else {
                _availableStates = ['--Select--'];
              }
            });
          },
        ),
        const SizedBox(height: 16),

        // --- State ---
        SharedComponents.buildFormLabel('State', isRequired: true),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Agar country select nahi ki hai, to error message dikhayein
            if (_country == null || _country == '--Select--') {

              scaffoldMessenger(context, title: 'Contact Details',
                  message: 'Please select a Country first', type: NotificationType.error);
            }
          },
          child: AbsorbPointer(
            // Agar country select nahi hai, to dropdown ko absorb (block) kar do
            absorbing: _country == null || _country == '--Select--',
            child: FunctionalDropdown(
              value: _state,
              hint: '--Select--',
              items: _availableStates, // Dynamic list yaha pass karein
              onChanged: (val) {
                setState(() {
                  _state = val;

                  // Jaise hi state change ho, City ko reset karein
                  _city = '--Select--';

                  // Nayi city list fetch karein
                  if (val != null && val != '--Select--') {
                    _availableCities = DummyData.citiesByState1[val] ?? ['--Select--'];
                  } else {
                    _availableCities = ['--Select--'];
                  }
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 16),

        // --- City ---
        SharedComponents.buildFormLabel('City'),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Agar state select nahi ki hai, to error message dikhayein
            if (_state == null || _state == '--Select--') {
              scaffoldMessenger(context, title: 'Contact Details',
                  message: 'Please select a State first', type: NotificationType.error);
            }
          },
          child: AbsorbPointer(
            // Agar state select nahi hai, to dropdown ko absorb (block) kar do
            absorbing: _state == null || _state == '--Select--',
            child: FunctionalDropdown(
              value: _city,
              hint: '--Select--',
              items: _availableCities, // Dynamic list yaha pass karein
              onChanged: (val) {
                setState(() {
                  _city = val;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 16),

        // --- Pin ---
        SharedComponents.buildFormLabel('Pin'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Enter the Pin',keyboardType: TextInputType.number),
        const SizedBox(height: 16),

        // --- Phone ---
        SharedComponents.buildFormLabel('Phone'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: '+91 67577 78897',keyboardType: TextInputType.number),
        const SizedBox(height: 16),

        // --- Nearest Rly. Stn. ---
        SharedComponents.buildFormLabel('Nearest Rly. Stn.', isRequired: true),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(controller: _rlyStnCtrl,hintText: 'Enter the Nearest Rly. Stn'),
        const SizedBox(height: 24),

        // --- Address (Correspondence) Heading ---
        SharedComponents.buildFormLabel('Address (Correspondence)', ),

        const SizedBox(height: 8),

        // --- Same as Present Address Checkbox ---
        Row(
          children: [
            GlobalCheckbox(
              crossAxisAlignment: CrossAxisAlignment.center,
              label: 'Same as Present address',
              value: _sameAsPresentAddress,
              onChanged: (bool newValue) => setState(() => _sameAsPresentAddress = newValue),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildEmergencyContact() {
      return CustomExpansionFrame(
          controller: _emergencyController,
          title: 'Emergency Contact Details',
          children: [

        SharedComponents.buildFormLabel('Contact Person\'s Name',isRequired: true),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(controller: _emgNameCtrl,hintText: 'Enter the Contact Person\'s Name'),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Phone/Mobile',isRequired: true),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          controller: _mobileCtrl2,
            hintText: 'Enter the Phone/Mobile',
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(14),

          ],
          onChanged: (value) {
            if (value.isNotEmpty &&
                !value.startsWith("+91 ")) {
              _mobileCtrl2.text =
                  "+91 " + value;
              _mobileCtrl2.selection =
                  TextSelection.fromPosition(
                    TextPosition(
                        offset:
                        _mobileCtrl2
                            .text.length),
                  );
            }
            if (value == "+91 ") {
              _mobileCtrl2.clear();
            }



          },
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('RelationShip',isRequired: true),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _relationShip2,

          items: DummyData.relations,
          onChanged: (val) => setState(() => _relationShip2 = val),
        ),
        const SizedBox(height: 16),

      ]);
  }

  Widget _buildReferralDetails() {
    return CustomExpansionFrame(
        controller: _referralController,
        title: 'Referral Details',
        children: [

      SharedComponents.buildFormLabel('Referring Doctor',isRequired: true),
      const SizedBox(height: 8),
      SharedComponents.buildTextField(controller: _refDoctorCtrl,hintText: 'Enter the Referring Doctor'),
      const SizedBox(height: 16),

      SharedComponents.buildFormLabel('Referring Department',isRequired: true),
      const SizedBox(height: 8),
      FunctionalDropdown(
        value: _referringDepartment,

        items: DummyData.department,
        onChanged: (val) => setState(() => _referringDepartment = val),
      ),
      const SizedBox(height: 16),

      SharedComponents.buildFormLabel('Referring Hospital',isRequired: true),
      const SizedBox(height: 8),
      SharedComponents.buildTextField(controller: _refHospitalCtrl,hintText: 'Enter the Referring Hospital'),
      const SizedBox(height: 16),



    ]);
  }

  Widget _buildIdentity() {
    return CustomExpansionFrame(
        controller: _identityController,
        title: 'Identity Information', children: [


      SharedComponents.buildFormLabel('Identity Proof'),
      const SizedBox(height: 8),
      FunctionalDropdown(
        value: _identity,

        items: DummyData.identity,
        onChanged: (val) => setState(() => _identity = val),
      ),
      const SizedBox(height: 16),


      SharedComponents.buildFormLabel('Identity Card Number'),
      const SizedBox(height: 8),
      SharedComponents.buildTextField(hintText: 'Enter the Identity Card Number'),
      const SizedBox(height: 16),



      SharedComponents.buildFormLabel('Issue Authority'),
      const SizedBox(height: 8),
      SharedComponents.buildTextField(hintText: 'Enter the Issue Authority'),
      const SizedBox(height: 16),



    ]);
  }

  void _validateAndSubmit() {
    // 1. Terms & Conditions Check


    // 2. Demographics Mandatory Checks
    if (_department == null || _department == '--Select--') {
      _handleSectionError('Demographics','Please select Department'); return;
    }
    if (_prefix == null || _prefix == '--Select--') {
      _handleSectionError('Demographics','Please select Prefix'); return;
    }

    if (_sex == null || _sex == '--Select--') {
      _handleSectionError('Demographics','Please select Sex'); return;
    }
    if (dobController.text.isEmpty) {
      _handleSectionError('Demographics','Please select Date of Birth'); return;
    }
    if (_ageCtrl.text.isEmpty) {
      _handleSectionError('Demographics','Please enter Age'); return;
    }

    // 3. Contact Details Mandatory Checks
    if (_localityCtrl.text.isEmpty) {
      _handleSectionError('Contact Details','Please enter Locality'); return;
    }
    if (_country == null || _country == '--Select--') {
      _handleSectionError('Contact Details','Please select Country'); return;
    }
    if (_state == null || _state == '--Select--') {
      _handleSectionError('Contact Details','Please select State'); return;
    }
    if (_rlyStnCtrl.text.isEmpty) {
      _handleSectionError('Contact Details','Please enter Nearest Rly. Stn.'); return;
    }

    // 4. Emergency Contact Mandatory Checks
    if (_emgNameCtrl.text.isEmpty) {
      _handleSectionError('Emergency Contact Details','Please enter Emergency Contact Name'); return;
    }
    if (_mobileCtrl2.text.isEmpty) {
      _handleSectionError('Emergency Contact Details','Please enter Emergency Phone/Mobile'); return;
    }
    if (_relationShip2 == null || _relationShip2 == '--Select--') {
      _handleSectionError('Emergency Contact Details','Please select Emergency Relationship'); return;
    }

    // 5. Referral Details Mandatory Checks
    if (_refDoctorCtrl.text.isEmpty) {
      _handleSectionError('Referral Details','Please enter Referring Doctor'); return;
    }
    if (_referringDepartment == null || _referringDepartment == '--Select--') {
      _handleSectionError('Referral Details','Please select Referring Department'); return;
    }
    if (_refHospitalCtrl.text.isEmpty) {
      _handleSectionError('Referral Details','Please enter Referring Hospital'); return;
    }
    if (!_action_a) {
      _showError('Terms & Conditions','Please accept Terms & Conditions');
      return;
    }

    // ====== ALL SUCCESS ======
    // Agar yahan tak code aa gaya, iska matlab sab fill ho chuka hai.
    // Ab hum User ko sahi screen par bhejenge (Issue 3 fixed)

    // Yahan apni Dashboard ya Success Screen ka naam daalein
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen(loginby: '')),
    );



  }

  void _showError(String title,String message) {
    scaffoldMessenger(
      context,
      title: title,
      message: message,
      type: NotificationType.error,
    );
  }

  void _handleSectionError(String sectionName, String errorMessage) {
    // 1. Pehle saare sections ko band (collapse) kar do
    if (_demoController.isExpanded) _demoController.collapse();
    if (_contactController.isExpanded) _contactController.collapse();
    if (_emergencyController.isExpanded) _emergencyController.collapse();
    if (_referralController.isExpanded) _referralController.collapse();
    if (_identityController.isExpanded) _identityController.collapse();

    // 2. Jisme error aaya hai, sirf usko open (expand) karo
    if (sectionName == 'Demographics') {
      _demoController.expand();
    } else if (sectionName == 'Contact Details') {
      _contactController.expand();
    } else if (sectionName == 'Emergency Contact Details') {
      _emergencyController.expand();
    } else if (sectionName == 'Referral Details') {
      _referralController.expand();
    }

    // 3. Error Snackbar dikhao
    _showError(sectionName, errorMessage);
  }
}