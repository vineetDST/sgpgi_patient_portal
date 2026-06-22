import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Appbar/bloodbank_appbar.dart';
import 'package:qc_hospital/Core/Utils/Drawer/Blood_Bank/bloodbank_drawer.dart';
import 'package:qc_hospital/Core/Utils/Drawer/drawer.dart';
import 'package:qc_hospital/Core/Utils/Header/bloodbank_header.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/Bloodbank/home_navigationbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/Bloodbank/blood_bank_navigation_bar.dart';

import 'package:qc_hospital/Screens/Blood_Bank/Camp/camp.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Collection/collection.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Donor/donor.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';

class BloodBankHome extends StatefulWidget {
  BloodBankHome({super.key});

  @override
  State<BloodBankHome> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<BloodBankHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BloodBankBaseScaffold(
      title: "Home",

      showDrawer: true,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "November",
                style: TextStyle(
                  fontSize: 14,
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
                  child: Icon(Icons.arrow_drop_down, color: Color(0xFFB7B7B7)),
                ),
              ),
            ],
          ),
          BloodStockSummaryCard(),
          SizedBox(height: height * 0.02),
          BloodOverviewCard(),
          SizedBox(height: height * 0.02),
          DonationOverviewCard(),
          SizedBox(height: height * 0.03),
        ],
      ),
    );
  }


}

class BloodStockSummaryCard extends StatelessWidget {
  const BloodStockSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Data list based on your image
    final List<Map<String, dynamic>> bloodData = [
      {'type': 'A+', 'units': '26 Units', 'color': const Color(0xFFC8E6C9)},
      {'type': 'A-', 'units': '05 Units', 'color': const Color(0xFFB3E5FC)},
      {'type': 'B+', 'units': '32 Units', 'color': const Color(0xFFE1BEE7)},
      {'type': 'B-', 'units': '14 Units', 'color': const Color(0xFFFFAB91)},
      {'type': 'O+', 'units': '120 Units', 'color': const Color(0xFFB2DFDB)},
      {'type': 'O-', 'units': '45 Units', 'color': const Color(0xFFB3E5FC)},
      {'type': 'AB+', 'units': '115 Units', 'color': const Color(0xFFB2EBF2)},
      {'type': 'AB-', 'units': '04 Units', 'color': const Color(0xFFE1BEE7)},
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
            CardHeader(title: "Blood Stock Summary"),
            const SizedBox(height: 15),
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

class BloodTypeTile extends StatelessWidget {
  final String bloodType;
  final String units;
  final Color bgColor;

  const BloodTypeTile({
    super.key,
    required this.bloodType,
    required this.units,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // Background Watermark Text
          SizedBox(height: height * 0.01),
          Container(
            alignment: Alignment.centerRight,
            child: Text(
              bloodType,

              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.042,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.05), // Faded effect
              ),
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
            ),
          ),

          // Content Text
          Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.01,
              bottom: MediaQuery.of(context).size.height * 0.01,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  bloodType,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                Text(
                  units,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.014,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardHeader extends StatelessWidget {
  String title;
  CardHeader({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF1E1E1E),
      ),
    );
  }
}

class BloodOverviewCard extends StatelessWidget {
  const BloodOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Data mapping based on your Figma image
    final List<_BloodData> data = [
      _BloodData('O+', 20, const Color(0xFFF2998F)),
      _BloodData('O-', 8, const Color(0xFFE1BEE7)),
      _BloodData('AB+', 19, const Color(0xFFC8E6C9)),
      _BloodData('AB-', 6, const Color(0xFFE1D5FF)),
      _BloodData('A+', 18, const Color(0xFFADD8E6)),
      _BloodData('A-', 16, const Color(0xFFBDBDBD)),
      _BloodData('B+', 7, const Color(0xFFB2DFDB)),
      _BloodData('B-', 6, const Color(0xFFCFD8DC)),
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
            CardHeader(title: "Blood Overview"),
            const SizedBox(height: 30),
            // Pie Chart Section
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  sections: data.map((item) {
                    return PieChartSectionData(
                      color: item.color,
                      value: item.value.toDouble(),
                      title: '${item.value.toString().padLeft(2, '0')}%',
                      radius: 110,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Legend Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                runSpacing: 12,
                spacing: 16,
                alignment: WrapAlignment.center,
                children: data.map((item) => _LegendItem(item: item)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final _BloodData item;
  const _LegendItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: item.color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          item.label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}

class _BloodData {
  final String label;
  final int value;
  final Color color;
  _BloodData(this.label, this.value, this.color);
}

class DonationOverviewCard extends StatelessWidget {
  const DonationOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardHeader(title: "Donation Overview"),
            const SizedBox(height: 30),
            SizedBox(
              height: 120,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine: (v) => FlLine(
                      color: Colors.grey.withOpacity(0.1),
                      strokeWidth: 0.5,
                    ),
                    getDrawingVerticalLine: (v) => FlLine(
                      color: Colors.grey.withOpacity(0.1),
                      strokeWidth: 0.5,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 100, // kitne gap par label aaye
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return Text(
                                '${value.toInt()}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              );
                            case 100:
                              return Text(
                                '${value.toInt()}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              );
                            case 200:
                              return Text(
                                '${value.toInt()}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              );
                            case 300:
                              return Text(
                                '${value.toInt()}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              );
                            case 400:
                              return Text(
                                '${value.toInt()}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              );
                            case 500:
                              return Text(
                                '${value.toInt()}',
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              );
                            default:
                              return SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),

                  // curve line information
                  lineBarsData: [
                    _lineData(const Color(0xFFE1BEE7), [
                      const FlSpot(0, 0),
                      const FlSpot(1, 240),
                      const FlSpot(2, 100),
                      const FlSpot(3, 250),
                      const FlSpot(4, 200),
                      const FlSpot(5, 280),
                      const FlSpot(6, 0),
                    ]),
                    _lineData(const Color(0xFFC8E6C9), [
                      const FlSpot(0, 0),
                      const FlSpot(1, 100),
                      const FlSpot(2, 0),
                      const FlSpot(3, 520),
                      const FlSpot(4, 250),
                      const FlSpot(5, 400),
                      const FlSpot(6, 0),
                    ]),

                    _lineData(const Color(0xFFF2998F), [
                      const FlSpot(0, 50),
                      const FlSpot(1, 40),
                      const FlSpot(2, 200),
                      const FlSpot(3, 100),
                      const FlSpot(4, 280),
                      const FlSpot(5, 180),
                      const FlSpot(6, 300),
                    ]),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: Container(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    _Legend(color: Color(0xFFC8E6C9), label: 'Walkin Donation'),
                    SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                    _Legend(
                      color: Color(0xFFE1BEE7),
                      label: 'Replacement Donation',
                    ),
                    SizedBox(width: MediaQuery.of(context).size.height * 0.02),
                    _Legend(
                      color: Color(0xFFF2998F),
                      label: 'Voluntary Donation',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartBarData _lineData(Color color, List<FlSpot> spots) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      curveSmoothness: 0.5,
      color: color,
      barWidth: 1,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: false),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;
  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
