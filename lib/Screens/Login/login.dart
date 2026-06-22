import 'package:flutter/material.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Home/home.dart';
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
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
                  getLabel("User Name"),
                  SizedBox(height: 10),
                  LoginInputField(
                    hintText: "User Name",
                    icon: Icons.person_outline,
                    isPassword: false,
                  ),
                  SizedBox(height: 10),

                  getLabel("Password"),
                  SizedBox(height: 10),
                  LoginInputField(
                    hintText: "Password",
                    icon: Icons.vpn_key_outlined,
                    isPassword: true,
                  ),
                  SizedBox(height: 30),

                  AppButton(
                    text: "Login",
                    color: Colors.teal,
                    onTap: () {
                      print("Login tapped");
                      _login(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getLabel(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
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
    if (widget.loginby == "doctor") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            // return Workbench();
            return DoctorModuleShell();
          },
        ),
      );
    } else {
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => Workbench()),
      //         (Route<dynamic> route) => false);

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return BloodBankModuleShell();
          },
        ),
      );
    }
  }
}

class LoginInputField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const LoginInputField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.isPassword,
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
