import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Screens/IP/in_patient_screen.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

class IPBedSwap extends StatefulWidget {
  final String patientName;
  final String crn;

  const IPBedSwap({super.key, required this.patientName, required this.crn});

  @override
  State<IPBedSwap> createState() => _IPInfectionRecState();
}

class _IPInfectionRecState extends State<IPBedSwap> {
  final dateOfDischargeController = TextEditingController();

  final dischargeRemarksController = TextEditingController();
  final reasonController = TextEditingController();

  DateTime? toDate;
  String? _requestType = null;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Bed Swap",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bed Swap",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          SharedComponents.buildFormLabel('Admitting Doctor'),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: "Sudeep Kumar",
            hint: '',
            items: [],
            onChanged: (val) {},
            enabled: false,
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel('Admittion Date'),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: '08-10-2025',
            enabled: false,
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel('From Location'),
          const SizedBox(height: 8),
          Container(
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200, width: 1.5),
            ),
            child: Text(
              'PGI Licknow / 1201 Cardiology Wing-A1(MICU) / Medical Care Unit / 19',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel('Request Date'),
          const SizedBox(height: 8),
          AppDateField(

            controller: dateOfDischargeController,
            onTap: () async {
              DateTime? pickedDate = await CustomCalendarDialog.show(
                context,
                initialDate: toDate ?? DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() {
                  toDate = pickedDate;
                  dateOfDischargeController.text = formatDate(pickedDate);
                });
              }
              ;
            },
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel('Request Type'),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: _requestType,
            hint: '--Select--',
            items: [
              "--Select--",
              "Absconded",
              "Any Other Reasong",
              "Comma State",
              "Cured",
              "Death",
              "Discharge on Own Request",
              "LAMA",
              "Normal Discharge",
              "Referred to Other Hospitals",
              "Transfer to Other Institute",
              "With Medical Advice",
            ],
            onChanged: (val) {
              setState(() {
                _requestType = val;
              });
            },
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SharedComponents.buildFormLabel('CRN Number'),
              GestureDetector(
                onTap: () {
                  _showCRNDialog();
                },
                child: Icon(Icons.search),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'CNR Number',),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel('Pateint Name'),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: 'Pateint Name',
            enabled: false,
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel('To Location'),
          const SizedBox(height: 8),
          Stack(
            children: [
              SharedComponents.buildTextField(
                controller: dischargeRemarksController,
                hintText: "To Location",
                maxLines: 5,
                // height: 130,
              ),
              // Positioned(
              //   bottom: 12,
              //   right: 12,
              //   child: Image.asset(
              //     'assets/txtarea.png', // Uses the uploaded icon
              //     width: 14,
              //     height: 14,
              //     color: Colors.grey.shade400,
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel('Reason', isRequired: true),
          const SizedBox(height: 8),
          Stack(
            children: [
              SharedComponents.buildTextField(
                controller: reasonController,
                hintText: "Reason",
                maxLines: 5,
                // height: 130,
              ),
              // Positioned(
              //   bottom: 12,
              //   right: 12,
              //   child: Image.asset(
              //     'assets/txtarea.png', // Uses the uploaded icon
              //     width: 14,
              //     height: 14,
              //     color: Colors.grey.shade400,
              //   ),
              // ),
            ],
          ),
          const SizedBox(height: 24),

          AppSaveButton(text: 'Transfer', onPressed: () {}),
          const SizedBox(height: 16),

          AppCancelButton(text: 'Cancel', onPressed: () {}),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void _showCRNDialog() {
    AppDialog.show(
      context: context,
      title: "Patient BedSwap Search",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          SharedComponents.buildFormLabel('Patient Search'),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'Search...',suffix: const Icon(Icons.search, color: Colors.grey, size: 22),),
          const SizedBox(height: 32),

          _buildPatientBedSwapSearchTable(),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildPatientBedSwapSearchTable() {
    return ScrollableDataTable(
      labels: const ["CR No", "Patient Name", "Age / Gender", "Add"],
      // Har array me 2 values hain, jo horizontally scroll hongi
      rowValues: [
        // 1. Investigation Name Row
        [
          const Text("2025000653", style: TextStyle(fontSize: 13)),
          const Text("2025000653", style: TextStyle(fontSize: 13)),
          const Text("2025000653", style: TextStyle(fontSize: 13)),
        ],
        // 2. Order No Row
        [
          const Text("Ram Sharma", style: TextStyle(fontSize: 13)),
          const Text("Ram Kumar", style: TextStyle(fontSize: 13)),
          const Text("Rohit Kumar", style: TextStyle(fontSize: 13)),
        ],
        // 3. Date Row (Pehla khali hai image me)
        [
          const Text("25 / Male", style: TextStyle(fontSize: 13)),
          const Text("25 / Male", style: TextStyle(fontSize: 13)),
          const Text("25 / Male", style: TextStyle(fontSize: 13)),
        ],
        [
          const Icon(Icons.add_circle, color: Color(0xFF4CAF50), size: 22),
          const Icon(Icons.add_circle, color: Color(0xFF4CAF50), size: 22),
          const Icon(Icons.add_circle, color: Color(0xFF4CAF50), size: 22),
        ],
      ],
    );
  }
}
