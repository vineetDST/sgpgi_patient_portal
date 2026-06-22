import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';

// --- IMPORT YOUR SHELL TO ACCESS THE GLOBAL KEY ---
import 'package:qc_hospital/Widgets/doctor_module_shell.dart'; // Adjust path if needed

// --- Make sure to use correct paths for your project ---
import 'package:qc_hospital/Screens/OP/actions_screens/pomr_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/cross_consultation_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/patient_referral_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/blood_request_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/send_sms_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/admission_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/print_invest_report_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/print_invest_requisition_screen.dart';

class OpActionBottomSheet extends StatelessWidget {
  final String patientName;
  final String crn;

  const OpActionBottomSheet({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  Widget build(BuildContext context) {
    // List of actions matching the image
    final List<Map<String, String>> actions = [
      {'label': 'Create POMR', 'icon': 'create_pomr'},
      {'label': 'Cross Consult', 'icon': 'cross_consult'},
      {'label': 'Patient Referral', 'icon': 'patient_referral'},
      {'label': 'Blood Request', 'icon': 'blood_request'},
      {'label': 'Send SMS', 'icon': 'send_sms'},
      {'label': 'Admission', 'icon': 'admission'},
      {'label': 'DayCare Admission', 'icon': 'daycare_admission'},
      {'label': 'Print Invest Report', 'icon': 'print_invest_report'},
      {'label': 'Print Invest Requisition', 'icon': 'print_invest_report'},
      {'label': 'Print OP Visit Summary', 'icon': 'print_invest_report'},
      {'label': 'Print IP Visit Summary', 'icon': 'print_invest_report'},
    ];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      child: Container(
        // --- REMOVED fixed height to prevent extra spaces ---
        // height: MediaQuery.of(context).size.height * 0.65,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(
          20,
          10,
          20,
          30,
        ), // Added slight bottom padding for safe area
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // --- ADDED: Forces column to wrap tightly around its children ---
          children: [
            // --- Drag Handle ---
            Center(
              child: Container(
                width: 100,
                height: 4,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // --- Close Button Row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColor.color1E1E1E),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            // --- Grid of Actions (Non-Scrollable) ---
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Wrap(
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                spacing: 15,
                runSpacing: 25,
                children: actions.map((action) {
                  return SizedBox(
                    width: (MediaQuery.of(context).size.width - 40 - 30) / 3,
                    child: _buildActionItem(
                      context,
                      action['label']!,
                      action['icon']!,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, String label, String iconName) {
    return InkWell(
      onTap: () {
        // --- Navigation Logic ---
        Navigator.pop(context); // Close the bottom sheet first

        // --- Using pushToCurrentTab to keep the footer visible ---
        if (label == 'Create POMR') {
          doctorShellKey.currentState?.pushToCurrentTab(
            PomrScreen(patientName: patientName, crn: crn),
          );
        } else if (label == 'Cross Consult') {
          doctorShellKey.currentState?.pushToCurrentTab(
            CrossConsultationScreen(patientName: patientName, crn: crn),
          );
        } else if (label == 'Patient Referral') {
          doctorShellKey.currentState?.pushToCurrentTab(
            PatientReferralScreen(patientName: patientName, crn: crn),
          );
        } else if (label == 'Blood Request') {
          doctorShellKey.currentState?.pushToCurrentTab(
            BloodRequestScreen(patientName: patientName, crn: crn),
          );
        } else if (label == 'DayCare Admission') {
          doctorShellKey.currentState?.pushToCurrentTab(
            AdmissionScreen(patientName: patientName, crn: crn),
          );
        } else if (label == 'Send SMS') {
          doctorShellKey.currentState?.pushToCurrentTab(
            SendSmsScreen(patientName: patientName, crn: crn),
          );
        } else if (label == 'Admission') {
          doctorShellKey.currentState?.pushToCurrentTab(
            AdmissionScreen(patientName: patientName, crn: crn),
          );
        } else if (label == 'Print Invest Report') {
          doctorShellKey.currentState?.pushToCurrentTab(
            PrintInvestReportScreen(patientName: patientName, crn: crn),
          );
        } else if (label == 'Print Invest Requisition') {
          doctorShellKey.currentState?.pushToCurrentTab(
            PrintInvestRequisitionScreen(patientName: patientName, crn: crn),
          );
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Circular Icon Background
          Container(
            height: 54,
            width: 54,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.color117A7A.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/$iconName.svg",
              colorFilter: const ColorFilter.mode(
                AppColor.color117A7A,
                BlendMode.srcIn,
              ),
              fit: BoxFit.contain,
              placeholderBuilder: (context) => const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Label Text
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColor.color1E1E1E,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
