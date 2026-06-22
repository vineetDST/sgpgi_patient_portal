import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class ProcedureReportsScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const ProcedureReportsScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<ProcedureReportsScreen> createState() => _ProcedureReportsScreenState();
}

class _ProcedureReportsScreenState extends State<ProcedureReportsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ClinicalBaseScaffold(
      title: "Procedure Reports",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction:
          'Proc', // Highlights this icon in the Quick Actions list
      // We only pass the content that is unique to the Procedure Reports screen below the Quick Actions
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Procedure Reports",
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
          "Service Name",
          Text(
            "CT - Abdomen + Contrast",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
        _buildDivider(),
        _buildRow(
          "Service Center",
          Text(
            "Clinical Chemistry",
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
        _buildRow("Result Status", SizedBox()),
        _buildDivider(),
        _buildRow(
          "Order Date",
          Text(
            "08-10-2025",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ),
        _buildDivider(),
        _buildRow(
          "View Report",
          Icon(Icons.visibility, color: Colors.black87, size: 20),
        ),
      ],
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
