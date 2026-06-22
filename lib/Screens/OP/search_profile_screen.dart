import 'package:flutter/material.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

import 'package:qc_hospital/Screens/OP/op_consultation.dart';
import 'package:qc_hospital/Screens/OP_IP_Workbench/workbench.dart'; // To reuse LoginOptionCard

class SearchProfileScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const SearchProfileScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<SearchProfileScreen> createState() => _SearchProfileScreenState();
}

class _SearchProfileScreenState extends State<SearchProfileScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate a brief loading state to allow keyboard to close
    // and prevent any overflow visual glitches during transition.
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return ClinicalBaseScaffold(
      title: "OP Consultation",
      showDrawer: true,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction:
          'Admission', // Ignored visually, satisfies required parameter
      child: _isLoading
          ? SizedBox(
              height:
                  height * 0.5, // Provide bounded height for loading spinner
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFF117A7A)),
              ),
            )
          : Stack(
              alignment: Alignment
                  .center, // Aligns both watermark and cards to the center
              children: [
                // Central Watermark Logo (SGPGI)
                // Opacity(
                //   opacity: 0.15,
                //   child: Image.asset(
                //     "assets/op_ip_workbench_logo_3.png",
                //     height: height * 0.3,
                //   ),
                // ),

                // Foreground Content (Workbench Buttons)
                Column(
                  children: [
                    SizedBox(height: height * 0.05),
                    Image.asset(
                      "assets/op_ip_workbench_logo_3.png",
                      height: height * 0.2,
                    ),
                    // Uses fixed spacing instead of Spacer() to avoid SingleChildScrollView crash
                    SizedBox(height: height * 0.05),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          LoginOptionCard(
                            title: "OP Workbench",
                            image: "op_workbench",
                            onTap: () {
                              // --- ROUTE 3: Patient Specific OP Consultant Dashboard ---
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OpConsultation(
                                    patientName: widget.patientName,
                                    crn: widget.crn,
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: height * 0.03),
                          LoginOptionCard(
                            title: "IP Workbench",
                            image: "ip_workbench",
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.1), // Bottom padding
                  ],
                ),
              ],
            ),
    );
  }
}
