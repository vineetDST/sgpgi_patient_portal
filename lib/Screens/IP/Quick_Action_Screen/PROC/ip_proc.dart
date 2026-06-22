import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class IPProcedureReportsScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const IPProcedureReportsScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<IPProcedureReportsScreen> createState() => _ProcedureReportsScreenState();
}

class _ProcedureReportsScreenState extends State<IPProcedureReportsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return IpBaseScaffold(
      title: "Procedure Reports",
      quickActionLabel: "Proc",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction:
      true,
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
              IPActionButton(),
            ],
          ),
          const SizedBox(height: 16),

          _buildReportTable(),
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
