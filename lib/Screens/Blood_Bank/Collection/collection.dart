import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Main_Screen/mainscreen_radiobutton.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/Text/text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Core/Utils/heaading_filter.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Redonation/redonation.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class Collection extends StatefulWidget {
  final String regNo; // Use final for widget properties

  Collection({Key? key, this.regNo = '055'}) : super(key: key);

  @override
  State<Collection> createState() => CollectionState(); // Underscore hataya aur naam theek kiya
}

class CollectionState extends State<Collection> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final dateOfDischargeController = TextEditingController();
  final addressController = TextEditingController();
  String? _select1 = null;
  String? _relation = null;

  DateTime? toDate;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  String typeRadio1 = "Male";
  String typeRadio2 = "No";
  String typeRadio3 = "No";
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

  late String currentRegNo;

  @override
  void initState() {
    super.initState();
    currentRegNo = widget.regNo; // Initial value set karein
  }

  // Ye function naya data receive karega aur UI update karega
  void updateRegNo(String newRegNo) {
    setState(() {
      currentRegNo = newRegNo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BloodBankBaseScaffold(
      title: "Donor Registration",

      showDrawer: true,
      child: Column(
        children: [
          HeadingWithFilter(heading: "Donor Registration"),
          const SizedBox(height: 24),

          DonationCard(regNo: currentRegNo),
          SizedBox(height: height * 0.02),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Donor Type"),
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(left: height * 0.02, right: height * 0.02),
            child: MainscreenRadiobutton(
              items: const [
                "Autologous",
                "Replacement",
                "Directed",
                "Voluntary",
                "Camp",
              ],
              onChanged: (value) {
                debugPrint("Selected value: $value");
              },
              initialValue: 'Autologous',
            ),
          ),
          SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SharedComponents.buildFormLabel("CRN Number"),
              ),

              GestureDetector(
                onTap: () {
                  _showSearchDialog(context);
                },
                child: const Icon(Icons.search, color: Colors.black, size: 22),
              ),
            ],
          ),
          SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'CRN Number'),
          SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Patient Name"),
          ),
          SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: 'Patient Name',
            enabled: false,
          ),
          SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel(
              "Donation Type",
              isRequired: true,
            ),
          ),
          SizedBox(height: 8),
          FunctionalDropdown(
            value: _select1,
            hint: '--Select--',
            items: [
              '--Select--',
              "Granulocyte-Pheresis",
              "Plasma-Pheresis",
              "Platelet-Pheresis",
              "Stem-cell-Pheresis",
              "Whole Blood",
            ],
            onChanged: (val) {
              setState(() {
                _select1 = val;
              });
            },
          ),
          SizedBox(height: 16),

          _buildDonorDetails(),
          SizedBox(height: 16),

          _buildDonorContactInformation(),
          SizedBox(height: 16),

          _buildPreviousBleedingDetails(),
          SizedBox(height: 16),

          AppSaveButton(text: "Register Donor", onPressed: () {}),
          SizedBox(height: 16),

          AppSaveButton(text: "New Donor Registration", onPressed: () {}),
          SizedBox(height: 16),

          AppCancelButton(text: "Re-Print", onPressed: () {}),
          SizedBox(height: 40),
        ],
      ),

      // bottomNavigationBar: BloodBankCollectionNavigationBar(index: 2,page: 2,onTap : _navigateToPage),
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

  void _showSearchDialog(BuildContext parentContext) {
    AppDialog.show(
      context: parentContext,
      title: "Patient Search",
      child: StatefulBuilder(
        builder: (context, setSidebarState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SharedComponents.buildFormLabel('Search By'),
              ),
              const SizedBox(height: 8),

              ExpandedDropdown(
                value: _searchBy,
                items: ['--Select--', 'CR No.', 'Name'],
                onChanged: (v) => setSidebarState(() => _searchBy = v),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  GlobalCheckbox(
                    label:
                        '', // Label blank hai kyunki hum text par alag action chahte hain
                    value: _action_a ?? false,
                    onChanged: (bool newValue) {
                      setSidebarState(() {
                        _action_a = newValue; // Checkbox ka state update
                      });
                    },
                  ),
                  const SizedBox(width: 8),
                  SharedComponents.buildFormLabel('Check Result To Negative'),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: SharedComponents.buildFormLabel('Value'),
              ),
              const SizedBox(height: 8),
              SharedComponents.buildTextField(),
              const SizedBox(height: 16),

              ScrollableDataTable(
                labels: [
                  'CR No.',
                  'Patient Name',
                  'Age/Gender',
                  'Department',
                  'Add',
                ],
                rowValues: [
                  [
                    const TableText('2025000653'),
                    const TableText('2025000653'),
                    const TableText('2025000653'),
                    const TableText('2025000653'),
                  ],
                  [
                    const TableText('Ram Sharma'),
                    const TableText('Ram Sharma'),
                    const TableText('Ram Sharma'),
                    const TableText('Ram Sharma'),
                  ],
                  [
                    const TableText('25/Male'),
                    const TableText('25/Male'),
                    const TableText('25/Male'),
                    const TableText('25/Male'),
                  ],

                  [
                    const TableText('Cardiology'),
                    const TableText('Cardiology'),
                    const TableText('Cardiology'),
                    const TableText('Cardiology'),
                  ],
                  [
                    Icon(Icons.add_circle, color: Color(0xFF4CAF50)),
                    Icon(Icons.add_circle, color: Color(0xFF4CAF50)),
                    Icon(Icons.add_circle, color: Color(0xFF4CAF50)),
                    Icon(Icons.add_circle, color: Color(0xFF4CAF50)),
                  ],
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class DonationCard extends StatefulWidget {
  String? regNo;
  DonationCard({super.key, this.regNo = '055'});

  @override
  State<DonationCard> createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // "055" Box
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD5EFEE), // Light teal color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${widget.regNo}',
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

                GestureDetector(
                  onTap: () async {
                    final result =await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return Redonation();
                        },
                      ),
                    );

                    print("result : $result");
                    setState(() {
                        widget.regNo = result;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A), // Dark blackish color
                      borderRadius: BorderRadius.circular(30), // Pill shape
                    ),
                    child: Text(
                      'Redonation',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.height * 0.014,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
