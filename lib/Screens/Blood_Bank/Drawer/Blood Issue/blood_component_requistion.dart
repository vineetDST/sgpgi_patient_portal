import 'package:flutter/material.dart';

import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/total_cost.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class BloodComponentRequistion extends StatefulWidget {
  final String patientName;
  final String crn;

  const BloodComponentRequistion({
    super.key,
    this.patientName = 'Anil Srivastava',
    this.crn = '2025100043',
  });

  @override
  State<BloodComponentRequistion> createState() => _IPInfectionRecState();
}

class _IPInfectionRecState extends State<BloodComponentRequistion> {
  bool isChecked1 = false;
  bool isChecked2 = false;

  bool irradiated1 = false;
  bool irradiated2 = false;

  String selectedDropdownValue1 = '--Select--';
  String selectedDropdownValue2 = '--Select--';

  List transfusion = [false, false, false, false, false, false];

  String? department = null;

  final reasonController = TextEditingController();

  String? diagnosisDetail = null;

  bool _isPatientFound = false; // State to handle toggle
  final TextEditingController _searchController = TextEditingController();

  void _handleSearch() {
    // Yahan se condition hata di hai. Ab direct true ho jayega.
    // Jab real API call lagayenge tab aap yahan validation add kar sakte hain.
    setState(() {
      _isPatientFound = true;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () {
        print("tap");
        _handleSearch();
      },
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search by CRN Number',
              style: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
            const Icon(Icons.search, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Blood Component Requistion",
      showDrawer: true,

      isPatientCard: _isPatientFound,
      customOverlapWidget: _isPatientFound ? null : _buildSearchBar(),

      patientName: widget.patientName,
      crn: widget.crn,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Blood Component Requistion",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),

              GestureDetector(
                onTap: () {
                  _openShowDialog();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A), // fixed color
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Details",
                    style: TextStyle(
                      color: Colors.white, // fixed text color
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildTransfusionRequestDetails(),
          const SizedBox(height: 16),

          _buildBloodRequistionNo(context),
          const SizedBox(height: 16),
          _buildBloodCost(),
          const SizedBox(height: 16),

          _buildTotalCost(),
          const SizedBox(height: 16),

          AppSaveButton(text: 'Save/Print', onPressed: () {}),
          const SizedBox(height: 16),
          AppCancelButton(text: 'Reprint', onPressed: () {}),
          const SizedBox(height: 24),

          _buildNotes(
            'Immediate',
            'Blood unit will be issued before cross matching, with in 30 minutes',
          ),
          const SizedBox(height: 16),
          _buildNotes(
            'Emergency',
            'Blood unit will be issued by immediate Spin Technology, with in 2 hours',
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildTransfusionRequestDetails() {
    return CustomExpansionFrame(
      title: 'Transfusion Request Details',
      children: [
        DetailTableWrapper(
          children: [
            DetailRow(width: 250, label: 'Blood Component Selection'),
            DetailRow(
              width: 250,
              label: 'Whole Blood',
              customWidget: _buildRadio(transfusion[0], () {
                setState(() {
                  transfusion[0] = !transfusion[0]; // Toggle value
                });
              }),
            ),

            DetailRow(
              width: 250,
              label: 'Leuco-Poor red Cells',
              customWidget: _buildRadio(transfusion[1], () {
                setState(() {
                  transfusion[1] = !transfusion[1]; // Toggle value
                });
              }),
            ),

            DetailRow(
              width: 250,
              label: 'Plateles(Random donor)',
              customWidget: _buildRadio(transfusion[2], () {
                setState(() {
                  transfusion[2] = !transfusion[2]; // Toggle value
                });
              }),
            ),

            DetailRow(
              width: 250,
              label: 'Fresh frozen plasma',
              customWidget: _buildRadio(transfusion[3], () {
                setState(() {
                  transfusion[3] = !transfusion[3]; // Toggle value
                });
              }),
            ),

            DetailRow(
              width: 250,
              label: 'Cryoprecipitate',
              customWidget: _buildRadio(transfusion[4], () {
                setState(() {
                  transfusion[4] = !transfusion[4]; // Toggle value
                });
              }),
            ),

            DetailRow(
              isLast: true,
              width: 250,
              label: 'Modified',
              customWidget: _buildRadio(transfusion[5], () {
                setState(() {
                  transfusion[5] = !transfusion[5]; // Toggle value
                });
              }),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Icon(Icons.keyboard_arrow_left),
            ),
            const SizedBox(width: 16),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Text(
                "01",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade100),
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              child: Text(
                "02",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Icon(Icons.keyboard_arrow_right),
            ),
            const SizedBox(width: 16),
          ],
        ),

        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildBloodRequistionNo(BuildContext context) {
    return CustomExpansionFrame(
      title: 'Blood Requistion No:',
      children: [
        ScrollableDataTable(
          labels: const [
            "Blood\nComponent",
            "CM",
            "Rate/Unit",
            "Unit",
            "Priority",
            "Irradiated",
            "Action",
          ],
          // Har array me 2 values hain, jo horizontally scroll hongi
          rowValues: [
            // 1. Investigation Name Row
            [
              const Text("Whole Blood", style: TextStyle(fontSize: 13)),
              const Text("Whole Blood", style: TextStyle(fontSize: 13)),
            ],
            // 2. Order No Row
            [
              _buildRadio(isChecked1, () {
                setState(() {
                  isChecked1 = !isChecked1; // Toggle value
                });
              }),
              _buildRadio(isChecked2, () {
                setState(() {
                  isChecked2 = !isChecked2; // Toggle value
                });
              }),
            ],
            // 3. Date Row (Pehla khali hai image me)
            [
              const Text("745.00", style: TextStyle(fontSize: 13)),
              const Text("745.00", style: TextStyle(fontSize: 13)),
            ],
            // 4. Order Status Row
            [_buildInnerTextField(''), _buildInnerTextField('')],

            [
              _buildInnerDropdown(
                selectedDropdownValue1,
                ["Elective", "Emergency", "Immediate"],
                (newValue) {
                  setState(() {
                    selectedDropdownValue1 = newValue; // Value update karein
                  });
                },
              ),

              _buildInnerDropdown(
                selectedDropdownValue2,
                ["Elective", "Emergency", "Immediate"],
                (newValue) {
                  setState(() {
                    selectedDropdownValue2 = newValue; // Value update karein
                  });
                },
              ),
            ],
            // 5. Link Row
            [
              _buildRadio(irradiated1, () {
                setState(() {
                  irradiated1 = !irradiated1; // Toggle value
                });
              }),
              _buildRadio(irradiated2, () {
                setState(() {
                  irradiated2 = !irradiated2; // Toggle value
                });
              }),
            ],
            // 6. New Link Row
            [
              NoPaddingCell(child: AppDeleteIcon(parentContext: context,)),
              NoPaddingCell(child: AppDeleteIcon(parentContext: context,)),
            ],
          ],
        ),
        const SizedBox(height: 16,)
      ],
    );
  }

  Widget _buildBloodCost() {
    return CustomExpansionFrame(
      title: 'Blood Cost',
      children: [
        DetailTableWrapper(


          children: [
            DetailRow(
              label: "Blood / Componenet",
              customWidget: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "745.00",
                      style: TextStyle(
                        color: Color(0xFF117A7A), // 🔵 Blue
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DetailRow(
              label: "Cross Match",
              customWidget: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "385.00",
                      style: TextStyle(

                        color: Color(0xFFFF0606), // 🔵 Blue
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DetailRow(
              label: "Irradiation",
              customWidget: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "0.00",
                      style: TextStyle(
                        color: Color(0xFF117A7A), // 🔵 Blue
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DetailRow(
isLast: true,
              label: "Total Amount",
              customWidget: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "1130.0",
                      style: TextStyle(
                        color: Color(0xFF107500), // 🔵 Blue
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTotalCost() {
    return CustomExpansionFrame(
      title: 'Total Cost',
      children: [
        TotalCostSection(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildNotes(String title, String subtitle) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
              text: "$title - ",
              style: TextStyle(
                color: Color(0xFF1E1E1E), // 🔵 Blue
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),

            TextSpan(
              text: "$subtitle",
              style: TextStyle(
                color: Color(0xFF1E1E1E), // 🔵 Blue
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadio(bool isChecked, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isChecked ? Color(0xFF117A7A) : Colors.grey.shade400,
            width: 1.5,
          ),
          color: isChecked ? Color(0xFF117A7A) : Colors.transparent,
        ),
        child: isChecked
            ? const Icon(Icons.check, size: 14, color: Colors.white)
            : null,
      ),
    );
  }

  Widget _buildInnerTextField(String value) {
    return Container(
      height: 38,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: TextEditingController(text: value),
        style: const TextStyle(fontSize: 11, color: Colors.black87),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildInnerDropdown(
    String value,
    List<String> items,
    Function(String) onChanged,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 38,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            onSelected: (v) {
              onChanged(v);
            },
            offset: const Offset(0, 38),
            color: Colors.white,
            elevation: 0,
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 11,
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
                  (item) => PopupMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 11,
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

  void _openShowDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          BloodRequestModal(patientName: widget.patientName, crn: widget.crn),
    );
  }
}

class BloodRequestModal extends StatefulWidget {
  final String patientName;
  final String crn;

  const BloodRequestModal({super.key, this.patientName = "", this.crn = ""});

  @override
  State<BloodRequestModal> createState() => _BloodRequestModalState();
}

class _BloodRequestModalState extends State<BloodRequestModal> {
  String? _selectedDepartment = "Cardiology";
  final TextEditingController _indicationCtrl = TextEditingController();
  final TextEditingController _pastTxHistoryCtrl = TextEditingController();
  final TextEditingController _remarksCtrl = TextEditingController();
  final TextEditingController _provisionalDiagnosisCtrl =
      TextEditingController();
  final TextEditingController _finalDiagnosisCtrl = TextEditingController();

  @override
  void dispose() {
    _indicationCtrl.dispose();
    _pastTxHistoryCtrl.dispose();
    _remarksCtrl.dispose();
    _provisionalDiagnosisCtrl.dispose();
    _finalDiagnosisCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Header Row with Title and Close Icon
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Blood Request",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.black87),
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),

            // Scrollable Content matching Blood Request.png exactly
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Department Dropdown
                    _buildLabelWithStar("Department"),
                    const SizedBox(height: 8),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Container(
                          height: 48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: PopupMenuButton<String>(
                            onSelected: (val) =>
                                setState(() => _selectedDepartment = val),
                            offset: const Offset(0, 48),
                            color: Colors.white,
                            elevation: 0,
                            constraints: BoxConstraints(
                              minWidth: constraints.maxWidth,
                              maxWidth: constraints.maxWidth,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedDepartment ?? "--Select--",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            itemBuilder: (context) =>
                                ["Cardiology", "Neurology", "Orthopedics"].map((
                                  String item,
                                ) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Ward No / Type
                    _buildLabel("Ward No / Type"),
                    const SizedBox(height: 8),
                    _buildDisabledFieldLarge(
                      "1703 Endocrinology Transgender A04 /\nNursing Station",
                    ),
                    const SizedBox(height: 16),

                    // Bed No & Type
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Bed No"),
                              const SizedBox(height: 8),
                              _buildDisabledField("5"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Type"),
                              const SizedBox(height: 8),
                              _buildDisabledField("General"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Admission Date & Blood Group
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Admission Date"),
                              const SizedBox(height: 8),
                              _buildDisabledField("10-10-2025"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Blood Group"),
                              const SizedBox(height: 8),
                              _buildDisabledField("AB+"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Indication for Tx
                    _buildLabel("Indication for Tx"),
                    const SizedBox(height: 8),
                    SharedComponents.buildTextField(
                      controller: _indicationCtrl,
                      hintText: "Indication for Tx",
                      height: 48,
                    ),
                    const SizedBox(height: 16),

                    // Past Tx History
                    _buildLabel("Past Tx History"),
                    const SizedBox(height: 8),
                    SharedComponents.buildTextField(
                      controller: _pastTxHistoryCtrl,
                      hintText: "Past Tx History",
                      height: 48,
                    ),
                    const SizedBox(height: 16),

                    // Remarks (TextArea with Group 3 icon)
                    _buildLabel("Remarks"),
                    const SizedBox(height: 8),


                    SharedComponents.buildTextField(hintText:'Remarks' ,controller: _remarksCtrl,maxLines: 5),
                    const SizedBox(height: 16),

                    // --- DIAGNOSIS DETAILS SECTION (Matching Diagnosis Details.png) ---
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          initiallyExpanded:
                              false, // Default collapsed per first image
                          title: const Text(
                            "Diagnosis Details",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildLabel("Provisional Diagnosis"),
                                  const SizedBox(height: 8),

                                  SharedComponents.buildTextField(hintText:'Provisional Diagnosis' ,controller: _provisionalDiagnosisCtrl,maxLines: 5),
                                  const SizedBox(height: 16),
                                  _buildLabel("Final Diagnosis"),
                                  const SizedBox(height: 8),


                                  SharedComponents.buildTextField(hintText:'Final Diagnosis' ,controller: _finalDiagnosisCtrl,maxLines: 5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // HB & Platelet Count
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("HB"),
                              const SizedBox(height: 8),
                              _buildDisabledField("12", suffix: "g/dL"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Platelet Count"),
                              const SizedBox(height: 8),
                              _buildDisabledField(
                                "10000",
                                suffix: "*1000/microL",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Replacement Count & Issue Count
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Replacement Count"),
                              const SizedBox(height: 8),
                              _buildDisabledField("0"),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLabel("Issue Count"),
                              const SizedBox(height: 8),
                              _buildDisabledField("0"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builders to match the exact styling of the mockups

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
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildDisabledField(String value, {String? suffix}) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6), // Correct grey from mockups
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (suffix != null)
            Text(
              suffix,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
        ],
      ),
    );
  }

  Widget _buildDisabledFieldLarge(String value) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.all(12),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        value,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
      ),
    );
  }


}
