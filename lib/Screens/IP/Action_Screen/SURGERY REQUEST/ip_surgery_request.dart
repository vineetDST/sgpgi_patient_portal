import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/EMR/ip_emr.dart';

// --- ADDED IMPORT FOR SERVICE BROWSER ---
import 'package:qc_hospital/Screens/IP/Action_Screen/SURGERY REQUEST/service_browser_screen.dart'; // Adjust path as necessary

class IpSurgeryRequestScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const IpSurgeryRequestScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<IpSurgeryRequestScreen> createState() => _IpSurgeryRequestScreenState();
}

class _IpSurgeryRequestScreenState extends State<IpSurgeryRequestScreen> {
  // --- STATE VARIABLES (Strictly from images) ---

  // Surgery Details
  final TextEditingController _reqNoCtrl = TextEditingController();
  DateTime? _requestDate = DateTime(2025, 10, 10);
  String _requestPriority = "Immediate"; // Immediate, Emergency, Elective
  final TextEditingController _reqSeqNoCtrl = TextEditingController();
  String? _chiefSurgeon = "Amit Kumar";
  String? _anesthesist;

  // Operation to be performed
  String? _department = "Endocrinology";
  String? _opCodeName;
  bool _isPrimarySurgery = true;

  // Operation Schedule Details
  DateTime? _operationDate = DateTime(2025, 10, 10);
  final TextEditingController _theatreCtrl = TextEditingController(
    text: "OT Endo2",
  );
  final TextEditingController _opTimeCtrl = TextEditingController(
    text: "12:00 AM - 1:00 PM",
  );
  final TextEditingController _durationCtrl = TextEditingController(
    text: "01:00:00",
  );
  final TextEditingController _residentInstCtrl = TextEditingController();
  final TextEditingController _nursingInstCtrl = TextEditingController();
  final TextEditingController _remarksCtrl = TextEditingController();

  @override
  void dispose() {
    _reqNoCtrl.dispose();
    _reqSeqNoCtrl.dispose();
    _theatreCtrl.dispose();
    _opTimeCtrl.dispose();
    _durationCtrl.dispose();
    _residentInstCtrl.dispose();
    _nursingInstCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Surgery Request",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Surgery Request",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),

          // 1. SURGERY DETAILS
          _buildSurgeryDetailsSection(),
          const SizedBox(height: 16),

          // 2. OPERATION TO BE PERFORMED
          _buildOperationToBePerformedSection(),
          const SizedBox(height: 16),

          // 3. OPERATION SCHEDULE DETAILS
          _buildOperationScheduleDetailsSection(),
          const SizedBox(height: 16),

          // 4. TOTAL COST
          _buildTotalCostSection(),
          const SizedBox(height: 32),

          // --- VERTICAL ACTION BUTTONS (As per Surgery Request.jpg) ---
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
                "Request",
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
          const SizedBox(height: 0),
        ],
      ),
    );
  }

  // =========================================================================
  // SECTIONS
  // =========================================================================

  Widget _buildSurgeryDetailsSection() {
    return CustomExpansionFrame(
      title: "Surgery Details",

      children: [
        _buildLabel("Request No (Auto Gen)"),
        const SizedBox(height: 8),
        _buildDisabledField(controller: _reqNoCtrl),
        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabel("Request Date"),

            // --- UPDATED: EMR Text instead of ElevatedButton ---
            GestureDetector(
              onTap: () {
                doctorShellKey.currentState?.pushToCurrentTab(
                  EmrScreen(
                    patientName: widget.patientName,
                    crn: widget.crn,
                    mode: 'ip',
                  ),
                );
              },
              child: const Text(
                "EMR",
                style: TextStyle(
                  color: Color(0xFF117A7A),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildDatePickerField(
          date: _requestDate,
          onDateSelected: (d) => setState(() => _requestDate = d),
          hideIcon: true,
        ),
        const SizedBox(height: 16),

        _buildLabel("Request Priority"),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _buildRadioOption("Immediate"),
              const SizedBox(width: 16),
              _buildRadioOption("Emergency"),
              const SizedBox(width: 16),
              _buildRadioOption("Elective"),
            ],
          ),
        ),
        const SizedBox(height: 16),

        _buildLabel("Request Sequence Number"),
        const SizedBox(height: 8),
        _buildTextField(controller: _reqSeqNoCtrl),
        const SizedBox(height: 16),

        _buildLabelWithStar("Chief Surgeon"),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _chiefSurgeon,
          hint: "--Select--",
          items: ["--Select--", "Amit Kumar"],
          onChanged: (val) => setState(() => _chiefSurgeon = val),
        ),
        const SizedBox(height: 16),

        _buildLabelWithStar("Anesthesist"),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _anesthesist,
          hint: "--Select--",
          items: ["Dr. Jane", "Dr. Smith"],
          onChanged: (val) => setState(() => _anesthesist = val),
        ),
        const SizedBox(height: 16),
      ]
    );
  }

  Widget _buildOperationToBePerformedSection() {
    return CustomExpansionFrame(
      title: "Operation to be performed",

      children: [
        _buildLabel("Department"),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _department,
          hint: "--Select--",
          items: ["--Select--", "Endocrinology"],
          onChanged: (val) => setState(() => _department = val),
        ),
        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabel("Operation Code / Name for"),
            Row(
              children: [
                const Icon(
                  Icons.add_circle,
                  color: Color(0xFF4CAF50),
                  size: 22,
                ),
                const SizedBox(width: 12),
                // --- UPDATED: Navigate to Service Browser ---
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceBrowserScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 22,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        FunctionalDropdown(
          value: _opCodeName,
          hint: "--Select--",
          items: ["--Select--", "Option 1"],
          onChanged: (val) => setState(() => _opCodeName = val),
        ),
        const SizedBox(height: 24),

        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              children: [
                _buildVerticalTableRow("Code", "T0408"),
                _buildDivider(),
                _buildVerticalTableRow("Name of Surgery", "DSA Venography"),
                _buildDivider(),
                _buildVerticalTableRow("CPT Code", ""),
                _buildDivider(),
                _buildVerticalTableRow("Is Primary Surgery", "CHECKBOX"),
                _buildDivider(),
                _buildVerticalTableRow("Tariff", "DSA Venography"),
                _buildDivider(),
                _buildVerticalTableRow("Action", "DELETE_BIN"),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ]
    );
  }

  Widget _buildOperationScheduleDetailsSection() {
    return CustomExpansionFrame(
      title: "Operation Schedule Details",

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabelWithStar("Operation Date"),

            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: const Icon(Icons.search, color: Colors.black, size: 22),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildDatePickerField(
          date: _operationDate,
          onDateSelected: (d) => setState(() => _operationDate = d),
        ),
        const SizedBox(height: 16),

        _buildLabel("Theatre"),
        const SizedBox(height: 8),
        _buildTextField(controller: _theatreCtrl),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Operation Time"),
                  const SizedBox(height: 8),
                  _buildTextField(controller: _opTimeCtrl),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Duration(Hrs)"),
                  const SizedBox(height: 8),
                  _buildTextField(controller: _durationCtrl),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        _buildLabel("Resident Instruction"),
        const SizedBox(height: 8),

        SharedComponents.buildTextField(hintText:'Resident Instruction' ,controller: _residentInstCtrl,maxLines: 5),
        const SizedBox(height: 16),

        _buildLabel("Nursing Instruction"),
        const SizedBox(height: 8),

        SharedComponents.buildTextField(hintText:'Nursing Instruction' ,controller: _nursingInstCtrl,maxLines: 5),
        const SizedBox(height: 16),

        _buildLabel("Remarks"),
        const SizedBox(height: 8),

        SharedComponents.buildTextField(hintText:'Remarks' ,controller: _remarksCtrl,maxLines: 5),
        const SizedBox(height: 16),
      ]
    );
  }

  Widget _buildTotalCostSection() {
    return CustomExpansionFrame(
      title: "Total Cost",
      children: [
        DetailTableWrapper(children: [


          DetailRow(label: 'Balance Amount',customWidget: Text(
              "5075.00",
            style:
                const TextStyle(
                  color: const Color(0xFF117A7A),
                  fontSize: 14,
                ),
          ),),
          DetailRow(
            isLast: true,
            label: 'Surgery Amount',customWidget: Text(
            "4830.00",
            style:
            const TextStyle(
              color: const Color(0xFFFF0606),
              fontSize: 14,
            ),
          ),),
        ]
        ),
        const SizedBox(height: 16,)



      ],


    );
  }



  Widget _buildExpandableContainer({
    required String title,
    required Widget child,
    bool isExpanded = false,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16),
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          iconColor: Colors.black87,
          collapsedIconColor: Colors.black87,
          children: [Padding(padding: padding, child: child)],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
      ),
    );
  }

  Widget _buildLabelWithStar(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: RichText(

        text: TextSpan(
          text: text,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
          children: const [
            TextSpan(
              text: "*",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
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
        style: const TextStyle(fontSize: 14, color: Colors.black87),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }



  Widget _buildDatePickerField({
    required DateTime? date,
    required Function(DateTime) onDateSelected,
    bool hideIcon = false,
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
            if (!hideIcon)
              const Icon(Icons.calendar_month, size: 20, color: Colors.black87),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String title) {
    bool isSelected = _requestPriority == title;
    return GestureDetector(
      onTap: () => setState(() => _requestPriority = title),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF117A7A)
                    : Colors.grey.shade400,
                width: 1.5,
              ),
            ),
            child: isSelected
                ? Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF117A7A),
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  // Layout for Left: Light Teal Header, Right: White Value
  Widget _buildVerticalTableRow(
    String label,
    String value, {
    Color valueColor = Colors.black87,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: const Color(
              0xFFF0F8F8,
            ), // Exact light teal color from images
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          Container(width: 1, color: Colors.grey.shade300),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              alignment: Alignment.centerLeft,
              child: _buildTableRightSide(value, valueColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRightSide(String value, Color valueColor) {
    if (value == "CHECKBOX") {
      return SizedBox(
        height: 24,
        width: 24,
        child: Checkbox(
          value: _isPrimarySurgery,
          onChanged: (v) => setState(() => _isPrimarySurgery = v!),
          activeColor: const Color(0xFF117A7A),
          side: BorderSide(color: Colors.grey.shade400),
        ),
      );
    } else if (value == "DELETE_BIN") {
      return GestureDetector(
        onTap: () => _showDeleteModal(context),
        child: Image.asset(
          'assets/deleteicon.png',
          height: 15,
          width: 15,
          color: Colors.red,
          errorBuilder: (c, e, s) =>
              const Icon(Icons.delete, color: Colors.red, size: 20),
        ),
      );
    } else {
      return Text(value, style: TextStyle(fontSize: 13, color: valueColor));
    }
  }

  // --- DELETE MODAL ---
  void _showDeleteModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 1.5),
                ),
                child: const Icon(Icons.close, color: Colors.red, size: 32),
              ),
              const SizedBox(height: 24),
              const Text(
                "Are you sure you want to\ndelete the record?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC60000),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
