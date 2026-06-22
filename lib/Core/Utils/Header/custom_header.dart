import 'package:flutter/material.dart';

class DynamicHeader extends StatelessWidget {
  final String title;
  final bool isDrawer; // Agar true toh Menu icon, false toh Back icon
  final VoidCallback? onLeadingPressed;

  const DynamicHeader({
    super.key,
    required this.title,
    this.isDrawer = true,
    this.onLeadingPressed,
  });

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height ;
    return Container(
      padding:  EdgeInsets.only(top: 40, bottom: 45, ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFC7F9CC), Color(0xFFBEE9E8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [


          GestureDetector(
             onTap: onLeadingPressed,
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(left: 20,right : 20,top : 10,bottom: 10),
              child: Image.asset(
                  "assets/drawer_2.png",
                height: height * 0.015,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  color: Color(0xFF1E1E1E)
                ),

              ),
            ),
          ),
          SizedBox(width: 55,)

        ],
      ),
    );
  }
}