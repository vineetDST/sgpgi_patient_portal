import 'package:flutter/material.dart';

class TableLabel {
  final String text;
  final IconData? icon;

  const TableLabel({required this.text, this.icon});
}

class ScrollableDataTable extends StatefulWidget {
  final List<String>? labels;
  final List<TableLabel>? tableLabels;
  final List<List<Widget>> rowValues;
  final double rowHeight;
  final double leftColumnWidth;
  final double dataColumnWidth;

  // 🔥 Naya parameter pagination ko on/off karne ke liye
  final bool showPagination;

  const ScrollableDataTable({
    super.key,
    this.labels,
    this.tableLabels,
    required this.rowValues,
    this.rowHeight = 64.0,
    this.leftColumnWidth = 140.0,
    this.dataColumnWidth = 160.0,
    this.showPagination =
        false, // Default false rakha hai taaki har jagah na dikhe
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
    final currentLabels = _actualLabels; // 🔥 Is variable ko use karenge

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
                Container(
                  width: widget.leftColumnWidth,
                  decoration: const BoxDecoration(color: Color(0xFFF0F8F8)),
                  child: Column(
                    children: List.generate(currentLabels.length, (index) {
                      return _buildCell(
                        width: widget.leftColumnWidth,
                        isLastRow: index == currentLabels.length - 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                currentLabels[index].text, // 🔥 Yahan use kiya
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            if (currentLabels[index].icon != null) ...[
                              const SizedBox(width: 4),
                              Icon(
                                currentLabels[index].icon,
                                size: 16,
                                color: Colors.black87,
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
                // ==========================================

                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...List.generate(currentLabels.length, (rowIndex) {
                          return Row(
                            children: List.generate(
                                widget.rowValues[rowIndex].length,
                                    (colIndex) {

                                  // 1. Current widget ko get karein
                                  Widget cellWidget = widget.rowValues[rowIndex][colIndex];

                                  // 2. Check karein kya ye NoPaddingCell hai?
                                  bool shouldRemovePadding = cellWidget is NoPaddingCell;

                                  // 3. Agar NoPaddingCell hai, to uske andar ka actual child nikal lein
                                  if (shouldRemovePadding) {
                                    cellWidget = (cellWidget as NoPaddingCell).child;
                                  }

                                  return _buildCell(
                                    width: widget.dataColumnWidth,
                                    isLastRow: rowIndex == currentLabels.length - 1,
                                    isLastCol: colIndex == widget.rowValues[rowIndex].length - 1,
                                    removePadding: shouldRemovePadding, // 🔥 True ya False pass karein
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
  }) {
    return Container(
      height: widget.rowHeight,
      width: width,
      padding: removePadding ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 16,),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: isLastRow
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300, width: 2),
          right: isLastCol
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300, width: 2),
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
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 2,
          ), // Table se alag dikhane ke liye border
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

  // Page numbers UI helper
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

  // Arrow UI helper
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

class NoPaddingCell extends StatelessWidget {
  final Widget child;

  const NoPaddingCell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
