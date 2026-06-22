import 'package:flutter/material.dart';


import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';

import 'package:qc_hospital/Screens/Blood_Bank/Home/home.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';

class Camp extends StatefulWidget {
  Camp({super.key});

  @override
  State<Camp> createState() => _BBCampState();
}

class _BBCampState extends State<Camp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return BloodBankBaseScaffold(
      title: "Camp",

      showDrawer: true,

      // We only pass the content that is unique to the Lab Reports screen below the Quick Actions
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BloodStockSummaryCard(),
          const SizedBox(height: 24,),
          Column(
            children: [
              _buildTable(),

            ],
          ),

        ],
      ),


    );
  }

  Widget _buildTable() {
    return ScrollableDataTable(
      showPagination: true,
      labels: const [
        'Camp Name',
        'Location',
        'Camp Date',
        'Organizer Name',
        'Blood Collection'
      ],
      // Har array me 2 values hain, jo horizontally scroll hongi
      rowValues: [
        // 1. Investigation Name Row
        [
           const TableText("Red Cross Camp"),
          const TableText("Red Cross Camp"),
          const TableText("Red Cross Camp"),
          const TableText("Red Cross Camp"),
        ],

        [
          const TableText("Caimbatore"),
          const TableText("Caimbatore"),
          const TableText("Caimbatore"),
          const TableText("Caimbatore"),
        ],

        [
          const TableText("05-10-2025"),
          const TableText("05-10-2025"),
          const TableText("05-10-2025"),
          const TableText("05-10-2025"),
        ],

        [
          const TableText("Prem Shankar"),
          const TableText("Prem Shankar"),
          const TableText("Prem Shankar"),
          const TableText("Prem Shankar"),

        ],

        [
          const TableText("50 Units"),
          const TableText("50 Units"),
          const TableText("50 Units"),
          const TableText("50 Units"),

        ],

        ],

    );
  }

}
class BloodStockSummaryCard extends StatelessWidget {
  const BloodStockSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height ;
    // Data list based on your image
    final List<Map<String, dynamic>> bloodData = [
      {'title' : '150','type': '150+', 'units': 'Total Camps', 'color': const Color(0xFFC8E6C9)},
      {'title' : '12','type': '12', 'units': 'Camps of Week', 'color': const Color(0xFFB3E5FC)},
      {'title' : '750','type': '750+', 'units': 'Total Donor', 'color': const Color(0xFFE1BEE7)},

    ];

    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.02,
          left: MediaQuery.of(context).size.height * 0.015,
          right: MediaQuery.of(context).size.height * 0.015,
          bottom: MediaQuery.of(context).size.height * 0.015,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CardHeader(title: "Camp"),
                Row(

                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "November",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E1E1E),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.only(
                          left: height * 0.005,
                          top: height * 0.01,
                          bottom: height * 0.01,
                        ),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xFFB7B7B7),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            LayoutBuilder(
              builder: (context, constraints) {
                final double spacing = 10;
                final double itemWidth =
                    (constraints.maxWidth - (spacing * 2)) / 3;

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  // alignment: WrapAlignment.center,
                  children: bloodData.map((item) {
                    return SizedBox(
                      width: itemWidth,
                      child: BloodTypeTile(
                        bloodType: item['type'],
                        units: item['units'],
                        bgColor: item['color'],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}





class ScrollableDataTable1 extends StatefulWidget {
  final List<String> labels;
  final List<List<Widget>> rowValues;
  final double rowHeight;
  final double leftColumnWidth;
  final double dataColumnWidth;

  const ScrollableDataTable1({
    super.key,
    required this.labels,
    required this.rowValues,
    this.rowHeight = 64.0,
    this.leftColumnWidth = 140.0,
    this.dataColumnWidth = 160.0,
  });

  @override
  State<ScrollableDataTable1> createState() => _ScrollableDataTableState();
}

class _ScrollableDataTableState extends State<ScrollableDataTable1> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
        child: Column( // 🔥 Pure table aur bottom part ko handle karne ke liye outer Column lagaya
          mainAxisSize: MainAxisSize.min,
          children: [
            // ==========================================
            // MAIN TABLE AREA (Labels + Scrollable Data)
            // ==========================================
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. LEFT FIXED COLUMN (Labels)
                Container(
                  width: widget.leftColumnWidth,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF0F8F8),
                  ),
                  child: Column(
                    children: List.generate(widget.labels.length, (index) {
                      return _buildCell(
                        width: widget.leftColumnWidth,
                        isLastRow: index == widget.labels.length - 1,
                        child: Text(
                          widget.labels[index],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // 2. RIGHT SCROLLABLE AREA (Data)
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(widget.labels.length, (rowIndex) {
                        return Row(
                          children: List.generate(
                            widget.rowValues[rowIndex].length,
                                (colIndex) {
                              return _buildCell(
                                width: widget.dataColumnWidth,
                                isLastRow: rowIndex == widget.labels.length - 1,
                                isLastCol: colIndex == widget.rowValues[rowIndex].length - 1,
                                child: widget.rowValues[rowIndex][colIndex],
                              );
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),

            // ==========================================
            // 🔥 NEW: BOTTOM PAGINATION PART
            // ==========================================
            Container(

              child: Row(
                children: [
                  // Left Side: Khali space (Aapki image ke mutabik labels ke niche blank hai)
                  Container(
                    width: widget.leftColumnWidth,
                    height: 56, // Pagination row ki height

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border : Border(right: BorderSide(color: Colors.grey.shade300,width: 2))
                    ),
                  ),

                  // Right Side: Pagination Buttons (Arrows aur Numbers)
                  Expanded(
                    child: Container(
                      height: 56,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Left Arrow Button
                          _buildPageArrow(Icons.arrow_back_ios_new_rounded, () {
                            // TODO: Previous page logic
                          }),
                          const SizedBox(width: 12),

                          // Page Number 01 (Active)
                          _buildPageNumber("01", isActive: true, onTap: () {}),
                          const SizedBox(width: 8),

                          // Page Number 02
                          _buildPageNumber("02", isActive: false, onTap: () {}),
                          const SizedBox(width: 12),

                          // Right Arrow Button
                          _buildPageArrow(Icons.arrow_forward_ios_rounded, () {
                            // TODO: Next page logic
                          }),
                        ],
                      ),
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

  // 🛠️ Helper method cells design karne ke liye
  Widget _buildCell({
    required Widget child,
    required double width,
    bool isLastRow = false,
    bool isLastCol = false,
  }) {
    return Container(
      height: widget.rowHeight,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 2), // Border rehne diya taaki pagination se alag dikhe
          right: isLastCol ? BorderSide.none : BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),
      child: child,
    );
  }

  // 🛠️ Helper: Pagination Arrow Buttons UI
  Widget _buildPageArrow(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 14, color: const Color(0xFF1E293B)),
      ),
    );
  }

  // 🛠️ Helper: Pagination Numbers UI (01, 02)
  Widget _buildPageNumber(String number, {required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFEDF2F7) : Colors.transparent, // Active hone par soft background color
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: isActive ? Colors.transparent : Colors.grey.shade200),
        ),
        child: Text(
          number,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? const Color(0xFF1E293B) : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
