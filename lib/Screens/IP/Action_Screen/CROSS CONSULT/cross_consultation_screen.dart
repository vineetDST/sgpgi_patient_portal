import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';

class CrossConsultationScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const CrossConsultationScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<CrossConsultationScreen> createState() =>
      _CrossConsultationScreenState();
}

class _CrossConsultationScreenState extends State<CrossConsultationScreen> {
  // --- FUNCTIONAL STATE VARIABLES ---
  String? _selectedDepartment;
  String? _selectedConsultant;
  String _requestType = "Optional Only";
  String? _selectedPriority; // Will show "HIGH" as hint initially

  final TextEditingController _reasonCtrl = TextEditingController();

  @override
  void dispose() {
    _reasonCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Cross Consultation",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cross Consultation request",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Department", isRequired: true),
          const SizedBox(height: 8),

          // _buildFunctionalDropdown(
          //   value: _selectedDepartment,
          //   hint: "--Select--",
          //   items: ["--Select--","Cardiology", "Neurology", "Orthopedics", "Pediatrics"],
          //   onChanged: (val) => setState(() => _selectedDepartment = val),
          // ),
          FunctionalDropdown(
            value: _selectedDepartment,
            hint: "--Select--",
            items: [
              "--Select--",
              "Cardiology",
              "Neurology",
              "Orthopedics",
              "Pediatrics",
            ],
            onChanged: (val) => setState(() => _selectedDepartment = val),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Consultant"),
          const SizedBox(height: 8),

          // _buildFunctionalDropdown(
          //   value: _selectedConsultant,
          //   hint: "--Select--",
          //   items: ["--Select--","Dr. Smith", "Dr. Jane Doe", "Dr. Adams"],
          //   onChanged: (val) => setState(() => _selectedConsultant = val),
          // ),
          FunctionalDropdown(
            value: _selectedConsultant,
            hint: "--Select--",
            items: ["--Select--", "Dr. Smith", "Dr. Jane Doe", "Dr. Adams"],
            onChanged: (val) => setState(() => _selectedConsultant = val),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel(
            "Cross Consultation Request Type",
            isRequired: true,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                _buildRadio("Optional Only"),
                const SizedBox(width: 16),
                _buildRadio("Transfer"),
              ],
            ),
          ),
          const SizedBox(height: 12),

          SharedComponents.buildFormLabel("Priority"),
          const SizedBox(height: 8),

          // _buildFunctionalDropdown(
          //   value: _selectedPriority,
          //   hint: "HIGH", // Default hint
          //   items: ["--Select--","HIGH", "MEDIUM", "LOW"],
          //   onChanged: (val) => setState(() => _selectedPriority = val),
          // ),
          FunctionalDropdown(
            value: _selectedPriority,
            hint: "--Select--", // Default hint
            items: ["--Select--", "HIGH", "MEDIUM", "LOW"],
            onChanged: (val) => setState(() => _selectedPriority = val),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Reason"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _reasonCtrl,
            hintText: "Reason",
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

  // --- FUNCTIONAL WIDGET BUILDERS ---

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
            // The visible button part
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
            // The dropdown menu items
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

  Widget _buildRadio(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Radio<String>(
            value: value,
            groupValue: _requestType,
            activeColor: const Color(0xFF117A7A),
            onChanged: (val) => setState(() => _requestType = val!),
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
}
