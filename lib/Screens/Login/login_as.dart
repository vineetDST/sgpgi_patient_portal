import 'package:flutter/material.dart';
import 'package:qc_hospital/Screens/Login/login.dart';

class LoginAs extends StatefulWidget {
  @override
  State<LoginAs> createState() => _LoginAsState();
}

class _LoginAsState extends State<LoginAs> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image with Teal Overlay
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
                  // const Color(0xFF2C8C98).withOpacity(0.85), // Light teal top
                  // const Color(0xFF103F4A).withOpacity(0.95), // Dark teal bottom
                  const Color(0xFF298DA7).withOpacity(0.8),
                  const Color(0xFF002030).withOpacity(0.9),
                ],
              ),
            ),
          ),

          // 3. Main Content (Logo and Buttons)
          SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.09),
                  Container(
                    child: Image.asset(
                      "assets/Onboarding_logo_4.png",
                      height: height * 0.22,
                    ),
                  ),
                  SizedBox(height: height * 0.045),

                  LoginOptionCard(
                    title: "Doctor Login",
                    image: "doctor_login_2",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LoginScreen(loginby: "doctor");
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.035),
                  LoginOptionCard(
                    title: "Blood Bank Login",
                    image: "bloodbank_login_2",
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return LoginScreen(loginby: "bloodbank");
                          },
                        ),
                      );
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
}

// --- Reusable Widget for the Login Buttons ---
class LoginOptionCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const LoginOptionCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,

          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(22),

                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFBEE9E8), Color(0xFFC7F9CC)],
                  ),
                ),
                child: Image.asset(
                  "assets/${image}.png",
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
              ),
              SizedBox(width: 20),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.02,
                    color: Color(0xFF1E1E1E),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
