import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// Import the other admission screens
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/accompanied_by_screen.dart'; // Assumes AdmDetailsModal is accessible from here
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/view_referral_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/diagnosis_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/document_upload_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/previous_admissions_screen.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/admission_bed_status_screen.dart';

class AdmissionScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const AdmissionScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<AdmissionScreen> createState() => _AdmissionScreenState();
}

class _AdmissionScreenState extends State<AdmissionScreen> {
  int _bottomNavIndex = 1;

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
          // Admission Tabs
          SharedAdmissionComponents.buildTabs(
            context,
            widget.patientName,
            widget.crn,
            activeTabIndex: 0,
          ),
          const SizedBox(height: 24),

          // Admission Header Row
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
                  GestureDetector(
                    onTap: () {
                      // --- CALL THE REUSABLE ADM DETAILS MODAL ---
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

          // Admission Quick Actions
          SharedAdmissionComponents.buildQuickActions(
            context,
            screenWidth,
            widget.patientName,
            widget.crn,
            activeLabel: 'Admission Notes',
          ),
          const SizedBox(height: 24),

          // Rich Text Editor
          _buildRichTextEditor(),
          const SizedBox(height: 20), // Bottom scroll padding
        ],
      ),
    );
  }

  // Same Rich Text Editor from Visit Summary
  Widget _buildRichTextEditor() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.image_outlined, size: 16, color: Colors.grey),
                      SizedBox(width: 6),
                      Text(
                        "Add Media",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: const [
                    Text(
                      "Visual",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    SizedBox(width: 16),
                    Text(
                      "Text",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text(
                  "Paragraph",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: Colors.grey,
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                ),
                const Icon(
                  Icons.format_align_left,
                  size: 18,
                  color: Colors.grey,
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.format_align_center,
                  size: 18,
                  color: Colors.grey,
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.format_align_right,
                  size: 18,
                  color: Colors.grey,
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                ),
                const Icon(
                  Icons.format_list_numbered,
                  size: 18,
                  color: Colors.grey,
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.format_list_bulleted,
                  size: 18,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text(
                  "A",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.format_color_text,
                  size: 18,
                  color: Colors.grey,
                ),
                const SizedBox(width: 16),
                const Text(
                  "B",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "I",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "U",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  "S",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
                Container(
                  height: 20,
                  width: 1,
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                ),
                const Icon(Icons.attach_file, size: 18, color: Colors.grey),
                const SizedBox(width: 16),
                const Icon(Icons.image_outlined, size: 18, color: Colors.grey),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey.shade200),
          Expanded(
            child: TextField(
              maxLines: null,
              expands: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- REUSABLE ADMISSION COMPONENTS ---
class SharedAdmissionComponents {
  // Pass context, patientName, and crn to handle Tab Routing!
  static Widget buildTabs(
    BuildContext context,
    String patientName,
    String crn, {
    required int activeTabIndex,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (activeTabIndex != 0) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AdmissionScreen(patientName: patientName, crn: crn),
                  ),
                );
              }
            },
            child: _buildTabItem("View Adm Details", 0, activeTabIndex),
          ),
          GestureDetector(
            onTap: () {
              if (activeTabIndex != 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdmissionBedStatusScreen(
                      patientName: patientName,
                      crn: crn,
                    ),
                  ),
                );
              }
            },
            child: _buildTabItem("View Bed Status", 1, activeTabIndex),
          ),
        ],
      ),
    );
  }

  static Widget _buildTabItem(String title, int index, int activeIndex) {
    bool isActive = activeIndex == index;
    return Container(
      padding: const EdgeInsets.only(bottom: 12, right: 16, left: 8),
      decoration: BoxDecoration(
        border: isActive
            ? const Border(
                bottom: BorderSide(color: Color(0xFF117A7A), width: 2),
              )
            : null,
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          color: isActive ? const Color(0xFF117A7A) : Colors.grey.shade600,
        ),
      ),
    );
  }

  static Widget buildQuickActions(
    BuildContext context,
    double width,
    String patientName,
    String crn, {
    String activeLabel = '',
  }) {
    // --- UPDATED: Using exact base names for SVG assets ---
    final actions = [
      {'icon': 'admissionnotes', 'label': 'Admission Notes'},
      {'icon': 'accompanied', 'label': 'Accompanied By'},
      {'icon': 'viewreferral', 'label': 'View Referral'},
      {'icon': 'diagnosis', 'label': 'Diagnosis'},
      {'icon': 'docsuploads', 'label': 'Upload Ext. Health Rec'},
      {
        'icon': 'admissionnotes',
        'label': 'Previous Admissions',
      }, // Update if you have a specific icon for this
    ];

    // Ensure identical horizontal and vertical sizes (perfect squares)
    // Calculate width: screen width - screen padding (32) - container padding (32) - spacing (36) / 4 items
    double itemSize = (width - 32 - 32 - 36) / 4;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Row(
            children: [
              const Icon(
                Icons.access_time_outlined,
                size: 18,
                color: Colors.black87,
              ),
              const SizedBox(width: 8),
              Text(
                "Quick Actions",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: actions.map((item) {
              bool isActive = item['label'] == activeLabel;

              return InkWell(
                onTap: () {
                  if (item['label'] == 'Admission Notes') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AdmissionScreen(patientName: patientName, crn: crn),
                      ),
                    );
                  } else if (item['label'] == 'Accompanied By') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AccompaniedByScreen(
                          patientName: patientName,
                          crn: crn,
                        ),
                      ),
                    );
                  } else if (item['label'] == 'View Referral') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ViewReferralScreen(
                          patientName: patientName,
                          crn: crn,
                        ),
                      ),
                    );
                  } else if (item['label'] == 'Diagnosis') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DiagnosisScreen(patientName: patientName, crn: crn),
                      ),
                    );
                  } else if (item['label'] == 'Upload Ext. Health Rec') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DocumentUploadScreen(
                          patientName: patientName,
                          crn: crn,
                        ),
                      ),
                    );
                  } else if (item['label'] == 'Previous Admissions') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PreviousAdmissionsScreen(
                          patientName: patientName,
                          crn: crn,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  width: itemSize,
                  height: itemSize, // Forces the box to be a perfect square
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF117A7A)
                        : const Color(0xFFE0F7F7).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- UPDATED: Using SvgPicture ---
                      SvgPicture.asset(
                        "assets/${item['icon']}.svg",
                        width: 20,
                        height: 20,
                        colorFilter: ColorFilter.mode(
                          isActive ? Colors.white : Colors.black87,
                          BlendMode.srcIn,
                        ),
                        fit: BoxFit.contain,
                        placeholderBuilder: (context) => const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 1),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['label'] as String,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: isActive
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isActive ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
