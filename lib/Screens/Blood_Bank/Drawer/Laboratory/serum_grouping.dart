import 'package:flutter/material.dart';

import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
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

class SerumGrouping extends StatefulWidget {
  SerumGrouping({super.key});

  @override
  State<SerumGrouping> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<SerumGrouping> {

  String _selected_1a = '--Select--';
  String _selected_1b = '--Select--';
  String _selected_1c = '--Select--';
  String _selected_1d = '--Select--';

  String _selected_2a = '--Select--';
  String _selected_2b = '--Select--';
  String _selected_2c = '--Select--';
  String _selected_2d = '--Select--';

  String _selected_3a = '--Select--';
  String _selected_3b = '--Select--';
  String _selected_3c = '--Select--';
  String _selected_3d = '--Select--';

  String _selected_4a = '--Select--';
  String _selected_4b = '--Select--';
  String _selected_4c = '--Select--';
  String _selected_4d = '--Select--';

  String _selected_5a = '--Select--';
  String _selected_5b = '--Select--';
  String _selected_5c = '--Select--';
  String _selected_5d = '--Select--';

  String _selected_6a = '--Select--';
  String _selected_6b = '--Select--';
  String _selected_6c = '--Select--';
  String _selected_6d = '--Select--';

  String _selected_7a = '--Select--';
  String _selected_7b = '--Select--';
  String _selected_7c = '--Select--';
  String _selected_7d = '--Select--';

  String _selected_8a = '--Select--';
  String _selected_8b = '--Select--';
  String _selected_8c = '--Select--';
  String _selected_8d = '--Select--';



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BloodBankBaseScaffold(
      title: "Serum Grouping",

      showDrawer: true,
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Serum Grouping',
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

          AppSaveButton(),
          const SizedBox(height: 16,),

          AppCancelButton(text: 'Serum Grouping Preperation', onPressed: (){
            AppDialog.show(
                context: context,
                title: 'Serum Grouping Preperation',
                child: DetailTableWrapper(
                    children: [
                      DetailRow(label: 'Blood Group',),
                      DetailRow(label: 'Blood Unit No.',),

                      DetailRow(label: 'Date Of Preperation',),
                      DetailRow(label: 'Document No.',isLast: true,),
                    ]
                )
            );
          }, ),
          const SizedBox(height: 16,),



        ],
      ),
      // bottomNavigationBar: BloodBankCollectionNavigationBar(index: 2,page: 2,onTap : _navigateToPage),

    );
  }

  Widget _buildTable(){
    return ScrollableDataTable(
      showPagination: true,
        tableLabels: const [
          TableLabel(text: 'Date'),
          TableLabel(text: 'Blood Bag\nNo.', icon: Icons.unfold_more), // 👈 Sirf isme icon hai
          TableLabel(text: 'A/C'),
          TableLabel(text: 'B/C'),
          TableLabel(text: 'O/C'),
          TableLabel(text: 'O/P'),
          TableLabel(text: 'O/alb'),
          TableLabel(text: 'Remarks'),
          TableLabel(text: 'Ir.Abb'),
          TableLabel(text: 'ABO'),

        ],
        rowValues:
        [
          [
            const TableText('04-11-2025'),
            const TableText('05-11-2025'),
            const TableText('06-11-2025'),
            const TableText('10-11-2025'),
          ],

          [
            Text( '2025091900001', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
            Text( '2025091900002', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
            Text( '2025091900003', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
            Text( '2025091900004', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
          ],

          [
            InnnerDropdown(
              value: _selected_1a,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_1a = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_1b,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_1b = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_1c,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_1c = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_1d,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_1d = newValue;
                });
              },
            ),
          ],
          [
            InnnerDropdown(
              value: _selected_2a,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_2a = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_2b,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_2b = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_2c,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_2c = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_2d,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_2d = newValue;
                });
              },
            ),
          ],
          [
            InnnerDropdown(
              value: _selected_3a,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_3a = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_3b,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_3b = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_3c,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_3c = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_3d,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_3d = newValue;
                });
              },
            ),
          ],
          [
            InnnerDropdown(
              value: _selected_4a,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_4a = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_4b,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_4b = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_4c,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_4c = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_4d,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_4d = newValue;
                });
              },
            ),
          ],
          [
            InnnerDropdown(
              value: _selected_5a,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_5a = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_5b,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_5b = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_5c,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_5c = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_5d,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_5d = newValue;
                });
              },
            ),
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
            InnnerDropdown(
              value: _selected_8a,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_8a = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_8b,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_8b = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_8c,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_8c = newValue;
                });
              },
            ),

            InnnerDropdown(
              value: _selected_8d,
              items: ["--Select--", "+ve", "-ve"],
              onChanged: (newValue) {
                setState(() {
                  _selected_8d = newValue;
                });
              },
            ),
          ],
          [
            SharedComponents.buildInnerTextField(),
            SharedComponents.buildInnerTextField(),
            SharedComponents.buildInnerTextField(),
            SharedComponents.buildInnerTextField(),
          ],




        ]
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


  String? _methodOfTesting = null ;

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
                      child: SharedComponents.buildFormLabel("Bleeding From Date",isRequired: true)),
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
            child: SharedComponents.buildFormLabel('Blood Bag No.')),
        const SizedBox(height: 8,),
        SharedComponents.buildTextField(hintText: 'Blood Bag No.'),
        const SizedBox(height: 16,),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel('Blood Bag No. From')),
                  const SizedBox(height: 8,),
                  SharedComponents.buildTextField(),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel('To')),
                  const SizedBox(height: 8,),
                  SharedComponents.buildTextField(),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
          ],
        ),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel('Method of Testing')),
        const SizedBox(height: 8,),
        FunctionalDropdown(
            value: _methodOfTesting,
            items: [
              'Micro PLate',
              'Test Tube'
            ],
            onChanged: (val) {
              setState(() {
                _methodOfTesting = val;
              });
            }
        ),
        const SizedBox(height: 16,),


        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel('Total')),
                  const SizedBox(height: 8,),
                  SharedComponents.buildTextField(hintText: '100'),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel('Grouped')),
                  const SizedBox(height: 8,),
                  SharedComponents.buildTextField(hintText: '80'),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel('Confirmed')),
                  const SizedBox(height: 8,),
                  SharedComponents.buildTextField(hintText: '14'),
                  const SizedBox(height: 16,),
                ],
              ),
            ),
          ],
        ),





      ],
    );
  }
}


