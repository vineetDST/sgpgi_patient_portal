import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';

// Shell & Routing
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Standard light background
      appBar: OpAppbar(
        appheight: true,
        title: "Notifications",
        onLeadingPressed: () {
          doctorShellScaffoldKey.currentState?.openDrawer();
        },
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_off_outlined,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              "No new notifications",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
