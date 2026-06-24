import 'package:flutter/material.dart';

class SwitchingTab extends StatelessWidget {
  final List<String> tabs;
  final int currentIndex;
  final Function(int) onTabChanged;
  final double fontSize; // Dynamically text size pass karne ke liye

  const SwitchingTab({
    Key? key,
    required this.tabs,
    required this.currentIndex,
    required this.onTabChanged,
    this.fontSize = 14.0, // Default size 14 rakha hai
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Taki zyada tabs aane par scroll ho sake
        child: Row(
          children: List.generate(
            tabs.length,
                (index) => _buildTabItem(tabs[index], index),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTabChanged(index),
      child: Container(
        padding: const EdgeInsets.only(bottom: 12, right: 16, left: 8),
        decoration: BoxDecoration(
          border: isActive
              ? const Border(
            bottom: BorderSide(color: Color(0xFF117A7A), width: 2),
          )
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize, // Custom font size applied here
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? const Color(0xFF117A7A) : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}