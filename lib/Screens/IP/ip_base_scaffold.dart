import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Screens/IP/shared_componenet.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class IpBaseScaffold extends StatelessWidget {
  final String title;
  final String? quickActionLabel;
  final bool showDrawer;
  final String patientName;
  final String crn;
  final bool activeQuickAction; // e.g., 'Op Consultant', 'Allergy', etc.
  final Widget child; // The specific content for the screen (SOAP, Forms, etc.)

  const IpBaseScaffold({
    super.key,
    required this.title,
    required this.showDrawer,
    required this.patientName,
    required this.crn,
    required this.activeQuickAction,
    required this.child,
    this.quickActionLabel = "",
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double topPadding = MediaQuery.of(context).padding.top;

    // Calculate exact AppBar height based on OpAppbar's preferred size
    double appBarHeight = topPadding + kToolbarHeight + 90;

    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFD1F2F2), Colors.white, Colors.white],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // ==========================================
            // LAYER 1: SCROLLABLE CONTENT
            // ==========================================
            Positioned.fill(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  top:
                      appBarHeight +
                      100, // Safely clears the AppBar and the Card
                  left: 16,
                  right: 16,
                  bottom: 140, // Space for the bottom nav bar
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (activeQuickAction) ...[
                      // Quick Actions Section (Always present on these screens)
                      IPSharedComponents.buildQuickActions(
                        context,
                        screenWidth,
                        patientName,
                        crn,
                        activeLabel: quickActionLabel!,
                      ),
                      const SizedBox(height: 24),
                    ],
                    // The unique content for the specific screen goes here!
                    child,
                  ],
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
              child: OpAppbar(
                title: title,
                showDrawer: showDrawer,
                onLeadingPressed: () {
                  doctorShellScaffoldKey.currentState?.openDrawer();
                },
              ),
            ),

            // ==========================================
            // LAYER 3: FIXED PATIENT CARD
            // ==========================================
            Positioned(
              top:
                  appBarHeight -
                  80, // Adjust this single value to move it across all screens!
              left: 16,
              right: 16,
              child: IPSharedComponents.buildPatientCard(
                context,
                screenWidth,
                patientName,
                crn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
