import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Screens/IP/in_patient_screen.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

class IPInfectionRec extends StatefulWidget {
  final String patientName;
  final String crn;

  const IPInfectionRec({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<IPInfectionRec> createState() => _IPInfectionRecState();
}

class _IPInfectionRecState extends State<IPInfectionRec> {
  String? _location = null;
  String? _infectionStatus = null;
  String? _infectionOutcomes = null;
  String? _infectionTypes = null;
  String? _infectionCategory = null;
  String? _infectionCategoryType = null;
  String? _infectionSubCategoryType = null;
  String? _onSetType = null;

  final dischargeRemarksController1 = TextEditingController();
  final dischargeRemarksController2 = TextEditingController();
  final dischargeRemarksController3 = TextEditingController();
  final dischargeRemarksController4 = TextEditingController();
  final dischargeRemarksController5 = TextEditingController();
  final dischargeRemarksController6 = TextEditingController();
  final dischargeRemarksController7 = TextEditingController();
  final dischargeRemarksController8 = TextEditingController();
  final dischargeRemarksController9 = TextEditingController();

  // State class ke andar variables ke saath ise rakhein
  Map<String, bool> reactionValues = {
    "Dialysis": false,
    "Post Operative Would of Admission": false,
    "On Admission Patient on Antibiotic": false,
    "Post Procedure Infection": false,
    "Fever within 48 hours": false,
    "Fever After 48 hours": false,
  };

  String selectedOption = "All";

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Infection Rec",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Infection Recording",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildInfectionRecording(),
          const SizedBox(height: 16),

          _buildDiagnosis(),
          const SizedBox(height: 16),

          AppSaveButton(text: "Save", onPressed: () {}),
          const SizedBox(height: 16),

          AppCancelButton(text: "Cancel", onPressed: () {}),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget buildCheckboxItem(String label) {
    // Map se current value nikalna
    bool isChecked = reactionValues[label] ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: () {
          // Main State ko update karna
          setState(() {
            reactionValues[label] = !isChecked;
          });
        },
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isChecked ? Color(0xFF117A7A) : Colors.grey.shade400,
                  width: 1.5,
                ),
                color: isChecked ? Color(0xFF117A7A) : Colors.transparent,
              ),
              child: isChecked
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfectionRecording() {
    return CustomExpansionFrame(
      title: "Infection Recording",
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Location', isRequired: true),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _location,
          hint: "--Select--",
          items: ['--Select--', '1201 Cardiology Wing-A01(MICU)/19'],
          onChanged: (val) {
            setState(() {
              _location = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Infection Status',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _infectionStatus,
          hint: "--Select--",
          items: ['--Select--', 'Suspected'],
          onChanged: (val) {
            setState(() {
              _location = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Infection Outcomes',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _infectionOutcomes,
          hint: "--Select--",
          items: ['--Select--', 'Unresolved'],
          onChanged: (val) {
            setState(() {
              _location = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Infection Type',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _infectionTypes,
          hint: "--Select--",
          items: ['--Select--', 'Infection Type'],
          onChanged: (val) {
            setState(() {
              _location = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Infection Category',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _infectionCategory,
          hint: "--Select--",
          items: ['--Select--', 'Infection Category'],
          onChanged: (val) {
            setState(() {
              _location = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Infection Category Type',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _infectionCategoryType,
          hint: "--Select--",
          items: ['--Select--', 'Infection Category Type'],
          onChanged: (val) {
            setState(() {
              _location = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Infection Sub Category Type',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _infectionSubCategoryType,
          hint: "--Select--",
          items: ['--Select--', 'Infection Sub Category Type'],
          onChanged: (val) {
            setState(() {
              _location = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Onset Type',
            isRequired: true,
          ),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _onSetType,
          hint: "--Select--",
          items: ['--Select--', 'Onset Type'],
          onChanged: (val) {
            setState(() {
              _location = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Reactions'),
        ),
        const SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Column(
            children: reactionValues.keys.map((String key) {
              return buildCheckboxItem(key);
            }).toList(),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildDiagnosis() {
    return CustomExpansionFrame(
      title: "Diagnosis",
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('ICD Code for'),
            ),
            Row(
              children: [
                Radio(
                  value: 'All',
                  groupValue: selectedOption,
                  activeColor: const Color(0xFF117A7A),
                  onChanged: (val) =>
                      setState(() => selectedOption = val.toString()),
                ),
                const Text("All"),

                const SizedBox(width: 4),

                Radio(
                  value: 'Cardiology',
                  groupValue: selectedOption,
                  activeColor: const Color(0xFF117A7A),
                  onChanged: (val) =>
                      setState(() => selectedOption = val.toString()),
                ),
                const Text("Cardiology"),
              ],
            ),
          ],
        ),
        SharedComponents.buildTextField(hintText: "%"),
        const SizedBox(height: 8),
        Stack(
          children: [
            SharedComponents.buildTextField(
              controller: dischargeRemarksController1,
              hintText: "Test",
              maxLines: 5,
              // height: 130,
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
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Sign and Symptons'),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            SharedComponents.buildTextField(
              controller: dischargeRemarksController2,
              hintText: "Sign and Symptons",
              maxLines: 5,
              // height: 130,
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
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Infection Sites'),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            SharedComponents.buildTextField(
              controller: dischargeRemarksController3,
              hintText: "Infection Sites",
              maxLines: 5,
              // height: 130,
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
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Detail of Antibiotics / Infection at the time of Adm',
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            SharedComponents.buildTextField(
              controller: dischargeRemarksController4,
              hintText: "Detail of Antibiotics / Infection at the time of Adm",
              maxLines: 5,
              // height: 130,
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
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('History of Infection'),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            SharedComponents.buildTextField(
              controller: dischargeRemarksController5,
              hintText: "History of Infection",
              maxLines: 5,
              // height: 130,
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
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Current Antibiotics details, durations and response',
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            SharedComponents.buildTextField(
              controller: dischargeRemarksController6,
              hintText: "Current Antibiotics details, durations and response",
              maxLines: 5,
              // height: 130,
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
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'History nd Duration of Class of Antibiotics',
          ),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          controller: dischargeRemarksController7,
          hintText: "History nd Duration of Class of Antibiotics",
          maxLines: 5,
          // height: 130,
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel(
            'Post Procedure and Infection',
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            SharedComponents.buildTextField(
              controller: dischargeRemarksController8,
              hintText: "Post Procedure and Infection",
              maxLines: 5,
              // height: 130,
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
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Remarks'),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            SharedComponents.buildTextField(
              controller: dischargeRemarksController9,
              hintText: "Remarks",
              maxLines: 5,
              // height: 130,
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
        const SizedBox(height: 16),
      ],
    );
  }
}
