import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Utils/scaffold_messenger.dart';

import 'package:qc_hospital/Screens/Login/login.dart';



class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgetPassword> {

  final newPwdController = TextEditingController();
  final cnfPwdController = TextEditingController();

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
                    controller: newPwdController,
                    hintText: "****",
                    icon: Icons.vpn_key_outlined,
                    isPassword: true, // Assuming this handles the eye icon logic inside
                  ),
                  SizedBox(height: 16),
                  // OTP Field Section

                  buildFormLabel("Confirm Password", isRequired: true),
                  SizedBox(height: 8),
                  LoginInputField(
                    controller: cnfPwdController,
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
                               _changePassword(context);
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

  void _changePassword(BuildContext context) {

    var newPwd = newPwdController.text.toString() ;
    var cnfPwd = cnfPwdController.text.toString() ;

    if(newPwd == null || newPwd.isEmpty) {
       _showError(context, 'Please enter New Password field');
    }
    else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$').hasMatch(newPwd)) {
      _showError(context, 'New Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a number, and a special character, and must not contain spaces.');
    }

    else if(cnfPwd == null || cnfPwd.isEmpty) {
      _showError(context, 'Please enter Confirm Password field');
    }
    else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$').hasMatch(cnfPwd)) {
      _showError(context, 'Confirm Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a number, and a special character, and must not contain spaces.');
    }
    else if(newPwd != cnfPwd){
      _showError(context, 'New Password & Confirm Password should be same');
    }
    else {
      // DummyData.password = cnfPwd.toString();
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      //    return LoginScreen(loginby: '');
      // }), (route) => false) ;

      DummyData.password = cnfPwd.toString();
      scaffoldMessenger(
        context,
        title: "Forget Password",
        message: 'Password is changed sucessfully',
        type: NotificationType.success,
      );

      Future.delayed(const Duration(seconds: 3), () {

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return LoginScreen(loginby: '');
            }),
                (route) => false,
          );
        }
      });
    }



  }

  void _showError(BuildContext context,String message) {
    scaffoldMessenger(
      context,
      title: "Forget Password",
      message: message,
      type: NotificationType.error,
    );
  }
}