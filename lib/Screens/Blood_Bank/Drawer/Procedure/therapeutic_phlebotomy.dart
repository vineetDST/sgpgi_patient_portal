import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/expanded_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Procedure/edit_therapeutic_phlebotomy.dart';


import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';


class TherapeuticPhlebotomy extends StatefulWidget {
  TherapeuticPhlebotomy({super.key});
  @override
  State<TherapeuticPhlebotomy> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<TherapeuticPhlebotomy> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;


  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  String? _searchBy = 'Cr No.' ;
  String? _orderStatus = null ;

  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Therapeutic Phlebotomy",
      showDrawer: true,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Therapeutic Phlebotomy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 16,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: SharedComponents.buildFormLabel("CR No.")
              ),

              GestureDetector(
                  onTap: (){
                    _showDialog();
                  },
                  child: const Icon(Icons.search, color: Colors.black, size: 22)
              ),
            ],
          ),
          SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: ''),
          SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: SharedComponents.buildFormLabel("From Date")),
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
                        child: SharedComponents.buildFormLabel("To Date")),
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
              child: SharedComponents.buildFormLabel("Order Status")
          ),
          SizedBox(height: 8),
          FunctionalDropdown(
              value: _orderStatus,

              items: [
                'Cancelled',
                'Ordered',
                'paid',
                'Processed'
              ],
              onChanged: (val) {
                setState(() {
                   _orderStatus = val ;
                });
              }
          ),
          SizedBox(height: 16),

          AppSaveButton(text: 'Search', onPressed: (){}),
          SizedBox(height: 16),

          _buildTable(),



        ],
      ),
    );
  }

  Widget _buildTable() {
    return ScrollableDataTable(
      labels: const [
        'Order Number',
        'Requesting Dept',
        'Order Status',
        'Action'
      ],
      // Har array me 2 values hain, jo horizontally scroll hongi
      rowValues: [
        // 1. Investigation Name Row
        [
          const TableText("ORDER20252946643"),
          const TableText("ORDER20252946655"),

        ],

        [
          const TableText("Emergency"),
          const TableText("Emergency"),

        ],
        [
          const TableText("Paid"),
          const TableText("Paid"),

        ],

        [
          GestureDetector(
            onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                     return EditTherapeuticPhlebotomy();
                 }));
            },
            child: Image.asset(
              'assets/editicons.png', // 👈 your image path
              height: 15,
              width: 15,
              color: Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return EditTherapeuticPhlebotomy();
              }));
            },
            child: Image.asset(
              'assets/editicons.png', // 👈 your image path
              height: 15,
              width: 15,
              color: Colors.black,
            ),
          ),

        ],



      ],

    );
  }

  void _showDialog() {
    AppDialog.show(
      context: context,
      title: "Patient Search",
      // 1. StatefulBuilder se wrap karein
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setDialogState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              SharedComponents.buildFormLabel('Search By'),
              const SizedBox(height: 8),


              ExpandedDropdown(

                  value: _searchBy,
                  items: const [
                    '--Select--',
                    'Cr No.',
                    'Name'
                  ],
                  onChanged: (val) {

                    setDialogState(() {
                      _searchBy = val;
                    });


                  }
              ),
              const SizedBox(height: 16),

              GlobalCheckboxGroup(
                items: const ['Soundex'],
                onSelectionChanged: (selectedList) {
                  print("Selected Items: $selectedList");
                },
              ),
              const SizedBox(height: 16),

              SharedComponents.buildFormLabel('Value'),
              const SizedBox(height: 8),
              SharedComponents.buildTextField(),
              const SizedBox(height: 16),

              _buildPatientSearchTable(),
            ],
          );
        },
      ),
    );
  }

  _buildPatientSearchTable() {
    return ScrollableDataTable(
      labels: const [
        'CR No.',
        'Patient Name',
        'Age/Gender',
        'Department',
        'Add'
      ],
      // Har array me 2 values hain, jo horizontally scroll hongi
      rowValues: [
        // 1. Investigation Name Row
        [
          const TableText("2025000653"),
          const TableText("2025000367"),
          const TableText("2025000266"),

        ],

        [
          const TableText("Vijay Singh"),
          const TableText("Pranav Gupta"),
          const TableText("Ram Gupta"),

        ],
        [
          const TableText("25/Male"),
          const TableText("25/Male"),
          const TableText("25/Male"),

        ],
        [
          const TableText("Cardiology"),
          const TableText("Cardiology"),
          const TableText("Cardiology"),

        ],

        [
          const Icon(Icons.add_circle, color: Color(0xFF4CAF50), size: 22),
          const Icon(Icons.add_circle, color: Color(0xFF4CAF50), size: 22),
          const Icon(Icons.add_circle, color: Color(0xFF4CAF50), size: 22),
        ]



      ],

    );
  }
}

