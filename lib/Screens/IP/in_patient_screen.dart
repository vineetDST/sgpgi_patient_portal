import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

import 'package:qc_hospital/Core/Utils/Dialog/app_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/Drawer/OP/op_drawer.dart'; // Added Drawer
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Search_Bar/op_search.dart'; // Added Search Field
import 'package:qc_hospital/Core/Utils/NavigationBar/HospitalBottomNavigationBar.dart'; // Added Custom Footer
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filterTextField.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/BLOCKED%20SERVICE/ip_blocked_service.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_cpoe.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/DISCHARGE%20SUMMARY/ip_discharge_summary.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/DISCHARGE/discharge.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/EMR/ip_emr.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/LAB/ip_lab.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/MARK%20DISCHARGE/mark_discharge.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/PROC/ip_proc.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/RAD/ip_rad.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/RX%20PRINTING/ip_rx_printing.dart';
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/admission_bed_status_screen.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

// Navigation Screens
import 'package:qc_hospital/Screens/OP/op_workbench.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';
import 'package:qc_hospital/Screens/OP/q_actions/lab_reports_screen.dart';
import 'package:qc_hospital/Screens/OP_IP_Workbench/workbench.dart';

// Modals
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_bottom_sheet.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/patient_filter_modal.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class InPatientScreen extends StatefulWidget {
  const InPatientScreen({super.key});

  @override
  State<InPatientScreen> createState() => _InPatientScreenState();
}

class _InPatientScreenState extends State<InPatientScreen> {
  int _activeTabIndex = 0; // 0 = Admitted Patient, 1 = Referrals

  List<Map<String, dynamic>> _admittedPatients = [
    {"name": "Anil Srivastava", "crn": "20251000438", "selected": true},
    {"name": "Chandra Bhan", "crn": "20251000465", "selected": false},
    {"name": "Gautem Kumar", "crn": "20251000487", "selected": false},
    {"name": "John Michael", "crn": "20251000547", "selected": false},
    {"name": "Chandra Bhan", "crn": "20251000465", "selected": false},
    {"name": "Gautem Kumar", "crn": "20251000487", "selected": false},
    {"name": "John Michael", "crn": "20251000547", "selected": false},
    {"name": "Peter", "crn": "20251000146", "selected": false},
  ];

  List<Map<String, dynamic>> _referral = [
    {"name": "Anil Srivastava", "crn": "20251000438", "selected": true},
    {"name": "Chandra Bhan", "crn": "20251000465", "selected": false},
    {"name": "Gautem Kumar", "crn": "20251000487", "selected": false},
    {"name": "John Michael", "crn": "20251000547", "selected": false},
    {"name": "Chandra Bhan", "crn": "20251000465", "selected": false},
  ];

  String _searchQuery = "";

  // 2. Ye getter automatically data filter karega basis on search query
  List<Map<String, dynamic>> get _filteredAdmittedPatients {
    if (_searchQuery.isEmpty) {
      return _admittedPatients;
    }
    return _admittedPatients.where((patient) {
      final name = patient["name"].toString().toLowerCase();
      final crn = patient["crn"].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();

      // Name ya CRN kisi mein bhi match ho toh true return karega
      return name.contains(query) || crn.contains(query);
    }).toList();
  }

  String _searchQuery1 = "";
  List<Map<String, dynamic>> get _filteredReferal {
    if (_searchQuery1.isEmpty) {
      return _referral;
    }
    return _referral.where((patient) {
      final name = patient["name"].toString().toLowerCase();
      final crn = patient["crn"].toString().toLowerCase();
      final query = _searchQuery1.toLowerCase();

      // Name ya CRN kisi mein bhi match ho toh true return karega
      return name.contains(query) || crn.contains(query);
    }).toList();
  }

  String? _patientStatus = 'Patient Status';
  String? _ls1 = 'Is';
  String? _ipcare = 'Under IP Care';
  String? _department = "Department";
  String? _ls2 = "Is";
  String? _cardiology = 'Cardiology';
  String? _crno = 'CRNO';
  String? _like = 'Like';
  String? _crno_value = '2025000653';
  String activeLabel = '';

  final toController = TextEditingController();
  DateTime? toDate;
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: OpAppbar(
        appheight: true,
        title: "InPatient",
        onLeadingPressed: () {
          doctorShellScaffoldKey.currentState?.openDrawer();
        },
      ),
      extendBody: true,

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white, Colors.white],
            stops: [0.0, 0.2, 1.0],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top),

              // Custom IP Tabs
              _buildTabs(),
              const SizedBox(height: 16),

              // Scrollable Content Below Tabs
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // IP Quick Actions
                      if (_activeTabIndex == 0)
                        _buildIpQuickActions(screenWidth),
                      if (_activeTabIndex == 0) const SizedBox(height: 24),

                      // Active Tab Content
                      _activeTabIndex == 0
                          ? _buildAdmittedPatientsTab()
                          : _buildReferralsTab(),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- CUSTOM IP TABS ---
  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          _buildTabItem("Admitted Patient", 0),

          _buildTabItem("Referrals", 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isActive = _activeTabIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 1 && _activeTabIndex == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  AdmissionBedStatusScreen(patientName: "", crn: ""),
            ),
          );
          setState(() => _activeTabIndex = index);
        } else {
          setState(() {
            _activeTabIndex = index;
          });
        }
      },
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
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isActive ? const Color(0xFF117A7A) : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  // --- IP QUICK ACTIONS ---
  Widget _buildIpQuickActions(double width) {
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                  fontSize: 14,
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
              double itemWidth = (width - 64 - 36) / 5.08;
              bool isActive = item['label'] == activeLabel;

              // double itemWidth = (width - 64) / 5.2;

              return GestureDetector(
                onTap: () {
                  Widget? targetScreen;
                  print("In Pateint : ${item['label']}");
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
                      patientName: "Anil",
                      crn: "2025000783",
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
                child: Container(
                  width: itemWidth,
                  height: 80,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F7F7).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
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

  // --- TAB 1: ADMITTED PATIENTS ---
  Widget _buildAdmittedPatientsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Admitted Patients",
              style: AppTextStyles.RegH3.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                IPActionButton(),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _showFilterSidebarAdmittedPateint,
                  child: const Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        Text(
          'Search',
          style: AppTextStyles.RegH3.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColor.color1E1E1E,
          ),
        ),
        const SizedBox(height: 8),
        // Replaced with generic OpSearchField
        OpSearchField(
          hintText: "Search by CR No./ Patient name",
          onChanged: (value) {
            setState(() {
              _searchQuery = value; // text type hote hi state update hogi
            });
          },
        ),
        const SizedBox(height: 24),

        _buildAdmittedTable(),
      ],
    );
  }

  // --- TAB 2: REFERRALS ---
  Widget _buildReferralsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Cross Consultation Requests",
              style: AppTextStyles.RegH3.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const Icon(Icons.filter_alt_outlined, color: Colors.black87),
            GestureDetector(
              onTap: _showFilterSidebarReferal,
              child: const Icon(
                Icons.filter_alt_outlined,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Text(
                        'Search',
                        style: AppTextStyles.RegH3.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColor.color1E1E1E,
                        ),
                      ),
                      // const SizedBox(width: 12),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Image.asset(
                          'assets/pdf.png', // 👈 your image path
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  OpSearchField(
                    hintText: "Search...",
                    onChanged: (value) {
                      setState(() {
                        _searchQuery1 =
                            value; // text type hote hi state update hogi
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        _buildReferralsTable(),
      ],
    );
  }

  // --- TABLES ---
  Widget _buildAdmittedTable() {
    if (_filteredAdmittedPatients.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("No patient found"),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 50,
                  color: const Color(0xFFEAF9F9),
                  alignment: Alignment.center,
                  child: const Text(
                    "Select",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                Container(width: 1, height: 50, color: Colors.grey.shade300),
                Expanded(
                  child: Container(
                    height: 50,
                    color: const Color(0xFFEAF9F9),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Patient Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Icon(Icons.unfold_more, size: 16),
                      ],
                    ),
                  ),
                ),
                Container(width: 1, height: 50, color: Colors.grey.shade300),
                Expanded(
                  child: Container(
                    height: 50,
                    color: const Color(0xFFEAF9F9),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "CRN Number",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Icon(Icons.unfold_more, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ..._filteredAdmittedPatients
                .map(
                  (row) => Column(
                    children: [
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  for (var patient in _admittedPatients) {
                                    patient["selected"] = false;
                                  }

                                  row["selected"] = true;
                                });
                              },
                              child: Container(
                                width: 60,
                                alignment: Alignment.center,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200), // स्मूथ ट्रांजिशन के लिए
                                  height: 20,
                                  width: 20,
                                  padding: const EdgeInsets.all(3.5), // ये पैडिंग बीच के व्हाइट गैप को कंट्रोल करेगी
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    // सिलेक्ट होने पर बाहरी बॉर्डर ग्रीन होगा, अनसिलेक्ट होने पर ग्रे
                                    border: Border.all(
                                      color: row['selected'] == true ? const Color(0xFF117A7A) : Colors.grey.shade400,
                                      width: 2,
                                    ),
                                    // बाहरी सर्कल का बैकग्राउंड कलर हमेशा व्हाइट रहेगा
                                    color: Colors.white,
                                  ),
                                  child: row['selected'] == true
                                      ? Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF117A7A), // सिलेक्ट होने पर अंदर का छोटा डॉट ग्रीन होगा
                                    ),
                                  )
                                      : null, // अनसिलेक्ट होने पर अंदर कुछ नहीं दिखेगा (सिर्फ़ खाली ग्रे बॉर्डर वाला सर्कल)
                                ),
                              ),
                            ),
                            Container(width: 1, color: Colors.grey.shade300),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  print("Patient Name : ${row["name"]}");

                                  _showAdmittedPatientDialog(
                                    context,
                                    row["name"],
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 16,
                                  ),
                                  child: Text(
                                    row["name"] as String,
                                    style: const TextStyle(
                                      color: Color(0xFF117A7A),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(width: 1, color: Colors.grey.shade300),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 16,
                                ),
                                child: Text(
                                  row["crn"] as String,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildReferralsTable() {
    if (_filteredReferal.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("No patient found"),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    color: const Color(0xFFEAF9F9),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Patient Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Icon(Icons.unfold_more, size: 16),
                      ],
                    ),
                  ),
                ),
                Container(width: 1, height: 50, color: Colors.grey.shade300),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 50,
                    color: const Color(0xFFEAF9F9),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Action",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            ..._filteredReferal
                .map(
                  (row) => Column(
                    children: [
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
                                onTap: () {
                                  print("Tap");

                                  print("${row["name"]} - ${row["crn"]}");
                                  _showBlockBedModal();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      text: row["name"],
                                      style: const TextStyle(
                                        color: Color(0xFF117A7A),
                                        fontSize: 13,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " - ${row["crn"]}",
                                          style: const TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(width: 1, color: Colors.grey.shade300),
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  'assets/editicons.png', // 👈 your image path
                                  height: 15,
                                  width: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  void _showFilterSidebarAdmittedPateint() {



    AppFilterDialog.show(
      context: context,
      title: "Search Crieteria",
      showFooter: true,

      child: _FilterSidebar1(),
    );

  }

  void _showFilterSidebarReferal() {

    AppFilterDialog.show(
      context: context,
      title: "Search Crieteria",
      showFooter: true,

      child: _FilterSidebar2(),
    );

  }

  void _showBlockBedModal() {
    AppDialog.show(
      context: context,
      title: "Patient Details",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: Column(
                children: [
                  DetailRow(
                    label: "Patient Name",
                    customWidget: Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: "Anil Srivastava",
                            style: TextStyle(
                              color: Color(0xFF117A7A), // 🔵 Blue
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(
                            text: " - ",
                            style: TextStyle(color: Colors.black87),
                          ),
                          const TextSpan(
                            text: "0001000310",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DetailRow(label: "From Department", text: "Cardiology"),
                  DetailRow(label: "From Consultant", text: "Admin"),
                  DetailRow(label: "To Department", text: "Endocrinlogy"),
                  DetailRow(label: "To Consultant", text: "Archna K"),
                  DetailRow(
                    label: "Requested Date",
                    text: "08-10-2025 | 10:30",
                  ),
                  DetailRow(label: "Approval Status", text: "Not Approved"),
                  DetailRow(label: "Visit Status", text: "IP"),
                  DetailRow(
                    label: "Priority",
                    customWidget: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color(0xFFFFB7B5),
                      ),
                      child: const Text("High"),
                    ),
                  ),
                  DetailRow(label: "Type", text: "Transfer"),
                  DetailRow(
                    label: "Action",
                    customWidget: Image.asset(
                      'assets/editicon.png',
                      height: 15,
                      width: 15,
                      color: Colors.black,
                    ),
                    onTap: () {
                      print("Edit clicked");
                    },
                    isLast: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAdmittedPatientDialog(BuildContext parentContext, String name) {
    AppDialog.show(
      context: parentContext,
      title: "Patient Details",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: Column(
                children: [
                  DetailRow(label: "From Consultant", text: "Admin"),
                  DetailRow(
                    label: "Patient Name",
                    customWidget: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: name,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          const TextSpan(
                            text: "M 45 Y",
                            style: TextStyle(
                              color: Color(0xFF117A7A), // 🔵 Blue
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DetailRow(label: "CRN Number", text: "2025000438"),
                  DetailRow(label: "HRF Type", text: "Medium"),
                  DetailRow(label: "DOA", text: "08-10-2025 | 15:30"),
                  DetailRow(label: "Consultant", text: "Satyendra Tiwari"),
                  DetailRow(label: "Patient Status", text: "Under IP Care"),

                  DetailRow(
                    isLast: true,
                    label: "Bal.Amount",
                    removePadding: true, // 🔥 important
                    customWidget: GestureDetector(
                      onTap: () async {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pop(); // ✅ sirf dialog close

                        await Future.delayed(const Duration(milliseconds: 100));

                        _showPendingRequestDialog(parentContext);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        color: Colors.yellow,
                        child: const Text(
                          "20,435.75",
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPendingRequestDialog(BuildContext parentContext) {
    AppDialog.show(
      context: parentContext,
      title: "Pending Requests",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: Column(
                children: [
                  DetailRow(label: "Requistion No.", text: "REQ5879641"),

                  DetailRow(label: "Date", text: "08-10-2025 | 15:30"),
                  DetailRow(label: "Req. By", text: "Doctor"),
                  DetailRow(label: "Amount", text: "5000.00"),

                  DetailRow(
                    isLast: true,
                    label: "Action",
                    removePadding: true, // 🔥 important
                    customWidget: Container(
                      width: double.infinity,
                      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Icon(
                              Icons.print,
                              color: Colors.black87,
                              size: 20,
                            ),
                          ),


                          // --- UPDATED: Wrapped in GestureDetector to trigger the modal ---
                          GestureDetector(
                            onTap: () async {
                              final result = await showDeleteDialog(
                                parentContext,
                              ); // ✅ correct

                              if (result == true) {
                                print("Deleted");
                              } else {
                                print("Cancel");
                              }
                            },
                            child: Image.asset(
                              'assets/deleteicon.png', // 👈 your image path
                              height: 15,
                              width: 15,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SharedComponents.buildFormLabel("Collection Request"),
          const SizedBox(height: 8),

          FilterTextField(
            hintText: "Enter Collection Request",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pop(), // ✅ sirf dialog close
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF117A7A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _FilterSidebar1 extends StatefulWidget {
  const _FilterSidebar1();
  @override
  State<_FilterSidebar1> createState() => _OrderSetFilterSidebarState1();
}

class _OrderSetFilterSidebarState1 extends State<_FilterSidebar1> {

  String? _patientStatus = 'Patient Status';
  String? _ls1 = 'Is';
  String? _ipcare = 'Under IP Care';
  String? _department = "Department";
  String? _ls2 = "Is";
  String? _cardiology = 'Cardiology';
  String? _crno = 'CRNO';
  String? _like = 'Like';
  String? _crno_value = '2025000653';
  String activeLabel = '';






  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Hugs content
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Align(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.remove_circle,
            color: Colors.red,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            Expanded(
              flex: 2,
              child: ExpandedDropdown(
                value: _patientStatus,
                items: [
                  "Status 1",
                  "Status 2",
                  "Status 3",
                  "Status 4",
                ],
                onChanged: (v) =>
                    setState(() => _patientStatus = v),
              ),
            ),
            const SizedBox(width: 16),

            Expanded(
              flex: 1,
              child: ExpandedDropdown(
                value: _ls1,
                items: ["LS 1", "LS 2", "LS 3", "LS 4"],
                onChanged: (v) =>
                    setState(() => _ls1 = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        FunctionalDropdown(
          value: _ipcare,
          hint: "--Select--",
          items: [
            "--Select--",
            "Billing Cleared",
            "Marked For Discharged",
            "Under IP Care",
            "Waiting For Admission",
          ],
          onChanged: (val) =>
              setState(() => _ipcare = val),
        ),
        const SizedBox(height: 24),
        // Second Block
        Align(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.remove_circle,
            color: Colors.red,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ExpandedDropdown(
                value: _department,
                items: [
                  "Department 1",
                  "Department 2",
                  "Department 3",
                  "Department 4",
                ],
                onChanged: (v) =>
                    setState(() => _department = v),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: ExpandedDropdown(
                value: _ls2,
                items: ["LS 1", "LS 2", "LS 3", "LS 4"],
                onChanged: (v) =>
                    setState(() => _ls2 = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FunctionalDropdown(
          value: _cardiology,
          hint: "--Select--",
          items: [
            "--Select--",
            "cardiology 1",
            "cardiology 2",
            "cardiology 3",
            "cardiology 4",
          ],
          onChanged: (val) =>
              setState(() => _cardiology = val),
        ),
        const SizedBox(height: 24),

        // Third Block
        Align(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.add_circle,
            color: Colors.green,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ExpandedDropdown(
                value: _crno,
                items: [
                  "CRNo 1",
                  "CRNo 2",
                  "CRNo 3",
                  "CRNo 4",
                ],
                onChanged: (v) =>
                    setState(() => _crno = v),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: ExpandedDropdown(
                value: _like,
                items: [
                  "Like 1",
                  "Like 2",
                  "Like 3",
                  "Like 4",
                ],
                onChanged: (v) =>
                    setState(() => _like = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FunctionalDropdown(
          value: _crno_value,
          hint: "--Select--",
          items: [
            "--Select--",
            "20250006531",
            "20250006532",
            "20250006533",
            "2025000653",
          ],
          onChanged: (val) =>
              setState(() => _crno_value = val),
        ),
        const SizedBox(height: 16),


      ],
    );
  }


}


class _FilterSidebar2 extends StatefulWidget {
  const _FilterSidebar2();
  @override
  State<_FilterSidebar2> createState() => _OrderSetFilterSidebarState2();
}

class _OrderSetFilterSidebarState2 extends State<_FilterSidebar2> {


  String? _crno = 'CRNO';

  String? _crno2 = 'CRNO';

  String? _like = 'Like';
  String? _like2 = 'Like';
  String? _crno_value = '2025000653';
  String activeLabel = '';


  final toController = TextEditingController();
  DateTime? toDate;
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Hugs content
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Align(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.remove_circle,
            color: Colors.red,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ExpandedDropdown(
                value: _crno,
                items: [
                  "CRNo 1",
                  "CRNo 2",
                  "CRNo 3",
                  "CRNo 4",
                ],
                onChanged: (v) =>
                    setState(() => _crno = v),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: ExpandedDropdown(
                value: _like,
                items: [
                  "Like 1",
                  "Like 2",
                  "Like 3",
                  "Like 4",
                ],
                onChanged: (v) =>
                    setState(() => _like = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FunctionalDropdown(
          value: _crno_value,
          hint: "--Select--",
          items: [
            "--Select--",
            "20250006531",
            "20250006532",
            "20250006533",
            "2025000653",
          ],
          onChanged: (val) =>
              setState(() => _crno_value = val),
        ),
        const SizedBox(height: 12),

        Align(
          alignment: Alignment.centerRight,
          child: const Icon(
            Icons.add_circle,
            color: Colors.green,
            size: 20,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: ExpandedDropdown(
                value: _crno2,
                items: [
                  "CRNo 1",
                  "CRNo 2",
                  "CRNo 3",
                  "CRNo 4",
                ],
                onChanged: (v) =>
                    setState(() => _crno2 = v),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: ExpandedDropdown(
                value: _like2,
                items: [
                  "Like 1",
                  "Like 2",
                  "Like 3",
                  "Like 4",
                ],
                onChanged: (v) =>
                    setState(() => _like2 = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        AppDateField(
          controller: toController,
          onTap: () async {
            DateTime? pickedDate =
            await CustomCalendarDialog.show(
              context,
              initialDate: toDate ?? DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                toDate = pickedDate;
                toController.text = formatDate(pickedDate);
              });
            }
            ;
          },

        ),
        const SizedBox(height: 16),

      ],
    );
  }


}