import 'package:flutter/material.dart';

class TableLabel {
  final String? text; // Ise optional nullable banaya hai
  final IconData? icon;
  final Widget? customWidget; // 🔥 NAYA: Custom widget ke liye

  const TableLabel({
    this.text,
    this.icon,
    this.customWidget,
  }) : assert(text != null || customWidget != null, 'Ya toh text pass karein ya customWidget');
}

class ScrollableDataTable extends StatefulWidget {
  final List<String>? labels;
  final List<TableLabel>? tableLabels;
  final List<List<Widget>> rowValues;
  final double rowHeight;
  final double leftColumnWidth;
  final double dataColumnWidth;
  final bool showPagination;

  // 🔥 NAYA FLAG: First row ko header ki tarah style karne ke liye
  final bool isFirstRowHeader;

  const ScrollableDataTable({
    super.key,
    this.labels,
    this.tableLabels,
    required this.rowValues,
    this.rowHeight = 64.0,
    this.leftColumnWidth = 140.0,
    this.dataColumnWidth = 160.0,
    this.showPagination = false,
    this.isFirstRowHeader = false, // Default false, taaki baaki jagah effect na ho
  });

  @override
  State<ScrollableDataTable> createState() => _ScrollableDataTableState();
}

class _ScrollableDataTableState extends State<ScrollableDataTable> {
  final ScrollController _scrollController = ScrollController();

  List<TableLabel> get _actualLabels {
    if (widget.tableLabels != null) {
      return widget.tableLabels!;
    }
    return widget.labels!.map((text) => TableLabel(text: text)).toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLabels = _actualLabels;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==========================================
                // 1. LEFT FIXED COLUMN
                // ==========================================
                // ==========================================
// 1. LEFT FIXED COLUMN
// ==========================================
                Container(
                  width: widget.leftColumnWidth,
                  decoration: const BoxDecoration(color: Color(0xFFF0F8F8)),
                  child: Column(
                    children: List.generate(currentLabels.length, (index) {

                      // 🔥 Check agar ye first row hai aur flag true hai
                      bool isHeader = widget.isFirstRowHeader && index == 0;
                      final currentLabel = currentLabels[index];

                      return _buildCell(
                        width: widget.leftColumnWidth,
                        isLastRow: index == currentLabels.length - 1,
                        bgColor: isHeader ? const Color(0xFF117A7A) : null,
                        borderColor: isHeader ? Colors.white : Colors.grey.shade300,
                        child: currentLabel.customWidget != null
                        // 🔥 AGAR CUSTOM WIDGET HAI TOH DIRECT USKO DIKHAO
                            ? currentLabel.customWidget!
                        // 🔥 WARNA PURANA TEXT + ICON LOGIC DIKHAO
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                currentLabel.text ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: isHeader ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                            if (currentLabel.icon != null) ...[
                              const SizedBox(width: 4),
                              Icon(
                                currentLabel.icon,
                                size: 16,
                                color: isHeader ? Colors.white : Colors.black87,
                              ),
                            ],
                          ],
                        ),
                      );
                    }),
                  ),
                ),

                // ==========================================
                // 2. RIGHT SCROLLABLE AREA
                // ==========================================
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(currentLabels.length, (rowIndex) {

                          // 🔥 Check agar ye first row hai aur flag true hai
                          bool isHeader = widget.isFirstRowHeader && rowIndex == 0;

                          return Row(
                            children: List.generate(
                                widget.rowValues[rowIndex].length,
                                    (colIndex) {

                                  Widget cellWidget = widget.rowValues[rowIndex][colIndex];
                                  bool shouldRemovePadding = cellWidget is NoPaddingCell;

                                  if (shouldRemovePadding) {
                                    cellWidget = (cellWidget as NoPaddingCell).child;
                                  }

                                  return _buildCell(
                                    width: widget.dataColumnWidth,
                                    isLastRow: rowIndex == currentLabels.length - 1,
                                    isLastCol: colIndex == widget.rowValues[rowIndex].length - 1,
                                    removePadding: shouldRemovePadding,
                                    bgColor: isHeader ? const Color(0xFF117A7A) : Colors.white, // Background Red
                                    borderColor: isHeader ? Colors.white : Colors.grey.shade300, // Border White
                                    child: cellWidget,
                                  );
                                }
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            if (widget.showPagination) _buildPaginationRow(),
          ],
        ),
      ),
    );
  }

  // 🛠️ Helper method cells design karne ke liye
  Widget _buildCell({
    required Widget child,
    required double width,
    bool isLastRow = false,
    bool isLastCol = false,
    bool removePadding = false,
    Color? bgColor, // 🔥 Naya parameter
    Color? borderColor, // 🔥 Naya parameter
  }) {
    return Container(
      height: widget.rowHeight,
      width: width,
      padding:    EdgeInsets.symmetric(horizontal: removePadding ? 0 : 16,vertical: 0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: bgColor, // 🔥 Background apply karo
        border: Border(
          bottom: isLastRow
              ? BorderSide.none
              : BorderSide(color:  Colors.grey.shade300, width: 2),
          right: isLastCol
              ? BorderSide.none
              : BorderSide(color: borderColor ?? Colors.grey.shade300, width: 2),
        ),
      ),
      child: child,
    );
  }

  // 🛠️ Helper method pagination UI ke liye
  Widget _buildPaginationRow() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 2)),
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
        style: TextStyle(color: Colors.black87, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal),
      ),
    );
  }

  Widget _buildPaginationArrow(IconData icon, {required bool isDisabled}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade300)),
      child: Icon(icon, size: 20, color: isDisabled ? Colors.grey.shade400 : Colors.black87),
    );
  }
}

class NoPaddingCell extends StatelessWidget {
  final Widget child;

  const NoPaddingCell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}