// import 'package:flutter/material.dart';
// import 'package:qc_hospital/Core/Theme/app_color.dart';
// import 'package:qc_hospital/Core/Theme/app_text_style.dart';
// import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
// import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';

// // Make sure to import your shared components!
// import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

// class ChiefComplaintsScreen extends StatefulWidget {
//   final String patientName;
//   final String crn;

//   const ChiefComplaintsScreen({
//     super.key,
//     required this.patientName,
//     required this.crn,
//   });

//   @override
//   State<ChiefComplaintsScreen> createState() => _ChiefComplaintsScreenState();
// }

// class _ChiefComplaintsScreenState extends State<ChiefComplaintsScreen> {
//   int _bottomNavIndex = 1;

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       extendBody: true,
//       appBar: OpAppbar(title: "Chief Complaints", showDrawer: false),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFFD1F2F2), Colors.white, Colors.white],
//             stops: [0.0, 0.3, 1.0],
//           ),
//         ),
//         child: SafeArea(
//           top: false,
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height:
//                       MediaQuery.of(context).padding.top + kToolbarHeight + 10,
//                 ),

//                 // 1. Patient Card
//                 SharedComponents.buildPatientCard(
//                   screenWidth,
//                   widget.patientName,
//                   widget.crn,
//                 ),
//                 const SizedBox(height: 24),

//                 // 2. Quick Actions
//                 SharedComponents.buildQuickActions(screenWidth),
//                 const SizedBox(height: 24),

//                 // 3. Screen Title
//                 Text(
//                   "Chief Complaints Detail",
//                   style: AppTextStyles.RegH3.copyWith(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 16),

//                 // 4. Form Details
//                 SharedComponents.buildFormLabel(
//                   "Description",
//                   isRequired: true,
//                 ),
//                 const SizedBox(height: 8),
//                 // A larger text area for detailed complaints
//                 SharedComponents.buildTextField(
//                   hintText: "Enter detailed chief complaints here...",
//                   maxLines: 8,
//                   height: 150,
//                 ),
//                 const SizedBox(height: 16),

//                 SharedComponents.buildFormLabel("Duration"),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: SharedComponents.buildTextField(
//                         hintText: "E.g., 3",
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     Expanded(
//                       child: SharedComponents.buildDropdown(hintText: "Days"),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 32),

//                 // 5. Actions
//                 SharedComponents.buildActionButtons(context),
//                 const SizedBox(height: 20), // Bottom nav padding
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: CustomCurvedNavigationBar(
//         index: _bottomNavIndex,
//         height: 75.0,
//         items: const <Widget>[
//           Icon(Icons.home_filled, size: 26, color: Colors.white),
//           Icon(Icons.medical_services, size: 26, color: Colors.white),
//           Icon(Icons.add_business_outlined, size: 26, color: Colors.white),
//           Icon(Icons.notifications, size: 26, color: Colors.white),
//         ],
//         color: AppColor.white,
//         buttonBackgroundColor: AppColor.color117A7A,
//         backgroundColor: Colors.transparent,
//         onTap: (index) => setState(() => _bottomNavIndex = index),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class ChiefComplaintsScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ChiefComplaintsScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ChiefComplaintsScreen> createState() => _ChiefComplaintsScreenState();
}

class _ChiefComplaintsScreenState extends State<ChiefComplaintsScreen> {
  int _bottomNavIndex = 1;
  String _filterType = 'All';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Chief Complaints",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Chief Complaints',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 3. Screen Title
          Text(
            "Chief Complaints",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // 4. Filters (Radios & Dropdown)
          Row(
            children: [
              _buildRadio("All"),
              const SizedBox(width: 8),
              _buildRadio("Department"),
              const SizedBox(width: 8),
              _buildRadio("Consultant"),
            ],
          ),
          const SizedBox(height: 12),
          SharedComponents.buildDropdown(hintText: "--Select--"),
          const SizedBox(height: 16),

          // 5. Search Bar
          SharedComponents.buildFormLabel("Search"),
          const SizedBox(height: 8),
          _buildSearchField(),
          const SizedBox(height: 16),

          // 6. Data Table
          // _buildChiefComplaintsTable(),

          MedicalComplaintsTable(),
          const SizedBox(height: 32),

          // 7. Actions (Save/Cancel)
          SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20), // Bottom nav padding
        ],
      ),


    );
  }

  // --- UI Builder Methods for this Screen ---

  Widget _buildRadio(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Radio<String>(
            value: value,
            groupValue: _filterType,
            activeColor: const Color(0xFF117A7A),
            onChanged: (val) => setState(() => _filterType = val!),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search by Chief Complaints",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          suffixIcon: const Icon(Icons.search, color: Colors.grey, size: 20),
        ),
      ),
    );
  }

  Widget _buildChiefComplaintsTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Table(
          border: TableBorder.symmetric(
            inside: BorderSide(color: Colors.grey.shade300),
          ),
          columnWidths: const {
            0: FlexColumnWidth(1.1),
            1: FlexColumnWidth(1.2),
          },
          children: [
            _buildTableHeader(),
            _buildTableRow("Ulcer Foot"),
            _buildTableRow("Hematoma of Brain"),
            _buildTableRow("Progressive spastic quadriparesis"),
            _buildTableRow("Back pain with lower limb radiation"),
            _buildTableRow("Mild Fever"),
            _buildTableRow("Swelling of legs"),
            _buildPaginationRow(),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: const BoxDecoration(color: Color(0xFFEAF9F9)),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Text(
            "Chief Complaints",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Text(
            "Duration",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  TableRow _buildTableRow(String complaint) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Text(
            complaint,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              // Checkbox Outline
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              // Number Input
              Container(
                width: 45,
                height: 32,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                      bottom: 14,
                    ), // Align text vertically
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Days Dropdown
              Expanded(
                child: Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Days",
                        style: TextStyle(fontSize: 11, color: Colors.black87),
                      ),
                      Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  TableRow _buildPaginationRow() {
    return TableRow(
      children: [
        Container(), // Empty left cell
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.chevron_left, size: 20, color: Colors.black54),
              const SizedBox(width: 16),
              // Active Page Indicator
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "01",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
              const SizedBox(width: 16),
              // Inactive Page
              const Text(
                "02",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.chevron_right, size: 20, color: Colors.black54),
            ],
          ),
        ),
      ],
    );
  }
}




class MedicalComplaintsTable extends StatefulWidget {
  const MedicalComplaintsTable({Key? key}) : super(key: key);

  @override
  _MedicalComplaintsTableState createState() => _MedicalComplaintsTableState();
}

// Data Model jisme optional values default selection handle karti hain
class ComplaintModel {
  final String name;
  bool isSelected;
  String? durationValue;
  String? durationUnit;

  ComplaintModel({
    required this.name,
    this.isSelected = false,
    this.durationValue,
    this.durationUnit, // Agar null pass hoga to dropdown me by default kuch select nahi hoga
  });
}

class _MedicalComplaintsTableState extends State<MedicalComplaintsTable> {
  late List<ComplaintModel> complaints;
  Map<int, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    // Yahan par hum default data setup kar rahe hain.
    // Agar aap durationUnit pass karenge to wo default select ho jayega, warna null rahega.
    complaints = [
      ComplaintModel(name: 'Ulcer Foot', durationUnit: 'Days'),
      ComplaintModel(name: 'Hematoma of Brain', durationUnit: 'Days'),
      ComplaintModel(name: 'Progressive spastic quadriparesis', durationUnit: 'Days'),
      ComplaintModel(name: 'Back pain with lower limb radiation', durationUnit: 'Days'),
      ComplaintModel(name: 'Mild Fever', durationUnit: 'Days'),
      ComplaintModel(name: 'Swelling of legs', durationUnit: 'Days'),
    ];

    for (int i = 0; i < complaints.length; i++) {
      _controllers[i] = TextEditingController(text: complaints[i].durationValue ?? '');
    }
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeaderRow(),
              ...List.generate(complaints.length, (index) => _buildDataRow(index)),
              _buildPaginationFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEAF9F9), // Light greenish-blue tint
        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: IntrinsicHeight(
        child: Row(

          children: [
            Container(
              width: 130,
              decoration: BoxDecoration(
                // Ye rahi wo middle wali line
                border: Border(
                  right: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
              child: const Text(
                'Chief Complaints',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
            const Expanded(

              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Duration',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(int index) {
    final complaint = complaints[index];
    // Alternate row coloring (Left side is tinted, right side is white)
    bool isEven = index % 2 == 0;
    Color leftBgColor = isEven ? const Color(0xFFF4FAFA) : const Color(0xFFF9FCFC);

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: IntrinsicHeight(
        child: Row(

          children: [
            // Left Column
            Container(
              width: 130,

              decoration: BoxDecoration(
                color: Color(0xFFEAF9F9),
                border: Border(
                  right: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              alignment: Alignment.centerLeft,
              child: Text(
                complaint.name,
                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ),
            // Right Column
            Expanded(

              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                child: Row(
                  children: [


                    GlobalCheckbox(
                      label: '',
                      value: complaint.isSelected,
                      onChanged: (bool _selected) {
                        setState(() {
                          complaint.isSelected = _selected ?? false;
                        });

                      },
                    ),

                    // Text Input Field
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 30,
                        child: TextField(
                          controller: _controllers[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (val) {
                            complaint.durationValue = val;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Dropdown Field
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: complaint.durationUnit,
                            hint: const Text('Select', style: TextStyle(color: Colors.grey)),
                            icon: Icon(Icons.arrow_drop_down, color: Colors.grey.shade700),
                            items: ['Days', 'Months', 'Years'].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value, style: const TextStyle(fontSize: 14)),
                              );
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                complaint.durationUnit = val;
                              });
                            },
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
      ),
    );
  }

  Widget _buildPaginationFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Container(
            width: 130,

            decoration: BoxDecoration(

              border: Border(
                right: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),


          ),
          _buildPaginationButton(Icons.chevron_left),
          const SizedBox(width: 12),
          _buildPageNumber('01', isSelected: true),
          const SizedBox(width: 8),
          _buildPageNumber('02'),
          const SizedBox(width: 12),
          _buildPaginationButton(Icons.chevron_right),
        ],
      ),
    );
  }

  Widget _buildPaginationButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(icon, size: 20, color: Colors.indigo.shade900),
    );
  }

  Widget _buildPageNumber(String number, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade200 : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        number,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: Colors.black87,
        ),
      ),
    );
  }
}
