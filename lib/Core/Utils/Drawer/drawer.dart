import 'package:flutter/material.dart';

class AppWidgets {
  // Static function banaya taaki direct class name se call ho sake
  static Widget commonDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header section
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD1FAE5), Color(0xFFBFF1F5)],
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Color(0xFF10B981)),
            ),
            accountName: const Text(
              "Dr. Amit Kumar",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            accountEmail: const Text(
              "amit.k@hospital.com",
              style: TextStyle(color: Colors.black54),
            ),
          ),

          // Menu Items
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text("Dashboard"),
            onTap: () {
              Navigator.pop(context); // Drawer band karne ke liye
              // Yahan navigate kar sakte hain
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text("Search CRN"),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              // Logout logic yahan aayegi
            },
          ),
        ],
      ),
    );
  }
}