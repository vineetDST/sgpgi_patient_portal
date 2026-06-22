import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog2.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:flutter_svg/flutter_svg.dart'; // REQUIRED FOR SVG ICONS
import 'package:qc_hospital/Screens/OP/cpoes/prev_material_screen.dart';

class PrescriptionItem {
  TextEditingController formCtrl;
  String genericName;
  String tradeName;
  TextEditingController doseCtrl;
  TextEditingController durationValCtrl;
  String? durationType;
  String? route;
  TextEditingController instructionCtrl;
  TextEditingController frequencyCtrl;

  PrescriptionItem({
    required String form,
    required this.genericName,
    required this.tradeName,
    required String dose,
    required String frequency,
    required String durationVal,

    this.durationType = "Days",
    this.route,
    String instruction = "",
  }) : formCtrl = TextEditingController(text: form),
       doseCtrl = TextEditingController(text: dose),
       frequencyCtrl = TextEditingController(text: frequency),
       durationValCtrl = TextEditingController(text: durationVal),
       instructionCtrl = TextEditingController(text: instruction);

  void dispose() {
    formCtrl.dispose();
    doseCtrl.dispose();
    durationValCtrl.dispose();
    instructionCtrl.dispose();
    frequencyCtrl.dispose();
  }
}

class PrescriptionScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const PrescriptionScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  final TextEditingController _genericCtrl = TextEditingController();
  final TextEditingController _tradeNameCtrl = TextEditingController();
  final TextEditingController _formCtrl = TextEditingController();
  final TextEditingController _doseCtrl = TextEditingController();
  final TextEditingController _durationValCtrl = TextEditingController(

  );
  final TextEditingController _instructionCtrl = TextEditingController();
  final TextEditingController _nonRcDrugCtrl = TextEditingController();

  final TextEditingController _formFrequency = TextEditingController();
  String? _formDurationType = "Days";

  final List<PrescriptionItem> _prescriptions = [
    PrescriptionItem(
      form: "Cap",
      genericName: "AA 10",
      tradeName: "Paracetamol",
      dose: "1",
      durationVal: "1",
      durationType: "Days",
      frequency: '',
    ),
    PrescriptionItem(
      form: "Tab",
      genericName: "BB 20",
      tradeName: "Ibuprofen",
      dose: "2",
      durationVal: "5",
      durationType: "Days",
      frequency: '',
    ),
  ];

  @override
  void dispose() {
    _genericCtrl.dispose();
    _tradeNameCtrl.dispose();
    _formCtrl.dispose();
    _doseCtrl.dispose();
    _durationValCtrl.dispose();
    _instructionCtrl.dispose();
    _nonRcDrugCtrl.dispose();
    _formFrequency.dispose();

    for (var item in _prescriptions) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClinicalBaseScaffold(
      title: "Prescription",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Prescription',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Prescription",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/reload.svg',
                    height: 24,
                    width: 24,
                    colorFilter: const ColorFilter.mode(
                      Color.fromARGB(255, 0, 0, 0),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrevMaterialScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    ),
                    child: const Text(
                      "Prev",
                      style: TextStyle(
                        color: Color(0xFF117A7A),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Generic"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _genericCtrl,
            hintText: "Generic",
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Trade Name", isRequired: true),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _tradeNameCtrl,
            hintText: "Trade Name",
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel(
            "Form (Tab, Cap, Inj etc.,)",
            isRequired: true,
          ),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _formCtrl,
            hintText: "Form",
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SharedComponents.buildFormLabel("Dose"),
                    const SizedBox(height: 8),
                    SharedComponents.buildTextField(
                      controller: _doseCtrl,

                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SharedComponents.buildFormLabel("Frequency"),
                    const SizedBox(height: 8),
                    SharedComponents.buildTextField(
                      controller: _formFrequency,
                      hintText: "",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Duration"),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: SharedComponents.buildTextField(
                  controller: _durationValCtrl,

                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildFunctionalDropdown(_formDurationType, [
                  "Days",
                  "Weeks",
                  "Months",
                  "Years",
                ], (v) => setState(() => _formDurationType = v)),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Instruction"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _instructionCtrl,
            hintText: "Instruction",
          ),
          const SizedBox(height: 24),

          Center(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                "Add Prescription",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          _buildSyncedTable(),
          const SizedBox(height: 24),

          SharedComponents.buildFormLabel("Non - RC Drug"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _nonRcDrugCtrl,
            hintText: "Non - RC Drug",
          ),
          const SizedBox(height: 24),

          _buildFullWidthButton("Add Drug", isFilled: true),
          const SizedBox(height: 12),
          _buildFullWidthButton("Save", isFilled: true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- UPDATED: Uses PopupMenuButton ---
  Widget _buildFunctionalDropdown(
    String? value,
    List<String> items,
    Function(String?) onChanged, {
    String hintText = "",
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
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? hintText,
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

  Widget _buildSyncedTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment
              .start, // 1. Isko 'start' rakhne se neeche ki khali jagah clean rahegi
          children: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF9F9),
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  _buildLeftCell("Form", 55),
                  _buildDivider(),
                  _buildLeftCell("Generic", 55),
                  _buildDivider(),
                  _buildLeftCell("Trade Name", 55),
                  _buildDivider(),
                  _buildLeftCell("Dose", 55),
                  _buildDivider(),
                  _buildLeftCell("Frequency", 55),
                  _buildDivider(),
                  _buildLeftCell("Duration", 55),
                  _buildDivider(),
                  _buildLeftCell("Route", 55),
                  _buildDivider(),
                  _buildLeftCell("Instruction", 55),
                  _buildDivider(),
                  _buildLeftCell("Action", 55),
                  _buildDivider(),
                  Container(
                    height: 55,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: const [
                        Icon(Icons.print, color: Colors.black87, size: 20),
                        SizedBox(width: 12),
                        Icon(Icons.visibility, color: Colors.black87, size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicWidth(
                  child: Row(
                    children: List.generate(_prescriptions.length, (index) {
                      final item = _prescriptions[index];
                      bool isLast = index == _prescriptions.length - 1;

                      // 2. Sirf is individual row ko IntrinsicHeight diya hai
                      return IntrinsicHeight(
                        child: Row(
                          children: [
                            _buildPrescriptionCol(item),

                            // 3. Ye divider ab sirf 'Action' row tak hi dikhega, uske neeche nahi jayega
                            if (!isLast)
                              VerticalDivider(
                                width: 1,
                                thickness: 1,
                                color: Colors.grey.shade300,
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrescriptionCol(PrescriptionItem item) {
    return SizedBox(
      width: 180,
      child: Column(
        children: [
          _buildRightInputCell(item.formCtrl, "Cap", 55),
          _buildDivider(),
          _buildRightTextCell(item.genericName, 55),
          _buildDivider(),
          _buildRightTextCell(item.tradeName, 55, isRed: true),
          _buildDivider(),
          _buildRightInputCell(item.doseCtrl, "1", 55),
          _buildDivider(),
          _buildRightInputCell(item.frequencyCtrl, "", 55),
          // _buildRightDropdownCell(
          //   item.frequency,
          //   ["Daily", "BD", "TDS", "QID"],
          //   (v) => setState(() => item.frequency = v),
          //   "Select",
          //   55,
          // ),
          _buildDivider(),
          _buildRightDurationCell(item, 55),
          _buildDivider(),
          _buildRightDropdownCell(
            item.route,
            ["Oral", "IV", "IM"],
            (v) => setState(() => item.route = v),
            "Select",
            55,
          ),
          _buildDivider(),
          _buildRightInstructionCell(item.instructionCtrl, 55),
          _buildDivider(),
          Container(
            height: 55,
            alignment: Alignment.centerLeft,

            child: AppDeleteIcon(),
          ),
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildLeftCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Colors.black87,
      ),
    ),
  );

  Widget _buildRightTextCell(
    String text,
    double height, {
    bool isRed = false,
  }) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: isRed ? Colors.red : Colors.black87,
      ),
    ),
  );

  Widget _buildRightInputCell(
    TextEditingController ctrl,
    String hint,
    double height,
  ) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: TextField(
          controller: ctrl,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 12),
          selectionControls: NoCursorHandleControls(),

          contextMenuBuilder: (_, __) => const SizedBox.shrink(),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 11, color: Colors.grey),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(bottom: 14),
          ),
        ),
      ),
    );
  }

  // --- UPDATED: Uses PopupMenuButton for Table Dropdowns ---
  Widget _buildRightDropdownCell(
    String? value,
    List<String> items,
    Function(String?) onChanged,
    String hint,
    double height,
  ) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            height: 38,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            child: PopupMenuButton<String>(
              onSelected: onChanged,
              offset: const Offset(0, 38),
              color: Colors.white,
              elevation: 0,
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                maxWidth: constraints.maxWidth,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        value ?? hint,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              itemBuilder: (context) => items
                  .map(
                    (e) => PopupMenuItem(
                      value: e,
                      child: Text(e, style: const TextStyle(fontSize: 11)),
                    ),
                  )
                  .toList(),
            ),
          );
        },
      ),
    );
  }

  // --- UPDATED: Uses PopupMenuButton for Duration Split Dropdown ---
  Widget _buildRightDurationCell(PrescriptionItem item, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 34,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextField(
                controller: item.durationValCtrl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
                selectionControls: NoCursorHandleControls(),

                contextMenuBuilder: (_, __) => const SizedBox.shrink(),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: 34,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: PopupMenuButton<String>(
                    onSelected: (v) => setState(() => item.durationType = v),
                    offset: const Offset(0, 34),
                    color: Colors.white,
                    elevation: 0,
                    constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      maxWidth: constraints.maxWidth,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                      side: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.durationType ?? "Days",
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            size: 16,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                    itemBuilder: (context) =>
                        ["Days", "Weeks", "Months", "Years"]
                            .map(
                              (e) => PopupMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRightInstructionCell(TextEditingController ctrl, double height) {
    return GestureDetector(
      // onTap: () => _showInstructionModal(context, ctrl),
      onTap: () async {
        await RemarksDialog.show(
          context,
          ctrl,
          title: "Instruction",
          hintText: "Instruction",
        );

        setState(() {}); // Dialog close hone ke baad text refresh
      },
      child: Container(
        height: height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            ctrl.text.isNotEmpty ? ctrl.text : "Instruction",
            style: TextStyle(
              fontSize: 11,
              color: ctrl.text.isNotEmpty ? Colors.black87 : Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  Widget _buildFullWidthButton(String text, {required bool isFilled}) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: isFilled
          ? ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.white,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }


}
