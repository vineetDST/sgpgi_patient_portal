import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

import 'package:qc_hospital/Screens/OP/actions_screens/admissions/admission_screen.dart'; // Ensure this imports SharedAdmissionComponents
// --- IMPORT THIS TO ACCESS AdmDetailsModal ---
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/accompanied_by_screen.dart';

class DiagnosisScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const DiagnosisScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  int _bottomNavIndex = 1;

  // --- FUNCTIONAL STATE VARIABLE ---
  final TextEditingController _diagnosisCtrl = TextEditingController();

  @override
  void dispose() {
    _diagnosisCtrl.dispose();
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
                  // --- UPDATED: Functional Details Button ---
                  GestureDetector(
                    onTap: () {
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
            activeLabel: 'Diagnosis',
          ),
          const SizedBox(height: 24),

          Text(
            "Provisional Diagnosis",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel(
            "Provisional Diagnosis",
            isRequired: true,
          ),
          const SizedBox(height: 8),

          // --- UPDATED: Text Area with Resizer Icon ---

          SharedComponents.buildTextField(hintText: 'Provisional Diagnosis',controller: _diagnosisCtrl,maxLines: 5),
          const SizedBox(height: 32),

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

      // bottomNavigationBar: CustomCurvedNavigationBar(
      //   index: _bottomNavIndex,
      //   height: 75.0,
      //   color: AppColor.white,
      //   buttonBackgroundColor: AppColor.color117A7A,
      //   backgroundColor: Colors.transparent,
      //   items: const [
      //     Icon(Icons.home_filled, size: 26, color: Colors.white),
      //     Icon(Icons.medical_services, size: 26, color: Colors.white),
      //     Icon(Icons.add_business_outlined, size: 26, color: Colors.white),
      //     Icon(Icons.notifications, size: 26, color: Colors.white),
      //   ],
      //   onTap: (index) => setState(() => _bottomNavIndex = index),
      // ),
    );
  }
}
