import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Camp/camp.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Procedure/edit_therapeutic_phlebotomy.dart';

import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class ProcedureDetails extends StatefulWidget {
  ProcedureDetails({super.key});
  @override
  State<ProcedureDetails> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<ProcedureDetails> {
  int _currentTabIndex = 0;

  String typeRadio1 = "Single";

  final plateletController = TextEditingController(
    text: '0',
  ); // Default value yahan assign karein
  final wtController = TextEditingController(text: '82.0');

  final expiryDate_1_controller = TextEditingController();
  final expiryDate_2_controller = TextEditingController();
  final expiryDate_3_controller = TextEditingController();

  DateTime? expiryDate_1_date;
  DateTime? expiryDate_2_date;
  DateTime? expiryDate_3_date;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  final TextEditingController _remarksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Procedure Details",
      showDrawer: false,
      child: Column(
        children: [
          _buildCustomTabs(),
          const SizedBox(height: 16),

          _currentTabIndex == 0 ? _buildProcedureTab(context) : _buildQualityTab(),
        ],
      ),
    );
  }

  Widget _buildCustomTabs() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
      ),
      child: Row(
        children: [
          _buildTabItem("Procedure Details", 0),
          _buildTabItem("Quality of Product", 1),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index) {
    bool isActive = _currentTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentTabIndex = index),
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

  Widget _buildProcedureTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Platelet Count'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(
                    controller: plateletController,
                    enabled: false,
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
                    child: SharedComponents.buildFormLabel('Wt(kg)/ht(in cm)'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(
                    controller: wtController,
                    enabled: false,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Machine'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Machine'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Arm'),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Row(
            children: [
              RadioButton<String>(
                value: "Single",
                label: "Single",
                groupValue: typeRadio1,
                onChanged: (v) => setState(() => typeRadio1 = v!),
              ),
              const SizedBox(width: 16), // Dono ke beech thoda gap
              RadioButton<String>(
                value: "Double",
                label: "Double",
                groupValue: typeRadio1,
                onChanged: (v) => setState(() => typeRadio1 = v!),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Kit No.'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: 'Kit No.'),
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
                    child: SharedComponents.buildFormLabel('Expiry Date'),
                  ),

                  const SizedBox(height: 8),
                  AppDateField(
                    controller: expiryDate_1_controller,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: expiryDate_1_date ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          expiryDate_1_date = pickedDate;
                          expiryDate_1_controller.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('ACD Lot No.'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: 'ACD Lot No.'),
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
                    child: SharedComponents.buildFormLabel('Expiry Date'),
                  ),

                  const SizedBox(height: 8),
                  AppDateField(
                    controller: expiryDate_2_controller,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: expiryDate_2_date ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          expiryDate_2_date = pickedDate;
                          expiryDate_2_controller.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('NS Lot No.'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: 'NS Lot No.'),
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
                    child: SharedComponents.buildFormLabel('Expiry Date'),
                  ),

                  const SizedBox(height: 8),
                  AppDateField(
                    controller: expiryDate_3_controller,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: expiryDate_3_date ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          expiryDate_3_date = pickedDate;
                          expiryDate_3_controller.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        _buildProcedureRecordDetails(context),

        const SizedBox(height: 16),
        UploadFileWidget(
          key: const ValueKey('procedure_consent_upload'),
          label: 'Consent Upload',
          onImagePicked: (XFile file) {
            print("Selected File Path: ${file.path}");
            // Yahan aap file ko server par upload karne ka logic likh sakte hain
          },
        ),
        const SizedBox(height: 16),
        AppSaveButton(),
        const SizedBox(height: 16),
        AppCancelButton(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildQualityTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Platelet Count/ml'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: '0'),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Final Volume'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: '0'),
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
                    child: SharedComponents.buildFormLabel('Final Yield'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: '0'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('WBC Count/ml'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: '0'),
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
                    child: SharedComponents.buildFormLabel('WBC/Unit'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: '0'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Red Cell Count/ml'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: '0'),
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
                    child: SharedComponents.buildFormLabel('Red Cell/Unit'),
                  ),

                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: '0'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Remarks"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: "Remarks",
          maxLines: 5,

          controller: _remarksController
        ),
        SizedBox(height: 16),

        UploadFileWidget(
          key: const ValueKey('quality_consent_upload'),
          label: 'Consent Upload',
          onImagePicked: (XFile file) {
            print("Selected File Path: ${file.path}");
            // Yahan aap file ko server par upload karne ka logic likh sakte hain
          },
        ),
        const SizedBox(height: 16),
        AppSaveButton(),
        const SizedBox(height: 16),
        AppCancelButton(),
        const SizedBox(height: 16),
      ],
    );
  }



  Widget _buildProcedureRecordDetails(BuildContext context)  {
    return CustomExpansionFrame(
      actionText: 'ADD',
      onActionPressed: () {},
      title: 'Procedure Record Details',
      children: [
        DetailTableWrapper(
          children: [
            DetailRow(label: 'Run Time'),
            DetailRow(label: 'WB Flow Rate'),
            DetailRow(label: 'WB Volume'),
            DetailRow(label: 'ACD Ratio'),
            DetailRow(label: 'ACD Volume'),
            DetailRow(label: 'Saline Volume'),
            DetailRow(label: 'Plasma Volume'),
            DetailRow(label: 'Plasma Flow Rate'),
            DetailRow(label: 'Yield/Cycle'),
            DetailRow(label: 'Pulse Rate'),
            DetailRow(label: 'Remarks'),
            DetailRow(
              label: 'Action',
              customWidget: NoPaddingCell(child: AppDeleteIcon(parentContext: context,)),
              isLast: true,
              removePadding: true,
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
