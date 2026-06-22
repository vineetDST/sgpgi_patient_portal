import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // <-- ADDED: For formatting the dates (e.g., 08-10-25)
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

class IPRxPrintingScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const IPRxPrintingScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<IPRxPrintingScreen> createState() => _RxPrintingScreenState();
}

class _RxPrintingScreenState extends State<IPRxPrintingScreen> {
  // --- ADDED: State variables to hold the selected dates ---
  DateTime _reqDateFrom = DateTime.now();
  DateTime _toDate = DateTime.now().add(
    const Duration(days: 10),
  ); // Defaulting 10 days ahead to match your mockup slightly

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "RX Printing",
      quickActionLabel: "RX Printing",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "RX Printing",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IPActionButton(),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SharedComponents.buildFormLabel("Req. Date From"),
                    const SizedBox(height: 8),
                    // --- UPDATED: Pass state and callback ---
                    _buildDatePickerField(_reqDateFrom, (newDate) {
                      setState(() {
                        _reqDateFrom = newDate;
                      });
                    }),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SharedComponents.buildFormLabel("To Date"),
                    const SizedBox(height: 8),
                    // --- UPDATED: Pass state and callback ---
                    _buildDatePickerField(_toDate, (newDate) {
                      setState(() {
                        _toDate = newDate;
                      });
                    }),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Search",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // --- Expandable Tables ---
          _buildExpandableTile("Prescription Details", [
            _buildDetailRow(
              "Pre. No",
              const Text(
                "0001000310",
                style: TextStyle(color: Color(0xFF117A7A), fontSize: 14),
              ),
              showSort: true,
            ),
            _buildDetailRow(
              "Pre. Date",
              const Text(
                "08-10-2025",
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              showSort: true,
            ),
            _buildDetailRow(
              "Action",
              const Icon(Icons.print, color: Colors.black87),
              isLast: true,
            ),
          ]),
          const SizedBox(height: 12),

          _buildExpandableTile("Prescription Details Description", [
            _buildDetailRow(
              "Form Type",
              const Text(
                "Cap",
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
            _buildDetailRow(
              "Drug",
              const Text(
                "Paracetamol",
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
            ),
            _buildDetailRow(
              "Pre. Date",
              const Text(
                "08-10-2025",
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              isLast: true,
            ),
          ]),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- UPDATED: Accepts current date and a callback to change it ---
  Widget _buildDatePickerField(
      DateTime currentDate,
      ValueChanged<DateTime> onDateSelected,
      ) {
    return GestureDetector(
      onTap: () async {
        // Wait for the user to pick a date from the popup
        DateTime? pickedDate = await CustomCalendarDialog.show(
          context,
          initialDate: currentDate,
        );

        // If they didn't cancel, update the state
        if (pickedDate != null) {
          onDateSelected(pickedDate);
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
                'dd-MM-yy',
              ).format(currentDate), // Format the real DateTime object
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const Icon(Icons.calendar_month, size: 18, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  // --- Expandable Tile Wrapper ---
  Widget _buildExpandableTile(String title, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            children: [
              // Top border to separate header from table contents
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Column(children: children),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Table Row Builder matching the Figma Designs ---
  Widget _buildDetailRow(
      String label,
      Widget valueWidget, {
        bool showSort = false,
        bool isLast = false,
      }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Column (Light Cyan Background)
            Container(
              width: 150,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F8F8), // Matched light cyan background
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  if (showSort) ...[
                    const Spacer(),
                    const Icon(
                      Icons.unfold_more,
                      size: 16,
                      color: Colors.black87,
                    ),
                  ],
                ],
              ),
            ),
            // Right Column (White Background)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                alignment: Alignment.centerLeft,
                child: valueWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
