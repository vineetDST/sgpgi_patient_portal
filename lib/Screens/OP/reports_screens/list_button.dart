import 'package:flutter/material.dart';

// --- Sabhi screens aur shells ke imports yahan karein ---
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_investigation_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_medication_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_prev_vital_signs_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_fluid_balance_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_transfusion_orders_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_examination_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_pomr_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_documents_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_patient_forms_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_infection_control_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_visit_summary_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_nursing_notes_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_surgical_procedure_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_progress_notes_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_discharge_summary_screen.dart';

/// 1. MAIN COMPONENT: Yeh button aap har jagah call karenge
class EmrListButton extends StatelessWidget {
  final String patientName;
  final String crn;
  final String? mode;
  final String buttonText;

  const EmrListButton({
    super.key,
    required this.patientName,
    required this.crn,
    this.mode = "op",
    this.buttonText = "List", // Default text 'List' rahega, change bhi kar sakte hain
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // --- Sidebar Open Karne Ka Dynamic Logic ---
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: "EMR List",
          
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75, // 85% width
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadiusGeometry.circular(16),
                  child: EmrListScreen(
                    patientName: patientName,
                    crn: crn,
                    mode: mode,
                  ),
                ),
              ),
            );
          },
          transitionBuilder: (context, anim1, anim2, child) {
            return SlideTransition(
              position: Tween(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ).animate(anim1),
              child: child,
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}

/// 2. INTERNAL SCREEN: Jo Sidebar ke andar dikhegi
class EmrListScreen extends StatelessWidget {
  final String patientName;
  final String crn;
  final String? mode;

  const EmrListScreen({
    super.key,
    required this.patientName,
    required this.crn,
    this.mode = "op",
  });

  @override
  Widget build(BuildContext context) {
    final List<String> opFolders = [
      "Consultation Details", "Investigation", "Medication", "Vital Sign",
      "Fluid Balance Chart", "Transfusion Orders", "Examination", "POMR",
      "Documents", "Progress Notes", "Nursing Notes", "Discharge Summary",
      "Surgical Procedure",
    ];

    final List<String> ipFolders = [
      "Consultation Details", "Investigation", "Medication", "Vital Sign",
      "Fluid Balance Chart", "Transfusion Orders", "Examination", "POMR",
      "Documents", "Patient Forms", "Infection Control", "Progress Notes",
      "Nursing Notes", "Discharge Summary", "Surgical Procedure",
    ];

    return SafeArea(

      child: Column(
        children: [
          // Header
          const SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Patient Chart",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.black87, size: 28),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          // Expandable List
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              decoration: BoxDecoration(

                color: Colors.white,
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _EmrExpandableRow(title: "OP - 10-08-2025", subItems: opFolders, patientName: patientName, crn: crn, screen_mode: mode),
                  _EmrExpandableRow(title: "OP - 11-08-2025", subItems: opFolders, patientName: patientName, crn: crn, screen_mode: mode),
                  _EmrExpandableRow(title: "OP - 12-08-2025", subItems: opFolders, patientName: patientName, crn: crn, screen_mode: mode),
                  _EmrExpandableRow(title: "IP - 15-08-2025", subItems: ipFolders, patientName: patientName, crn: crn, screen_mode: mode),
                  _EmrExpandableRow(title: "IP - 16-08-2025", subItems: ipFolders, patientName: patientName, crn: crn, screen_mode: mode),
                  _EmrExpandableRow(title: "IP - 17-08-2025", subItems: ipFolders, patientName: patientName, crn: crn, screen_mode: mode),
                  _EmrExpandableRow(title: "IP - 18-08-2025", subItems: ipFolders, patientName: patientName, crn: crn, screen_mode: mode),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 3. INTERNAL EXPANDABLE ROW: Jisme dynamic routing map use kiya h
class _EmrExpandableRow extends StatefulWidget {
  final String title;
  final List<String> subItems;
  final bool initiallyExpanded;
  final String patientName;
  final String crn;
  final String? screen_mode;

  const _EmrExpandableRow({
    required this.title,
    required this.subItems,
    this.initiallyExpanded = false,
    required this.patientName,
    required this.crn,
    this.screen_mode = "op",
  });

  @override
  State<_EmrExpandableRow> createState() => _EmrExpandableRowState();
}

class _EmrExpandableRowState extends State<_EmrExpandableRow> {
  late bool _isExpanded;

  // --- DYNAMIC SCREEN ROUTE MAP ---
  late final Map<String, Widget Function(String, String, String?)> _screenMap;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;

    // Yahan humne saare screens ko key-value pairs mein map kar diya
    _screenMap = {
      "Consultation Details": (pName, crn, mode) => EmrScreen(patientName: pName, crn: crn, mode: mode),
      "Investigation": (pName, crn, mode) => EmrInvestigationScreen(patientName: pName, crn: crn, mode: mode),
      "Medication": (pName, crn, mode) => EmrMedicationScreen(patientName: pName, crn: crn, mode: mode),
      "Vital Sign": (pName, crn, mode) => EmrPrevVitalSignsScreen(patientName: pName, crn: crn, mode: mode),
      "Fluid Balance Chart": (pName, crn, mode) => EmrFluidBalanceScreen(patientName: pName, crn: crn, mode: mode),
      "Transfusion Orders": (pName, crn, mode) => EmrTransfusionOrdersScreen(patientName: pName, crn: crn, mode: mode),
      "Examination": (pName, crn, mode) => EmrExaminationScreen(patientName: pName, crn: crn, mode: mode),
      "POMR": (pName, crn, mode) => EmrPomrScreen(patientName: pName, crn: crn, mode: mode),
      "Documents": (pName, crn, mode) => EmrDocumentsScreen(patientName: pName, crn: crn, mode: mode),
      "Patient Forms": (pName, crn, mode) => EmrPatientFormsScreen(patientName: pName, crn: crn, mode: mode),
      "Infection Control": (pName, crn, mode) => EmrInfectionControlScreen(patientName: pName, crn: crn, mode: mode),
      "Visit Summary": (pName, crn, mode) => EmrVisitSummaryScreen(patientName: pName, crn: crn, mode: mode),
      "Progress Notes": (pName, crn, mode) => EmrProgressNotesScreen(patientName: pName, crn: crn, mode: mode),
      "Nursing Notes": (pName, crn, mode) => EmrNursingNotesScreen(patientName: pName, crn: crn, mode: mode),
      "Discharge Summary": (pName, crn, mode) => EmrDischargeSummaryScreen(patientName: pName, crn: crn, mode: mode),
      "Surgical Procedure": (pName, crn, mode) => EmrSurgicalProcedureScreen(patientName: pName, crn: crn, mode: mode),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                Icon(_isExpanded ? Icons.remove_circle : Icons.add_circle, color: Colors.grey.shade400, size: 24),
                const SizedBox(width: 16),
                Image.asset('assets/file.png', height: 24, width: 24, color: const Color(0xFF117A7A)),
                const SizedBox(width: 16),
                Text(widget.title, style: const TextStyle(fontSize: 16, color: Colors.black87)),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Column(
            children: widget.subItems.map((subItem) {
              return InkWell(
                onTap: () {
                  // Sidebar Close Karein
                  Navigator.pop(context);

                  // Map se widget builder fetch karein aur redirect karein
                  final screenBuilder = _screenMap[subItem];
                  if (screenBuilder != null) {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      screenBuilder(widget.patientName, widget.crn, widget.screen_mode),
                    );
                  } else {
                    debugPrint("No screen mapping found for: $subItem");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 60, top: 12, bottom: 12, right: 20),
                  child: Row(
                    children: [
                      Image.asset('assets/folder.png', height: 24, width: 24, color: const Color(0xFFFFC107)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(subItem, style: const TextStyle(fontSize: 16, color: Colors.black87)),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}