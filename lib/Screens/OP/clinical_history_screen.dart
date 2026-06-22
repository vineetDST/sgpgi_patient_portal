import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';

// --- Make sure to adjust these imports to match your actual file structure ---
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/family_history_screen.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/immunization_history_screen.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/medication_history_screen.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/chief_complaints_screen.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class ClinicalHistoryScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ClinicalHistoryScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ClinicalHistoryScreen> createState() => _ClinicalHistoryScreenState();
}

class _ClinicalHistoryScreenState extends State<ClinicalHistoryScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _bottomNavIndex = 1;

  final TextEditingController _chiefComplaintsController = TextEditingController();
  final TextEditingController _historyController = TextEditingController();

  final TextEditingController _socialController = TextEditingController();
  final TextEditingController _pastController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Clinical History",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Clinical History',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 3. Clinical History Content
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Clinical History", // Updated Section Title
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // --- SHOW BOTTOM SHEET CODE ---
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled:
                        true, // Allows sheet to be taller than half screen
                    useRootNavigator: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => OpActionBottomSheet(
                      patientName: widget.patientName,
                      crn: widget.crn,
                    ),
                  );
                  // ------------------------------
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.color1E1E1E,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                ),
                child: Text(
                  'Action',
                  style: AppTextStyles.RegH3.copyWith(color: AppColor.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Form Fields
          _buildLabelWithIcon(
            "Chief Complaints",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChiefComplaintsScreen(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),

          SharedComponents.buildTextField(
            hintText: "Clinical Notes",
            maxLines: 5,
controller: _chiefComplaintsController,

          ),
          const SizedBox(height: 16),

          _buildLabel("History of Present Illness"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
              hintText: "History of Present Illness",
              maxLines: 5,
              controller: _historyController
          ),
          const SizedBox(height: 16),

          // Accordions / Navigation Tiles
          // _buildExpansionTile("Clinical History"),
          _buildClinicalHistoryExpandable(),
          const SizedBox(height: 10),

          // --- REPLACED: Custom Immunization History Expandable Widget ---
          _buildImmunizationHistoryExpandable(),
          const SizedBox(height: 10),

          // --- Custom Family History Expandable Widget ---
          _buildFamilyHistoryExpandable(),
          const SizedBox(height: 10),

          // --- REPLACED: Custom Medication History Expandable Widget ---
          _buildMedicationHistoryExpandable(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildLabelWithIcon(String text, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            Icons.double_arrow,
            size: 14,
            color: onTap != null ? const Color(0xFF117A7A) : Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  // --- REUSABLE CELL BUILDER FOR TABLES ---
  Widget _buildTableCell({
    required double width,
    Widget? child,
    String? text,
    bool isHeader = false,
    bool isLastRow = false,
  }) {
    const double cellHeight = 60.0;
    return Container(
      width: width,
      height: cellHeight,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isHeader ? const Color(0xFFF2FAF9) : Colors.white,
        border: Border(
          bottom: isLastRow
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child:
          child ??
          Text(
            text ?? "",
            style: TextStyle(
              fontSize: 14,
              fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
              color: Colors.black87,
            ),
          ),
    );
  }

  Widget _buildClinicalHistoryExpandable() {
    const double fixedColWidth = 150.0;
    const double dataColWidth = 180.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        shape: const Border(), // Expanded hone par line ko hide karega
        collapsedShape: const Border(),
        initiallyExpanded: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Clinical History",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildLabel("Social History"),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              children: [
                SharedComponents.buildTextField(
                  hintText: "Socail History",
                  maxLines: 5,

                  controller: _socialController
                ),

              ],
            ),
          ),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: _buildLabel("Past History"),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Stack(
              children: [
                SharedComponents.buildTextField(
                  hintText: "Past History",
                  maxLines: 5,
                  controller: _pastController
                ),
                // Positioned(
                //   bottom: 12,
                //   right: 12,
                //   child: Image.asset(
                //     'assets/txtarea.png', // Uses the uploaded icon
                //     width: 14,
                //     height: 14,
                //     color: Colors.grey.shade400,
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // --- Custom Immunization History Table ---
  Widget _buildImmunizationHistoryExpandable() {
    const double fixedColWidth = 150.0;
    const double dataColWidth = 180.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        shape: const Border(), // Expanded hone par line ko hide karega
        collapsedShape: const Border(),
        initiallyExpanded: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Immunization History",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.refresh, color: Color(0xFF117A7A), size: 20),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    // Yahan apni navigation lagayein
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImmunizationHistoryScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Fixed Left Column ---
                    Column(
                      children: [
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Immunization",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Status",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Age at\nImmunization(Yrs)",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Duration(Yrs)",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Date & Time",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Action",
                          isHeader: true,
                          isLastRow: true,
                        ),
                      ],
                    ),

                    // --- Scrollable Right Section ---
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // DATA COLUMN 1
                            Column(
                              children: [
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "Heptatitis A",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFA5F3B4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Given",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "62",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "1 Year",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "08-10-2025 | 13:20",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  isLastRow: true,

                                  // child: Row(
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 ImmunizationHistoryScreen(
                                  //                   patientName:
                                  //                       widget.patientName,
                                  //                   crn: widget.crn,
                                  //                 ),
                                  //           ),
                                  //         );
                                  //       },
                                  //       child: const Icon(
                                  //         Icons.edit_square,
                                  //         size: 22,
                                  //         color: Colors.black87,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 16),
                                  //     InkWell(
                                  //       onTap: () {}, // Delete Action
                                  //       child: const Icon(
                                  //         Icons.delete,
                                  //         size: 22,
                                  //         color: Color(0xFFD32F2F),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ImmunizationHistoryScreen(
                                                    patientName:
                                                        widget.patientName,
                                                    crn: widget.crn,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/editicon.png', // 👈 your image path
                                          height: 15,
                                          width: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      AppDeleteIcon(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // DATA COLUMN 2
                            Column(
                              children: [
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "Heptatitis A",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFA5F3B4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Given",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "62",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "1 Year",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "08-10-2025 | 10:50",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  isLastRow: true,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ImmunizationHistoryScreen(
                                                    patientName:
                                                        widget.patientName,
                                                    crn: widget.crn,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/editicon.png', // 👈 your image path
                                          height: 15,
                                          width: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      AppDeleteIcon(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Custom Family History Table ---
  Widget _buildFamilyHistoryExpandable() {
    const double fixedColWidth = 150.0;
    const double dataColWidth = 180.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        shape: const Border(), // Expanded hone par line ko hide karega
        collapsedShape: const Border(),
        initiallyExpanded: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Family History",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.refresh, color: Color(0xFF117A7A), size: 20),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    // Yahan apni navigation lagayein
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FamilyHistoryScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Fixed Left Column ---
                    Column(
                      children: [
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Relationship",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Survival Status",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Age(Yrs)",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Illness",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Duration(Yrs)",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Age at Death(Yrs)",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Cause of Death",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Date & Time",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Action",
                          isHeader: true,
                          isLastRow: true,
                        ),
                      ],
                    ),

                    // --- Scrollable Right Section ---
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // DATA COLUMN 1 (Father)
                            Column(
                              children: [
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "Father",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(
                                        0xFFA5F3B4,
                                      ), // Pill color matching UI
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Alive",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "62",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "Cancer",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "1 Year",
                                ),
                                _buildTableCell(width: dataColWidth, text: "-"),
                                _buildTableCell(width: dataColWidth, text: "-"),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "08-10-2025 | 13:20",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  isLastRow: true,

                                  // child: Row(
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () {
                                  //         // Action triggers current navigation
                                  //         Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 FamilyHistoryScreen(
                                  //                   patientName:
                                  //                       widget.patientName,
                                  //                   crn: widget.crn,
                                  //                 ),
                                  //           ),
                                  //         );
                                  //       },
                                  //       child: const Icon(
                                  //         Icons.edit_square,
                                  //         size: 22,
                                  //         color: Colors.black87,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 16),
                                  //     InkWell(
                                  //       onTap: () {}, // Delete Action
                                  //       child: const Icon(
                                  //         Icons.delete,
                                  //         size: 22,
                                  //         color: Color(0xFFD32F2F),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Action triggers current navigation
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FamilyHistoryScreen(
                                                    patientName:
                                                        widget.patientName,
                                                    crn: widget.crn,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/editicon.png', // 👈 your image path
                                          height: 15,
                                          width: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      AppDeleteIcon(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // DATA COLUMN 2 (Mother)
                            Column(
                              children: [
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "Mother",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFA5F3B4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Alive",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "62",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "Cancer",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "1 Year",
                                ),
                                _buildTableCell(width: dataColWidth, text: "-"),
                                _buildTableCell(width: dataColWidth, text: "-"),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "08-10-2025 | 17:20",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  isLastRow: true,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Action triggers current navigation
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FamilyHistoryScreen(
                                                    patientName:
                                                        widget.patientName,
                                                    crn: widget.crn,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/editicon.png', // 👈 your image path
                                          height: 15,
                                          width: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      AppDeleteIcon(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Custom Medication History Table ---
  Widget _buildMedicationHistoryExpandable() {
    const double fixedColWidth = 150.0;
    const double dataColWidth = 180.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        shape: const Border(), // Expanded hone par line ko hide karega
        collapsedShape: const Border(),
        initiallyExpanded: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Medication History",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.refresh, color: Color(0xFF117A7A), size: 20),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    // Yahan apni navigation lagayein
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicationHistoryScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Fixed Left Column ---
                    Column(
                      children: [
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Medication",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Dosages",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Frequency",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Status",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Duration",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Remarks",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Date & Time",
                          isHeader: true,
                        ),
                        _buildTableCell(
                          width: fixedColWidth,
                          text: "Action",
                          isHeader: true,
                          isLastRow: true,
                        ),
                      ],
                    ),

                    // --- Scrollable Right Section ---
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // DATA COLUMN 1
                            Column(
                              children: [
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "Diabetics",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "500 mg",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "Daily",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFA5F3B4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Active",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "1 Week",
                                ),
                                _buildTableCell(width: dataColWidth, text: "-"),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "08-10-2025 | 16:20",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  isLastRow: true,

                                  // child: Row(
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () {
                                  //         Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //             builder: (context) =>
                                  //                 MedicationHistoryScreen(
                                  //                   patientName:
                                  //                       widget.patientName,
                                  //                   crn: widget.crn,
                                  //                 ),
                                  //           ),
                                  //         );
                                  //       },
                                  //       child: const Icon(
                                  //         Icons.edit_square,
                                  //         size: 22,
                                  //         color: Colors.black87,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(width: 16),
                                  //     InkWell(
                                  //       onTap: () {}, // Delete Action
                                  //       child: const Icon(
                                  //         Icons.delete,
                                  //         size: 22,
                                  //         color: Color(0xFFD32F2F),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MedicationHistoryScreen(
                                                    patientName:
                                                        widget.patientName,
                                                    crn: widget.crn,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/editicon.png', // 👈 your image path
                                          height: 15,
                                          width: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(width: 12),

                                      // --- UPDATED: Wrapped in GestureDetector to trigger the modal ---
                                      NoPaddingCell(child: AppDeleteIcon()),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // DATA COLUMN 2
                            Column(
                              children: [
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "Diabetics",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "500 mg",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "Daily",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFA5F3B4),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Active",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "1 Week",
                                ),
                                _buildTableCell(width: dataColWidth, text: "-"),
                                _buildTableCell(
                                  width: dataColWidth,
                                  text: "08-10-2025 | 09:20",
                                ),
                                _buildTableCell(
                                  width: dataColWidth,
                                  isLastRow: true,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MedicationHistoryScreen(
                                                    patientName:
                                                        widget.patientName,
                                                    crn: widget.crn,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Image.asset(
                                          'assets/editicon.png', // 👈 your image path
                                          height: 15,
                                          width: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      AppDeleteIcon(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
