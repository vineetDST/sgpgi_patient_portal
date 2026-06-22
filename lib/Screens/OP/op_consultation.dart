import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';

// --- Import the Base Shell to access the Master Drawer Key ---
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// --- Imports for the routed screens ---
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/clinical_history_screen.dart';
import 'package:qc_hospital/Screens/OP/clinical_summary_screen.dart';
import 'package:qc_hospital/Screens/OP/allergy/allergy_screen.dart';
import 'package:qc_hospital/Screens/OP/vital_signs/vital_signs_screen.dart';
import 'package:qc_hospital/Screens/OP/examinations/examination_screen.dart';
import 'package:qc_hospital/Screens/OP/cpoe_screen.dart';

class OpConsultation extends StatefulWidget {
  final String patientName;
  final String crn;

  const OpConsultation({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<OpConsultation> createState() => _OpConsultationState();
}

class _OpConsultationState extends State<OpConsultation> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ClinicalBaseScaffold(
      title: "OP Consultation",
      showDrawer: true,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Op Consultant',

      // ONLY pass the content that is unique to this screen
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("SOAP"),
          const SizedBox(height: 16),
          _buildSoapGrid(screenWidth),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, {IconData? icon}) {
    return Row(
      children: [
        if (icon != null) Icon(icon, size: 18, color: Colors.black87),
        if (icon != null) const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyles.RegH3.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSoapGrid(double width) {
    final soapItems = [
      {
        'label': 'Clinical History',
        'icon': 'assets/ch.png',
        'color': const Color(0xFFC4E7C5), // Light Green
      },
      {
        'label': 'Allergy',
        'icon': 'assets/al.png',
        'color': const Color(0xFFA9D6E5), // Light Blue
      },
      {
        'label': 'Vital Signs',
        'icon': 'assets/vs.png',
        'color': const Color(0xFFDAD7FE), // Light Purple
      },
      {
        'label': 'Examination',
        'icon': 'assets/ex.png',
        'color': const Color(0xFFF4978E), // Soft Red/Pink
      },
      {
        'label': 'Clinical Summary',
        'icon': 'assets/cs.png',
        'color': const Color(0xFFBEE9E8), // Light Cyan
      },
      {
        'label': 'CPOE',
        'icon': 'assets/cpoe.png',
        'color': const Color(0xFFC7F9CC), // Light Green
      },
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.95, // Adjusted for the taller rectangular look
      ),
      itemCount: soapItems.length,
      itemBuilder: (context, index) {
        final item = soapItems[index];

        return InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            Widget? targetScreen;
            if (item['label'] == 'Clinical History')
              targetScreen = ClinicalHistoryScreen(
                patientName: widget.patientName,
                crn: widget.crn,
              );
            else if (item['label'] == 'Clinical Summary')
              targetScreen = ClinicalSummaryScreen(
                patientName: widget.patientName,
                crn: widget.crn,
              );
            else if (item['label'] == 'Allergy')
              targetScreen = AllergyScreen(
                patientName: widget.patientName,
                crn: widget.crn,
              );
            else if (item['label'] == 'Vital Signs')
              targetScreen = VitalSignsScreen(
                patientName: widget.patientName,
                crn: widget.crn,
              );
            else if (item['label'] == 'Examination')
              targetScreen = ExaminationScreen(
                patientName: widget.patientName,
                crn: widget.crn,
              );
            else if (item['label'] == 'CPOE')
              targetScreen = CpoeScreen(
                patientName: widget.patientName,
                crn: widget.crn,
              );

            if (targetScreen != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => targetScreen!),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: item['color'] as Color,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Stack(
              children: [
                // --- BACKGROUND WATERMARK ICON ---
                Positioned(
                  right: -6,
                  top: 4,
                  child: Opacity(
                    opacity: 0.04, // Subtle watermark effect
                    child: Image.asset(
                      item['icon'] as String,
                      width: 55,
                      height: 55,
                      color: Colors.black,
                    ),
                  ),
                ),
                // --- FOREGROUND CONTENT ---
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.end, // Aligns text to bottom
                    children: [
                      Image.asset(
                        item['icon'] as String,
                        width: 20,
                        height: 20,
                        color: Colors.black87,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item['label'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          // color: Colors.blackDE,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
