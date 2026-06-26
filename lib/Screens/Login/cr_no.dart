import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Home/home.dart';
import 'package:qc_hospital/Screens/Login/login.dart';
import 'package:qc_hospital/Screens/Login/online_registration.dart';
import 'package:qc_hospital/Screens/Login/opd_schedule.dart';
import 'package:qc_hospital/Screens/Login/otp.dart';
import 'package:qc_hospital/Screens/OP_IP_Workbench/workbench.dart';
import 'package:qc_hospital/Widgets/blood_bank_module_shell.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Widgets/app_button.dart';

class CrNo extends StatefulWidget {

  CrNo({super.key,  });

  @override
  State<CrNo> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<CrNo> {

  final int _numPages = 3;
  int _currentPage = 0;

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
                  // const Color(0xFF2C8C98).withOpacity(0.7), // Light teal top
                  // const Color(0xFF103F4A).withOpacity(0.8), // Dark teal bottom
                  const Color(0xFF298DA7).withOpacity(0.8),
                  const Color(0xFF002030).withOpacity(0.9),
                ],
              ),
            ),
          ),

          // 3. Main Content (Scrollable)
          SafeArea(
            child: SingleChildScrollView(
              // अगर कीबोर्ड खुलता है, तो स्क्रीन ऊपर-नीचे हो सकती है
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                // Stack के अंदर Column को पूरी हाइट लेने के लिए
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: height * 0.15),
                  Container(
                    child: Image.asset(
                      "assets/Onboarding_logo_4.png",
                      height: height * 0.22,
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Forget Password",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: height * 0.032,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                        SizedBox(height: 10),

                        Text(
                          "Hospital Information System",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: height * 0.022,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Sanjay Gandhi Postgraduate Institute of Medical Sciences",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xB2FFFFFF),
                              fontSize: height * 0.016,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  getLabel("Hospital CR No."),
                  SizedBox(height: 10),
                  LoginInputField(
                    hintText: "Enter the CR No.",
                    icon: Icons.person_outline,
                    isPassword: false,
                  ),
                  SizedBox(height: 24),








                  AppSaveButton(text: 'Submit',onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {

                          return Otp();
                        },
                      ),
                    );
                  },),
                  SizedBox(height: 24),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getLabel(String label,{bool removePadding = false}) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: removePadding ? 0 : 10),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }





}

