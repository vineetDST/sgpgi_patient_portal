import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class ImmunizationHistoryScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ImmunizationHistoryScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ImmunizationHistoryScreen> createState() =>
      _ImmunizationHistoryScreenState();
}

class _ImmunizationHistoryScreenState extends State<ImmunizationHistoryScreen> {
  int _bottomNavIndex = 1;
  String status = 'Given';
  String? _selectedImmunization = null;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Immunization History",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Immunization History',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Immunization History",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Form
          SharedComponents.buildFormLabel("Immunization", isRequired: true),
          const SizedBox(height: 8),
          // SharedComponents.buildDropdown(hintText: "Hepatitis A"),
          // const SizedBox(height: 16),

          FunctionalDropdown(value: _selectedImmunization,
              hint: "--Select--",
              items: ["--Select--","Hepatitis A","Hepatitis B","Hepatitis C",],
              onChanged: (value) => setState(() {
                 _selectedImmunization = value;
              })
          ),

          const SizedBox(height: 16),
          SharedComponents.buildFormLabel("Status"),
          Row(
            children: [
              Radio(
                value: 'Given',
                groupValue: status,
                activeColor: const Color(0xFF117A7A),
                onChanged: (val) => setState(() => status = val.toString()),
              ),
              const Text("Given"),
              const SizedBox(width: 16),
              Radio(
                value: 'Not Given',
                groupValue: status,
                activeColor: const Color(0xFF117A7A),
                onChanged: (val) => setState(() => status = val.toString()),
              ),
              const Text("Not Given"),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Age at Immunization(Yrs)"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Age at Immunization(Yrs)"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Duration(Yrs)"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: "Duration(Yrs)"),
          const SizedBox(height: 32),

          SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20),
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
