import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Screens/Login/forget_password.dart';

import 'package:qc_hospital/Screens/Login/login.dart';



class Otp extends StatefulWidget {
  Otp({super.key});

  @override
  State<Otp> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Otp> {

  @override
  void initState() {
    super.initState();
    // Jaise hi page open hoga, pehla OTP chala jayega
    sendInitialOtp();
  }

  void sendInitialOtp() async {
    await sendOTP();
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Login As.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 2. Teal Color Overlay to match the design
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF298DA7).withOpacity(0.8),
                  const Color(0xFF002030).withOpacity(0.9),
                ],
              ),
            ),
          ),

          // 3. Main Content (Scrollable)
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24), // Thoda aur padding diya
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height * 0.10), // Thoda kam height diya top se

                  // Logo
                  Container(
                    child: Image.asset(
                      "assets/Onboarding_logo_4.png",
                      height: height * 0.20,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Text Headers
                  Column(
                    children: [
                      Text(
                        "Forget Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: height * 0.032,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Hospital Information System",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: height * 0.022,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Sanjay Gandhi Postgraduate Institute of Medical Sciences",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(0xB2FFFFFF),
                            fontSize: height * 0.016,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  // ==========================================
                  // PATIENT DETAILS SECTION (Jo aapko chahiye tha)
                  // ==========================================
                  _buildDetailRow("Patient Name", "Atul Yadav"),
                  const SizedBox(height: 10),
                  _buildDetailRow("Current Mobile Number", "7565482376"),
                  const SizedBox(height: 10),
                  _buildDetailRow("Reference No", "1080"),

                  SizedBox(height: 25),

                  // OTP Field Section
                  getLabel("OTP", removePadding: true),
                  SizedBox(height: 8),
                  LoginInputField(
                    hintText: "Enter OTP",
                    icon: Icons.vpn_key_outlined,
                    isPassword: true, // Assuming this handles the eye icon logic inside
                  ),

                  SizedBox(height: 30),

                  // Buttons Section
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF147B74), // Match resend color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () {
                              // Resend logic
                            },
                            child: const Text(
                              'Resend',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF147B74), // Match submit color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return ForgetPassword();
                                  },
                                ),
                              );
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Detail Row (Label : Value)
  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160, // Fixed width for label so colons align perfectly
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
            ),
          ),
        ),
        const Text(
          ":   ",
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: "Poppins",
            ),
          ),
        ),
      ],
    );
  }

  Widget getLabel(String label, {bool removePadding = false}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: removePadding ? 0 : 10),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}