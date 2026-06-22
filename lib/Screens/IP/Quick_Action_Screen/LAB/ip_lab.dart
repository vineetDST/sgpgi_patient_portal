import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';


class IPLabReportsScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const IPLabReportsScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<IPLabReportsScreen> createState() => _LabReportsScreenState();
}

class _LabReportsScreenState extends State<IPLabReportsScreen> {
  @override
  Widget build(BuildContext context) {

    return IpBaseScaffold(
      title: "Lab Reports",
      quickActionLabel: "Lab",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction:
      true,
      // We only pass the content that is unique to the Lab Reports screen below the Quick Actions
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lab Reports",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IPActionButton(),
            ],
          ),
          const SizedBox(height: 16),

          _buildTotalCostTable1(),
          const SizedBox(height: 20),
        ],
      ),


    );
  }




  Widget _buildTotalCostTable1() {
    return ScrollableDataTable(
      labels: const [
        "Investigation\nName",
        "Order No",
        "Date",
        "Order Status",
        "Link",
        "New Link",
      ],
      // Har array me 2 values hain, jo horizontally scroll hongi
      rowValues: [
        // 1. Investigation Name Row
        [
          const Text("0.1. S. Glucose (F)", style: TextStyle(fontSize: 13)),
          const Text("0.1. S. Glucose (F)", style: TextStyle(fontSize: 13)),

        ],
        // 2. Order No Row
        [
          const Text("ORDER202500068", style: TextStyle(fontSize: 13)),
          const Text("ORDER202500068", style: TextStyle(fontSize: 13)),

        ],
        // 3. Date Row (Pehla khali hai image me)
        [
          const Text("08-10-2025", style: TextStyle(fontSize: 13)),
          const Text("08-10-2025", style: TextStyle(fontSize: 13)),
        ],
        // 4. Order Status Row
        [
          _buildStatusBadge("Ordered"), // Pehla badge (half cut in image)
          _buildStatusBadge("Ordered"), // Dusra badge
        ],
        // 5. Link Row
        [
          const Text("Link", style: TextStyle(fontSize: 13, color: Color(0xFF117A7A))),
          const Text("Link", style: TextStyle(fontSize: 13, color: Color(0xFF117A7A))),
        ],
        // 6. New Link Row
        [
          Image.asset('assets/pdf.png', height: 24, width: 24),
          Image.asset('assets/pdf.png', height: 24, width: 24),
        ],
      ],
    );
  }

// 🎨 Badge banane ke liye chota sa reusable function
  Widget _buildStatusBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }
}
