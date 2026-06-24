import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure you have this package

class SummaryCardComponent extends StatelessWidget {
  final String title;
  final String units;
  final Color backgroundColor;
  final VoidCallback onTap;

  const SummaryCardComponent({
    super.key,
    required this.title,
    required this.units,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90, // Slightly reduced height
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Background SVG Icon
            Positioned(
              right: -12,
              top: 8,

              // SvgPicture.asset(
              //     // item['icon'],
              //     "assets/${item['icon']}.svg",
              //     height: 24,
              //     width: 24,
              //     colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              //   ),
              child: Opacity(
                opacity: 1, // Subtle watermark effect
                child: SvgPicture.asset(
                  'assets/summarycardicon.svg', // Ensure this path is correct
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                  width: 55,
                  // height: 50,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    units,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
