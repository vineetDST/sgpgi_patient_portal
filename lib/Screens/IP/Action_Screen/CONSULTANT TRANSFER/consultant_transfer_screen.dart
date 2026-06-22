import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';

class ConsultantTransferScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ConsultantTransferScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ConsultantTransferScreen> createState() =>
      _ConsultantTransferScreenState();
}

class _ConsultantTransferScreenState extends State<ConsultantTransferScreen> {
  DateTime? _requestDate = DateTime(2025, 10, 10);
  String? _requestType = "Doctor Transfer";
  String? _department = "Cardiology";

  final TextEditingController _admittingDoctorCtrl = TextEditingController(
    text: "Sudeep Kumar",
  );
  final TextEditingController _admissionDateCtrl = TextEditingController(
    text: "08-10-2025",
  );
  final TextEditingController _fromLocationCtrl = TextEditingController(
    text:
        "PGI Lucknow / 1201 Cardiology Wing-A01(MICU) / Medical Care Unit / 19",
  );
  final TextEditingController _consultantCtrl = TextEditingController(
    text: "Roopali Khanna",
  );

  @override
  void dispose() {
    _admittingDoctorCtrl.dispose();
    _admissionDateCtrl.dispose();
    _fromLocationCtrl.dispose();
    _consultantCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Consultant Transfer",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Consultant Transfer",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          _buildLabel("Admitting Doctor"),
          const SizedBox(height: 8),
          _buildDisabledField(controller: _admittingDoctorCtrl),
          const SizedBox(height: 16),

          _buildLabel("Admission Date"),
          const SizedBox(height: 8),
          _buildDisabledField(controller: _admissionDateCtrl),
          const SizedBox(height: 16),

          _buildLabel("From Location"),
          const SizedBox(height: 8),
          _buildDisabledTextArea(controller: _fromLocationCtrl),
          const SizedBox(height: 16),

          _buildLabel("Request Date"),
          const SizedBox(height: 8),
          _buildDatePickerField(
            date: _requestDate,
            onDateSelected: (d) => setState(() => _requestDate = d),
          ),
          const SizedBox(height: 16),

          _buildLabel("Request Type"),
          const SizedBox(height: 8),
          FunctionalDropdown(
            value: _requestType,
            hint: "--Select--",
            items: [
              "--Select--",
              "Absconded",
              "Any Other Reason",
              "Comma State",
              "Cured",
              "Death",
              "Discharge on Own Request",
              "LAMA",
              "Normal Discharge",
              "Referred to Other Hospitals",
              "Transfer to Other Institute",
              "With Medical Advice",
            ],
            onChanged: (val) => setState(() => _requestType = val),
          ),
          // _buildFunctionalDropdown(
          //   value: _requestType,
          //   hint: "--Select--",
          //   items: ["Doctor Transfer", "Department Transfer"],
          //   onChanged: (val) => setState(() => _requestType = val),
          // ),
          const SizedBox(height: 16),

          _buildLabel("Consultant"),
          const SizedBox(height: 8),
          _buildTextField(controller: _consultantCtrl),
          const SizedBox(height: 16),

          _buildLabel("Department"),
          const SizedBox(height: 8),

          FunctionalDropdown(
            value: _department,
            hint: "--Select--",
            items: [
              "--Select--",
              "Absconded",
              "Any Other Reason",
              "Comma State",
              "Cured",
              "Death",
              "Discharge on Own Request",
              "LAMA",
              "Normal Discharge",
              "Referred to Other Hospitals",
              "Transfer to Other Institute",
              "With Medical Advice",
            ],
            onChanged: (val) => setState(() => _department = val),
          ),
          // _buildFunctionalDropdown(
          //   value: _department,
          //   hint: "--Select--",
          //   items: ["Cardiology", "Neurology"],
          //   onChanged: (val) => setState(() => _department = val),
          // ),
          const SizedBox(height: 32),

          // Action Buttons (Vertical Layout)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Transfer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                side: BorderSide(color: Colors.grey.shade400),
              ),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 13, color: Colors.black87),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String hint = "",
  }) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDisabledField({required TextEditingController controller}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        enabled: false,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }

  Widget _buildDisabledTextArea({required TextEditingController controller}) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        enabled: false,
        maxLines: 5,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildDatePickerField({
    required DateTime? date,
    required Function(DateTime) onDateSelected,
  }) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await CustomCalendarDialog.show(
          context,
          initialDate: date ?? DateTime.now(),
        );
        if (pickedDate != null) onDateSelected(pickedDate);
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
              date != null ? DateFormat('dd-MM-yyyy').format(date) : "",
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
            const Icon(Icons.calendar_month, size: 20, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  Widget _buildFunctionalDropdown({
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
            offset: const Offset(0, 48),
            color: Colors.white,
            elevation: 0,
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
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
                        color: value == null || value.isEmpty
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
}
