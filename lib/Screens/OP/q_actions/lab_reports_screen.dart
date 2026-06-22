import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class LabReportsScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const LabReportsScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<LabReportsScreen> createState() => _LabReportsScreenState();
}

class _LabReportsScreenState extends State<LabReportsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ClinicalBaseScaffold(
      title: "Lab Reports",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction:
          'Lab', // Highlights this icon in the Quick Actions list
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

          _buildTotalCostTable1(),
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
