import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/scaffold_messenger.dart';

import 'package:qc_hospital/Screens/Login/login.dart';



class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgetPassword> {
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


                  buildFormLabel("New Password", isRequired: true),
                  SizedBox(height: 8),
                  LoginInputField(

                    hintText: "****",
                    icon: Icons.vpn_key_outlined,
                    isPassword: true, // Assuming this handles the eye icon logic inside
                  ),
                  SizedBox(height: 16),
                  // OTP Field Section

                  buildFormLabel("Confirm Password", isRequired: true),
                  SizedBox(height: 8),
                  LoginInputField(
                    hintText: "****",
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
                              backgroundColor: const Color(0xFF147B74), // Match submit color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                            onPressed: () {
                              scaffoldMessenger(
                                context,
                                title: "Success",
                                message: "Registration completed successfully.",
                                type: NotificationType.success,
                              );
                            },
                            child: const Text(
                              'Save',
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



  static Widget buildFormLabel(String text, {bool isRequired = false,}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(
            fontSize: 13,

            color: Colors.white,
          ),
          children: isRequired
              ? [
            const TextSpan(
              text: ' *',
              style: TextStyle(color: Colors.red),
            ),
          ]
              : [],
        ),
      ),
    );
  }
}