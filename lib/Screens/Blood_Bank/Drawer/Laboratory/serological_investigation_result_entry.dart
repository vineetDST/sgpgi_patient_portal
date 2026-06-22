import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/radio_button.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Laboratory/next_serological_investing_result_entry.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class SerologicalInvestigationResultEntry extends StatefulWidget {
  SerologicalInvestigationResultEntry({super.key});

  @override
  State<SerologicalInvestigationResultEntry> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<SerologicalInvestigationResultEntry> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;



  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  String? typeRadio3 = "Pending(0)";
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
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                RadioButton<String>(
                  value: "Pending(0)",
                  label: "Pending(0)",
                  groupValue: typeRadio3,
                  onChanged: (v) => setState(() => typeRadio3 = v),
                ),
                const SizedBox(width: 16), // Dono ke beech thoda gap
                RadioButton<String>(
                  value: "Pending Validations(0)",
                  label: "Pending Validations(0)",
                  groupValue: typeRadio3,
                  onChanged: (v) => setState(() => typeRadio3 = v),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              children: [
                RadioButton<String>(
                  value: "ReTest(0)",
                  label: "ReTest(0)",
                  groupValue: typeRadio3,
                  onChanged: (v) => setState(() => typeRadio3 = v),
                ),
                const SizedBox(width: 16), // Dono ke beech thoda gap
                RadioButton<String>(
                  value: "Processed(0)",
                  label: "Processed(0)",
                  groupValue: typeRadio3,
                  onChanged: (v) => setState(() => typeRadio3 = v),
                ),
              ],
            ),
          ),
          SizedBox(height: 24),

          AppSaveButton(text: 'Search',),
          SizedBox(height: 16),

          _buildBagDetails(),
          const SizedBox(height: 16,),
        ],
      ),


    );
  }

  Widget _buildBagDetails() {
    return CustomExpansionFrame(
      initiallyExpanded: true,
        title: 'Bag Details',
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: SharedComponents.buildFormLabel('Search')),
          const SizedBox(height: 8,),
          SharedComponents.buildTextField(hintText: 'Bag No',suffix: const Icon(Icons.search, color: Colors.black, size: 20)),
          const SizedBox(height: 16,), // Thoda space table ke upar

          // Niche diye gaye functions yahan call honge
          _buildBagTableAndPagination(),
          const SizedBox(height: 16,),
        ]
    );
  }

  Widget _buildBagTableAndPagination() {

    final List<Map<String, String>> bagData = [
      {'bagNo': '2025091900001', },
      {'bagNo': '2025091901456', },
      {'bagNo': '2025091906547', },
      {'bagNo': '20250919001466',},
      {'bagNo': '2025091900789', },
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300), // Table ka outer border
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            // --- TABLE ROW SECTION ---
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.grey.shade300),
                verticalInside: BorderSide(color: Colors.grey.shade300),
              ),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
              },
              children: [
                // Header Row (Light Teal Background)
                TableRow(
                  decoration: const BoxDecoration(
                    color: Color(0xFFEEF7F7),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Bag Number', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade900)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text('Status', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade900)),
                    ),
                  ],
                ),
                // Data Rows Generation
                ...bagData.map((data) => TableRow(
                  children: [
                    GestureDetector(
                      onTap: (){
                           Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                               return NextSerologicalInvestingResultEntry();
                           }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          data['bagNo']!,
                          style: const TextStyle(color: Color(0xFF2A8B8B), fontWeight: FontWeight.w500), // Teal text color
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '',
                        style: const TextStyle(color: Colors.black87),
                      ),
                    ),
                  ],
                )),
              ],
            ),

            // --- PAGINATION SECTION ---
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Right side align karne ke liye
                children: [
                  _buildPaginationArrow(Icons.chevron_left, isDisabled: true),
                  const SizedBox(width: 8),
                  _buildPageNumber('01', isActive: true),
                  const SizedBox(width: 8),
                  _buildPageNumber('02', isActive: false),
                  const SizedBox(width: 8),
                  _buildPaginationArrow(Icons.chevron_right, isDisabled: false),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageNumber(String number, {required bool isActive}) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey.shade100 : Colors.transparent,
        border: isActive ? null : Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        number,
        style: TextStyle(
          color: Colors.black87,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }


  Widget _buildPaginationArrow(IconData icon, {required bool isDisabled}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Icon(
        icon,
        size: 20,
        color: isDisabled ? Colors.grey.shade400 : Colors.black87,
      ),
    );
  }

}




