import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class VisitSummaryScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const VisitSummaryScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<VisitSummaryScreen> createState() => _VisitSummaryScreenState();
}

class _VisitSummaryScreenState extends State<VisitSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ClinicalBaseScaffold(
      title: "Visit Summary",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction:
          'Summary', // Highlights this icon in the Quick Actions list
      // We only pass the content that is unique to the Visit Summary screen below the Quick Actions
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Visit Summary",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Container(
              //  padding: const EdgeInsets.symmetric(
              //   horizontal: 20,
              //   vertical: 8,
              //  ),
              //  decoration: BoxDecoration(
              //   color: const Color(0xFF1A1A1A),
              //   borderRadius: BorderRadius.circular(20),
              //  ),
              //  child: const Text(
              //   "Action",
              //   style: TextStyle(
              //    color: Colors.white,
              //    fontWeight: FontWeight.w600,
              //    fontSize: 12,
              //   ),
              //  ),
              // ),
              ElevatedButton(
                onPressed: () {
                  // --- SHOW BOTTOM SHEET CODE ---
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled:
                        true, // Allows sheet to be taller than half screen
                    useRootNavigator: true,

                    backgroundColor: Colors.transparent,
                    builder: (context) => OpActionBottomSheet(
                      patientName: widget.patientName,
                      crn: widget.crn,
                    ),
                  );
                  // ------------------------------
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.color1E1E1E,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                ),
                child: Text(
                  'Action',
                  style: AppTextStyles.RegH3.copyWith(color: AppColor.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildRichTextEditor(),
          const SizedBox(height: 32),

          SharedComponents.buildActionButtons(
            context,
            title: "Create Visit Summary",
          ),
          const SizedBox(height: 20),
        ],
      ),

      // bottomNavigationBar: CustomCurvedNavigationBar(
      //   index: 1,
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
      //   onTap: (index) {},
      // ),
    );
  }

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
          // Header Tabs
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

          // Toolbar Line 1
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

          // Toolbar Line 2
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

          // Text Area Input
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
