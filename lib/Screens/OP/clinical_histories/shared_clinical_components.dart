import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Screens/OP/patient_profile_screen.dart';
import 'package:qc_hospital/Screens/OP/q_actions/bed_status_screen.dart';
import 'package:qc_hospital/Screens/OP/q_actions/lab_reports_screen.dart';
import 'package:qc_hospital/Screens/OP/q_actions/pacs_reports_screen.dart';
import 'package:qc_hospital/Screens/OP/q_actions/procedure_reports_screen.dart';
import 'package:qc_hospital/Screens/OP/q_actions/visit_summary_screen.dart';
import 'package:qc_hospital/Screens/OP/q_actions/rx_printing_screen.dart';
import 'package:qc_hospital/Screens/OP/q_actions/emr_screen.dart';
import 'package:qc_hospital/Screens/OP/cpoes/investigation_screen.dart';

class SharedComponents {
  static Widget buildPatientCard(
    BuildContext context,
    double width,
    String patientName,
    String crn,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    width: width * 0.28,
                    // height: width * 0.32,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                        topRight: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      image: const DecorationImage(
                        image: AssetImage("assets/a.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to Patient Profile
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PatientProfileScreen(
                              patientName: patientName,
                              crn: crn,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "View",
                          style: AppTextStyles.RegH3.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _rowInfo(
                      "Patient Name",
                      "Visit ID",
                      patientName,
                      "OP - 001",
                      isName: true,
                    ),
                    const Divider(height: 20, color: Color(0xFFF0F0F0)),
                    _rowInfo("Patient ID", "Age / Gender", crn, "24 / Male"),
                    const Divider(height: 20, color: Color(0xFFF0F0F0)),
                    _rowInfo("Validity", "", "10-10-2026", ""),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _rowInfo(
    String label1,
    String label2,
    String val1,
    String val2, {
    bool isName = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
              const SizedBox(height: 2),
              Text(
                val1,
                style: TextStyle(
                  color: isName ? const Color(0xFF117A7A) : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        if (label2.isNotEmpty)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label2,
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                const SizedBox(height: 2),
                Text(
                  val2,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  static Widget buildQuickActions(
    BuildContext context,
    double width,
    String patientName,
    String crn, {
    String activeLabel = '',
  }) {
    final actions = [
      {'icon': 'assets/bedst.png', 'label': 'Bed Status'},
      {'icon': 'assets/rx.png', 'label': 'RX Printing'},
      {'icon': 'assets/lab.png', 'label': 'Lab'},
      {'icon': 'assets/rad.png', 'label': 'Rad'},
      {'icon': 'assets/proc.png', 'label': 'Proc'},
      {'icon': 'assets/sumry.png', 'label': 'Summary'},
      {'icon': 'assets/ordrst.png', 'label': 'Order Status'},
      {'icon': 'assets/emr.png', 'label': 'EMR'},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Icon(
                Icons.access_time_outlined,
                size: 18,
                color: Colors.black87,
              ),
              const SizedBox(width: 8),
              Text(
                "Quick Actions",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: actions.map((item) {
              double itemWidth = (width - 64) / 5.5;
              bool isActive = item['label'] == activeLabel;

              return InkWell(
                onTap: () {
                  Widget? nextScreen;
                  if (item['label'] == 'Bed Status')
                    nextScreen = BedStatusScreen(
                      patientName: patientName,
                      crn: crn,
                    );
                  else if (item['label'] == 'Lab')
                    nextScreen = LabReportsScreen(
                      patientName: patientName,
                      crn: crn,
                    );
                  else if (item['label'] == 'Rad')
                    nextScreen = PacsReportsScreen(
                      patientName: patientName,
                      crn: crn,
                    );
                  else if (item['label'] == 'Proc')
                    nextScreen = ProcedureReportsScreen(
                      patientName: patientName,
                      crn: crn,
                    );
                  else if (item['label'] == 'RX Printing')
                    nextScreen = RxPrintingScreen(
                      patientName: patientName,
                      crn: crn,
                    );
                  else if (item['label'] == 'Order Status')
                    nextScreen = InvestigationScreen(
                      patientName: patientName,
                      crn: crn,
                    );
                  else if (item['label'] == 'Summary')
                    nextScreen = VisitSummaryScreen(
                      patientName: patientName,
                      crn: crn,
                    );
                  else if (item['label'] == 'EMR') {
                    nextScreen = EmrScreen(patientName: patientName, crn: crn);
                  }

                  if (nextScreen != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => nextScreen!),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: itemWidth,
                  height: 70,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xFF117A7A)
                        : const Color(0xFFE0F7F7).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: const Color(0xFF117A7A).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        item['icon'] as String,
                        width: 22,
                        height: 22,
                        color: isActive ? Colors.white : Colors.black87,
                      ),

                      SizedBox(
                        // height: 25,
                        child: Text(
                          item['label'] as String,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isActive
                                ? FontWeight.bold
                                : FontWeight.w500,
                            color: isActive ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // --- FORM HELPERS ---
  static Widget buildFormLabel(String text, {bool isRequired = false}) {
    return RichText(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        children: isRequired
            ? [
                const TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ]
            : [],
      ),
    );
  }

  static Widget buildTextField({
    TextEditingController? controller, // <-- ADDED: To manage text state
    String? hintText,
    int maxLines = 1,
    double? height,
    TextInputType? keyboardType, // <-- ADDED: For number vs text keyboards
    Function(String)? onChanged, // <-- ADDED: To listen to typing events
    bool readOnly = false, // <-- ADDED: To disable typing if needed
    bool enabled = true,
    Widget? suffix,
    bool isDense = false,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Stack(
        children: [
          TextField(
            controller: controller,
            maxLines: maxLines,
            keyboardType: keyboardType,
            onChanged: (text) {
              // Agar maxLines set hai aur text ki lines maxLines se zyada ho rahi hain
              if (maxLines != 1 && '\n'.allMatches(text).length >= maxLines) {
                // Nayi line allow nahi karega aur purane text par fix rakhega
                if (controller != null) {
                  // Last typed character ko hata dega agar wo limit cross kare
                  controller.text = text.substring(0, text.length - 1);
                  // Cursor ko aakhiri position par banaye rakhega
                  controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: controller.text.length),
                  );
                }
              } else {
                // Agar sab theek hai toh aapka normal onChanged chalega
                if (onChanged != null) onChanged(text);
              }
            },
            readOnly: readOnly,
            enabled: enabled,
            selectionControls: NoCursorHandleControls(),

            contextMenuBuilder: (_, __) => const SizedBox.shrink(),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              border: InputBorder.none,
              suffixIcon: suffix,
              isDense: isDense,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: isDense ? 10 : 12,
              ),
            ),
          ),
          maxLines >= 5
              ? Positioned(
            bottom: 12,
            right: 12,
            child: Image.asset(
              'assets/txtarea.png',
              width: 14,
              height: 14,
              color: Colors.grey.shade400,
            ),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  static Widget buildInnerTextField({
    TextEditingController? controller, // <-- ADDED: To manage text state
    String? hintText,
    int maxLines = 1,
    double? height,
    TextInputType? keyboardType, // <-- ADDED: For number vs text keyboards
    Function(String)? onChanged, // <-- ADDED: To listen to typing events
    bool readOnly = false, // <-- ADDED: To disable typing if needed
    bool enabled = true,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        onChanged: onChanged,
        readOnly: readOnly,
        enabled: enabled,
        selectionControls: NoCursorHandleControls(),

        contextMenuBuilder: (_, __) => const SizedBox.shrink(),
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
      ),
    );
  }

  static Widget buildDropdown({required String hintText}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            hintText,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          items: [], // Populate with actual items
          onChanged: (value) {},
        ),
      ),
    );
  }

  static Widget buildActionButtons(BuildContext context, {String title = ""}) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF117A7A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 0,
            ),
            child: Text(
              title != "" ? title : "Save",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.grey.shade300),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor: Colors.white,
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
      ],
    );
  }
}

class NoCursorHandleControls extends MaterialTextSelectionControls {
  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    return const SizedBox.shrink();
  }
}
