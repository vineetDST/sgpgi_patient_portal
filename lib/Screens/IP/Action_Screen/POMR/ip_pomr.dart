import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Screens/IP/in_patient_screen.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

class IPPomrScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const IPPomrScreen({super.key, required this.patientName, required this.crn});

  @override
  State<IPPomrScreen> createState() => _PomrScreenState();
}

class _PomrScreenState extends State<IPPomrScreen> {
  // --- FUNCTIONAL STATE VARIABLES ---
  final TextEditingController _problemSearchCtrl = TextEditingController();
  final TextEditingController _evidenceCtrl = TextEditingController();
  final TextEditingController _planCtrl = TextEditingController();

  String? _problemStatus = null;
  DateTime _recordedDate = DateTime.now();

  @override
  void dispose() {
    _problemSearchCtrl.dispose();
    _evidenceCtrl.dispose();
    _planCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "POMR",
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
                "POMR",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                // --- UPDATED: Goes back to the previous screen ---
                // onPressed: () => Navigator.pop(context),
                onPressed: () {
                  doctorShellKey.currentState?.pushToCurrentTab(
                    const InPatientScreen(),
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
                ),
                child: const Text(
                  "Add New",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildCreatePomr(),
          const SizedBox(height: 16),

          // POMR Details Tile
          _buildPomrDetailsTile(context),
          const SizedBox(height: 16),

          AppSaveButton(),
          const SizedBox(height: 16),
          AppCancelButton(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // --- FUNCTIONAL WIDGET BUILDERS ---

  Widget _buildSearchField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          suffixIcon: const Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }







  Widget _buildDatePickerField(
      DateTime currentDate,
      ValueChanged<DateTime> onDateSelected,
      ) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await CustomCalendarDialog.show(
          context,
          initialDate: currentDate,
        );

        if (pickedDate != null) {
          // 1. मौजूदा समय (Current Time) को निकालें
          final now = DateTime.now();

          // 2. चुनी हुई तारीख में मौजूदा घंटे (Hour) और मिनट (Minute) को मिला दें
          DateTime dateWithCurrentTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            now.hour,
            now.minute,
          );

          // 3. अपडेटेड डेट-टाइम को स्टेट में भेजें
          onDateSelected(dateWithCurrentTime);
        }
      },
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat(
                'dd-MM-yy | HH:mm',
              ).format(currentDate), // Format the real DateTime object
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const Icon(Icons.calendar_month, size: 18, color: Colors.black87),
          ],
        ),
      ),
    );
  }


  Widget _buildPomrDetailsTile(BuildContext con) {


    return CustomExpansionFrame(
        title: 'POMR Details',
        children: [
          DetailTableWrapper(
            children: [
              DetailRow(
                label: 'Problem Name',
                text: 'Hypertension',
              ),
              DetailRow(
                label: 'Evidence',
                text: 'Elevated BP over 3 visits',
              ),
              DetailRow(
                label: 'Plan of Action',
                text: 'Start Lisinopril 10mg',
              ),
              DetailRow(
                label: 'Problem Status',
                text: 'Active',
              ),
              DetailRow(
                label: 'Recorded By',
                text: 'Dr. Smith',
              ),
              DetailRow(
                label: 'Recorded Date',
                text: '08-10-2025',
              ),
              DetailRow(
                label: 'Resolve Date',
                text: '-',
              ),
              DetailRow(
                removePadding: true,
                isLast: true,
                label: 'Action',
                customWidget: Row(
                  children: [
                    const SizedBox(width: 16,),
                    Image.asset(
                      'assets/editicons.png', // 👈 your image path
                      height: 15,
                      width: 15,
                      color: Colors.black,
                    ),
                    AppDeleteIcon(parentContext: con,)
                  ],
                ),

              ),
            ],
          ),
          const SizedBox(height: 16,),
        ]
    );
  }

  Widget _buildCreatePomr() {
    return CustomExpansionFrame(
        title: 'Create POMR',
        children:
        [
          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel(
              "Problem Name",
              isRequired: true,
            ),
          ),
          const SizedBox(height: 8),
          _buildSearchField(_problemSearchCtrl, "Problem Name"),
          const SizedBox(height: 16),

          Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel(
              "Problem Status",
              isRequired: true,
            ),
          ),
          const SizedBox(height: 8),


          FunctionalDropdown(
            value: _problemStatus,
            hint: "--Select--",
            items: [
              "--Select--",
              "Active",
              "Inactive",
              "Resolved",
            ],
            onChanged: (val) =>
                setState(() => _problemStatus = val),
          ),
          const SizedBox(height: 16),

          Align(
              alignment: Alignment.centerLeft,child: SharedComponents.buildFormLabel("Evidence")),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _evidenceCtrl,
            hintText: "Evidence",
            maxLines: 5,
            // height: 130,
          ),
          const SizedBox(height: 16),

          Align(
              alignment: Alignment.centerLeft,child: SharedComponents.buildFormLabel("Plan of Action")),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _planCtrl,
            hintText: "Plan of Action",
            maxLines: 5,
            // height: 130,
          ),
          const SizedBox(height: 16),

          Align(
              alignment: Alignment.centerLeft,child: SharedComponents.buildFormLabel("Recorded Date")),
          const SizedBox(height: 8),
          _buildDatePickerField(
            _recordedDate,
                (newDate) => setState(() => _recordedDate = newDate),
          ),
          const SizedBox(height: 16),
        ]


    );
  }
}
