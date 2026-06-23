import 'package:flutter/material.dart';

// --- Make sure these imports match your file structure ---
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart'; // Your existing EMR Screen
import 'package:qc_hospital/Screens/OP/reports_screens/emr_investigation_screen.dart';
import 'package:qc_hospital/Screens/OP/reports_screens/emr_medication_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_prev_vital_signs_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_fluid_balance_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_transfusion_orders_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_examination_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_pomr_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_documents_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_patient_forms_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_infection_control_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_visit_summary_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_nursing_notes_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_surgical_procedure_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_progress_notes_screen.dart'; // The new screen below
import 'package:qc_hospital/Screens/OP/reports_screens/emr_discharge_summary_screen.dart'; // The new screen below

// --- ADDED IMPORT FOR DOCTOR SHELL NAVIGATION ---
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

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
    print("$mode");
    final List<String> opFolders = [
      "Consultation Details",
      "Investigation",
      "Medication",
      "Vital Sign",
      "Fluid Balance Chart",
      "Transfusion Orders",
      "Examination",
      "POMR",
      "Documents",
      "Progress Notes",
      "Nursing Notes",
      "Discharge Summary",
      "Surgical Procedure",
      // "Patient Forms",
      // "Infection Control",
      // "Visit Summary",
    ];

    final List<String> ipFolders = [
      "Consultation Details",
      "Investigation",
      "Medication",
      "Vital Sign",
      "Fluid Balance Chart",
      "Transfusion Orders",
      "Examination",
      "POMR",
      "Documents",
      "Patient Forms",
      "Infection Control",
      "Progress Notes",
      "Nursing Notes",
      "Discharge Summary",
      "Surgical Procedure",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "EMR",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black87,
                      size: 28,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

            // The Expandable List Area
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  children: [
                    _EmrExpandableRow(
                      title: "OP - 10-08-2025",
                      subItems: opFolders,
                      initiallyExpanded: false,
                      patientName: patientName,
                      crn: crn,
                      screen_mode: mode,
                    ),
                    _EmrExpandableRow(
                      title: "OP - 11-08-2025",
                      subItems: opFolders,
                      patientName: patientName,
                      crn: crn,
                      screen_mode: mode,
                    ),
                    _EmrExpandableRow(
                      title: "OP - 12-08-2025",
                      subItems: opFolders,
                      patientName: patientName,
                      crn: crn,
                      screen_mode: mode,
                    ),
                    _EmrExpandableRow(
                      title: "IP - 15-08-2025",
                      subItems: ipFolders,
                      patientName: patientName,
                      crn: crn,
                      screen_mode: mode,
                    ),
                    _EmrExpandableRow(
                      title: "IP - 16-08-2025",
                      subItems: ipFolders,
                      patientName: patientName,
                      crn: crn,
                      screen_mode: mode,
                    ),
                    _EmrExpandableRow(
                      title: "IP - 17-08-2025",
                      subItems: ipFolders,
                      patientName: patientName,
                      crn: crn,
                      screen_mode: mode,
                    ),
                    _EmrExpandableRow(
                      title: "IP - 18-08-2025",
                      subItems: ipFolders,
                      patientName: patientName,
                      crn: crn,
                      screen_mode: mode,
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
}

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

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
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
                Icon(
                  _isExpanded ? Icons.remove_circle : Icons.add_circle,
                  color: Colors.grey.shade400,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Image.asset(
                  'assets/file.png', // 👈 your image path
                  height: 24,
                  width: 24,
                  color: const Color(0xFF117A7A),
                ),
                const SizedBox(width: 16),
                Text(
                  widget.title,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          Column(
            children: widget.subItems.map((subItem) {
              return InkWell(
                onTap: () {
                  // --- ROUTING LOGIC (UPDATED TO RETAIN FOOTER) ---

                  // Pop the current EMR List Screen first
                  Navigator.pop(context);

                  if (subItem == "Consultation Details") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Investigation") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrInvestigationScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Medication") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrMedicationScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Vital Sign") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrPrevVitalSignsScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Fluid Balance Chart") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrFluidBalanceScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Transfusion Orders") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrTransfusionOrdersScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Examination") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrExaminationScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "POMR") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrPomrScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Documents") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrDocumentsScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Patient Forms") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrPatientFormsScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Infection Control") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrInfectionControlScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Visit Summary") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrVisitSummaryScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Progress Notes") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrProgressNotesScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Nursing Notes") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrNursingNotesScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Discharge Summary") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrDischargeSummaryScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  } else if (subItem == "Surgical Procedure") {
                    doctorShellKey.currentState?.pushToCurrentTab(
                      EmrSurgicalProcedureScreen(
                        patientName: widget.patientName,
                        crn: widget.crn,
                        mode: widget.screen_mode,
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 60,
                    top: 12,
                    bottom: 12,
                    right: 20,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/folder.png', // 👈 your image path
                        height: 24,
                        width: 24,
                        color: const Color(0xFFFFC107),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          subItem,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
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
