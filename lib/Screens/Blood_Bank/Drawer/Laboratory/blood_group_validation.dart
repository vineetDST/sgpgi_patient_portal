import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/bottom_sheet.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/innner_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class BloodGroupValidation extends StatefulWidget {
  BloodGroupValidation({super.key});

  @override
  State<BloodGroupValidation> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<BloodGroupValidation> {

  final TextEditingController _remarksController1 = TextEditingController();
  final TextEditingController _remarksController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Blood Group Validation",

      showDrawer: true,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Blood Group Validation',
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

          AppCancelButton(
            text: 'Confirm All Mathced Records',
            onPressed: () {
              AppDialog.show(
                context: context,
                title: 'Serum Grouping Preperation',
                child: DetailTableWrapper(
                  children: [
                    DetailRow(label: 'Blood Group'),
                    DetailRow(label: 'Blood Unit No.'),

                    DetailRow(label: 'Date Of Preperation'),
                    DetailRow(label: 'Document No.', isLast: true),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return ScrollableDataTable(
      showPagination: true,
      tableLabels: const [
        TableLabel(text: 'Blood Bag No.', icon: Icons.unfold_more),
        TableLabel(text: 'Serum', icon: Icons.unfold_more),
        TableLabel(text: 'Remarks'), // 👈 Isme icon nahi hai
        TableLabel(text: 'Cell', icon: Icons.unfold_more),
        TableLabel(text: 'Rh', icon: Icons.unfold_more),
        TableLabel(text: 'Remarks'), // 👈 Isme bhi icon nahi hai
        TableLabel(text: 'Gr/Rh'),
        TableLabel(text: 'Irr.A', icon: Icons.unfold_more),
        TableLabel(text: 'Geno Type', icon: Icons.unfold_more),
        TableLabel(text: 'Status', icon: Icons.unfold_more),
        TableLabel(text: 'Action'), // 👈 Isme bhi icon nahi hai
      ],
      rowValues: [
        [
          Text(
            '2025091900001',
            style: TextStyle(fontSize: 13, color: const Color(0xFF117A7A)),
          ),
          Text(
            '2025091900002',
            style: TextStyle(fontSize: 13, color: const Color(0xFF117A7A)),
          ),
          Text(
            '2025091900003',
            style: TextStyle(fontSize: 13, color: const Color(0xFF117A7A)),
          ),
          Text(
            '2025091900004',
            style: TextStyle(fontSize: 13, color: const Color(0xFF117A7A)),
          ),
        ],
        [
          const TableText('B'),
          const TableText('B'),
          const TableText('B'),
          const TableText('B'),
        ],
        [
          CustomRemarksField(
            title: "Remarks",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Remarks",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Remarks",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Remarks",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
        ],
        [
          const TableText('B'),
          const TableText('B'),
          const TableText('B'),
          const TableText('B'),
        ],
        [
          const TableText('+ve'),
          const TableText('+ve'),
          const TableText('+ve'),
          const TableText('+ve'),
        ],
        [
          CustomRemarksField(
            title: "Remarks",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Remarks",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Remarks",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Remarks",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
        ],
        [
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
        ],
        [
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
        ],
        [
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
          const SizedBox(),
        ],
        [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFBDDAFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TableText('Confirmed'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFBDDAFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TableText('Confirmed'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFBDDAFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TableText('Confirmed'),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFBDDAFF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TableText('Confirmed'),
          ),
        ],

        [
          Wrap(
            runSpacing: 10,

            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text(
                'Retest',
                style: TextStyle(fontSize: 10, color: const Color(0xFF117A7A)),
              ),
              const SizedBox(width: 16),
              Text(
                'Override',
                style: TextStyle(fontSize: 10, color: const Color(0xFF117A7A)),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  _openCellBottomSheet(context);
                },
                child: Text(
                  'Cell',
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF117A7A),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  _openSerumBottomSheet(context);
                },
                child: Text(
                  'Serum',
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF117A7A),
                  ),
                ),
              ),
            ],
          ),
          Wrap(
            runSpacing: 10,

            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text(
                'Retest',
                style: TextStyle(fontSize: 10, color: const Color(0xFF117A7A)),
              ),
              const SizedBox(width: 16),
              Text(
                'Override',
                style: TextStyle(fontSize: 10, color: const Color(0xFF117A7A)),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  _openCellBottomSheet(context);
                },
                child: Text(
                  'Cell',
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF117A7A),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  _openSerumBottomSheet(context);
                },
                child: Text(
                  'Serum',
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF117A7A),
                  ),
                ),
              ),
            ],
          ),
          Wrap(
            runSpacing: 10,

            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text(
                'Retest',
                style: TextStyle(fontSize: 10, color: const Color(0xFF117A7A)),
              ),
              const SizedBox(width: 16),
              Text(
                'Override',
                style: TextStyle(fontSize: 10, color: const Color(0xFF117A7A)),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  _openCellBottomSheet(context);
                },
                child: Text(
                  'Cell',
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF117A7A),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  _openSerumBottomSheet(context);
                },
                child: Text(
                  'Serum',
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF117A7A),
                  ),
                ),
              ),
            ],
          ),
          Wrap(
            runSpacing: 10,

            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              Text(
                'Retest',
                style: TextStyle(fontSize: 10, color: const Color(0xFF117A7A)),
              ),
              const SizedBox(width: 16),
              Text(
                'Override',
                style: TextStyle(fontSize: 10, color: const Color(0xFF117A7A)),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  _openCellBottomSheet(context);
                },
                child: Text(
                  'Cell',
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF117A7A),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  _openSerumBottomSheet(context);
                },
                child: Text(
                  'Serum',
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFF117A7A),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _openCellBottomSheet(BuildContext context) {
    final dateOfDischargeController = TextEditingController();
    DateTime? toDate;
    String formatDate(DateTime date) {
      return "${date.day.toString().padLeft(2, '0')}-"
          "${date.month.toString().padLeft(2, '0')}-"
          "${date.year.toString().substring(2)}";
    }

    String _selected_Anti_H = '--Select--';
    String _selected_Anti_A = '--Select--';
    String _selected_Anti_B = '--Select--';
    String _selected_Anti_AB = '--Select--';
    String _selected_D1 = '--Select--';
    String _selected_D2 = '--Select--';
    String _selected_DU = '--Select--';
    String _selected_RH = '--Select--';

    return CustomBottomSheet.show(
      context,
      title: 'Cell Grouping Overriding',

      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Query Date'),
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
                  dateOfDischargeController.text = formatDate(pickedDate);
                });
              }
              ;
            },
          ),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Blood Bag No.'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'Blood Bag No.'),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel('Anti-H'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_Anti_H,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_Anti_H = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('Anti-A'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_Anti_A,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_Anti_A = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('Anti-B'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_Anti_B,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_Anti_B = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('Anti-AB'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_Anti_AB,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_Anti_AB = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('D1'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_D1,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_D1 = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('D2'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_D2,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_D2 = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('DU'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_DU,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_DU = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('Geno Type'),
                    ),
                    const SizedBox(height: 8),
                    SharedComponents.buildTextField(),
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
                      child: SharedComponents.buildFormLabel('ABO'),
                    ),
                    const SizedBox(height: 8),
                    SharedComponents.buildTextField(hintText: 'B'),
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
                      child: SharedComponents.buildFormLabel('Rh'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_RH,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_RH = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Remarks'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
              hintText: "Remarks",
              maxLines: 5,
              controller: _remarksController1
          ),
          const SizedBox(height: 16),

          AppSaveButton(),
          const SizedBox(height: 16),
          AppCancelButton(text: 'Close'),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  void _openSerumBottomSheet(BuildContext context) {
    final dateOfDischargeController = TextEditingController();
    DateTime? toDate;
    String formatDate(DateTime date) {
      return "${date.day.toString().padLeft(2, '0')}-"
          "${date.month.toString().padLeft(2, '0')}-"
          "${date.year.toString().substring(2)}";
    }

    String _selected_Anti_H = '--Select--';
    String _selected_Anti_A = '--Select--';
    String _selected_Anti_B = '--Select--';
    String _selected_Anti_AB = '--Select--';
    String _selected_D1 = '--Select--';
    String _selected_D2 = '--Select--';

    return CustomBottomSheet.show(
      context,
      title: 'Serum Grouping Overriding',

      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Query Date'),
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
                  dateOfDischargeController.text = formatDate(pickedDate);
                });
              }
              ;
            },
          ),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Blood Bag No.'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'Blood Bag No.'),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel('A/C'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_Anti_H,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_Anti_H = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('B/C'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_Anti_A,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_Anti_A = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('O/C'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_Anti_B,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_Anti_B = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('O/P'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_Anti_AB,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_Anti_AB = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('O/alb'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_D1,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_D1 = newValue;
                        });
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
                      child: SharedComponents.buildFormLabel('Ir.Abb'),
                    ),
                    const SizedBox(height: 8),
                    InnnerDropdown(
                      value: _selected_D2,
                      items: ["--Select--", "+ve", "-ve"],
                      onChanged: (newValue) {
                        setState(() {
                          _selected_D2 = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('ABO'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'ABO'),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Remarks'),
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
              hintText: "Remarks",
              maxLines: 5,
              controller: _remarksController2
          ),
          const SizedBox(height: 16),

          AppSaveButton(),
          const SizedBox(height: 16),
          AppCancelButton(text: 'Close'),
          const SizedBox(height: 100),
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
  final fromController = TextEditingController();
  final toController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  String? _methodOfTesting = null;

  @override
  Widget build(BuildContext context) {
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
                    child: SharedComponents.buildFormLabel(
                      "From Date",
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: fromController,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: fromDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          fromDate = pickedDate;
                          fromController.text = formatDate(pickedDate);
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
                    child: SharedComponents.buildFormLabel(
                      "To Date",
                      isRequired: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: toController,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
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
              ),
            ),
          ],
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Blood Bag No.'),
        ),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Blood Bag No.'),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Total'),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(),
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
                    child: SharedComponents.buildFormLabel('Confirmed'),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel('Status'),
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _methodOfTesting,
          items: ['Pending', 'Complete'],
          onChanged: (val) {
            setState(() {
              _methodOfTesting = val;
            });
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
