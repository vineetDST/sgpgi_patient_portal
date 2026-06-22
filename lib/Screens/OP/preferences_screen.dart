import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';

import 'package:qc_hospital/Core/Utils/Sub_Screen/filterSelectType.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({super.key});

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  // --- STATE VARIABLES (Matching the image exactly) ---
  String? _selectedBranch = null;
  String? _selectedDepartment = null;
  String? _selectedLocation = null;
  String? _selectedDefaultPage = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: OpAppbar(
        appheight: true,
        showDrawer: false,

        title: "Preferences",
        onLeadingPressed: () {
          doctorShellScaffoldKey.currentState?.openDrawer();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabelWithStar("Branch"),
                  const SizedBox(height: 8),
                  FunctionalDropdown(
                    value: _selectedBranch,
                    hint: "--Select--",
                    items: [
                      "--Select--",
                      "Administration",
                      "Hospital Revolving Fund",
                      "PGI Lucknow",
                      "Research Accounting",
                      "Shruthi Auditorium"
                    ],
                    onChanged: (val) => setState(() => _selectedBranch = val),
                  ),


                  const SizedBox(height: 20),

                  _buildLabelWithStar("Department"),
                  const SizedBox(height: 8),
                  FunctionalDropdown(
                    value: _selectedDepartment,
                    hint: "--Select--",
                    items: ["--Select--","Cardiology", "Neurology", "Orthopedics"],
                    onChanged: (val) =>
                        setState(() => _selectedDepartment = val),
                  ),
                  const SizedBox(height: 20),

                  _buildLabelWithStar("Location"),
                  const SizedBox(height: 8),
                  FunctionalDropdown(
                    value: _selectedLocation,
                    hint: "--Select--",
                    items: ["--Select--","1201 Cardiology Wing-A01(MICU)", "OPD 2", "OPD 3"],
                    onChanged: (val) => setState(() => _selectedLocation = val),
                  ),

                  const SizedBox(height: 20),

                  _buildLabelWithStar("Default Page"),
                  const SizedBox(height: 8),


                  FunctionalDropdown(
                    value: _selectedDefaultPage,
                    hint: "--Select--",
                    items: ["--Select--","Workbench", "Dashboard", "Patient List"],
                    onChanged: (val) {
                      setState(() {
                        _selectedDefaultPage = val;
                      });
                    },
                  ),
                  const SizedBox(height: 20),


                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context) ,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 12
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF117A7A),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),


                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.pop(context) ,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade400
                              ),
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Align(
                              alignment: Alignment.center,
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
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildLabelWithStar(String text) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: " *",
            style: TextStyle(color: Colors.red),
          ),
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
            border: Border.all(color: Colors.grey.shade300,width: 1.5),
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
