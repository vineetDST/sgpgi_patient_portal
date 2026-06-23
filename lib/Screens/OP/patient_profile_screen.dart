import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Widgets/profile_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/profile/change_contact_screen.dart';
import 'package:qc_hospital/Screens/OP/profile/change_password_screen.dart';

class PatientProfileScreen extends StatelessWidget {
  final String patientName;
  final String crn;

  const PatientProfileScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileBaseScaffold(
      title: "Patient Profile",
      showDrawer: true,
      patientName: patientName,
      crn: crn,
      activeQuickAction: 'Patient Profile',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Center Profile Image
          // Center(
          //   child: Container(
          //     width: 130,
          //     height: 130,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(0.08),
          //           blurRadius: 15,
          //           offset: const Offset(0, 5),
          //         ),
          //       ],
          //       image: const DecorationImage(
          //         image: AssetImage("assets/a.png"), // Uses same asset
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 32),

          // Profile Fields
          _buildProfileField("CRN Number", crn),
          const SizedBox(height: 16),
          _buildProfileField("Name", patientName),
          const SizedBox(height: 16),
          _buildProfileField("User Login ID", "98765456789"),
          const SizedBox(height: 16),
          _buildProfileField("User Password", "*************"),
          const SizedBox(height: 16),
          _buildProfileField("Age & Gender", "24 / Male"),
          const SizedBox(height: 16),
          _buildProfileField("Mobile", "+91 9876543210"),
          const SizedBox(height: 16),
          _buildProfileField("Email", "ramsharma@gmail.com"),
          const SizedBox(height: 16),
          _buildProfileField(
            "Validity",
            "September 18, 2026",
            suffixIcon: Icons.calendar_month,
          ),
          const SizedBox(height: 16),
          _buildProfileField("Visit ID", "OP-001"),

          const SizedBox(height: 40), // Bottom padding
          Row(
            children: [
              Expanded(
                child: SharedComponents.buildButtons(
                  context,
                  title: "Change Contact",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeContactScreen(
                          patientName: patientName,
                          crn: crn,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SharedComponents.buildButtons(
                  context,
                  title: "Change Password",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangePasswordScreen(
                          patientName: patientName,
                          crn: crn,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Reusable widget for building the read-only form fields
  Widget _buildProfileField(
    String label,
    String value, {
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F7F7), // Light grey background
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54, // Greyed out text matching the image
                ),
              ),
              if (suffixIcon != null)
                Icon(suffixIcon, size: 20, color: Colors.grey.shade600),
            ],
          ),
        ),
      ],
    );
  }
}
