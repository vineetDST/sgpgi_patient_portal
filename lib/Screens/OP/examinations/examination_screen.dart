import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// Import the next screen
import 'package:qc_hospital/Screens/OP/examinations/general_physical_examination_screen.dart';
import 'package:qc_hospital/Screens/OP/examinations/systemic_examination_screen.dart';
import 'package:qc_hospital/Screens/OP/examinations/image_annotation_screen.dart';

class ExaminationScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ExaminationScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ExaminationScreen> createState() => _ExaminationScreenState();
}

class _ExaminationScreenState extends State<ExaminationScreen> {
  int _bottomNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Examinations",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Examinations',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: MediaQuery.of(context).padding.top + kToolbarHeight + 10,
          // ),
          // SharedComponents.buildPatientCard(
          //   context,
          //   screenWidth,
          //   widget.patientName,
          //   widget.crn,
          // ),
          // const SizedBox(height: 24),
          // SharedComponents.buildQuickActions(
          //   context,
          //   screenWidth,
          //   widget.patientName,
          //   widget.crn,
          //   activeLabel: 'Examinations',
          // ),
          // const SizedBox(height: 24),

          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Examination",
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

          // Examination Cards
          _buildExamCard(
            title: "General Physical Examination",
            imageUrl: 'assets/exambg1.png', // Blood pressure placeholder
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GeneralPhysicalExaminationScreen(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildExamCard(
            title: "Systemic Examination",
            imageUrl: 'assets/exambg2.png', // Doctor tablet placeholder
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SystemicExaminationScreen(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            }, // Add route when needed
          ),
          const SizedBox(height: 12),

          _buildExamCard(
            title: "Image Annotation",
            imageUrl: 'assets/exambg3.png', // Anatomy placeholder
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageAnnotationScreen(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            }, // Add route when needed
          ),

          const SizedBox(height: 20),
        ],
      ),

      // bottomNavigationBar: CustomCurvedNavigationBar(
      //   index: _bottomNavIndex,
      //   height: 75.0,
      //   items: const <Widget>[
      //     Icon(Icons.home_filled, size: 26, color: Colors.white),
      //     Icon(Icons.medical_services, size: 26, color: Colors.white),
      //     Icon(Icons.add_business_outlined, size: 26, color: Colors.white),
      //     Icon(Icons.notifications, size: 26, color: Colors.white),
      //   ],
      //   color: AppColor.white,
      //   buttonBackgroundColor: AppColor.color117A7A,
      //   backgroundColor: Colors.transparent,
      //   onTap: (index) => setState(() => _bottomNavIndex = index),
      // ),
    );
  }

  Widget _buildExamCard({
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
            // image: NetworkImage(imageUrl), // Using high quality placeholders
            fit: BoxFit.cover,
            // Adds the dark overlay so the white text reads clearly just like the UI
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
