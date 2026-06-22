import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/cpoes/investigation_screen.dart';

// --- Make sure to use the correct paths for your project ---
import 'package:qc_hospital/Screens/OP/cpoes/prev_investigation_screen.dart';
import 'package:qc_hospital/Screens/OP/cpoes/drug_screen.dart';
import 'package:qc_hospital/Screens/OP/cpoes/material_screen.dart';
import 'package:qc_hospital/Screens/OP/cpoes/order_set_screen.dart';
import 'package:qc_hospital/Screens/OP/cpoes/diet_prescription_screen.dart';
import 'package:qc_hospital/Screens/OP/cpoes/prescription_screen.dart';

class CpoeScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const CpoeScreen({super.key, required this.patientName, required this.crn});

  @override
  State<CpoeScreen> createState() => _CpoeScreenState();
}

class _CpoeScreenState extends State<CpoeScreen> {
  int _bottomNavIndex = 1;
  // he
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "CPOE",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'CPOE',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "CPOE",
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

          _buildImageCard(
            title: "Investigation",
            imageUrl: 'assets/cpoebg1.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InvestigationScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildImageCard(
            title: "Drug",
            imageUrl: 'assets/cpoebg2.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DrugScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildImageCard(
            title: "Material",
            imageUrl: 'assets/cpoebg3.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MaterialScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildImageCard(
            title: "Order set",
            imageUrl: 'assets/cpoebg4.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderSetScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildImageCard(
            title: "Diet Prescription",
            imageUrl: 'assets/cpoebg5.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DietPrescriptionScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          _buildImageCard(
            title: "Prescription",
            imageUrl: 'assets/cpoebg6.png',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PrescriptionScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );

    // bottomNavigationBar: CustomCurvedNavigationBar(
    //   index: _bottomNavIndex,
    //   height: 10.0,
    //   color: AppColor.white,
    //   buttonBackgroundColor: AppColor.color117A7A,
    //   backgroundColor: Colors.transparent,
    //   items: const [
    //     Icon(Icons.home_filled, size: 26, color: Colors.white),
    //     Icon(Icons.medical_services, size: 26, color: Colors.white),
    //     Icon(Icons.add_business_outlined, size: 26, color: Colors.white),
    //     Icon(Icons.notifications, size: 26, color: Colors.white),
    //   ],
    //   onTap: (index) => setState(() => _bottomNavIndex = index),
    // ),
  }

  Widget _buildImageCard({
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(imageUrl),

            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5),
              BlendMode.darken,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
