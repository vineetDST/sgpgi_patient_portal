import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';

import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Camp/camp.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class BloodBagNumberGeneration extends StatefulWidget {
  BloodBagNumberGeneration({super.key});
  @override
  State<BloodBagNumberGeneration> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<BloodBagNumberGeneration> {
  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Blood Bag Number Generation",
      showDrawer: true,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Blood Bag Number Generation',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showFilterSidebar(context);
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
        ],
      ),
    );
  }

  void _showFilterSidebar(BuildContext context) {


    AppFilterDialog.show(
      context: context,
      title: "Search",
      showFooter: true,
      child: _FilterSidebar(),
    );
  }

  Widget _buildTable() {
    return ScrollableDataTable(

showPagination: true,
      tableLabels: const [
        TableLabel(text: 'Date', icon: Icons.unfold_more),
        TableLabel(text: 'Dono Reg.No', icon: Icons.unfold_more),
        TableLabel(text: 'Queue No', icon: Icons.unfold_more),
        TableLabel(text: 'Donor Name', icon: Icons.unfold_more),
        TableLabel(text: 'Donor Type', icon: Icons.unfold_more),
        TableLabel(text: 'Donation\nType', icon: Icons.unfold_more),
        TableLabel(text: 'CR No.', icon: Icons.unfold_more),
        TableLabel(text: 'Blood Bag No', icon: Icons.unfold_more),
        TableLabel(text: 'Action'), // 👈 Action mein icon nahi hai
      ],
      // Har array me 2 values hain, jo horizontally scroll hongi
      rowValues: [
        // 1. Investigation Name Row
        [
          const TableText("04-11-2025"),
          const TableText("05-11-2025"),
          const TableText("06-11-2025"),
          const TableText("11-11-2025"),
        ],

        [
          const TableText("D-2025110400064"),
          const TableText("D-2025110400078"),
          const TableText("D-2025110400098"),
          const TableText("D-2025110400077"),
        ],

        [
          const TableText("041"),
          const TableText("123"),
          const TableText("125"),
          const TableText("200"),
        ],

        [
          const TableText("Abhay Yadav"),
          const TableText("Ajay Singh"),
          const TableText("Vinod Singh"),
          const TableText("Alok Paul"),

        ],

        [
          const TableText("Replacement"),
          const TableText("Replacement"),
          const TableText("Replacement"),
          const TableText("Replacement"),

        ],
        [
          const TableText("Whole Blood"),
          const TableText("Whole Blood"),
          const TableText("Whole Blood"),
          const TableText("Whole Blood"),

        ],
        [
          const TableText("20251042143"),
          const TableText("20251042143"),
          const TableText("20251042143"),
          const TableText("20251042143"),

        ],
        [
           Text( 'Generate Blood Bag No', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
          const TableText("2025104214320"),
          const TableText("2025104214322"),
          const TableText("2025104214325"),

        ],
        [
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  ReassignBloodBagDialog();
                      },
                    );
                  },
                  child: Text( 'Assign', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),)),
              const SizedBox(width: 16,),
              GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return  ReassignBloodBagDialog(assign: false,);
                      },
                    );
                  },
                  child: Text( 'Reassign', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),)),
            ],
          ),
          const Icon(Icons.print, color: Colors.black87, size: 20),
          const Icon(Icons.print, color: Colors.black87, size: 20),
          const Icon(Icons.print, color: Colors.black87, size: 20),

        ],
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

  String? _donorType = null ;
  String? _donationType =  null;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  String? _radioStatus = 'Pending';

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

        SharedComponents.buildFormLabel('Queue No'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Queue No'),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Donor Reg.No'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Donor Reg.No'),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Donor Name'),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Donor Name'),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Donor Type'),
        const SizedBox(height: 8),
        FunctionalDropdown(
            value: _donorType,
            hint: '--Select--',
            items: DummyData.donorTypes,
            onChanged: (val) {
              setState(() {
                _donorType = val ;
              });
            }
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel('Donation Type'),
        const SizedBox(height: 8),
        FunctionalDropdown(
            value: _donationType,
            hint: '--Select--',
            items: DummyData.donationTypes,
            onChanged: (val) {
              setState(() {
                _donationType = val ;
              });
            }
        ),
        const SizedBox(height: 16),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel('Status',)),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Row(
                      children: [
                        RadioButton<String>(
                          value: "Done",
                          label: "Done",
                          groupValue: _radioStatus,
                          onChanged: (v) => setState(() => _radioStatus = v),
                          textStyle: TextStyle(
                            fontSize: 11,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12), // Dono ke beech thoda gap
                        RadioButton<String>(
                          value: "Pending",
                          label: "Pending",
                          groupValue: _radioStatus,
                          onChanged: (v) => setState(() => _radioStatus = v),
                          textStyle: TextStyle(
                            fontSize: 11,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel('Total'),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),


      ],
    );
  }
}

class ReassignBloodBagDialog extends StatelessWidget {
  bool? assign ;
   ReassignBloodBagDialog({Key? key,this.assign = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Image jaisa curve
      ),
      insetPadding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Jini jagah chahiye utni hi lega
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Row ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(
                  assign! ? "Assign Blood Bag No" :  "Reassign Blood Bag No",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(), // Close Action
                  child: const Icon(Icons.close, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // --- Donor Name Field ---
            const Text(
              "Donor Name",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            SharedComponents.buildTextField(hintText: 'Rakesh',enabled: false),
            const SizedBox(height: 20),

            // --- Blood Bag No Fields ---
            const Text(
              "Blood Bag No",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildBagNumberField("2025", isReadOnly: assign! ? true : false, flex: 3),
                const SizedBox(width: 8),
                _buildBagNumberField("11", flex: 2),
                const SizedBox(width: 8),
                _buildBagNumberField("06", flex: 2),
                const SizedBox(width: 8),
                _buildBagNumberField("30139", flex: 3),
              ],
            ),
            const SizedBox(height: 32),

            // --- Action Buttons ---
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close par click
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Save action logic yahan likhein
                      print("Saved!");
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF157F7F), // Teal button color
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Chote TextFields banane ke liye ek helper function
  Widget _buildBagNumberField(String text, {bool isReadOnly = false, required int flex}) {
    return Expanded(
      flex: flex,
      child: TextField(
        controller: TextEditingController(text: text),
        readOnly: isReadOnly,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          filled: isReadOnly,
          fillColor: isReadOnly ? Colors.grey.shade100 : Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFF157F7F)),
          ),
        ),
      ),
    );
  }
}

