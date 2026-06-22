import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/BLOCKED%20SERVICE/ip_blocked_service.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/DISCHARGE%20SUMMARY/ip_discharge_summary.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/DISCHARGE/discharge.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/EMR/ip_emr.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/LAB/ip_lab.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/MARK%20DISCHARGE/mark_discharge.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/PROC/ip_proc.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/RAD/ip_rad.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/RX%20PRINTING/ip_rx_printing.dart';
import 'package:qc_hospital/Screens/OP/patient_profile_screen.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';
import 'package:qc_hospital/Screens/OP/q_actions/lab_reports_screen.dart';
import 'Quick_Action_Screen/CPOE/ip_cpoe.dart';

class IPSharedComponents {
  static Widget buildPatientCard(
    BuildContext context,
    double width,
    String patientName,
    String crn,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: width * 0.28,
                    // height: width * 0.32,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        topRight: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      image: const DecorationImage(
                        image: AssetImage("assets/a.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Patient Profile
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientProfileScreen(
                              patientName: patientName,
                              crn: crn,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "View",
                          style: AppTextStyles.RegH3.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _rowInfo(
                      patientName,
                      "Visit ID",
                      crn,
                      "OP - 001",
                      isName: true,
                      titleColor: Color(0xFF117A7A)
                    ),
                    const Divider(height: 20, color: Color(0xFFF0F0F0)),
                    _rowInfo(
                      "Validity",
                      "Age / Gender",
                      "10-10-2026",
                      "24 / Male",

                    ),
                    const Divider(height: 20, color: Color(0xFFF0F0F0)),
                    _rowInfo(
                      "Location",
                      "",
                      "1202 cardiology-Wing-A01 (MICU)/1",
                      "",
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

  static Widget _rowInfo(
    String label1,
    String label2,
    String val1,
    String val2, {
    bool isName = false,
    Color titleColor =     Colors.grey,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style:  TextStyle(color: titleColor, fontSize:  11,fontWeight: isName ? FontWeight.bold: FontWeight.normal ),
              ),
              const SizedBox(height: 2),
              Text(
                val1,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        if (label2.isNotEmpty)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label2,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  val2,
                  maxLines: 1,

                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  static Widget buildQuickActions(
    BuildContext context,
    double width,
    String patientName,
    String crn, {
    String activeLabel = '',
  }) {
    final actions = [
      {'icon': 'assets/emr.png', 'label': 'EMR'},

      {'icon': 'assets/cpoe.png', 'label': 'CPOE'},

      {'icon': 'assets/lab.png', 'label': 'Lab'},
      {'icon': 'assets/rad.png', 'label': 'Rad'},
      {'icon': 'assets/proc.png', 'label': 'Proc'},

      {'icon': 'assets/blockedservices.png', 'label': 'Blocked Services'},

      {'icon': 'assets/rx.png', 'label': 'RX Printing'},

      {'icon': 'assets/markdischarge.png', 'label': 'Mark Discharge'},
      {'icon': 'assets/dischargesmmry.png', 'label': 'Discharge Summary'},
      {'icon': 'assets/discharge.png', 'label': 'Discharge'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(
                Icons.access_time_outlined,
                size: 18,
                color: Colors.black87,
              ),
              const SizedBox(width: 8),
              Text(
                "Quick Actions",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: actions.map((item) {
              double itemWidth = (width - 64) / 5.5;
              bool isActive = item['label'] == activeLabel;

              return InkWell(
                onTap: () {
                  if (isActive) {
                    print("Already on same screen → no navigation");
                    return;
                  }
                  print(item['label']);

                  Widget? targetScreen;
                  if (item['label'] == "EMR") {
                    targetScreen = EmrScreen(
                      patientName: "Anil",
                      crn: "2025000783",
                      mode: 'ip',
                    );
                  } else if (item['label'] == "CPOE") {
                    targetScreen = CpoeMainScreen(
                      patientName: "Anil",
                      crn: "2025000783",
                    );
                  } else if (item['label'] == "Lab") {
                    targetScreen = IPLabReportsScreen(
                      patientName: patientName,
                      crn: crn,
                    );
                  } else if (item['label'] == "Rad") {
                    targetScreen = IPPacsReportsScreen(
                      patientName: "Anil",
                      crn: "2025000783",
                    );
                  } else if (item['label'] == "Proc") {
                    targetScreen = IPProcedureReportsScreen(
                      patientName: "Anil",
                      crn: "2025000783",
                    );
                  } else if (item['label'] == "Blocked Services") {
                    targetScreen = IPBlockedService(
                      patientName: "Anil",
                      crn: "2025000783",
                    );
                  } else if (item['label'] == "RX Printing") {
                    targetScreen = IPRxPrintingScreen(
                      patientName: "Anil",
                      crn: "2025000783",
                    );
                  } else if (item['label'] == "Mark Discharge") {
                    targetScreen = IPMarkDischarge(
                      patientName: "Anil",
                      crn: "2025000783",
                    );
                  } else if (item['label'] == "Discharge Summary") {
                    targetScreen = IPDischargeSummary(
                      patientName: "Anil",
                      crn: "2025000783",
                    );
                  } else if (item['label'] == "Discharge") {
                    targetScreen = IPDischarge(
                      patientName: "Anil",
                      crn: "2025000783",
                    );
                  }

                  if (targetScreen != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => targetScreen!),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: itemWidth,
                  height: 80,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF117A7A)
                        : const Color(0xFFE0F7F7).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: const Color(0xFF117A7A).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Image.asset(
                        item['icon'] as String,
                        width: 22,
                        height: 22,
                        color: isActive ? Colors.white : Colors.black87,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item['label'] as String,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: isActive
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isActive ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
