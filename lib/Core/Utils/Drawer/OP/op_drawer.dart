import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qc_hospital/Screens/Drawer/acc_stmt.dart';
import 'package:qc_hospital/Screens/Drawer/duplicate_recepits.dart';
import 'package:qc_hospital/Screens/Drawer/investigation_order.dart';
import 'package:qc_hospital/Screens/Drawer/ped_balance.dart';
import 'package:qc_hospital/Screens/Login/login.dart';
import 'package:qc_hospital/Screens/OP/preferences_screen.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

class OpDrawer extends StatefulWidget {
  const OpDrawer({super.key});

  @override
  State<OpDrawer> createState() => _OpDrawerState();
}

class _OpDrawerState extends State<OpDrawer> {
  int _expandedIndex = -1;

  final List<Map<String, dynamic>> _menuData = [
    {'title': 'PED Balance', 'icon': 'ped_balance'},
    {'title': 'Account Statement', 'icon': 'acc_stmt'},
    {'title': 'Investigation Orders', 'icon': 'investigation'},
    {'title': 'Duplicate Receipt', 'icon': 'duplicate'},
  ];

  String name = DummyData.dummyProfile['name'];
  String crn = DummyData.dummyProfile['crn'];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      // backgroundColor: Colors.white, // Drawer ka base background white
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColor.colorC7F9CC, // Light Green
              AppColor.colorBEE9E8, // Light Teal/Blue
            ],
          ),
        ),
        // SafeArea top ke liye zaroori hai (status bar avoid karne ke liye)
        child: Column(
          children: [
            // --- TOP SECTION (Gradient Setup) ---
            Expanded(
              child: SafeArea(
                bottom: false, // Niche ki safe area yahan allow mat karo
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Row(
                              children: [
                                // Profile Image
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.5),
                                      width: 2,
                                    ),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        "assets/op_profile.png",
                                      ),
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
                                      name,
                                      style: AppTextStyles.RegH3.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: AppColor.color1E1E1E,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      crn,
                                      style: AppTextStyles.RegH3.copyWith(
                                        fontSize: 14,
                                        color: AppColor.color717171,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              padding: EdgeInsets.only(right: 10),
                              color: Colors.transparent,
                              child: Icon(
                                Icons.close,
                                size: MediaQuery.of(context).size.height * 0.03,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    // --- Menu List ---
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _menuData.length,
                        itemBuilder: (context, index) {
                          return _buildMenuItem(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- BOTTOM SECTION (White Background for Logout) ---
            Container(
              color: Colors.transparent,
              // Isko explicitly white diya hai
              child: SafeArea(
                top: false, // Top safe area pehle hi handle ho chuki hai
                child: ListTile(
                  horizontalTitleGap: 1,
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: AppColor.color1E1E1E,
                      fontWeight: FontWeight.w400,
                      fontSize: MediaQuery.of(context).size.height * 0.018,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    _showLogoutDialog(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(int index) {
    final item = _menuData[index];
    final bool isOpen = _expandedIndex == index;
    final Color titleColor = isOpen
        ? AppColor.color117A7A
        : AppColor.color1E1E1E;
    final Color iconColor = isOpen
        ? AppColor.color117A7A
        : AppColor.color1E1E1E;

    return InkWell(
      onTap: () {
        Widget? targetScreen;
        int? targetTabIndex;

        if (index == 0) {
          targetScreen = PedBalance(patientName: name, crn: crn);
        } else if (index == 1) {
          targetScreen = AccStmt(patientName: name, crn: crn);
        } else if (index == 2) {
          targetScreen = InvestigationOrder(patientName: name, crn: crn);
        } else if (index == 3) {
          targetScreen = DuplicateRecepits(patientName: name, crn: crn);
        }

        if (targetScreen != null) {
          // 1. Pehle drawer ko close karein
          Navigator.of(context).pop();
          if (targetTabIndex != null) {
            doctorShellKey.currentState?.changeTab(index);
          } else {
            doctorShellKey.currentState?.pushToCurrentTab(targetScreen);
          }
        }
      },
      splashColor: Colors.red.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              "assets/${item['icon']}.svg",
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
            const SizedBox(width: 12),
            Text(
              item['title'],
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.w400,
                fontSize: MediaQuery.of(context).size.height * 0.018,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Dialog Implementation ---
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      size: 26,
                      color: Color(0xFF001533),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Image.asset('assets/logout_2.png', width: 40, height: 40),
                const SizedBox(height: 20),
                const Text(
                  "Are you sure you want to\nLogout?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E1E1E),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LoginScreen(loginby: ''),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC00000),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
