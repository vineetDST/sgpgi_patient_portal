import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// Import the Custom Calendar Dialog
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

// Import the other admission screens to access SharedAdmissionComponents & AdmDetailsModal
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/accompanied_by_screen.dart'; // Contains AdmDetailsModal
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/admission_screen.dart';

class ViewReferralScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ViewReferralScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ViewReferralScreen> createState() => _ViewReferralScreenState();
}

class _ViewReferralScreenState extends State<ViewReferralScreen> {
  // --- FUNCTIONAL STATE VARIABLES ---
  String? _selectedHospital;
  DateTime? _referredDate;
  final TextEditingController _remarksCtrl = TextEditingController();

  final dateOfDischargeController = TextEditingController();
  DateTime? toDate;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  @override
  void dispose() {
    _remarksCtrl.dispose();
    super.dispose();
  }

  String? _department = null;
  String? _consultant = null;

  final TextEditingController _referalReasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Admission",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Admission',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SharedAdmissionComponents.buildTabs(
            context,
            widget.patientName,
            widget.crn,
            activeTabIndex: 0,
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Admission",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  // --- FUNCTIONAL DETAILS BUTTON ---
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => AdmDetailsModal(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.print, color: Colors.black87),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedAdmissionComponents.buildQuickActions(
            context,
            screenWidth,
            widget.patientName,
            widget.crn,
            activeLabel: 'View Referral',
          ),
          const SizedBox(height: 24),

          Text(
            "View Referral",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Ref. Doctor"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'Doctor Name'),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Ref. Hospital"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'Hospital Name'),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Address"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(hintText: 'Address'),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Referred Date"),
          const SizedBox(height: 8),
          AppDateField(

            controller: dateOfDischargeController,
            onTap: () async {
              DateTime? pickedDate = await CustomCalendarDialog.show(
                context,
                initialDate: toDate ?? DateTime.now(),
              );
              if (pickedDate != null) {
                setState(() {
                  toDate = pickedDate;
                  dateOfDischargeController.text = formatDate(pickedDate);
                });
              }
              ;
            },
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Referred to Department"),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: _department,
            items: ['Department 1', 'Department 2'],
            onChanged: (val) {
              setState(() {
                _department = val;
              });
            },
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Referred to Consultant"),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: _consultant,
            items: ['Consultant 1', 'Consultant 2'],
            onChanged: (val) {
              setState(() {
                _consultant = val;
              });
            },
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Referral Reason"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: "Referral Reason",
            maxLines: 5,
            controller: _referalReasonController,
          ),
          const SizedBox(height: 16),

          AppSaveButton(text: 'Admit'),
          const SizedBox(height: 16),

          AppCancelButton(text: "Back to Patient List"),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // --- FUNCTIONAL WIDGET BUILDERS ---

  // --- UPDATED: Uses PopupMenuButton for Dropdown ---
  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            onSelected: onChanged,
            offset: const Offset(0, 48), // Drops down exactly below the field
            color: Colors.white,
            elevation: 0, // Flat look
            constraints: BoxConstraints(
              minWidth: constraints
                  .maxWidth, // Matches the exact width of the container
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5,
              ), // THE OUTLINE BORDER
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? hint,
                      style: TextStyle(
                        color: value == null
                            ? Colors.grey.shade400
                            : Colors.black87,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
            itemBuilder: (context) => items
                .map(
                  (item) => PopupMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildDatePickerField() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await CustomCalendarDialog.show(
          context,
          initialDate: _referredDate ?? DateTime.now(),
        );
        if (pickedDate != null) {
          setState(() => _referredDate = pickedDate);
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
              _referredDate != null
                  ? DateFormat('dd-MM-yy').format(_referredDate!)
                  : "Choose Date",
              style: TextStyle(
                fontSize: 14,
                color: _referredDate != null
                    ? Colors.black87
                    : Colors.grey.shade400,
              ),
            ),
            const Icon(Icons.calendar_month, size: 20, color: Colors.black87),
          ],
        ),
      ),
    );
  }


}
