import 'package:flutter/material.dart';

class OpAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showDrawer; // Kya is screen pe drawer chahiye ya back button?
  final VoidCallback? onLeadingPressed; // <-- NEW: Optional callback
  final bool appheight;

  const OpAppbar({
    super.key,
    required this.title,
    this.showDrawer = true,
    this.onLeadingPressed, // <-- NEW
    this.appheight = false,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(appheight ? kToolbarHeight : kToolbarHeight + 90);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: appheight ? kToolbarHeight : kToolbarHeight + 90,
      bottom: appheight
          ? null
          : const PreferredSize(
              preferredSize: Size.fromHeight(90),
              child: SizedBox(height: 90),
            ),
      centerTitle: true,
      title: Text(
        title, // Dynamic Title
        style: TextStyle(
          fontSize: height * 0.021,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF1E1E1E),
        ),
      ),

      // Dynamic Leading (Drawer ya Back Button)
      leading: showDrawer
          ? Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                  // --- NEW LOGIC ---
                  if (onLeadingPressed != null) {
                    onLeadingPressed!(); // Use the custom callback (Master Shell Drawer)
                  } else {
                    Scaffold.of(
                      context,
                    ).openDrawer(); // Fallback (Normal Drawer)
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
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
    );
  }
}
