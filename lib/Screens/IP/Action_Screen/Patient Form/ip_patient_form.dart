import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';

import '../../../OP/clinical_histories/shared_clinical_components.dart';

class IpPatientForm extends StatefulWidget {
  final String patientName;
  final String crn;

  const IpPatientForm({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<IpPatientForm> createState() => _IPIpPatientFormState();
}

class _IPIpPatientFormState extends State<IpPatientForm> {
  String? _templateType = "Haemodialysis";

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Patient Form",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section (Kept as you provided)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Patient Form",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle New Report action
                  _openShowDialog();
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
                    "New Report",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- NEW FORM SECTION BEGINS HERE ---

          // 1. Template Type Dropdown
          _buildLabelWithStar("Template Type"),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: _templateType,
            hint: "--Select--",
            items: const ["Haemodialysis", "Other Template"],
            onChanged: (val) {
              setState(() {
                _templateType = val;
              });
            },
          ),
          const SizedBox(height: 24),

          // 2. Info Table
          _buildInfoTable(),
          const SizedBox(height: 32),

          // 3. Action Buttons
          _buildFullWidthButton(
            "Submit",
            isFilled: true,
            onTap: () {
              // Handle Submit
            },
          ),
          const SizedBox(height: 12),
          _buildFullWidthButton("Cancel", isFilled: false, onTap: () => {}),
          const SizedBox(height: 12),
          _buildFullWidthButton(
            "View Report",
            isFilled: true,
            onTap: () {
              // Handle View Report
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _openShowDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          BloodRequestModal(patientName: widget.patientName, crn: widget.crn),
    );
  }

  // =========================================================================
  // HELPER WIDGETS
  // =========================================================================

  Widget _buildLabelWithStar(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: " *",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // Builds the table exactly as shown in the design
  Widget _buildInfoTable() {
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
            _buildTableRow("Patient Details", ""),
            _buildDivider(),
            _buildTableRow("Visit.No", ""),
            _buildDivider(),
            _buildTableRow("Form Name", ""),
            _buildDivider(),
            _buildTableRow("Created Date", ""),
            _buildDivider(),
            _buildTableRow("Created By", ""),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(String label, String value) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: const Color(
              0xFFEAF9F9,
            ), // Light teal header matching the design
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          Container(width: 1, color: Colors.grey.shade300),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                value,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  // Reusable button builder for the stacked bottom buttons
  Widget _buildFullWidthButton(
    String text, {
    required bool isFilled,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: isFilled
          ? ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A), // Theme Teal
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade400),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.white,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}

class BloodRequestModal extends StatefulWidget {
  final String patientName;
  final String crn;

  const BloodRequestModal({super.key, this.patientName = "", this.crn = ""});

  @override
  State<BloodRequestModal> createState() => _BloodRequestModalState();
}

class _BloodRequestModalState extends State<BloodRequestModal> {
  String? _selectedDepartment = "Cardiology";
  final TextEditingController _indicationCtrl = TextEditingController();
  final TextEditingController _pastTxHistoryCtrl = TextEditingController();
  final TextEditingController _remarksCtrl = TextEditingController();
  final TextEditingController _provisionalDiagnosisCtrl =
      TextEditingController();
  final TextEditingController _finalDiagnosisCtrl = TextEditingController();

  @override
  void dispose() {
    _indicationCtrl.dispose();
    _pastTxHistoryCtrl.dispose();
    _remarksCtrl.dispose();
    _provisionalDiagnosisCtrl.dispose();
    _finalDiagnosisCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Header Row with Title and Close Icon
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Blood Request",
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
            ),

            // Scrollable Content matching Blood Request.png exactly
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Department Dropdown
                    _buildLabelWithStar("Department"),
                    const SizedBox(height: 8),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: PopupMenuButton<String>(
                            onSelected: (val) =>
                                setState(() => _selectedDepartment = val),
                            offset: const Offset(0, 48),
                            color: Colors.white,
                            elevation: 0,
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                              maxWidth: constraints.maxWidth,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedDepartment ?? "--Select--",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            itemBuilder: (context) =>
                                ["Cardiology", "Neurology", "Orthopedics"].map((
                                  String item,
                                ) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Ward No / Type
                    _buildLabel("Ward No / Type"),
                    const SizedBox(height: 8),
                    _buildDisabledFieldLarge(
                      "1703 Endocrinology Transgender A04 /\nNursing Station",
                    ),
                    const SizedBox(height: 16),

                    // Bed No & Type
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Bed No"),
                              const SizedBox(height: 8),
                              _buildDisabledField("5"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Type"),
                              const SizedBox(height: 8),
                              _buildDisabledField("General"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Admission Date & Blood Group
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Admission Date"),
                              const SizedBox(height: 8),
                              _buildDisabledField("10-10-2025"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Blood Group"),
                              const SizedBox(height: 8),
                              _buildDisabledField("AB+"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Indication for Tx
                    _buildLabel("Indication for Tx"),
                    const SizedBox(height: 8),
                    SharedComponents.buildTextField(
                      controller: _indicationCtrl,
                      hintText: "Indication for Tx",
                      height: 48,
                    ),
                    const SizedBox(height: 16),

                    // Past Tx History
                    _buildLabel("Past Tx History"),
                    const SizedBox(height: 8),
                    SharedComponents.buildTextField(
                      controller: _pastTxHistoryCtrl,
                      hintText: "Past Tx History",
                      height: 48,
                    ),
                    const SizedBox(height: 16),

                    // Remarks (TextArea with Group 3 icon)
                    _buildLabel("Remarks"),
                    const SizedBox(height: 8),

                    SharedComponents.buildTextField(hintText:'Remarks' ,controller: _remarksCtrl,maxLines: 5),
                    const SizedBox(height: 16),

                    // --- DIAGNOSIS DETAILS SECTION (Matching Diagnosis Details.png) ---
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          initiallyExpanded:
                              false, // Default collapsed per first image
                          title: const Text(
                            "Diagnosis Details",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("Provisional Diagnosis"),
                                  const SizedBox(height: 8),

                                  SharedComponents.buildTextField(hintText:'Provisional Diagnosis' ,controller: _provisionalDiagnosisCtrl,maxLines: 5),
                                  const SizedBox(height: 16),
                                  _buildLabel("Final Diagnosis"),
                                  const SizedBox(height: 8),

                                  SharedComponents.buildTextField(hintText:'Final Diagnosis' ,controller: _finalDiagnosisCtrl,maxLines: 5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // HB & Platelet Count
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("HB"),
                              const SizedBox(height: 8),
                              _buildDisabledField("12", suffix: "g/dL"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Platelet Count"),
                              const SizedBox(height: 8),
                              _buildDisabledField(
                                "10000",
                                suffix: "*1000/microL",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Replacement Count & Issue Count
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Replacement Count"),
                              const SizedBox(height: 8),
                              _buildDisabledField("0"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Issue Count"),
                              const SizedBox(height: 8),
                              _buildDisabledField("0"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builders to match the exact styling of the mockups

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 13, color: Colors.black87),
    );
  }

  Widget _buildLabelWithStar(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
        children: const [
          TextSpan(
            text: "*",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildDisabledField(String value, {String? suffix}) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6), // Correct grey from mockups
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (suffix != null)
            Text(
              suffix,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
        ],
      ),
    );
  }

  Widget _buildDisabledFieldLarge(String value) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.all(12),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        value,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
      ),
    );
  }


}
