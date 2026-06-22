import 'package:flutter/material.dart';

// class BloodbankAppbar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool showDrawer; // Kya is screen pe drawer chahiye ya back button?
//
//   BloodbankAppbar({
//     required this.title,
//     this.showDrawer = true,
//   });
//
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
//
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//
//     return AppBar(
//       centerTitle: true,
//       title: Text(
//         title, // Dynamic Title
//         style: TextStyle(
//           fontSize: height * 0.021,
//           fontWeight: FontWeight.w500,
//           color: Color(0xFF1E1E1E),
//         ),
//       ),
//
//       // Dynamic Leading (Blood_Bank ya Back Button)
//       leading: showDrawer
//           ? Builder(
//         builder: (context) => GestureDetector(
//           onTap: () => Scaffold.of(context).openDrawer(),
//           child: Container(
//             color: Colors.transparent,
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Image.asset(
//               "assets/drawer_2.png",
//               height: height * 0.019,
//             ),
//           ),
//         ),
//       )
//           : IconButton(
//         icon: Icon(Icons.arrow_back_ios, color: Colors.black),
//         onPressed: () => Navigator.pop(context),
//       ),
//
//       flexibleSpace: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [ Color(0xFFC7F9CC), Color(0xFFBEE9E8)],
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//           ),
//         ),
//       ),
//       elevation: 0,
//     );
//   }
// }

import 'package:flutter/material.dart';

class BloodbankAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showDrawer;
  final VoidCallback? onLeadingPressed; // <-- NEW: Shell drawer handle karne ke liye

  const BloodbankAppbar({
    super.key,
    required this.title,
    this.showDrawer = true,
    this.onLeadingPressed, // <-- NEW
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: height * 0.021,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1E1E1E),
        ),
      ),
      leading: showDrawer
          ? Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            // --- NEW LOGIC: Shell Key check ---
            if (onLeadingPressed != null) {
              onLeadingPressed!();
            } else {
              Scaffold.of(context).openDrawer();
            }
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Image.asset(
              "assets/drawer_2.png",
              height: height * 0.019,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.menu, color: Colors.black87),
            ),
          ),
        ),
      )
          : IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC7F9CC), Color(0xFFBEE9E8)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent, // Gradient background ko smooth dikhane ke liye
    );
  }
}