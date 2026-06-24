import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// Import Custom Components & Unified Model
import 'package:qc_hospital/Core/Utils/Cards/summary_card_component.dart';
import 'package:qc_hospital/Core/Utils/Cards/dashboard_card_component.dart';
import 'package:qc_hospital/Core/Utils/Modals/dashboard_card_model.dart';

class DashboardVisitsScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const DashboardVisitsScreen({
    super.key,
    this.patientName = "Ram Sharma",
    this.crn = "2025000653",
  });

  @override
  State<DashboardVisitsScreen> createState() => _DashboardVisitsScreenState();
}

class _DashboardVisitsScreenState extends State<DashboardVisitsScreen> {
  // --- MAIN TAB STATE ---
  int _activeMainTab = 0; // 0 = My Visit, 1 = My Appointments

  // --- VISITS STATE ---
  String _activeFilter = "Total"; // "Total", "IP", or "OP"
  String _selectedMonth = "November";

  // --- MOCK DATA: VISITS ---
  final List<DashboardCardModel> _allVisits = [
    DashboardCardModel(
      date: DateTime(2026, 1, 12),
      dateTimeText: "January 12, 2026 | 8:00 AM",
      title: "Endocrine Surgery",
      badgeText: "IP",
      row1Label: "Visit ID : ",
      row1Value: "IP-001",
      row2Value: "Dr. Sabaretnam Mayilaganam",
      recordType: "IP",
    ),
    DashboardCardModel(
      date: DateTime(2026, 1, 19),
      dateTimeText: "January 19, 2026 | 8:00 AM",
      title: "Endocrine Surgery",
      badgeText: "IP",
      row1Label: "Visit ID : ",
      row1Value: "IP-002",
      row2Value: "Dr. Sabaretnam Mayilaganam",
      recordType: "IP",
    ),
    DashboardCardModel(
      date: DateTime(2026, 1, 7),
      dateTimeText: "January 7, 2026 | 8:00 AM",
      title: "Endocrine Surgery",
      badgeText: "OP",
      row1Label: "Visit ID : ",
      row1Value: "OP-001",
      row2Value: "Dr. Sabaretnam Mayilaganam",
      recordType: "OP",
    ),
  ];

  // --- MOCK DATA: APPOINTMENTS ---
  final List<DashboardCardModel> _allAppointments = [
    DashboardCardModel(
      date: DateTime(2026, 1, 7),
      dateTimeText: "January 12, 2026 | 8:00 AM - 1:00 PM",
      title: "Endocrine Surgery",
      badgeText: "Booked",
      row1Label: "Appointment Type : ",
      row1Value: "Consultation",
      row2Value: "Dr. Sabaretnam Mayilaganam",
      recordType: "Appointment",
    ),
  ];

  // Logic to dynamically filter visits
  List<DashboardCardModel> get _filteredVisits {
    if (_selectedMonth == "All") return []; // Shows empty SVG for visits
    if (_activeFilter == "Total") return _allVisits;
    return _allVisits.where((v) => v.recordType == _activeFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ClinicalBaseScaffold(
      title: "Dashboard",
      showDrawer: true,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Dashboard',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 2. Main Navigation Tabs (My Visit / My Appointments)
          Row(
            children: [
              _buildMainTabItem("My Visit", 0),
              const SizedBox(width: 24),
              _buildMainTabItem("My Appointments", 1),
            ],
          ),
          const SizedBox(height: 16),

          // 3. Conditional Rendering based on active tab
          if (_activeMainTab == 0)
            _buildMyVisitsView()
          else
            _buildMyAppointmentsView(),
        ],
      ),
    );
  }

  // --- MAIN TAB SELECTOR UI ---
  Widget _buildMainTabItem(String title, int index) {
    bool isActive = _activeMainTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeMainTab = index),
      child: Container(
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? const Color(0xFF117A7A) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isActive ? const Color(0xFF117A7A) : Colors.grey,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // =======================================================================
  // VIEW: MY VISITS
  // =======================================================================
  Widget _buildMyVisitsView() {
    int totalCount = _allVisits.length;
    int ipCount = _allVisits.where((v) => v.recordType == "IP").length;
    int opCount = _allVisits.where((v) => v.recordType == "OP").length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary Cards
        Row(
          children: [
            Expanded(
              child: SummaryCardComponent(
                title: "Total Visit",
                units: "$totalCount Units",
                backgroundColor: const Color(0xFFD0F0C0),
                onTap: () => setState(() => _activeFilter = "Total"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SummaryCardComponent(
                title: "IP Visit",
                units: "$ipCount Units",
                backgroundColor: const Color(0xFFADD8E6),
                onTap: () => setState(() => _activeFilter = "IP"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SummaryCardComponent(
                title: "OP Visit",
                units: "$opCount Units",
                backgroundColor: const Color(0xFFE6E6FA),
                onTap: () => setState(() => _activeFilter = "OP"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // List Header & Filter Dropdown
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _activeFilter == "Total" ? "Total Visit" : "$_activeFilter Visit",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Row(
              children: [
                Text(
                  _selectedMonth,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  onSelected: (newValue) =>
                      setState(() => _selectedMonth = newValue!),
                  itemBuilder: (context) => ["All", "November"].map((
                    String value,
                  ) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(value, style: const TextStyle(fontSize: 13)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Scrollable List OR Empty State
        _filteredVisits.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0, bottom: 40.0),
                  child: SvgPicture.asset(
                    'assets/myvisitillust.svg', // Visit SVG
                    width: MediaQuery.of(context).size.width * 0.9,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 8, bottom: 40),
                itemCount: _filteredVisits.length,
                itemBuilder: (context, index) {
                  return DashboardCardComponent(record: _filteredVisits[index]);
                },
              ),
      ],
    );
  }

  // =======================================================================
  // VIEW: MY APPOINTMENTS
  // =======================================================================
  Widget _buildMyAppointmentsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _allAppointments.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 60.0, bottom: 40.0),
                  child: SvgPicture.asset(
                    'assets/myappointsillust.svg',
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 8, bottom: 40),
                itemCount: _allAppointments.length,
                itemBuilder: (context, index) {
                  return DashboardCardComponent(
                    record: _allAppointments[index],
                  );
                },
              ),
      ],
    );
  }

  // Exact profile card replication
}
