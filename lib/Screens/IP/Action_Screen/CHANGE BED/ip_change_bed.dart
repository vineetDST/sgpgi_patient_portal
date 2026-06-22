import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Screens/IP/in_patient_screen.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/CHANGE BED/ip_change_bed_status.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

class IPChangeBed extends StatefulWidget {
  final String patientName;
  final String crn;

  const IPChangeBed({super.key, required this.patientName, required this.crn});

  @override
  State<IPChangeBed> createState() => _IPInfectionRecState();
}

class _IPInfectionRecState extends State<IPChangeBed> {
  String? _department = null;
  final reasonController = TextEditingController();

  final dateOfDischargeController = TextEditingController();
  DateTime? toDate;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Bed Change",
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
                "Change Bed",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildFromWardDetails(),
          const SizedBox(height: 16),

          _buildToWardDetails(),
          const SizedBox(height: 16),

          _buildOtherDetails(),
          const SizedBox(height: 16),

          AppSaveButton(text: 'Transfer', onPressed: () {}),
          const SizedBox(height: 16),

          AppCancelButton(text: 'Cancel', onPressed: () {}),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildFromWardDetails() {
    return CustomExpansionFrame(
      title: 'From Ward Details',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Department'),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _department,
          hint: "--Select--",
          items: ['--Select--', 'Cardiology'],
          onChanged: (val) {
            setState(() {
              _department = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Ward'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Ward'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Unit Name'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Unit Name'),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Bed Type'),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: 'Bed Type'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Bed No'),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: 'Bed No'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToWardDetails() {
    return CustomExpansionFrame(
      title: 'To Ward Details',
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('Department'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IpChangeBedStatusScreen(
                      patientName: widget.patientName,
                      crn: widget.crn,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.search, color: Colors.black, size: 22),
            ),
            // Icon(Icons.search),
          ],
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _department,
          hint: "--Select--",
          items: ['--Select--', 'Cardiology'],
          onChanged: (val) {
            setState(() {
              _department = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Ward'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Ward'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Unit Name'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: 'Unit Name',
          enabled: false,
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      'Bed Type',
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: 'Bed Type'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      'Bed No',
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: 'Bed No'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOtherDetails() {
    return CustomExpansionFrame(
      title: 'Other Details',
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Transfer Date'),
                  ),
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
                          dateOfDischargeController.text = formatDate(
                            pickedDate,
                          );
                        });
                      }
                      ;
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Transfer Time'),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(
                    hintText: 'Transfer Time',
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Reason', isRequired: true),
        ),
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
      ],
    );
  }
}
