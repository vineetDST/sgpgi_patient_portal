import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// Import your shared components file here
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class FamilyHistoryScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const FamilyHistoryScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<FamilyHistoryScreen> createState() => _FamilyHistoryScreenState();
}

class _FamilyHistoryScreenState extends State<FamilyHistoryScreen> {
  int _bottomNavIndex = 1;
  String survivalStatus = 'Alive';
  String? _selectedRelationship = null;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Family History",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Family History',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Family History",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Form
          SharedComponents.buildFormLabel("Relationship", isRequired: true),
          const SizedBox(height: 8),
          // SharedComponents.buildDropdown(hintText: "Father"),
          FunctionalDropdown(value: _selectedRelationship,
              hint: "--Select--",
              items: ["--Select--","Father","Mother","Brother",],
              onChanged: (value) => setState(() {
                _selectedRelationship = value;
              })
          ),

          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Survival Status"),
          Row(
            children: [
              Radio(
                value: 'Alive',
                groupValue: survivalStatus,
                activeColor: const Color(0xFF117A7A),
                onChanged: (val) =>
                    setState(() => survivalStatus = val.toString()),
              ),
              const Text("Alive"),
              const SizedBox(width: 16),
              Radio(
                value: 'Dead',
                groupValue: survivalStatus,
                activeColor: const Color(0xFF117A7A),
                onChanged: (val) =>
                    setState(() => survivalStatus = val.toString()),
              ),
              const Text("Dead"),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Current Age(Yrs)"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Current Age(Yrs)"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Illness"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Illness"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Duration(Yrs)"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Duration(Yrs)"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Age at Death(Yrs)"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Age at Death(Yrs)"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Cause of Death"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Cause of Death"),
          const SizedBox(height: 32),

          SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20), // Bottom nav padding
        ],
      ),

      // bottomNavigationBar: CustomCurvedNavigationBar(
      //   index: _bottomNavIndex,
      //   height: 75.0,
      //   items: const <Widget>[
      //     Icon(Icons.home_filled, size: 26, color: Colors.white),
      //     Icon(Icons.medical_services, size: 26, color: Colors.white),
      //     Icon(Icons.add_business_outlined, size: 26, color: Colors.white),
      //     Icon(Icons.notifications, size: 26, color: Colors.white),
      //   ],
      //   color: AppColor.white,
      //   buttonBackgroundColor: AppColor.color117A7A,
      //   backgroundColor: Colors.transparent,
      //   onTap: (index) => setState(() => _bottomNavIndex = index),
      // ),
    );
  }
}
