import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class GeneralPhysicalExaminationScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const GeneralPhysicalExaminationScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<GeneralPhysicalExaminationScreen> createState() =>
      _GeneralPhysicalExaminationScreenState();
}

class _GeneralPhysicalExaminationScreenState
    extends State<GeneralPhysicalExaminationScreen> {
  // --- 1. Physical Examination States ---
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
  final TextEditingController _skinExamController = TextEditingController(
    text: 'No',
  );
  final TextEditingController _visionController = TextEditingController(
    text: 'No',
  );
  final TextEditingController _entLocalController = TextEditingController(
    text: 'No',
  );
  final TextEditingController _breastsController = TextEditingController(
    text: 'No',
  );
  final TextEditingController _axillaController = TextEditingController(
    text: 'No',
  );
  final TextEditingController _thyroidController = TextEditingController(
    text: 'No',
  );
  final TextEditingController _spineController = TextEditingController(
    text: 'No',
  );
  final TextEditingController _ribCageController = TextEditingController(
    text: 'No',
  );

  // Remarks
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

  @override
  Widget build(BuildContext context) {
    return ClinicalBaseScaffold(
      title: "General Physical Examinations",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'General Physical Examinations',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "General Physical Examination",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // --- Physical Examination Expanded Tile ---
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Theme(
                data: Theme.of(
                  context,
                ).copyWith(dividerColor: Colors.transparent),
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
          ),
          const SizedBox(height: 16),

          // --- Local Examination Tile (local.png) ---
          _buildLocalExamTable(),
          const SizedBox(height: 16),

          // --- Remarks ---
          SharedComponents.buildFormLabel("Remarks"),
          const SizedBox(height: 8),

          SharedComponents.buildTextField(
            controller: _remarksController,
            hintText: "Remarks",
            maxLines: 5,
            // height: 130,
          ),

          const SizedBox(height: 32),

          SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20),
        ],
      ),
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
              label: 'Skin Examination',
              customWidget: SharedComponents.buildTextField(
                controller: _skinExamController,
              ),
            ),
            DetailRow(
              label: 'Vision',
              customWidget: SharedComponents.buildTextField(
                controller: _visionController,
              ),
            ),
            DetailRow(
              label: 'ENT/Oral Cravity',
              customWidget: SharedComponents.buildTextField(
                controller: _entLocalController,
              ),
            ),
            DetailRow(
              label: 'Breats',
              customWidget: SharedComponents.buildTextField(
                controller: _breastsController,
              ),
            ),
            DetailRow(
              label: 'Axilla',
              customWidget: SharedComponents.buildTextField(
                controller: _axillaController,
              ),
            ),
            DetailRow(
              label: 'Thyroid',
              customWidget: SharedComponents.buildTextField(
                controller: _thyroidController,
              ),
            ),
            DetailRow(
              label: 'Spine',
              customWidget: SharedComponents.buildTextField(
                controller: _spineController,
              ),
            ),
            DetailRow(
              label: 'Rib Cage',
              isLast: true,
              customWidget: SharedComponents.buildTextField(
                controller: _ribCageController,
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
}
