import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart'; // REQUIRED FOR SVG ICONS
import 'package:qc_hospital/Screens/OP/preferences_screen.dart'; // Adjust this import path based on where you saved the file

class OpDrawer extends StatelessWidget {
  const OpDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.colorC7F9CC, // Light Green from your AppColor
              AppColor.colorBEE9E8, // Light Teal/Blue from your AppColor
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Close Button ---
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColor.color1E1E1E,
                      size: 28,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // --- Profile Section ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    // Profile Image
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.white.withOpacity(0.5),
                          width: 2,
                        ),
                        image: const DecorationImage(
                          image: AssetImage("assets/op_profile.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Name & Specialty
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DR. Ram Varma",
                          style: AppTextStyles.RegH3.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColor.color1E1E1E,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Cardiology",
                          style: AppTextStyles.RegH3.copyWith(
                            fontSize: 14,
                            color: AppColor.color717171, // Grey from AppColor
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // --- Preference Item ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Navigator.pop(context); // Closes the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PreferenceScreen(),
                      ),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon and Badge Column
                      Column(
                        children: [
                          // Preference Icon
                          SizedBox(
                            child: SvgPicture.asset(
                              'assets/preference_icon.svg',
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                                Colors.black87,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),

                      const SizedBox(width: 16),

                      // Label
                      Padding(
                        padding: const EdgeInsets.only(top: 6.0),
                        child: Text(
                          "Preference",
                          style: AppTextStyles.RegH3.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColor.color1E1E1E,
                          ),
                        ),
                      ),
                    ],
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
