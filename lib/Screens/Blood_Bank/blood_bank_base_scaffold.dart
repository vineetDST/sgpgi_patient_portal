import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Appbar/bloodbank_appbar.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Screens/IP/shared_componenet.dart';
import 'package:qc_hospital/Widgets/blood_bank_module_shell.dart';

class BloodBankBaseScaffold extends StatelessWidget {
  final String title;

  final bool showDrawer;
  final String patientName;
  final String crn;

  final Widget child;
  final bool isPatientCard ;

  final Widget? customOverlapWidget;


  const BloodBankBaseScaffold({
    super.key,
    required this.title,
    required this.showDrawer,
      this.patientName = '',
      this.crn = '',

    required this.child,
    this.isPatientCard = false,

    this.customOverlapWidget,

  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double topPadding = MediaQuery.of(context).padding.top;

    // 1. APPBAR HEIGHT LOGIC KO ALAG KIYA:
    double appBarHeight = topPadding + kToolbarHeight;
    if (isPatientCard) {
      appBarHeight += 90; // Patient card ke liye jyada height
    } else if (customOverlapWidget != null) {
      appBarHeight += 30; // Sirf Search bar ke liye kam height
    }

    // 2. SCROLL PADDING LOGIC KO BHI ALAG KIYA:
    double scrollPaddingTop = appBarHeight + 24;
    if (isPatientCard) {
      scrollPaddingTop = appBarHeight + 110;
    } else if (customOverlapWidget != null) {
      scrollPaddingTop = appBarHeight + 40;
    }
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,

        child: Stack(
          children: [
            // ==========================================
            // LAYER 1: SCROLLABLE CONTENT
            // ==========================================
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: scrollPaddingTop,
                  left: 16,
                  right: 16,
                  bottom: 140,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [child],
                ),
              ),
            ),

            // ==========================================
            // LAYER 2: APPBAR
            // ==========================================
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: appBarHeight,
              child: BloodbankAppbar( // <-- REPLACED WITH BLOODBANK APPBAR
                title: title,
                showDrawer: showDrawer,
                onLeadingPressed: () {
                  bloodBankShellScaffoldKey.currentState?.openDrawer();
                },
              ),
            ),

            // ==========================================
            // LAYER 3: OVERLAPPING WIDGETS
            // ==========================================
            if (isPatientCard)
              Positioned(
                top: appBarHeight - 80,
                left: 16,
                right: 16,
                child: IPSharedComponents.buildPatientCard(
                  context,
                  screenWidth,
                  patientName,
                  crn,
                ),
              )
            else if (customOverlapWidget != null)
              Positioned(
                top: appBarHeight - 25, // Search bar ko sahi position par set kiya
                left: 16,
                right: 16,
                child: customOverlapWidget!,
              ),

          ],
        ),
      ),

    );
  }
}