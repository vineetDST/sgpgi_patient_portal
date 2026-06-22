import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';

class SendSmsScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const SendSmsScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<SendSmsScreen> createState() => _SendSmsScreenState();
}

class _SendSmsScreenState extends State<SendSmsScreen> {
  int _bottomNavIndex = 1;
  String? _hbMethod = "--Select--";

  final TextEditingController _composeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return IpBaseScaffold(
      title: "Send SMS",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Send SMS",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Compose Message"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: "Compose Message",
            maxLines: 5,
            controller: _composeController
            // height: 130,
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SharedComponents.buildFormLabel("Send To"),
                    const SizedBox(height: 8),
                    // SharedComponents.buildDropdown(hintText: "Admin"),
                    ExpandedDropdown(
                      value: _hbMethod,
                      items: [
                        '--Select--',
                        'Admin',
                        'Manager',
                        'Sales',
                      ],
                      onChanged: (v) => setState(() => _hbMethod = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SharedComponents.buildFormLabel("Mobile"),
                    const SizedBox(height: 8),
                    SharedComponents.buildTextField(hintText: "Mobile"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                "Save/Print",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Center(
            child: Text(
              "Note: Use for sending SMS to multiple persons",
              style: TextStyle(
                fontSize: 12,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
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
      //   onTap: (index) => setState(() => _bottomNavIndex = index),
      // ),
    );
  }
}
