import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

class IPDischarge extends StatefulWidget {
  final String patientName;
  final String crn;
  const IPDischarge({super.key, required this.patientName, required this.crn});
  @override
  State<IPDischarge> createState() => _VisitSummaryScreenState();
}

class _VisitSummaryScreenState extends State<IPDischarge> {
  final toController = TextEditingController();
  final dateOfDischargeController = TextEditingController();
  final dischargeRemarksController = TextEditingController();

  DateTime? toDate;
  String? dischargeType = null;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return IpBaseScaffold(
      title: "Discharge",
      quickActionLabel: "Discharge",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: true,

      // We only pass the content that is unique to the Visit Summary screen below the Quick Actions
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Discharge",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  IPActionButton(),

                  const SizedBox(width: 12),
                  const Icon(Icons.print, color: Colors.black87),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Consulting Doctor"),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: "Sudeep Kumar",
            hint: "--Select--",
            items: [],
            onChanged: (val) => () {},
            enabled: false,
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Admitted On"),
          const SizedBox(height: 8),
          AppDateField(

            controller: toController,
            onTap: () async {},
            enabled: false,
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Date of Discharge"),
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

          SharedComponents.buildFormLabel("Bed Type"),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: "Sudeep Kumar",
            hint: "--Select--",
            items: [],
            onChanged: (val) => () {},
            enabled: false,
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Dischrage Type", isRequired: true),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: dischargeType,
            hint: "--Select--",
            items: [
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
            onChanged: (v) => setState(() => dischargeType = v),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Location"),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: "1201 Cardiology Wing-A01(MICU)",
            hint: "--Select--",
            items: [],
            onChanged: (val) => () {},
            enabled: false,
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Discharge Remarks"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: dischargeRemarksController,
            hintText: "Discharge Remarks",
            maxLines: 5,
            // height: 130,
          ),
          const SizedBox(height: 32),

          AppSaveButton(text: "Discharge", onPressed: () {}),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
