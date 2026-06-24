import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';

// --- Imports for the Systemic Detail Screens (Nervous System, etc.) ---
import 'package:qc_hospital/Screens/OP/examinations/systemic_detail_screens.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_list_screen.dart';

class EmrExaminationScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  final String? mode;

  const EmrExaminationScreen({
    super.key,
    required this.patientName,
    required this.crn,
    this.mode = "op",
  });

  @override
  State<EmrExaminationScreen> createState() => _EmrExaminationScreenState();
}

class _EmrExaminationScreenState extends State<EmrExaminationScreen> {
  String? genApp;
  String? nutStatus;
  String? ent;
  String? pallor;
  String? jaundice;
  String? cyanosis;
  String? clubbing;
  String? jvp;
  String? edema;
  String? lymphNode;

  // Controllers for the Text Fields in Physical Examination table (physical.png)
  final TextEditingController _genAppRemController = TextEditingController();
  final TextEditingController _nutStatusRemController = TextEditingController();
  final TextEditingController _entRemController = TextEditingController();
  final TextEditingController _pallorRemController = TextEditingController();
  final TextEditingController _jaundiceRemController = TextEditingController();
  final TextEditingController _cyanosisRemController = TextEditingController();
  final TextEditingController _clubbingRemController = TextEditingController();
  final TextEditingController _jvpRemController = TextEditingController();
  final TextEditingController _edemaRemController = TextEditingController();
  final TextEditingController _lymphNodeRemController = TextEditingController();

  // --- 2. Local Examination States (local.png) ---
  // Controllers for the Text Fields in Local Examination table
  final TextEditingController _skinExamController = TextEditingController();
  final TextEditingController _visionController = TextEditingController();
  final TextEditingController _entLocalController = TextEditingController();
  final TextEditingController _breastsController = TextEditingController();
  final TextEditingController _axillaController = TextEditingController();
  final TextEditingController _thyroidController = TextEditingController();
  final TextEditingController _spineController = TextEditingController();
  final TextEditingController _ribCageController = TextEditingController();

  final TextEditingController _remarksController = TextEditingController();
  @override
  void dispose() {
    // Dispose Physical Exam Controllers
    _genAppRemController.dispose();
    _nutStatusRemController.dispose();
    _entRemController.dispose();
    _pallorRemController.dispose();
    _jaundiceRemController.dispose();
    _cyanosisRemController.dispose();
    _clubbingRemController.dispose();
    _jvpRemController.dispose();
    _edemaRemController.dispose();
    _lymphNodeRemController.dispose();

    // Dispose Local Exam Controllers
    _skinExamController.dispose();
    _visionController.dispose();
    _entLocalController.dispose();
    _breastsController.dispose();
    _axillaController.dispose();
    _thyroidController.dispose();
    _spineController.dispose();
    _ribCageController.dispose();

    _remarksController.dispose();
    super.dispose();
  }

  int _bottomNavIndex = 1;
  int _activeTabIndex = 0; // 0: General Examination, 1: Systemic Examination

  // Mock data for the read-only report state
  final Map<String, String?> _physicalExamState = {
    "General Appearance": "Normal",
    "Nutritional Status": "Good",
    "ENT/Oral Cravity": "0",
  };
  final Map<String, bool> _systemicNadState = {
    "Nervous System": true,
    "Respiratory System": false,
  };

  final List<String> systemicColumns = [
    "Nervous System",
    "Respiratory System",
    "Circulatory System",
    "Digestive System",
    "Endocrine System",
    "Immune System",
    "Muscloskeletel System",
    "Urinary / Reproductive System",
    "Eye",
  ];
  final Map<String, String> _localExamFindings = {
    "Skin Examination": "No",
    "Vision": "No",
    "ENT/Oral Cravity": "No",
    "Breasts": "No",
    "Axilla": "No",
    "Thyroid": "No",
    "Spine": "No",
    "Rib Cage": "No",
  };

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Examination",
              style: AppTextStyles.RegH3.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                _buildBlackButton(
                  "List",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmrListScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                          mode: widget.mode,
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                // const SizedBox(width: 8),
                // widget.mode == "op"
                //     ? _buildBlackButton(
                //         "Action",
                //         onTap: () {
                //           showModalBottomSheet(
                //             context: context,
                //             isScrollControlled: true,
                //             useRootNavigator: true,
                //             backgroundColor: Colors.transparent,
                //             builder: (context) => OpActionBottomSheet(
                //               patientName: widget.patientName,
                //               crn: widget.crn,
                //             ),
                //           );
                //         },
                //       )
                //     : IPActionButton(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Custom Tabs
        _buildTabs(),
        const SizedBox(height: 24),

        // Switch Tab Content
        _activeTabIndex == 0
            ? _buildGeneralExaminationTab()
            : _buildSystemicExaminationTab(),

        const SizedBox(height: 20),
      ],
    );
    if (widget.mode == "ip") {
      return IpBaseScaffold(
        title: "EMR",
        quickActionLabel: "EMR",
        showDrawer: false,
        patientName: widget.patientName,
        crn: widget.crn,
        activeQuickAction: true,
        child: content,
      );
    } else {
      return ClinicalBaseScaffold(
        title: "EMR",
        showDrawer: false,
        patientName: widget.patientName,
        crn: widget.crn,
        activeQuickAction: 'EMR',
        child: content,
      );
    }
  }

  Widget _buildBlackButton(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          _buildTabItem("General Examination", 0),
          _buildTabItem("Systemic Examination", 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isActive = _activeTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTabIndex = index),
      child: Container(
        padding: const EdgeInsets.only(bottom: 12, right: 16, left: 8),
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
                  bottom: BorderSide(color: Color(0xFF117A7A), width: 2),
                )
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? const Color(0xFF117A7A) : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // TAB 1: GENERAL EXAMINATION (READ-ONLY)
  // =========================================================================
  Widget _buildGeneralExaminationTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Physical Examination Section
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: true,
              title: const Text(
                "Physical Examination",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              children: [_buildPhysicalExamTable()],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Local Examination Section
        _buildLocalExamTable(),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel("Remarks"),
        const SizedBox(height: 8),

        // Wrapped in IgnorePointer to make it uneditable
        SharedComponents.buildTextField(
          hintText: "Remarks",
          maxLines: 5,
          controller: _remarksController,
        ),

        // Buttons removed!
      ],
    );
  }

  // =========================================================================
  // 1. PHYSICAL EXAMINATION TABLE (Constraint 1 & physical.png)
  // =========================================================================
  Widget _buildPhysicalExamTable() {
    const double rowHeight = 64.0;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT FIXED COLUMN
        Container(
          width: 150,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF9F9),
            border: Border(
              right: BorderSide(color: Colors.grey.shade300),
              top: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLeftCell("General\nAppearance", rowHeight),
              _buildLeftCell("Nutritional Status", rowHeight),
              _buildLeftCell("ENT/Oral Cravity", rowHeight),
              _buildLeftCell("Pallor", rowHeight),
              _buildLeftCell("Jaundice", rowHeight),
              _buildLeftCell("Cyanosis", rowHeight),
              _buildLeftCell("Clubbing", rowHeight),
              _buildLeftCell("JVP", rowHeight),
              _buildLeftCell("Edema", rowHeight),
              _buildLeftCell("Lymph Node", rowHeight, isLast: true),
            ],
          ),
        ),

        // RIGHT SCROLLABLE COLUMN
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPhysicalRightCell(
                    ["Normal", "Abnormal"],
                    genApp,
                    (val) => setState(() => genApp = val),
                    rowHeight,
                    _genAppRemController,
                  ),
                  _buildPhysicalRightCell(
                    ["Good", "Adequate", "Reduced"],
                    nutStatus,
                    (val) => setState(() => nutStatus = val),
                    rowHeight,
                    _nutStatusRemController,
                  ),
                  _buildPhysicalRightCell(
                    ["0", "+", "++", "+++"],
                    ent,
                    (val) => setState(() => ent = val),
                    rowHeight,
                    _entRemController,
                  ),
                  _buildPhysicalRightCell(
                    ["No", "Yes"],
                    pallor,
                    (val) => setState(() => pallor = val),
                    rowHeight,
                    _pallorRemController,
                  ),
                  _buildPhysicalRightCell(
                    ["No", "Yes"],
                    jaundice,
                    (val) => setState(() => jaundice = val),
                    rowHeight,
                    _jaundiceRemController,
                  ),
                  _buildPhysicalRightCell(
                    ["No", "Yes"],
                    cyanosis,
                    (val) => setState(() => cyanosis = val),
                    rowHeight,
                    _cyanosisRemController,
                  ),
                  _buildPhysicalRightCell(
                    ["No", "Yes"],
                    clubbing,
                    (val) => setState(() => clubbing = val),
                    rowHeight,
                    _clubbingRemController,
                  ),
                  _buildPhysicalRightCell(
                    ["No", "Yes"],
                    jvp,
                    (val) => setState(() => jvp = val),
                    rowHeight,
                    _jvpRemController,
                  ),
                  _buildPhysicalRightCell(
                    ["No", "Yes"],
                    edema,
                    (val) => setState(() => edema = val),
                    rowHeight,
                    _edemaRemController,
                  ),
                  _buildPhysicalRightCell(
                    ["No", "Yes"],
                    lymphNode,
                    (val) => setState(() => lymphNode = val),
                    rowHeight,
                    _lymphNodeRemController,
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // 2. LOCAL EXAMINATION TABLE (Constraint 2 & local.png)
  // =========================================================================
  Widget _buildLocalExamTable() {
    return CustomExpansionFrame(
      title: 'Local Examinaton',
      children: [
        DetailTableWrapper(
          children: [
            DetailRow(
              label: 'Skip Examination',
              customWidget: SharedComponents.buildTextField(
                controller: TextEditingController(text: 'No'),
                isDense: true,
              ),
            ),
            DetailRow(
              label: 'Vision',
              customWidget: SharedComponents.buildTextField(
                controller: TextEditingController(text: 'No'),
                isDense: true,
              ),
            ),
            DetailRow(
              label: 'ENT/Oral Cravity',
              customWidget: SharedComponents.buildTextField(
                controller: TextEditingController(text: 'No'),
                isDense: true,
              ),
            ),
            DetailRow(
              label: 'Breats',
              customWidget: SharedComponents.buildTextField(
                controller: TextEditingController(text: 'No'),
                isDense: true,
              ),
            ),
            DetailRow(
              label: 'Axilla',
              customWidget: SharedComponents.buildTextField(
                controller: TextEditingController(text: 'No'),
                isDense: true,
              ),
            ),
            DetailRow(
              label: 'Thyroid',
              customWidget: SharedComponents.buildTextField(
                controller: TextEditingController(text: 'No'),
                isDense: true,
              ),
            ),
            DetailRow(
              label: 'Spin',
              customWidget: SharedComponents.buildTextField(
                controller: TextEditingController(text: 'No'),
                isDense: true,
              ),
            ),
            DetailRow(
              label: 'Rip Cage',
              isLast: true,
              customWidget: SharedComponents.buildTextField(
                controller: TextEditingController(text: 'No'),
                isDense: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // =========================================================================
  // HELPER BUILDERS
  // =========================================================================

  // Fixed Left Column Cell (Light Cyan)
  Widget _buildLeftCell(String label, double height, {bool isLast = false}) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Right Row for Physical Exam (Radios + Textbox)
  Widget _buildPhysicalRightCell(
    List<String> options,
    String? groupValue,
    Function(String?) onChanged,
    double height,
    TextEditingController controller, {
    bool isLast = false,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Fixed width for radios so the text boxes all align perfectly vertically
          SizedBox(
            width: 320,
            child: Row(
              children: options.map((option) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: option,
                      groupValue: groupValue,
                      activeColor: const Color(0xFF117A7A),
                      visualDensity: VisualDensity.compact,
                      onChanged: onChanged,
                    ),
                    Text(
                      option,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                );
              }).toList(),
            ),
          ),
          VerticalDivider(width: 24, thickness: 1, color: Colors.grey.shade300),
          // Input Box matching the design
          Container(
            width: 320,
            height: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Right Row for Local Exam (Only Textbox)
  Widget _buildLocalRightCell(
    double height,
    TextEditingController controller, {
    bool isLast = false,
  }) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Container(
        width:
            640, // Matches the total width of the Physical exam elements to align neatly
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: TextField(
          controller: controller,
          style: const TextStyle(fontSize: 13),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // TAB 2: SYSTEMIC EXAMINATION (READ-ONLY)
  // =========================================================================
  Widget _buildSystemicExaminationTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Fixed Labels (Inverted Table Layout)
              Container(
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFEAF9F9),
                  border: Border(
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
                child: Column(
                  children: [
                    _buildLeftCell("Systems", 65),
                    _buildDivider(),
                    _buildLeftCell("NAD", 65),
                    _buildDivider(),
                    _buildLeftCell("Findings", 65),
                    _buildDivider(),
                    _buildLeftCell("Full Examination", 65),
                  ],
                ),
              ),
              // Right Scrollable System Columns
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: IntrinsicWidth(
                    child: Row(
                      // 1. .map() ki jagah List.generate ka use kiya index-based tracking ke liye
                      children: List.generate(systemicColumns.length, (index) {
                        final sys = systemicColumns[index];
                        bool isLast = index == systemicColumns.length - 1;

                        // 2. IntrinsicHeight lagane se divider line ko poori height mil jayegi
                        return IntrinsicHeight(
                          child: Row(
                            children: [
                              _buildSystemicCol(sys, 65),

                              // 3. Agar last item nahi hai toh proper VerticalDivider dikhao
                              if (!isLast)
                                VerticalDivider(
                                  width: 1, // Line ka padding area
                                  thickness: 1, // Line ki motai
                                  color: Colors.grey.shade300, // Line ka color
                                ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSystemicCol(String sys, double height) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Container(
            height: height,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              sys,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
          _buildDivider(),
          Container(
            height: height,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: _systemicNadState[sys] ?? false,
                activeColor: const Color(0xFF117A7A),
                onChanged: (value) {
                  setState(() {
                    _systemicNadState[sys] = value ?? false;
                  });
                },
              ),
            ),
          ),
          _buildDivider(),
          _buildModalTriggerCell(
            height,
            fieldKey: '',
          ), // Findings opens read-only modal
          _buildDivider(),
          InkWell(
            onTap: () {
              Widget nextScreen;
              if (sys == "Nervous System")
                nextScreen = NervousSystemScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                );
              else if (sys == "Respiratory System")
                nextScreen = RespiratorySystemScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                );
              else if (sys == "Circulatory System")
                nextScreen = CirculatorySystemScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                );
              else if (sys == "Digestive System")
                nextScreen = DigestiveSystemScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                );
              else if (sys == "Endocrine System")
                nextScreen = EndocrineSystemScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                );
              else if (sys == "Immune System")
                nextScreen = ImmuneSystemScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                );
              else if (sys == "Muscloskeletel System")
                nextScreen = MusculoskeletalSystemScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                );
              else if (sys == "Urinary / Reproductive System")
                nextScreen = ReproductiveSystemScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                );
              else if (sys == "Eye")
                nextScreen = EyeSystemScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                );
              else
                nextScreen = NervousSystemScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                );

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextScreen),
              );
            },
            child: Container(
              height: height,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "Details",
                style: TextStyle(
                  color: Color(0xFF117A7A),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // COMMON HELPER WIDGETS
  // =========================================================================

  // Widget _buildLeftCell(String text, double height) => Container(
  //   height: height,
  //   alignment: Alignment.centerLeft,
  //   padding: const EdgeInsets.symmetric(horizontal: 12),
  //   child: Text(
  //     text,
  //     style: const TextStyle(
  //       fontWeight: FontWeight.bold,
  //       fontSize: 13,
  //       color: Colors.black87,
  //     ),
  //   ),
  // );
  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  // The input field that acts like a button to open the bottom sheet modal
  Widget _buildModalTriggerCell(double height, {required String fieldKey}) {
    return GestureDetector(
      onTap: () => _showFindingsModal(context, fieldKey: fieldKey),
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _localExamFindings[fieldKey] ?? "No",
                style: const TextStyle(color: Colors.black87, fontSize: 13),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // The Findings Modal UI (Read-Only Version)
  void _showFindingsModal(BuildContext context, {required String fieldKey}) {
    final TextEditingController controller = TextEditingController(
      text: _localExamFindings[fieldKey] == "No"
          ? ""
          : _localExamFindings[fieldKey],
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      fieldKey,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Expanded(
                //   child: Container(
                //     decoration: BoxDecoration(
                //       border: Border.all(color: Colors.grey.shade300),
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //     padding: const EdgeInsets.all(12),
                //     child: TextField(
                //       controller: controller,
                //       maxLines: null,
                //       expands: true,
                //       textAlignVertical: TextAlignVertical.top,
                //       decoration: const InputDecoration(
                //         hintText: "Findings",
                //         border: InputBorder.none,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  // height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Stack(
                    children: [
                      TextField(
                        controller: controller,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Findings",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        inputFormatters: [
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            final lineCount =
                                '\n'.allMatches(newValue.text).length + 1;

                            if (lineCount > 5) {
                              return oldValue; // 6th line allow nahi karega
                            }

                            return newValue;
                          }),
                        ],
                      ),
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Image.asset(
                          'assets/txtarea.png', // Uses the uploaded icon
                          width: 14,
                          height: 14,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _localExamFindings[fieldKey] =
                            controller.text.trim().isEmpty
                            ? "No"
                            : controller.text.trim();
                      });

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF117A7A),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
