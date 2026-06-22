import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // <-- ADDED for date formatting
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog2.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_bottom_sheet.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

// Import the previous vital signs screen & calendar
import 'ip_prev_vital_signs_screen.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart'; // Adjust path if needed

class IPVitalSignsScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const IPVitalSignsScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<IPVitalSignsScreen> createState() => _VitalSignsScreenState();
}

class _VitalSignsScreenState extends State<IPVitalSignsScreen> {
  // --- FUNCTIONAL STATE VARIABLES ---
  String? _groupName = null;
  DateTime _vitalDate = DateTime.now();

  // Controllers for the vitals (Height, Weight, BP, etc.)
  final List<TextEditingController> _valueControllers = List.generate(
    7,
        (_) => TextEditingController(),
  );
  final List<TextEditingController> _remarkControllers = List.generate(
    7,
        (_) => TextEditingController(),
  );

  List signs = [
    'Height' , 'Weight' , 'Pulse', 'BP-SYSTOLIC', 'BP-DIASTOLIC', 'TEMPERATURE', 'BMI'
  ] ;
  List units = [
    'Meter', 'Kilo Gram', 'Beats/Min', 'mmHg', 'mmHg', 'F', 'Kg/m2'
  ];

  List ranges = [
    ' ', '60.0 - 80.0', '60.0 - 80.0', '90.0 - 140.0', '60.0 - 90.0', '98.0 - 99.0', '21 - 25',
  ];

  @override
  void dispose() {
    for (var ctrl in _valueControllers) {
      ctrl.dispose();
    }
    for (var ctrl in _remarkControllers) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Vital Signs",

      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Vital Signs",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IPActionButton()
            ],
          ),
          const SizedBox(height: 16),

          // Group Name Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Group Name",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // FUNCTIONAL DATE PICKER
              GestureDetector(
                onTap: () async {
                  DateTime? picked = await CustomCalendarDialog.show(
                    context,
                    initialDate: _vitalDate,
                  );
                  if (picked != null) {
                    setState(() => _vitalDate = picked);
                  }
                },
                child: Row(
                  children: [
                    Text(
                      DateFormat('dd-MM-yy | HH:mm').format(_vitalDate),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.calendar_month,
                      size: 18,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // FUNCTIONAL DROPDOWN
          // _buildFunctionalDropdown(
          //   value: _groupName,
          //   hint: "Select Group",
          //   items: [
          //     "General Vital Signs",
          //     "Cardio Vital Signs",
          //     "Neuro Vital Signs",
          //   ],
          //   onChanged: (val) => setState(() => _groupName = val),
          // ),
          FunctionalDropdown(
            value: _groupName,
            hint: "--Select--",
            items: [
              "--Select--",
              "General Vital Signs",
              "Cardio Vital Signs",
              "Neuro Vital Signs",
            ],
            onChanged: (val) => setState(() => _groupName = val),
          ),
          const SizedBox(height: 16),

          // View Vital Sign Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IPPrevVitalSignsScreen(
                      patientName: widget.patientName,
                      crn: widget.crn,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A1A1A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                minimumSize: Size.zero,
              ),
              child: const Text(
                "View Vital Sign",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Flipped Matrix Table
          _buildFlippedVitalSignsTable(),
          const SizedBox(height: 32),

          SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }


  Widget _buildFlippedVitalSignsTable() {


    return ScrollableDataTable(
        labels: [
          'Vital Signs',
          'Current Value',
          'Unit',
          'Range',
          'Remarks',
        ],
        rowValues: [
          [
            ...signs.map((sign) {
              return TableText(sign);
            } ).toList()


          ],
          [
            ..._valueControllers.map((controller) => _buildInputCell(controller, isNumeric: true)).toList()
          ],
          [
            ...units.map((unit) {
              return TableText(unit);
            } ).toList()
          ],
          [
            ...ranges.map((range) {
              return TableText(range);
            } ).toList()
          ],
          [
            ..._remarkControllers.map((controller) => _buildInputCell(controller, isNumeric: true,hint: 'Remarks')).toList()
          ],
        ]

    );
  }

  Widget _buildInputCell(
      TextEditingController ctrl, {
        bool isNumeric = false,
        String hint = "",
        bool isLast = false,
      }) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),

      child: GestureDetector(
        // --- ADDED: Triggers Remarks Modal ---
        onTap: hint == "Remarks"
            ? () async {
          await RemarksDialog.show(
            context,
            ctrl,
            title: "Remarks",
            hintText: "Remarks",
          );

          setState(() {}); // dialog close hone ke baad UI refresh
        }
            : null,
        child: Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children:[
              TextField(
                controller: ctrl,
                keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
                textAlign: TextAlign.left, // ✅ always left aligned
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(fontSize: 12, height: 1.2),
                readOnly: hint == "Remarks",
                onTap: hint == "Remarks"
                    ? () async {
                  await RemarksDialog.show(
                    context,
                    ctrl,
                    title: "Remarks",
                    hintText: "Remarks",
                  );

                  setState(() {}); // dialog close hone ke baad UI refresh
                }
                    : null,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                  border: InputBorder.none,
                  isCollapsed: true,

                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }



}
