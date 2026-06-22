import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/HospitalBottomNavigationBar.dart';

// Import the drawers
import 'package:qc_hospital/Core/Utils/Drawer/drawer.dart';
import 'package:qc_hospital/Core/Utils/Drawer/OP/op_drawer.dart';

// --- Import your 4 Main Doctor Tab Screens ---
import 'package:qc_hospital/Screens/OP_IP_Workbench/workbench.dart'; // Tab 0: Home/Search
import 'package:qc_hospital/Screens/OP/op_workbench.dart'; // Tab 1: OP Root
import 'package:qc_hospital/Screens/IP/in_patient_screen.dart'; // Tab 2: IP Root
// --- UPDATED: Import the actual notifications screen ---
import 'package:qc_hospital/Screens/Notifications/notifications_screen.dart'; // Tab 3

// Global key to allow cross-tab routing inside the Doctor module
final GlobalKey<DoctorModuleShellState> doctorShellKey =
    GlobalKey<DoctorModuleShellState>();

// Global key for the Master Scaffold so inner screens can open the drawer!
final GlobalKey<ScaffoldState> doctorShellScaffoldKey =
    GlobalKey<ScaffoldState>();

class DoctorModuleShell extends StatefulWidget {
  DoctorModuleShell({Key? key}) : super(key: doctorShellKey);

  @override
  State<DoctorModuleShell> createState() => DoctorModuleShellState();
}

class DoctorModuleShellState extends State<DoctorModuleShell> {
  int _currentIndex = 0;

  // 1. Create a Navigator key for each of the 4 Doctor tabs
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // 2. Define the 4 Root Screens for the Doctor tabs
  final List<Widget> _rootScreens = [
    const Workbench(),
    const OpWorkbench(patientName: "", crn: ""), // Default empty OP root
    const InPatientScreen(),
    const NotificationsScreen(), // --- UPDATED: Replaced placeholder ---
  ];

  // Call this to switch tabs programmatically
  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Helper to push screens INSIDE the active tab
  void pushToCurrentTab(Widget screen) {
    _navigatorKeys[_currentIndex].currentState?.push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Handle Android back button correctly within the module
  Future<bool> _systemBackButtonPressed() async {
    final NavigatorState? currentNavigator =
        _navigatorKeys[_currentIndex].currentState;

    if (currentNavigator != null && currentNavigator.canPop()) {
      currentNavigator.pop();
      return false;
    } else {
      if (_currentIndex != 0) {
        setState(() => _currentIndex = 0);
        return false;
      }
      return true;
    }
  }

  // Dynamic Drawer based on the active tab
  Widget _getActiveDrawer() {
    if (_currentIndex == 1) {
      return const OpDrawer();
    }
    else if(_currentIndex == 2) {
      return const OpDrawer();
    }
    return AppWidgets.commonDrawer(context);
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        key: doctorShellScaffoldKey,
        drawer: _getActiveDrawer(),
        backgroundColor: Colors.transparent,
        extendBody: true,

        // Render all tabs, but hide the inactive ones
        body: Stack(
          children: List.generate(_rootScreens.length, (index) {
            return Offstage(
              offstage: _currentIndex != index,
              child: Navigator(
                key: _navigatorKeys[index],
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (context) => _rootScreens[index],
                  );
                },
              ),
            );
          }),
        ),

        // The Doctor-specific footer (Now visible across all screens)
        bottomNavigationBar: HospitalBottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          notificationBadge: 2,
          onTap: (index) {
            if (index == _currentIndex) {
              _navigatorKeys[index].currentState?.popUntil(
                (route) => route.isFirst,
              );
            } else {
              setState(() => _currentIndex = index);
            }
          },
        ),
      ),
    );
  }
}
