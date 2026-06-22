import 'package:flutter/material.dart';

class DetailTableWrapper extends StatelessWidget {
  final List<Widget> children;

  // 🔥 Naya parameter pagination ke liye
  final bool showPagination;

  const DetailTableWrapper({
    super.key,
    required this.children,
    this.showPagination = false, // Default false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // List of DetailRows
            ...children,

            // 🔥 Pagination Condition
            if (showPagination) _buildPaginationRow(),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 🛠️ Pagination UI Helpers
  // ==========================================
  Widget _buildPaginationRow() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          // Table ki last row aur pagination ke beech border
          top: BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildPaginationArrow(Icons.chevron_left, isDisabled: true),
          const SizedBox(width: 8),
          _buildPageNumber('01', isActive: true),
          const SizedBox(width: 8),
          _buildPageNumber('02', isActive: false),
          const SizedBox(width: 8),
          _buildPaginationArrow(Icons.chevron_right, isDisabled: false),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildPageNumber(String number, {required bool isActive}) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey.shade100 : Colors.transparent,
        border: isActive ? null : Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        number,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildPaginationArrow(IconData icon, {required bool isDisabled}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        icon,
        size: 20,
        color: isDisabled ? Colors.grey.shade400 : Colors.black87,
      ),
    );
  }
}