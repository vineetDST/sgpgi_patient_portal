import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
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

class ReceiveBackDiscard extends StatefulWidget {
  const ReceiveBackDiscard({
    super.key,
  });
  @override
  State<ReceiveBackDiscard> createState() => _IPInfectionRecState();
}

class _IPInfectionRecState extends State<ReceiveBackDiscard> {
  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(

      title: "Receive Back/Discard",
      showDrawer: true,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Receive Back/Discard',
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
          'Expiry Date',
          'ABO',
          'CR NO.',
          'Issued On',
          'Issued By',
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
            const TableText('Platelets(randon donor)'),
            const TableText('Platelets(randon donor)'),
            const TableText('Platelets(randon donor)'),
            const TableText('Platelets(randon donor)'),
          ],
          [
            const TableText('04-11-2025'),
            const TableText('05-11-2025'),
            const TableText('06-11-2025'),
            const TableText('07-11-2025'),
          ],

          [
            const TableText('A+ ve'),
            const TableText('A+ ve'),
            const TableText('A+ ve'),
            const TableText('A+ ve'),
          ],


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
             const TableText('Regular R'),
             const TableText('Regular R'),
             const TableText('Regular R'),
             const TableText('Regular R'),
           ],
          [
            Text( 'Receive/Discard', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
            Text( 'Receive/Discard', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
            Text( 'Receive/Discard', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),),
            Text( 'Receive/Discard', style: TextStyle(fontSize: 13,color:  const Color(0xFF117A7A,),),)
          ]


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


  String? _department =  null;


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
            child: SharedComponents.buildFormLabel("Blood Bag No.")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Blood Bag No.'),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("CR No.")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'CR No.'),
        const SizedBox(height: 16),




        SharedComponents.buildFormLabel("Issued Date"),
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

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Status")),
        const SizedBox(height: 8),
        FunctionalDropdown(
            value: _department,
            items: [
              'Pending',
              'Completed'
            ],
            onChanged: (val) {
              setState(() {
                _department = val;
              });
            }
        ),
        const SizedBox(height: 16),






      ],
    );
  }


}


