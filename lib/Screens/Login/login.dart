import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/scaffold_messenger.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Home/home.dart';
import 'package:qc_hospital/Screens/Dashboard/dashboard.dart';
import 'package:qc_hospital/Screens/Drawer/acc_stmt.dart';
import 'package:qc_hospital/Screens/Drawer/ped_balance.dart';
import 'package:qc_hospital/Screens/Login/cr_no.dart';
import 'package:qc_hospital/Screens/Login/online_registration.dart';
import 'package:qc_hospital/Screens/Login/opd_schedule.dart';
import 'package:qc_hospital/Screens/NavigationBar/online_payment.dart';
import 'package:qc_hospital/Screens/OP_IP_Workbench/workbench.dart';
import 'package:qc_hospital/Widgets/blood_bank_module_shell.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Widgets/app_button.dart';

class LoginScreen extends StatefulWidget {
  String loginby;
  LoginScreen({super.key, required this.loginby});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController crnoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController continueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    crnoController.text = 'Asgar';
    passwordController.text = 'Asgar@123';
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
                  SizedBox(height: height * 0.09),
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
                          "Login",
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

                  getLabel("CR No."),
                  SizedBox(height: 10),
                  LoginInputField(
                    controller: crnoController,
                    hintText: "Enter the CR No.",
                    icon: Icons.person_outline,
                    isPassword: false,
                  ),
                  SizedBox(height: 10),

                  getLabel("Password"),
                  SizedBox(height: 10),
                  LoginInputField(
                    controller: passwordController,
                    hintText: "Password",
                    icon: Icons.vpn_key_outlined,
                    isPassword: true,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                // return ForgotPassword();
                                return CrNo();
                              },
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(color: Colors.transparent),
                          child: getLabel(
                            'Forgot Password?New User',
                            removePadding: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  AppSaveButton(
                    text: 'Login',
                    onPressed: () {
                      _login(context);
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: AppSaveButton(
                          size: 14,
                          text: 'Online Registration',
                          onPressed: () {
                            // Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //    return OnlineRegistration();
                            // }));

                            DummyData.registration = 0;
                            showPatientRegistrationDialog(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: AppSaveButton(
                          size: 14,
                          text: 'OPD Schedule',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return OpdSchedule();
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getLabel(String label, {bool removePadding = false}) {
    return Container(
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

  void _login(BuildContext context) {
    print("Login");

    String crnoText = crnoController.text;
    if (crnoText == null || crnoText.isEmpty) {
      scaffoldMessenger(
        context,
        title: 'Login Credentials',
        message: 'Please Enter CR No. Field',
        type: NotificationType.error,
      );
      return;
    }

    String pwdText = passwordController.text;
    if (pwdText == null || pwdText.isEmpty) {
      scaffoldMessenger(
        context,
        title: 'Login Credentials',
        message: 'Please Enter Password Field',
        type: NotificationType.error,
      );
      return;
    } else if (!RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$',
    ).hasMatch(pwdText)) {
      setState(() {
        scaffoldMessenger(
          context,
          title: 'Login Credentials',
          message:
              'Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a number, and a special character, and must not contain spaces.',
          type: NotificationType.error,
        );
        return;
      });
    } else if (pwdText != DummyData.password) {
      scaffoldMessenger(
        context,
        title: 'Login Credentials',
        message: 'Password is not matched',
        type: NotificationType.error,
      );
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return DoctorModuleShell();
          },
        ),
      );
    }
  }

  // 🛠️ Is function ko kisi button ke onPressed se call karein
  void showPatientRegistrationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Dialog ke bahar click karne se close na ho
      builder: (BuildContext context) {
        bool isChecked = true; // Default checkbox state jaisa image me hai

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min, // Jaisa content utni height
                children: [
                  // ==========================================
                  // 1. GRADIENT HEADER
                  // ==========================================
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFC6F2D6), // Light Green
                          Color(0xFFBCEBEB), // Light Blue
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Patient Online Registration Form',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                        InkWell(
                          onTap: () =>
                              Navigator.pop(context), // Close button action
                          child: const Icon(
                            Icons.close,
                            color: Colors.black87,
                            size: 22,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ==========================================
                  // 2. DIALOG BODY (Instructions & Checkbox)
                  // ==========================================
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Instructions For Filling the Pre Registration Form',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Bullet Points
                        _buildBulletPoint(
                          'You can do advance booking for next one month only.',
                        ),
                        const SizedBox(height: 12),
                        _buildBulletPoint(
                          'While choosing the department, please be informed about the working days of that department.',
                        ),
                        const SizedBox(height: 12),
                        _buildBulletPoint(
                          'Please take a print out of online registration form.',
                        ),
                        const SizedBox(height: 12),
                        _buildBulletPoint(
                          'Please arrive at the hospital before 10.00 AM and report to the online registration counter with your referral documents with this online registration form.',
                        ),

                        const SizedBox(height: 24),

                        // Checkbox Row
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: isChecked,
                                activeColor: const Color(
                                  0xFF147B74,
                                ), // Teal color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'I have read all the above instructions',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Continue Button
                        Center(
                          child: SizedBox(
                            width: 120,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF147B74,
                                ), // Teal color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                elevation: 0,
                              ),
                              onPressed: () {
                                if (isChecked) {
                                  DummyData.registration = 0;
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return OnlineRegistration();
                                      },
                                    ),
                                  );
                                } else {
                                  scaffoldMessenger(
                                    context,
                                    title: 'Patient Online Registration Form',
                                    message: 'Please select Instructions field',
                                    type: NotificationType.error,
                                  );
                                }
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // 🛠️ Helper method bullet points ke design ke liye
  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6.0, right: 8.0, left: 4.0),
          child: Icon(
            Icons.circle,
            size: 3,
            color: Colors.grey, // Bullet dot color
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Colors.black54, // Image ki tarah thoda grayish text
              // height: 1.5, // Line spacing
            ),
          ),
        ),
      ],
    );
  }
}

class LoginInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  TextEditingController? controller;
  FocusNode? focusNode;
  TextInputType? keyboardType;
  Function(String)? onChanged;

  LoginInputField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.isPassword,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.onChanged,
  });

  @override
  State<LoginInputField> createState() => _LoginInputFieldState();
}

class _LoginInputFieldState extends State<LoginInputField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 15,horizontal: 15),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),

        border: Border.all(color: Colors.white, width: 1.0),
      ),
      child: Row(
        children: [
          Container(
            child: Icon(widget.icon, color: Color(0xFFB7B7B7), size: 15),
          ),

          const SizedBox(
            height: 15, //
            child: VerticalDivider(color: Colors.grey, thickness: 1, width: 20),
          ),

          Expanded(
            // TextField को बची हुई सारी जगह लेने के लिए
            child: TextFormField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              obscureText: _obscureText,
              obscuringCharacter: "*",
              style: TextStyle(
                color: Color(0xFF1E1E1E),
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.height * 0.016,
                decoration: TextDecoration.none,
              ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Color(0xFFB7B7B7),
                  fontWeight: FontWeight.w400,
                  fontSize: MediaQuery.of(context).size.height * 0.016,
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                isDense: true,

                border: InputBorder.none,
              ),
              keyboardType: widget.keyboardType,
              onChanged: widget.onChanged,
            ),
          ),
          widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Container(
                    child: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Color(0xFFB7B7B7),
                      size: 17,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
