import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Drawer/Blood_Bank/bloodbank_drawer.dart';

import 'package:qc_hospital/Core/Utils/NavigationBar/HospitalBottomNavigationBar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/blood_bank_bottom_navigationbar.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Camp/camp.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Collection/collection.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Donor/donor.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Home/home.dart';



final GlobalKey<BloodBankModuleShellState> bloodBankShellKey = GlobalKey<BloodBankModuleShellState>();
final GlobalKey<ScaffoldState> bloodBankShellScaffoldKey = GlobalKey<ScaffoldState>();
final GlobalKey<CollectionState> collectionTabKey = GlobalKey<CollectionState>();

class BloodBankModuleShell extends StatefulWidget {
  BloodBankModuleShell({Key? key}) : super(key: bloodBankShellKey);

  @override
  State<BloodBankModuleShell> createState() => BloodBankModuleShellState();
}

class BloodBankModuleShellState extends State<BloodBankModuleShell> {
  int _currentIndex = 0;

  // 1. Create a Navigator key for each of the 4 Doctor tabs
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  // 1. Collection Tab ke liye ek GlobalKey banayein


  // 2. Define the 4 Root Screens for the Doctor tabs
  final List<Widget> _rootScreens = [
    BloodBankHome(),
    Donor(),
    // Collection(),
    Collection(key: collectionTabKey),
    Camp(), // --- UPDATED: Replaced placeholder ---
  ];

  // Call this to switch tabs programmatically
  // void changeTab(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }


  void changeTab(int index, {String? regNo}) {

    if (index == 2 && regNo != null) {

      collectionTabKey.currentState?.updateRegNo(regNo);
    }

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



  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        key: bloodBankShellScaffoldKey,
        drawer: BloodbankDrawer(),
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
        bottomNavigationBar: BloodBankBottomNavigationbar(
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
