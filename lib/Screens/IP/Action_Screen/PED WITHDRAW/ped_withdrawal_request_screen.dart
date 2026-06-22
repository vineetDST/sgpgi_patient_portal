import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class PedWithdrawalRequestScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const PedWithdrawalRequestScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<PedWithdrawalRequestScreen> createState() =>
      _PedWithdrawalRequestScreenState();
}

class _PedWithdrawalRequestScreenState
    extends State<PedWithdrawalRequestScreen> {
  String? _referredDepartment;
  String? _referredBy;
  String? _withdrawalreqamnts;

  final TextEditingController _reqNoCtrl = TextEditingController();
  final TextEditingController _reqDateCtrl = TextEditingController(
    text: "08-10-2025",
  );
  final TextEditingController _serviceRequestedCtrl = TextEditingController();
  final TextEditingController _remarksCtrl = TextEditingController();
  final TextEditingController _withdrawalAmountCtrl = TextEditingController();
  final TextEditingController _chequeCtrl = TextEditingController();

  @override
  void dispose() {
    _reqNoCtrl.dispose();
    _reqDateCtrl.dispose();
    _serviceRequestedCtrl.dispose();
    _remarksCtrl.dispose();
    _withdrawalAmountCtrl.dispose();
    _chequeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "PED Withdrawal Request",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PED Withdrawal Request",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Icon(Icons.print, color: Colors.black87), // Print Icon
            ],
          ),
          const SizedBox(height: 16),

          _buildLabel("Request No."),
          const SizedBox(height: 8),
          _buildDisabledField(controller: _reqNoCtrl),
          const SizedBox(height: 16),

          _buildLabel("Requested Date"),
          const SizedBox(height: 8),
          _buildDisabledField(controller: _reqDateCtrl),
          const SizedBox(height: 16),

          _buildLabelWithStar("Referred Department"),
          const SizedBox(height: 8),

          FunctionalDropdown(
            value: _referredDepartment,
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
            onChanged: (val) => setState(() => _referredDepartment = val),
          ),
          // _buildFunctionalDropdown(
          //   value: _referredDepartment,
          //   hint: "--Select--",
          //   items: ["Option 1", "Option 2"],
          //   onChanged: (val) => setState(() => _referredDepartment = val),
          // ),
          const SizedBox(height: 16),

          _buildLabelWithStar("Referred By"),
          const SizedBox(height: 8),

          FunctionalDropdown(
            value: _referredBy,
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
            onChanged: (val) => setState(() => _referredBy = val),
          ),
          // _buildFunctionalDropdown(
          //   value: _referredBy,
          //   hint: "--Select--",
          //   items: ["Doctor A", "Doctor B"],
          //   onChanged: (val) => setState(() => _referredBy = val),
          // ),
          const SizedBox(height: 16),

          _buildLabel("Service Requested"),
          const SizedBox(height: 8),


          SharedComponents.buildTextField(hintText:'Service Requested' ,controller: _serviceRequestedCtrl,maxLines: 5),
          const SizedBox(height: 16),

          _buildLabel("Remarks"),
          const SizedBox(height: 8),

          SharedComponents.buildTextField(hintText:'Remarks' ,controller: _remarksCtrl,maxLines: 5),
          const SizedBox(height: 16),

          _buildLabelWithStar("Withdrawal Request Amount"),
          const SizedBox(height: 8),


          _buildTextField(controller: _withdrawalAmountCtrl),
          const SizedBox(height: 16),

          _buildLabelWithStar("Cheque/D.D. in favour of"),
          const SizedBox(height: 8),

          SharedComponents.buildTextField(hintText:'Cheque/D.D. in favour of' ,controller: _chequeCtrl,maxLines: 5),
          const SizedBox(height: 16),

          // Action Buttons (Vertical Layout - 3 buttons)
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
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
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
                "Save & Print",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
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

  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 13, color: Colors.black87),
    );
  }

  Widget _buildLabelWithStar(String text) {
    return RichText(
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
    );
  }

  Widget _buildTextField({required TextEditingController controller}) {
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
        decoration: const InputDecoration(border: InputBorder.none),
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
