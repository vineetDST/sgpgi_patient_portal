import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: OpAppbar(
        title: "Patient Profile",
        showDrawer: false, // Enables the back button
        appheight: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1F2F2), Colors.white, Colors.white],
            stops: [0.0, 0.25, 1.0], // Gradient fades out a bit higher up
          ),
        ),
        child: SafeArea(
          top: false, // Ensure it draws behind the app bar gradient
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height:
                      MediaQuery.of(context).padding.top + kToolbarHeight + 20,
                ),

                // Center Profile Image
                Center(
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      image: const DecorationImage(
                        image: AssetImage("assets/a.png"), // Uses same asset
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Profile Fields
                _buildProfileField("CRN Number", crn),
                const SizedBox(height: 16),
                _buildProfileField("Name", patientName),
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
              ],
            ),
          ),
        ),
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
