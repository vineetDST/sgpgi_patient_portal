import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Tab/switching_tab.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

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

class AccStmt extends StatefulWidget {
  final String patientName;
  final String crn;

  const AccStmt({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<AccStmt> createState() => _OpConsultationState();
}

class _OpConsultationState extends State<AccStmt> {

  final fromController = TextEditingController();
  final toController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;

  String? _visitType = "--Select--";

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ClinicalBaseScaffold(
      title: "Account Statement",
      showDrawer: true,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Admission',

      // ONLY pass the content that is unique to this screen
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SharedComponents.buildFormLabel("From Date",isRequired: true)),
                    const SizedBox(height: 8),
                    AppDateField(
                      controller: fromController,
                      onTap: () async {
                        DateTime? pickedDate =
                        await CustomCalendarDialog.show(
                          context,
                          initialDate: fromDate ?? DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            fromDate = pickedDate;
                            fromController.text = formatDate(pickedDate);
                          });
                        }
                        ;
                      },

                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SharedComponents.buildFormLabel("To Date",isRequired: true)),
                    const SizedBox(height: 8),
                    AppDateField(
                      controller: toController,
                      onTap: () async {
                        DateTime? pickedDate =
                        await CustomCalendarDialog.show(
                          context,
                          initialDate: toDate ?? DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            toDate = pickedDate;
                            toController.text = formatDate(pickedDate);
                          });
                        }
                        ;
                      },

                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
            ],
          ),

          SharedComponents.buildFormLabel('Visit Type'),
          const SizedBox(height: 8,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ExpandedDropdown(
                  value: _visitType,
                  items: ['--Select--', 'IP', 'OP', ],
                  onChanged: (v) => setState(() => _visitType = v),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(flex: 1,child: Container(),)
            ],
          ),
          const SizedBox(height: 16,),

          const Text(
            "Export Statement",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            "Choose file format to download",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              // PDF Button
              Expanded(
                child: _buildExportCard(
                  title: "Download PDF",
                  subtitle: "Portable Document Format",
                  image: 'assets/pdf.png', // Yahan aap apna custom SVG bhi laga sakte hain
                  iconColor: const Color(0xFFF05152),
                  borderColor: const Color(0xFFF05152),
                  backgroundColor: const Color(0xFFFCEBEB),
                  onTap: () {
                    // PDF Download Logic yahan likhein
                    print("PDF Download clicked");
                  },
                ),
              ),

              const SizedBox(width: 16), // Dono cards ke beech ka gap

              // Excel Button
              Expanded(
                child: _buildExportCard(
                  title: "Download Excel",
                  subtitle: "Microsoft Excel Format",
                  image: 'assets/excel.png',
                  iconColor: const Color(0xFF1E7E34),
                  borderColor: const Color(0xFF1E7E34),
                  backgroundColor: const Color(0xFFE9F5EC),
                  onTap: () {
                    // Excel Download Logic yahan likhein
                    print("Excel Download clicked");
                  },
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  // Reusable Card Widget
  Widget _buildExportCard({
    required String title,
    required String subtitle,
    required String image,
    required Color iconColor,
    required Color borderColor,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(10), // Rounded corners jaisa image me hai
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Image.asset(image,width: 16,height: 16,),
            const SizedBox(width: 12),

            // Text Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 8,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}


