import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/bottom_sheet.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/innner_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/IP/in_patient_screen.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

class BloodInventory extends StatefulWidget {
  const BloodInventory({super.key});
  @override
  State<BloodInventory> createState() => _IPInfectionRecState();
}

class _IPInfectionRecState extends State<BloodInventory> {
  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Blood Inventory",
      showDrawer: true,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Blood Inventory',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              GestureDetector(
                onTap: () {
                  AppFilterDialog.show(
                    context: context,
                    title: "Search",
                    showFooter: true,
                    child: _FilterSidebar(),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.02,
                    top: MediaQuery.of(context).size.height * 0.01,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: const Icon(Icons.filter_alt_outlined),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _buildTable(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return ScrollableDataTable(
      showPagination: true,
      labels: [
        'Blood Bag No.',
        'Component',
        'Group',
        'Status',
        'Expiry Date',
        'CR NO.',
        'Donor Reg No.',
        'Actions',
      ],
      rowValues: [
        [
          const TableText('2025091900001'),
          const TableText('2025091900002'),
          const TableText('2025091900003'),
          const TableText('2025091900004'),
        ],
        [
          const TableText('Cryo Poor Plasma'),
          const TableText('Cryo Poor Plasma'),
          const TableText('Cryo Poor Plasma'),
          const TableText('Cryo Poor Plasma'),
        ],
        [
          const TableText('O+ ve'),
          const TableText('O+ ve'),
          const TableText('O+ ve'),
          const TableText('O+ ve'),
        ],
        [
          const TableText('Not Available'),
          const TableText('Not Available'),
          const TableText('Not Available'),
          const TableText('Not Available'),
        ],
        [
          const TableText('04-11-2025'),
          const TableText('05-11-2025'),
          const TableText('06-11-2025'),
          const TableText('07-11-2025'),
        ],
        [
          const TableText('2025091900001'),
          const TableText('2025091900002'),
          const TableText('2025091900003'),
          const TableText('2025091900004'),
        ],

        [
          const TableText('D-202510300074'),
          const TableText('D-202510300074'),
          const TableText('D-202510300074'),
          const TableText('D-202510300074'),
        ],
        [
          GestureDetector(
            onTap: () {
              _openBottomSheet(context);
            },
            child: Image.asset(
              'assets/editicons.png',
              height: 15,
              width: 15,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              _openBottomSheet(context);
            },
            child: Image.asset(
              'assets/editicons.png',
              height: 15,
              width: 15,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              _openBottomSheet(context);
            },
            child: Image.asset(
              'assets/editicons.png',
              height: 15,
              width: 15,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              _openBottomSheet(context);
            },
            child: Image.asset(
              'assets/editicons.png',
              height: 15,
              width: 15,
              color: Colors.black,
            ),
          ),
        ],
      ],
    );
  }

  void _openBottomSheet(BuildContext context) {
    return CustomBottomSheet.show(
      context,
      title: 'Donor Donoation Details',

      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Donor Name'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: 'Amar Paswan',
            enabled: false,
          ),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Blood Group'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'O+ve', enabled: false),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Donor Type'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: 'Replacement',
            enabled: false,
          ),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Donation Type'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: 'Whole Blood',
            enabled: false,
          ),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Patient Name'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: 'Ram Sanjeevan',
            enabled: false,
          ),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Blood Component'),
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              SharedComponents.buildTextField(
                enabled: false,
                hintText:
                    "Leuco-poor red cells,Cryo poor PLasma. Cryoprecipitate",
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

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Issued Blood Componenets'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: 'Leuco-poor red cells',
            enabled: false,
          ),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel(
              'Transfused Patient and status',
            ),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(enabled: false),
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}

class _FilterSidebar extends StatefulWidget {
  const _FilterSidebar();
  @override
  State<_FilterSidebar> createState() => _OrderSetFilterSidebarState();
}

class _OrderSetFilterSidebarState extends State<_FilterSidebar> {
  String? _component = null;
  String? _bloodGroup = null;
  String? _status = null;
  String? _store = null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Componenet"),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _component,
          items: ['Pending', 'Completed'],
          onChanged: (val) {
            setState(() {
              _component = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Blood Bag No."),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Requistion No.'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Blood Group"),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _bloodGroup,
          items: ['Pending', 'Completed'],
          onChanged: (val) {
            setState(() {
              _bloodGroup = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Status"),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _status,
          items: ['Pending', 'Completed'],
          onChanged: (val) {
            setState(() {
              _status = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Donor Reg No."),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Donor Reg No.'),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Store"),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _store,
          items: ['Pending', 'Completed'],
          onChanged: (val) {
            setState(() {
              _store = val;
            });
          },
        ),
        const SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Total"),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: ''),
        const SizedBox(height: 16),
      ],
    );
  }
}
