import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class NextSerologicalInvestingResultEntry extends StatefulWidget {
  NextSerologicalInvestingResultEntry({super.key});

  @override
  State<NextSerologicalInvestingResultEntry> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<NextSerologicalInvestingResultEntry> {

  String? _machine = null;
  String? _ttd = null;
  bool _action_a = false ;

  String radio_1 = "";
  String radio_2 = "";
  String radio_3 = "";
  String radio_4 = "";

  final dateController1 = TextEditingController();
  final dateController2 = TextEditingController();
  final dateController3 = TextEditingController();
  final dateController4 = TextEditingController();


  DateTime? toDate;
  String? dischargeType = null;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  @override
  Widget build(BuildContext context) {

    return BloodBankBaseScaffold(
      title: "Serological Investigation Result Entry",

      showDrawer: true,
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Serological Investigation Result Entry',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            ],
          ),
          const SizedBox(height: 24,),

          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('Name Of Machine')),
          const SizedBox(height: 8,),
          FunctionalDropdown(
              value: _machine,
              items: [
                'Machine 1',
                'Machine 2'
              ],
              onChanged: (val) {
                setState(() {
                   _machine = val;
                });
              }
          ),
          const SizedBox(height: 16,),


          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('TTD Method')),
          const SizedBox(height: 8,),
          FunctionalDropdown(
              value: _ttd,
              items: [
                'AUTOMATED ELISA',
                'MANUAL ELISA',
                'RAPDI METHOD'
              ],
              onChanged: (val) {
                setState(() {
                  _ttd = val;
                });
              }
          ),
          const SizedBox(height: 16,),

          SharedComponents.buildFormLabel('Serological Investing Reagent Details'),
          const SizedBox(height: 16,),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Blood Bag No:',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                const TextSpan(
                  text: "2025091900001",
                  style: TextStyle(
                    color: Color(0xFF117A7A), // 🔵 Blue
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16,),


          _buildTable(),
          const SizedBox(height: 16,),
          Row(
            children: [
              SharedComponents.buildFormLabel('Check Result To Negative'),
              const SizedBox(width: 16,),
              GlobalCheckbox(
                label: '', // Label blank hai kyunki hum text par alag action chahte hain
                value: _action_a ?? false,
                onChanged: (bool newValue) {
                  setState(() {

                    _action_a = newValue; // Checkbox ka state update
                  });
                },
              ),
            ],
          ),


          const SizedBox(height: 16,),
          AppSaveButton(),
          const SizedBox(height: 16,),

          AppCancelButton(text: 'Save & Validate',),
          const SizedBox(height: 16,),
        ],
      ),


    );
  }


  Widget _buildTable() {
    return ScrollableDataTable(
        labels: [
          'Investing',
          'Result',
          'Description',
          'Entry Date',
          'Status',
          'Supervisor\nRemarks',
        ],
        rowValues: [
          [
            RichText(
              text: TextSpan(
                text: 'HBsAg',
                style: const TextStyle(
                  fontSize: 13,

                  color: Colors.black87,
                ),
                children:   [
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ]
                     ,
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'HCV Ab',
                style: const TextStyle(
                  fontSize: 13,

                  color: Colors.black87,
                ),
                children:   [
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ]
                ,
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'HIV (|/||) Ab',
                style: const TextStyle(
                  fontSize: 13,

                  color: Colors.black87,
                ),
                children:   [
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ]
                ,
              ),
            ),
            RichText(
              text: TextSpan(
                text: 'Malaria',
                style: const TextStyle(
                  fontSize: 13,

                  color: Colors.black87,
                ),
                children:   [
                  const TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
                ]
                ,
              ),
            ),
          ],
          [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "N",
                        label: "",
                        groupValue: radio_1,
                        onChanged: (v) => setState(() => radio_1 = v!),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        'N',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "G",
                        label: "",
                        groupValue: radio_1,
                        onChanged: (v) => setState(() => radio_1 = v!),
                      ),

                      const SizedBox(height: 5,),
                      Text(
                        'G',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "P",
                        label: "",
                        groupValue: radio_1,
                        onChanged: (v) => setState(() => radio_1 = v!),
                      ),

                       const SizedBox(height: 5,),
                      Text(
                        'P',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "N",
                        label: "",
                        groupValue: radio_2,
                        onChanged: (v) => setState(() => radio_2 = v!),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        'N',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "G",
                        label: "",
                        groupValue: radio_2,
                        onChanged: (v) => setState(() => radio_2 = v!),
                      ),

                      const SizedBox(height: 5,),
                      Text(
                        'G',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "P",
                        label: "",
                        groupValue: radio_2,
                        onChanged: (v) => setState(() => radio_2 = v!),
                      ),

                      const SizedBox(height: 5,),
                      Text(
                        'P',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "N",
                        label: "",
                        groupValue: radio_3,
                        onChanged: (v) => setState(() => radio_3 = v!),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        'N',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "G",
                        label: "",
                        groupValue: radio_3,
                        onChanged: (v) => setState(() => radio_3 = v!),
                      ),

                      const SizedBox(height: 5,),
                      Text(
                        'G',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "P",
                        label: "",
                        groupValue: radio_3,
                        onChanged: (v) => setState(() => radio_3 = v!),
                      ),

                      const SizedBox(height: 5,),
                      Text(
                        'P',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "N",
                        label: "",
                        groupValue: radio_4,
                        onChanged: (v) => setState(() => radio_4 = v!),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        'N',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "G",
                        label: "",
                        groupValue: radio_4,
                        onChanged: (v) => setState(() => radio_4 = v!),
                      ),

                      const SizedBox(height: 5,),
                      Text(
                        'G',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RadioButton<String>(
                        value: "P",
                        label: "",
                        groupValue: radio_4,
                        onChanged: (v) => setState(() => radio_4 = v!),
                      ),

                      const SizedBox(height: 5,),
                      Text(
                        'P',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ],
          [
            CustomRemarksField(
              title: "Findings",
              hintText: "",
              onChanged: (value) {
                print("User ne type kiya: $value");
                // Yahan aap value ko apne API model ya variables me save kar sakte hain
              },
            ),
            CustomRemarksField(
              title: "Findings",
              hintText: "",
              onChanged: (value) {
                print("User ne type kiya: $value");
                // Yahan aap value ko apne API model ya variables me save kar sakte hain
              },
            ),
            CustomRemarksField(
              title: "Findings",
              hintText: "",
              onChanged: (value) {
                print("User ne type kiya: $value");
                // Yahan aap value ko apne API model ya variables me save kar sakte hain
              },
            ),
            CustomRemarksField(
              title: "Findings",
              hintText: "",
              onChanged: (value) {
                print("User ne type kiya: $value");
                // Yahan aap value ko apne API model ya variables me save kar sakte hain
              },
            ),
          ],
          [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Flexible(
                  child: AppDateField(
                    isDense: true,
                    hintText: "",
                    controller: dateController1,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: toDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          toDate = pickedDate;
                          dateController1.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Flexible(
                  child: AppDateField(
                    hintText: "",
                    isDense: true,
                    controller: dateController2,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: toDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          toDate = pickedDate;
                          dateController2.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Flexible(
                  child: AppDateField(
                    isDense: true,
                    hintText: "",
                    controller: dateController3,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: toDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          toDate = pickedDate;
                          dateController3.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Flexible(

                  child: AppDateField(
                    isDense: true,
                    hintText: "",
                    controller: dateController4,
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: toDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          toDate = pickedDate;
                          dateController4.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },
                  ),
                ),
              ],
            ),
          ],
          [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: const TableText('Result Entered')
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: const TableText('Result Entered')
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: const TableText('Result Entered')
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: const TableText('Result Entered')
            ),
          ],
          [
            CustomRemarksField(
              title: "Findings",
              hintText: "",
              onChanged: (value) {
                print("User ne type kiya: $value");
                // Yahan aap value ko apne API model ya variables me save kar sakte hain
              },
            ),
            CustomRemarksField(
              title: "Findings",
              hintText: "",
              onChanged: (value) {
                print("User ne type kiya: $value");
                // Yahan aap value ko apne API model ya variables me save kar sakte hain
              },
            ),
            CustomRemarksField(
              title: "Findings",
              hintText: "",
              onChanged: (value) {
                print("User ne type kiya: $value");
                // Yahan aap value ko apne API model ya variables me save kar sakte hain
              },
            ),
            CustomRemarksField(
              title: "Findings",
              hintText: "",
              onChanged: (value) {
                print("User ne type kiya: $value");
                // Yahan aap value ko apne API model ya variables me save kar sakte hain
              },
            ),
          ],
        ]
    );
  }

}




