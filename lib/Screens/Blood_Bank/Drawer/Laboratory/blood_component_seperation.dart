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
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/Drawer/Blood_Bank/bloodbank_drawer.dart';
import 'package:qc_hospital/Core/Utils/Drawer/drawer.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/innner_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
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

class BloodComponentSeperation extends StatefulWidget {
  BloodComponentSeperation({super.key});

  @override
  State<BloodComponentSeperation> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<BloodComponentSeperation> {

  String? selectedDropdownValue1 = null;

  final List<Map<String, dynamic>> componentsData = [
    {'name': 'Whole Blood', 'days': '35', 'expiry': '04-11-2025', 'isChecked': false},
    {'name': 'Leuco-poor Red Cells', 'days': '46', 'expiry': '04-11-2025', 'isChecked': false},
    {'name': 'Platelets', 'days': '20', 'expiry': '04-11-2025', 'isChecked': false},
    {'name': 'Cryoprecipitate', 'days': '40', 'expiry': '04-11-2025', 'isChecked': false},
    {'name': 'Packed Red Cells', 'days': '35', 'expiry': '04-11-2025', 'isChecked': false},
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BloodBankBaseScaffold(
      title: "Blood Component Seperation",

      showDrawer: true,
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Blood Component Seperation',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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

          const SizedBox(height: 8,),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Blood Bag No:',
                  style:  TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
                const TextSpan(
                  text: "2025091900001",
                  style: TextStyle(
                    color: Color(0xFF117A7A), // 🔵 Blue
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),

          _buildBagDetails(),
          const SizedBox(height: 16,),

          _buildListOfCompanies(context),
          const SizedBox(height: 16,),

          DetailTableWrapper(
              children: [
                 DetailRow(label: 'Blood Reg No.',text: '2025091900001',),
                DetailRow(label: 'Component Name',text: 'Whole Blood',),
                DetailRow(label: 'Expiry Date',text: '04-11-2025',),
                DetailRow(label: 'Store',customWidget: InnnerDropdown(
                  value: selectedDropdownValue1,
                  items: ['--Select--',"Elective", "Emergency", "Immediate"],
                  onChanged: (newValue) {
                    setState(() {
                      selectedDropdownValue1 = newValue;
                    });
                  },
                )),
                DetailRow(label: 'Bag Status',text: 'In Process',isLast: true,),
              ]
          ),
          const SizedBox(height: 16,),
          AppSaveButton(),
          const SizedBox(height: 16,),


        ],
      ),
      // bottomNavigationBar: BloodBankCollectionNavigationBar(index: 2,page: 2,onTap : _navigateToPage),

    );
  }

  Widget _buildBagDetails() {
    return CustomExpansionFrame(
        title: 'Bag Details',
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('Search')),
          const SizedBox(height: 8,),
          SharedComponents.buildTextField(hintText: 'Bag No',suffix: const Icon(Icons.search, color: Colors.black, size: 20)),
          const SizedBox(height: 16,), // Thoda space table ke upar

          // Niche diye gaye functions yahan call honge
          _buildBagTableAndPagination(),
          const SizedBox(height: 16,),
        ]
    );
  }

// Table aur Pagination ko banane wala main widget
  Widget _buildBagTableAndPagination() {
    // Dummy data jaisa aapki image me hai
    final List<Map<String, String>> bagData = [
      {'bagNo': '2025091900001', 'date': '04-11-2025'},
      {'bagNo': '2025091901456', 'date': '04-11-2025'},
      {'bagNo': '2025091906547', 'date': '04-11-2025'},
      {'bagNo': '20250919001466', 'date': '04-11-2025'},
      {'bagNo': '2025091900789', 'date': '04-11-2025'},
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300), // Table ka outer border
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            // --- TABLE ROW SECTION ---
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.grey.shade300),
                verticalInside: BorderSide(color: Colors.grey.shade300),
              ),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: [
                // Header Row (Light Teal Background)
                TableRow(
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEF7F7),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Bag Number', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade900)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Collection Date', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade900)),
                    ),
                  ],
                ),
                // Data Rows Generation
                ...bagData.map((data) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        data['bagNo']!,
                        style: const TextStyle(color: Color(0xFF2A8B8B), fontWeight: FontWeight.w500), // Teal text color
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        data['date']!,
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                )),
              ],
            ),

            // --- PAGINATION SECTION ---
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Right side align karne ke liye
                children: [
                  _buildPaginationArrow(Icons.chevron_left, isDisabled: true),
                  const SizedBox(width: 8),
                  _buildPageNumber('01', isActive: true),
                  const SizedBox(width: 8),
                  _buildPageNumber('02', isActive: false),
                  const SizedBox(width: 8),
                  _buildPaginationArrow(Icons.chevron_right, isDisabled: false),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// Page numbers (01, 02) design karne ka helper function
  Widget _buildPageNumber(String number, {required bool isActive}) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey.shade100 : Colors.transparent,
        border: isActive ? null : Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        number,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

// Arrows (Left, Right) design karne ka helper function
  Widget _buildPaginationArrow(IconData icon, {required bool isDisabled}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        icon,
        size: 20,
        color: isDisabled ? Colors.grey.shade400 : Colors.black87,
      ),
    );
  }

  // Dhyan de: Function me BuildContext pass kiya gaya hai taaki dialog open ho sake
  Widget _buildListOfCompanies(BuildContext context) {
    return CustomExpansionFrame(
        title: 'List of Components', // Image ke hisaab se title
        children: [
          _buildComponentsTableAndPagination(context),
          const SizedBox(height: 16,),
        ]
    );
  }

// Table aur Pagination banane ka function
  Widget _buildComponentsTableAndPagination(BuildContext context) {
    // Dummy data jaisa image me hai


    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            // --- TABLE SECTION ---
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.grey.shade300),
                verticalInside: BorderSide(color: Colors.grey.shade300),
              ),
              columnWidths: const {
                0: FlexColumnWidth(2.5), // Component Name column thoda bada hoga
                1: FlexColumnWidth(1.0), // Life Days chota
                2: FlexColumnWidth(1.5), // Expiry Date medium
              },
              children: [
                // Header Row
                TableRow(
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEF7F7),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Component Name', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade900)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Life\nDays', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade900)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('Expiry Date', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade900)),
                    ),
                  ],
                ),
                // Data Rows
                ...componentsData.map((data) => TableRow(
                  children: [
                    // 1. Component Name (Checkbox + Clickable Text)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                      child: Row(
                        children: [
                          // Checkbox Box UI (Jaise image me square box hai)
                          GlobalCheckbox(
                            label: '', // Label blank hai kyunki hum text par alag action chahte hain
                            value: data['isChecked'] ?? false,
                            onChanged: (bool newValue) {
                              setState(() {
                                print("$newValue");
                                data['isChecked'] = newValue; // Checkbox ka state update
                              });
                            },
                          ),
                          const SizedBox(width: 0),
                          // Clickable Text
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                _showAdmittedPatientDialog(context); // Dialog call hoga
                              },
                              child: Text(
                                data['name'],
                                style: const TextStyle(color: Colors.black87),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 2. Life Days (Clickable Text)
                    GestureDetector(
                      onTap: () {
                        _showAdmittedPatientDialog(context); // Dialog call hoga
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          data['days'],
                          style: const TextStyle(color: Colors.black87),
                        ),
                      ),
                    ),

                    // 3. Expiry Date (Non-clickable)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        data['expiry'],
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                )),
              ],
            ),

            // --- PAGINATION SECTION ---
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildPaginationArrow(Icons.chevron_left, isDisabled: true),
                  const SizedBox(width: 8),
                  _buildPageNumber('01', isActive: true),
                  const SizedBox(width: 8),
                  _buildPageNumber('02', isActive: false),
                  const SizedBox(width: 8),
                  _buildPaginationArrow(Icons.chevron_right, isDisabled: false),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }






  void _showAdmittedPatientDialog(BuildContext parentContext) {
    AppDialog.show(
      context: parentContext,
      title: "Patient Details",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: Column(
                children: [
                  DetailRow(label: "Bed", text: "General - 1"),
                  DetailRow(
                    label: "Patient Name",
                    customWidget: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Anil Srivastava',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          const TextSpan(
                            text: "M 45 Y",
                            style: TextStyle(
                              color: Color(0xFF117A7A), // 🔵 Blue
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DetailRow(label: "CRN Number", text: "2025000438"),
                  DetailRow(label: "HRF Type", text: "Medium"),
                  DetailRow(label: "DOA", text: "08-10-2025 | 15:30"),
                  DetailRow(label: "Consultant", text: "Satyendra Tiwari"),
                  DetailRow(label: "Patient Status", text: "Under IP Care"),

                  DetailRow(
                    isLast: true,
                    label: "Bal.Amount",
                    removePadding: true, // 🔥 important
                    customWidget: GestureDetector(
                      onTap: () async {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pop(); // ✅ sirf dialog close

                        await Future.delayed(const Duration(milliseconds: 100));

                        _showPendingRequestDialog(parentContext);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        color: Colors.yellow,
                        child: const Text(
                          "20,435.75",
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPendingRequestDialog(BuildContext parentContext) {
    AppDialog.show(
      context: parentContext,
      title: "Pending Requests",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: Column(
                children: [
                  DetailRow(label: "Requistion No.", text: "REQ5879641"),

                  DetailRow(label: "Date", text: "08-10-2025 | 15:30"),
                  DetailRow(label: "Req. By", text: "Doctor"),
                  DetailRow(label: "Amount", text: "5000.00"),

                  DetailRow(
                    isLast: true,
                    label: "Action",
                    removePadding: true, // 🔥 important
                    customWidget: Container(
                      width: double.infinity,
                      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 16),
                            child: const Icon(
                              Icons.print,
                              color: Colors.black87,
                              size: 20,
                            ),
                          ),


                          AppDeleteIcon(parentContext: parentContext,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SharedComponents.buildFormLabel("Collection Request"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: '0.0'),

          SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pop(), // ✅ sirf dialog close
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF117A7A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
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

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GlobalCheckboxGroup(
            items: const ['Override'],
            onSelectionChanged: (selectedList) {

              print("Selected Items: $selectedList");

            },
          ),
        ),
        const SizedBox(height: 16,)



      ],
    );
  }
}


