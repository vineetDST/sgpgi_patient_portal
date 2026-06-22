import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';

import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_bottom_sheet.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_diet_prescription.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_drug_order.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_general.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_material.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_orderset.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_prescription.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_service_order.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';


class CpoeMainScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const CpoeMainScreen({super.key, required this.patientName, required this.crn});

  @override
  State<CpoeMainScreen> createState() => _CpoeScreenState();
}

class _CpoeScreenState extends State<CpoeMainScreen> {
  int _bottomNavIndex = 1;
  // he
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return IpBaseScaffold(
      title: "CPOE",
      quickActionLabel: "CPOE",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: true,
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
              IPActionButton(),
            ],
          ),
          const SizedBox(height: 16),

          _buildImageCard(
            title: "Service Order",
            imageUrl: 'assets/service_order.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IPServiceOrder(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildImageCard(
            title: "Drug Order",
            imageUrl: 'assets/drug_order.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IPDrugScreen(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildImageCard(
            title: "Material Order",
            imageUrl: 'assets/cpoebg2.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IPMaterialScreen(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildImageCard(
            title: "Order set",
            imageUrl: 'assets/cpoebg3.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IPOrderSetScreen(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildImageCard(
            title: "Diet Prescription",
            imageUrl: 'assets/cpoebg4.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IPDietPrescriptionScreen(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          _buildImageCard(
            title: "General",
            imageUrl: 'assets/cpoebg5.png',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IPGeneral(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildImageCard(
            title: "Prescription",
            imageUrl: 'assets/cpoebg6.png',
            onTap: () {
              print("Prescription");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IPPrescriptionScreen(
                    patientName: widget.patientName,
                    crn: widget.crn,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );


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
