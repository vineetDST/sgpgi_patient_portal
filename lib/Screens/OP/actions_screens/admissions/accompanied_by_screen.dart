import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

import 'package:qc_hospital/Screens/OP/actions_screens/admissions/admission_screen.dart'; // To access SharedAdmissionComponents

// ============================================================================
// 1. ACCOMPANIED BY SCREEN
// ============================================================================
class AccompaniedByScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const AccompaniedByScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<AccompaniedByScreen> createState() => _AccompaniedByScreenState();
}

class _AccompaniedByScreenState extends State<AccompaniedByScreen> {
  // --- FUNCTIONAL STATE VARIABLES ---
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _mobileCtrl = TextEditingController();

  String? _selectedRelation;
  String? _selectedGender;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _ageCtrl.dispose();
    _addressCtrl.dispose();
    _mobileCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Admission",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Admission',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SharedAdmissionComponents.buildTabs(
            context,
            widget.patientName,
            widget.crn,
            activeTabIndex: 0,
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Admission",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // --- OPEN ADMISSION DETAILS MODAL ---
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => AdmDetailsModal(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.print, color: Colors.black87),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedAdmissionComponents.buildQuickActions(
            context,
            screenWidth,
            widget.patientName,
            widget.crn,
            activeLabel: 'Accompanied By',
          ),
          const SizedBox(height: 24),

          Text(
            "Accompanied By Information",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Accompanied Name", isRequired: true),
          const SizedBox(height: 8),
          _buildFunctionalTextField(_nameCtrl, "Accompanied Name"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Relation", isRequired: true),
          const SizedBox(height: 8),
          // _buildFunctionalDropdown(
          //   value: _selectedRelation,
          //   hint: "--Select--",
          //   items: ["Brother", "Sister", "Father", "Mother", "Spouse", "Other"],
          //   onChanged: (v) => setState(() => _selectedRelation = v),
          // ),

          FunctionalDropdown(
            value: _selectedRelation,
            hint: "--Select--",
            items: ["--Select--","Brother", "Sister", "Father", "Mother", "Spouse", "Other"],
            onChanged: (v) => setState(() => _selectedRelation = v),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SharedComponents.buildFormLabel("Accompanied Age"),
                    const SizedBox(height: 8),
                    _buildFunctionalTextField(_ageCtrl, "0", isNumeric: true),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SharedComponents.buildFormLabel("Gender"),
                    const SizedBox(height: 8),
                    _buildFunctionalDropdown(
                      value: _selectedGender,
                      hint: "--Select--",
                      items: ["Male", "Female", "Other"],
                      onChanged: (v) => setState(() => _selectedGender = v),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Address", isRequired: true),
          const SizedBox(height: 8),
          _buildFunctionalTextField(_addressCtrl, "Address"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Mobile Number", isRequired: true),
          const SizedBox(height: 8),
          _buildFunctionalTextField(
            _mobileCtrl,
            "Mobile Number",
            isNumeric: true,
          ),
          const SizedBox(height: 24),

          // Data Table
          _buildAccompaniedTable(),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                "Admit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "Back to Patient List",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- FUNCTIONAL FIELD BUILDERS ---
  Widget _buildFunctionalTextField(
    TextEditingController ctrl,
    String hint, {
    bool isNumeric = false,
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
        ),
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  Widget _buildFunctionalDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            onSelected: onChanged,
            offset: const Offset(0, 48), // Drops down exactly below the field
            color: Colors.white,
            elevation: 0, // Flat look
            constraints: BoxConstraints(
              minWidth: constraints
                  .maxWidth, // Matches the exact width of the container
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5,
              ), // THE OUTLINE BORDER
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? hint,
                      style: TextStyle(
                        color: value == null
                            ? Colors.grey.shade400
                            : Colors.black87,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
            itemBuilder: (context) => items
                .map(
                  (item) => PopupMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  // --- DATA TABLE ---
  Widget _buildAccompaniedTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            _buildTableRow("Accompanied\nName", "Gautam Kumar"),
            _buildDivider(),
            _buildTableRow("Age", "42"),
            _buildDivider(),
            _buildTableRow("Gender", "Male"),
            _buildDivider(),
            _buildTableRow("Relation", "Brother"),
            _buildDivider(),
            _buildTableRow("Address", "Lucknow"),
            _buildDivider(),
            _buildTableRow("Mobile Number", "9876543210"),
            _buildDivider(),
            _buildTableRow("Action", "", isAction: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(String label, String value, {bool isAction = false}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            color: const Color(0xFFEAF9F9),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
          Container(width: 1, color: Colors.grey.shade300),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              alignment: Alignment.centerLeft,
              child: isAction
                  ? Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // --- OPEN CENTERED EDIT MODAL ---
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  const AccompaniedByEditModal(
                                    initialName: "Gautam Kumar",
                                    initialAge: "42",
                                    initialGender: "Male",
                                    initialRelation: "Brother",
                                    initialAddress: "Lucknow",
                                    initialMobile: "9876543210",
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
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () => _showDeleteModal(context),
                          child: Image.asset(
                            'assets/deleteicon.png', // 👈 your image path
                            height: 15,
                            width: 15,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    )
                  : Text(
                      value,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  // --- DELETE MODAL ---
  void _showDeleteModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 1.5),
                ),
                child: const Icon(Icons.close, color: Colors.red, size: 32),
              ),
              const SizedBox(height: 24),
              const Text(
                "Are you sure you want to\ndelete the record?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC60000),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// 2. ADMISSION DETAILS MODAL (Bottom Sheet)
// ============================================================================
class AdmDetailsModal extends StatefulWidget {
  final String patientName;
  final String crn;

  const AdmDetailsModal({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<AdmDetailsModal> createState() => _AdmDetailsModalState();
}

class _AdmDetailsModalState extends State<AdmDetailsModal> {
  String? _department = "Cardiology";
  String? _ward = "1201 Cardiology Wing-A01 (MICU)";
  String? _admissionType = "2 Days General Bed";
  String? _hrfType = "Medium";
  String? _estStay = "7";
  String? _bedType = "Medical Care Unit";

  final TextEditingController _bedNoCtrl = TextEditingController(text: "7");
  final TextEditingController _unitCtrl = TextEditingController(
    text: "UNIT-D00003-01",
  );
  final TextEditingController _doctorCtrl = TextEditingController(
    text: "Sudeep Kumar",
  );

  @override
  void dispose() {
    _bedNoCtrl.dispose();
    _unitCtrl.dispose();
    _doctorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // --- REMOVED fixed height (MediaQuery) ---
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      // --- Add bottom padding for keyboard & safe area ---
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // --- ADDED: Forces column to shrink-wrap tightly ---
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black87,
                    size: 28,
                  ),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 12),

            _buildLabel("Department"),
            const SizedBox(height: 8),
            _buildDropdown(
              value: _department,
              items: ["Cardiology", "Neurology", "Orthopedics"],
              onChanged: (val) => setState(() => _department = val),
            ),
            const SizedBox(height: 16),

            _buildLabel("Ward"),
            const SizedBox(height: 8),
            _buildDropdown(
              value: _ward,
              items: [
                "1201 Cardiology Wing-A01 (MICU)",
                "1202 Cardiology Wing-B01 (GEN)",
              ],
              onChanged: (val) => setState(() => _ward = val),
            ),
            const SizedBox(height: 16),

            _buildLabelWithStar("Admission Type"),
            const SizedBox(height: 8),
            _buildDropdown(
              value: _admissionType,
              items: [
                "1 Day General Bed",
                "2 Days General Bed",
                "7 Days General Bed",
              ],
              onChanged: (val) => setState(() => _admissionType = val),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelWithStar("HRF Type"),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        value: _hrfType,
                        items: ["Low", "Medium", "High"],
                        onChanged: (val) => setState(() => _hrfType = val),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Est. Stay"),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        value: _estStay,
                        items: ["1", "2", "3", "5", "7", "10", "14"],
                        onChanged: (val) => setState(() => _estStay = val),
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Bed Type"),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        value: _bedType,
                        items: ["General", "Private", "Medical Care Unit"],
                        onChanged: (val) => setState(() => _bedType = val),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelWithStar("Bed No"),
                      const SizedBox(height: 8),
                      _buildTextField(_bedNoCtrl, suffixIcon: Icons.search),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelWithStar("Unit"),
                      const SizedBox(height: 8),
                      _buildTextField(_unitCtrl),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabelWithStar("Consulting Doctor"),
                      const SizedBox(height: 8),
                      _buildTextField(_doctorCtrl),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Bottom Text
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  "Estimated Advance Amount Rs.",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "1100.00",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF117A7A),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildLabelWithStar(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
        children: const [
          TextSpan(
            text: "*",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, {IconData? suffixIcon}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: suffixIcon != null
              ? Icon(suffixIcon, color: Colors.grey, size: 20)
              : null,
        ),
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  // --- UPDATED: Uses PopupMenuButton layout ---
  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            onSelected: onChanged,
            offset: const Offset(0, 48), // Drops down exactly below the field
            color: Colors.white,
            elevation: 0, // Flat look
            constraints: BoxConstraints(
              minWidth: constraints
                  .maxWidth, // Matches the exact width of the container
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5,
              ), // THE OUTLINE BORDER
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? "--Select--",
                      style: TextStyle(
                        color: value == null
                            ? Colors.grey.shade400
                            : Colors.black87,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
            itemBuilder: (context) => items
                .map(
                  (item) => PopupMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

// ============================================================================
// 3. ACCOMPANIED BY EDIT MODAL (Centered Dialog)
// ============================================================================
class AccompaniedByEditModal extends StatefulWidget {
  final String initialName;
  final String initialRelation;
  final String initialAge;
  final String initialGender;
  final String initialAddress;
  final String initialMobile;

  const AccompaniedByEditModal({
    super.key,
    this.initialName = "",
    this.initialRelation = "",
    this.initialAge = "",
    this.initialGender = "",
    this.initialAddress = "",
    this.initialMobile = "",
  });

  @override
  State<AccompaniedByEditModal> createState() => _AccompaniedByEditModalState();
}

class _AccompaniedByEditModalState extends State<AccompaniedByEditModal> {
  late TextEditingController _nameCtrl;
  late TextEditingController _relationCtrl;
  late TextEditingController _ageCtrl;
  late TextEditingController _addressCtrl;
  late TextEditingController _mobileCtrl;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName);
    _relationCtrl = TextEditingController(text: widget.initialRelation);
    _ageCtrl = TextEditingController(text: widget.initialAge);
    _addressCtrl = TextEditingController(text: widget.initialAddress);
    _mobileCtrl = TextEditingController(text: widget.initialMobile);
    _selectedGender = widget.initialGender.isNotEmpty
        ? widget.initialGender
        : null;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _relationCtrl.dispose();
    _ageCtrl.dispose();
    _addressCtrl.dispose();
    _mobileCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Shrink wraps the dialog content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Close Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Accompanied By Information",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.black87),
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Form Fields
            _buildLabelWithStar("Accompanied Name"),
            const SizedBox(height: 8),
            _buildTextField(_nameCtrl),
            const SizedBox(height: 16),

            _buildLabelWithStar("Relation"),
            const SizedBox(height: 8),
            _buildTextField(_relationCtrl),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Accompanied Age"),
                      const SizedBox(height: 8),
                      _buildTextField(_ageCtrl, isNumeric: true),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("Gender"),
                      const SizedBox(height: 8),
                      _buildDropdown(
                        value: _selectedGender,
                        hint: "--Select--",
                        items: ["Male", "Female", "Other"],
                        onChanged: (v) => setState(() => _selectedGender = v),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildLabelWithStar("Address"),
            const SizedBox(height: 8),
            _buildTextField(_addressCtrl),
            const SizedBox(height: 16),

            _buildLabelWithStar("Mobile Number"),
            const SizedBox(height: 8),
            _buildTextField(_mobileCtrl, isNumeric: true),
            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
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
                    onPressed: () => Navigator.pop(context),
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
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black87,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildLabelWithStar(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
        children: const [
          TextSpan(
            text: "*",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController ctrl, {bool isNumeric = false}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: ctrl,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        decoration: const InputDecoration(border: InputBorder.none),
        style: const TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  // --- UPDATED: Uses PopupMenuButton layout ---
  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            onSelected: onChanged,
            offset: const Offset(0, 48), // Drops down exactly below the field
            color: Colors.white,
            elevation: 0, // Flat look
            constraints: BoxConstraints(
              minWidth: constraints
                  .maxWidth, // Matches the exact width of the container
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5,
              ), // THE OUTLINE BORDER
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? hint,
                      style: TextStyle(
                        color: value == null
                            ? Colors.grey.shade400
                            : Colors.black87,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
            itemBuilder: (context) => items
                .map(
                  (item) => PopupMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
