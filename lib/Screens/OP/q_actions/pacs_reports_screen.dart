import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class PacsReportsScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const PacsReportsScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<PacsReportsScreen> createState() => _PacsReportsScreenState();
}

class _PacsReportsScreenState extends State<PacsReportsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ClinicalBaseScaffold(
      title: "PACS Reports",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction:
          'Rad', // Highlights this icon in the Quick Actions list
      // We only pass the content that is unique to the PACS Reports screen below the Quick Actions
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PACS Reports",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

          _buildReportTable(),
          const SizedBox(height: 20),
        ],
      ),


    );
  }

  Widget _buildReportTable() {
    return DetailTableWrapper(
      children: [
        _buildRow(
          "Investigation\nName",
          Text(
            "CT - Abdomen + Contrast",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
        _buildDivider(),
        _buildRow(
          "Order No",
          Text(
            "ORDER202500068",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
        _buildDivider(),
        _buildRow(
          "Date",
          Text(
            "08-10-2025",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
        _buildDivider(),
        _buildRow(
          "Order Status",
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Ordered",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        _buildDivider(),
        _buildRow(
          "Link",
          Text(
            "Link",
            style: TextStyle(fontSize: 13, color: Color(0xFF117A7A)),
          ),
        ),
        _buildDivider(),
        _buildRow(
          "New Link",
          Image.asset(
            'assets/pdf.png', // 👈 your image path
            height: 24,
            width: 24,
          ),
        ),
      ]
    );
  }

  Widget _buildRow(String label, Widget content) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: const Color(0xFFEAF9F9),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          Container(width: 1, color: Colors.grey.shade300),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              alignment: Alignment.centerLeft,
              child: content,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);
}
