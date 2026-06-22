import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class MedicationHistoryScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const MedicationHistoryScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<MedicationHistoryScreen> createState() =>
      _MedicationHistoryScreenState();
}

class _MedicationHistoryScreenState extends State<MedicationHistoryScreen> {
  int _bottomNavIndex = 1;
  String? _selectedFrequency = null;
  String? _selectedStatus = null;
  String? _durationUnit = 'Days';

  String typeRadio1 = "Trade Name";

  final TextEditingController _remarksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Medication History",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Medication History',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Medication History",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Form
          SharedComponents.buildFormLabel("Medication", isRequired: true),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Medication"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Drug"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RadioButton<String>(
                value: "Generic Name",
                label: "Generic Name",
                groupValue: typeRadio1,
                onChanged: (v) => setState(() => typeRadio1 = v!),
              ),
              const SizedBox(width: 16), // Dono ke beech thoda gap
              RadioButton<String>(
                value: "Trade Name",
                label: "Trade Name",
                groupValue: typeRadio1,
                onChanged: (v) => setState(() => typeRadio1 = v!),
              ),
            ],
          ),
          const SizedBox(height: 24),

          SharedComponents.buildFormLabel("Search"),
          const SizedBox(height: 8),
          _buildSearchField(),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Dosages"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Dosages"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Frequency"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Frequency"),

          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Status"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Active"),

          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Duration"),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: SharedComponents.buildTextField(hintText: "")),
              const SizedBox(width: 16),
              // Expanded(child: SharedComponents.buildDropdown(hintText: "Days")),
              Expanded(
                child: _buildFunctionalDropdown(
                  value: _durationUnit,
                  hint: "Days",
                  items: ["Days", "Weeks", "Months", "Years"],
                  onChanged: (val) => setState(() => _durationUnit = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Remarks"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: "Remarks",
            maxLines: 5,

            controller: _remarksController
          ),
          const SizedBox(height: 32),

          SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20),
        ],
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
                width: 1,
              ), // THE OUTLINE BORDER
            ),
            // The visible button part
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value ?? hint,
                    style: TextStyle(
                      color: value == null
                          ? Colors.grey.shade400
                          : Colors.black87,
                      fontSize: 14,
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
          hintText: "Search by Drugs",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
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
}
