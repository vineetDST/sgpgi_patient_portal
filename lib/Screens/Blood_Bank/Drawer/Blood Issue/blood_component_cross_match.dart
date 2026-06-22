import 'package:flutter/material.dart';

import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/innner_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';


class BloodComponentRequestMatch extends StatefulWidget {


  const BloodComponentRequestMatch({
    super.key,

  });

  @override
  State<BloodComponentRequestMatch> createState() => _IPInfectionRecState();
}

class _IPInfectionRecState extends State<BloodComponentRequestMatch> {


  String? actionDetail = null;

  bool _action_a = true ;
  bool _action_b = false ;
  bool _action_c = false ;
  bool _action_d = false ;
  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Blood Requisition Entry Search",
      showDrawer: true,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Blood Requisition Entry Search',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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

          const SizedBox(height: 16,),

          _buildTable(),
          const SizedBox(height: 16,),

          _buildBloodRequistionDetails(),
          const SizedBox(height: 16,),



        ],
      ),
    );
  }

  Widget _buildTable() {
    return ScrollableDataTable(
        showPagination: true,
        tableLabels: const [
          TableLabel(text: 'Requisition No.', icon: Icons.unfold_more),
          TableLabel(text: 'Requisition Date', icon: Icons.unfold_more),
          TableLabel(text: 'Department', icon: Icons.unfold_more),
          TableLabel(text: 'Componenet\nName', icon: Icons.unfold_more),
          TableLabel(text: 'Patient', icon: Icons.unfold_more),
          TableLabel(text: 'CR No.', icon: Icons.unfold_more),
          TableLabel(text: 'ABO Rh', icon: Icons.unfold_more),
          TableLabel(text: 'Req. Unit', icon: Icons.unfold_more),
          TableLabel(text: 'Status', icon: Icons.unfold_more),
          TableLabel(text: 'Action'), // 👈 Isme icon nahi hai
        ],
        rowValues: [
          [
            const TableText('2025091900001'),
            const TableText('2025091900002'),
            const TableText('2025091900003'),
            const TableText('2025091900004'),
          ],

          [
            const TableText('04-11-2025'),
            const TableText('05-11-2025'),
            const TableText('06-11-2025'),
            const TableText('07-11-2025'),
          ],
          [
            const TableText('Emergency'),
            const TableText('Emergency'),
            const TableText('Emergency'),
            const TableText('Emergency'),
          ],
          [
            const TableText('Fresh Frozen Plasma'),
            const TableText('Fresh Frozen Plasma'),
            const TableText('Fresh Frozen Plasma'),
            const TableText('Fresh Frozen Plasma'),
          ],

          [
            const TableText('Prem Shankar'),
            const TableText('Ram Shankar'),
            const TableText('Shyam Shankar'),
            const TableText('Sundar Shankar'),
          ],
          [
            const TableText('2025091900001'),
            const TableText('2025091900002'),
            const TableText('2025091900003'),
            const TableText('2025091900004'),
          ],
          [
            const TableText('B+'),
            const TableText('B+'),
            const TableText('B+'),
            const TableText('B+'),
          ],
          [
            const TableText('4'),
            const TableText('4'),
            const TableText('4'),
            const TableText('4'),
          ],

          [
            const TableText('Not Processed'),
            const TableText('Not Processed'),
            const TableText('Not Processed'),
            const TableText('Not Processed'),
          ],
          [
            GlobalCheckbox(
              label: '', // Label blank hai kyunki hum text par alag action chahte hain
              value: _action_a ?? false,
              onChanged: (bool newValue) {
                setState(() {

                  _action_a = newValue; // Checkbox ka state update
                });
              },
            ),
            GlobalCheckbox(
              label: '', // Label blank hai kyunki hum text par alag action chahte hain
              value: _action_b ?? false,
              onChanged: (bool newValue) {
                setState(() {

                  _action_b = newValue; // Checkbox ka state update
                });
              },
            ),
            GlobalCheckbox(
              label: '', // Label blank hai kyunki hum text par alag action chahte hain
              value: _action_c ?? false,
              onChanged: (bool newValue) {
                setState(() {

                  _action_c = newValue; // Checkbox ka state update
                });
              },
            ),
            GlobalCheckbox(
              label: '', // Label blank hai kyunki hum text par alag action chahte hain
              value: _action_d ?? false,
              onChanged: (bool newValue) {
                setState(() {

                  _action_d = newValue; // Checkbox ka state update
                });
              },
            ),
          ]


        ]
    );

  }

  Widget _buildBloodRequistionDetails() {
      return CustomExpansionFrame(
        title: 'Blood Component Requisition Details',
        children: [
          DetailTableWrapper(
              children: [
                DetailRow(label: 'Requisition No.',text: '2025091900001',),
                DetailRow(label: 'Acceptance No.',),
                DetailRow(label: 'Company Name',text: 'Fresh Frozen Plasma',),
                DetailRow(label: 'Ward/Bed',text: '151 EMD Yellow Zone 14',),
                DetailRow(label: 'Order Status',text: 'Billing Pending',),
                DetailRow(label: 'Process Status',text: 'Not Processed',),
                DetailRow(label: 'Req Status',),
                DetailRow(label: 'ABO Rh',text: 'B+ ve',),
                DetailRow(label: 'Stock Quantity',text: '1217',),
                DetailRow(label: 'Received By',),
                DetailRow(label: 'Action',customWidget: InnnerDropdown(
                    value: actionDetail,
                    items: [
                      'Accept',
                      'Reject',
                      'Defer',
                      'Override Blod Group',
                      'Re-Print',
                      'Cancel Request'
                    ],
                    onChanged: (val) {
                      setState(() {
                        actionDetail = val;
                      });
                    }
                ),isLast: true,),


              ]
          ),
          const SizedBox(height: 16,), 
        ],

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

  String? _bloodComponent = null ;
  String? _department =  null;
  String? _bloodGroup =  null;
  String? _status =  null;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Requisition No")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Requisition No'),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("CR No.")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'CR No.'),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Blood Compoenent")),
        const SizedBox(height: 8),
        FunctionalDropdown(
            value: _bloodComponent,
            items: [
              'Blood Component 1',
              'Blood Component 2'
            ],
            onChanged: (val) {
              setState(() {
                 _bloodComponent = val;
              });
            }
        ),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Deparment")),
        const SizedBox(height: 8),
        FunctionalDropdown(
            value: _department,
            items: [
              'Blood Component 1',
              'Blood Component 2'
            ],
            onChanged: (val) {
              setState(() {
                _department = val;
              });
            }
        ),
        const SizedBox(height: 16),


        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel("From Date",isRequired: true)),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: fromController,
                    onTap: () async {
                      DateTime? pickedDate =
                      await CustomCalendarDialog.show(
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
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel("To Date",isRequired: true)),
                  const SizedBox(height: 8),
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
              ),
            )
          ],
        ),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Status")),
        const SizedBox(height: 8),
        FunctionalDropdown(
            value: _status,
            items: [
              'Pending',
              'Completed'
            ],
            onChanged: (val) {
              setState(() {
                _status = val;
              });
            }
        ),
        const SizedBox(height: 16),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel("Blood Group")),
                  const SizedBox(height: 8),
                  InnnerDropdown(
                    size: 16,
                      value: _bloodGroup,
                      items: [
                        'A+',
                        'A-'
                      ],
                      onChanged: (val) {
                        setState(() {
                          _bloodGroup = val;
                        });
                      }
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
                      child: SharedComponents.buildFormLabel("Total Requisition")),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: '100'),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        )




      ],
    );
  }


}

