import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class ClinicalSummaryScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ClinicalSummaryScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ClinicalSummaryScreen> createState() => _ClinicalSummaryScreenState();
}

class _ClinicalSummaryScreenState extends State<ClinicalSummaryScreen> {
  // Clinical Notes Controller
  final TextEditingController _clinicalNotesCtrl = TextEditingController();

  // Provisional Diagnosis States & Controllers
  String? _provIcdCodeRadio = 'Cardiology'; // Default matching the image
  final TextEditingController _provSearchCtrl = TextEditingController();
  final TextEditingController _provIcdCtrl = TextEditingController();
  final TextEditingController _provDeptCtrl = TextEditingController();
  final TextEditingController _provDescCtrl = TextEditingController();

  // Final Diagnosis States & Controllers
  String? _finalIcdCodeRadio = 'Cardiology'; // Default matching the image
  final TextEditingController _finalSearchCtrl = TextEditingController();
  final TextEditingController _finalIcdCtrl = TextEditingController();
  final TextEditingController _finalDeptCtrl = TextEditingController();
  final TextEditingController _finalDescCtrl = TextEditingController();

  List<Map<String, dynamic>> diagnosisList = [
    {
      "name": "Infections of kidney in pregnancy, unspecified trimester",
      "code": "ICD-10 : O23.00",
      "isSelected": false,
    },
    {
      "name": "Infections of kidney in pregnancy, second trimester",
      "code": "ICD-10 : O23.02",
      "isSelected": false,
    },
    {
      "name": "Infections of bladder in pregnancy, unspecified trimester",
      "code": "ICD-10 : O23.10",
      "isSelected": false,
    },
  ];

  void _updateTextField() {
    List<String> selectedNames = diagnosisList
        .where((item) => item['isSelected'] == true)
        .map((item) => item['name'] as String)
        .toList();

    _finalSearchCtrl.text = selectedNames.join(
      ', ',
    ); // Join multiple selections with a comma
  }

  @override
  void dispose() {
    _clinicalNotesCtrl.dispose();
    _provSearchCtrl.dispose();
    _provIcdCtrl.dispose();
    _provDeptCtrl.dispose();
    _provDescCtrl.dispose();
    _finalSearchCtrl.dispose();
    _finalIcdCtrl.dispose();
    _finalDeptCtrl.dispose();
    _finalDescCtrl.dispose();
    super.dispose();
  }

  bool _isDiagnosisListVisible = false;

  List _diagnosis = [
    {
      'isCheck': false,
      'title': 'Infection of kidney in pregnency,unspecified trimister',
      'subtitle': 'ICD-10 : 023.00',
    },
    {
      'isCheck': false,
      'title': 'Infection of kidney in pregnency,second trimister',
      'subtitle': 'ICD-10 : 023.00',
    },
    {
      'isCheck': false,
      'title': 'Infection of bladder in pregnency,unspecified trimister',
      'subtitle': 'ICD-10 : 023.00',
    },
    {
      'isCheck': false,
      'title': 'Infection of bladder in pregnency,second trimister',
      'subtitle': 'ICD-10 : 023.00',
    },
    {
      'isCheck': false,
      'title': 'Infection of uthera in pregnency,unspecified trimister',
      'subtitle': 'ICD-10 : 023.00',
    },
  ];

  bool _isIcdListVisible = false; // Toggle variable

  // Image ke basis par dummy data
  final List<Map<String, String>> _icdCodesList = [
    {
      'code': 'R00.1',
      'desc': 'R00.1 : ABNORMALITIES OF HEART BEAT: Bradycardia, unspecified',
    },
    {
      'code': 'R00.8',
      'desc':
          'R00.8 : ABNORMALITIES OF HEART BEAT: Other and unspecified abnormalities of heart beat',
    },
    {
      'code': 'Q22.0',
      'desc':
          'Q22.0: CONGENITAL MALFORMATIONS OF PULMONARY AND TRICUSPID VALVES: Pulmonary valve atresia',
    },
    {
      'code': 'Q22.2',
      'desc':
          'Q22.2: CONGENITAL MALFORMATIONS OF PULMONARY AND TRICUSPID VALVES: Pulmonary valve insufficiency',
    },
    {
      'code': 'Q22.4',
      'desc':
          'Q22.4: CONGENITAL MALFORMATIONS OF PULMONARY AND TRICUSPID VALVES: Congenital tricuspid stenosis',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ClinicalBaseScaffold(
      title: "Clinical Summary",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Clinical Summary',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Clinical Summary",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useRootNavigator: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => OpActionBottomSheet(
                      patientName: widget.patientName,
                      crn: widget.crn,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.color1E1E1E,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                ),
                child: Text(
                  'Action',
                  style: AppTextStyles.RegH3.copyWith(color: AppColor.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // --- UPDATED: Clinical Notes Text Area with Custom Icon ---
          SharedComponents.buildFormLabel("Clinical Notes"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _clinicalNotesCtrl,
            hintText: "Clinical Notes",
            maxLines: 5,

          ),
          const SizedBox(height: 16),

          // Provisional Diagnosis Expandable Section
          _buildDiagnosisSection(
            title: "Provisional Diagnosis",
            requiredIcon: true,
            icdRadioValue: _provIcdCodeRadio,
            onIcdRadioChanged: (val) => setState(() => _provIcdCodeRadio = val),
            searchCtrl: _provSearchCtrl,
            icdCtrl: _provIcdCtrl,
            deptCtrl: _provDeptCtrl,
            descCtrl: _provDescCtrl,
            icdHint: "%",
          ),
          const SizedBox(height: 16),

          // Final Diagnosis Expandable Section
          _buildDiagnosisSection(
            title: "Final Diagnosis",
            icdRadioValue: _finalIcdCodeRadio,
            onIcdRadioChanged: (val) =>
                setState(() => _finalIcdCodeRadio = val),
            searchCtrl: _finalSearchCtrl,
            icdCtrl: _finalIcdCtrl,
            deptCtrl: _finalDeptCtrl,
            descCtrl: _finalDescCtrl,
            icdHint: "",
          ),
          const SizedBox(height: 32),

          SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20), // Bottom nav padding
        ],
      ),
    );
  }

  // --- REUSABLE HELPER WIDGET FOR DIAGNOSIS SECTIONS ---
  Widget _buildDiagnosisSection({
    required String title,
    bool? requiredIcon,
    required String? icdRadioValue,
    required ValueChanged<String?> onIcdRadioChanged,
    required TextEditingController searchCtrl,
    required TextEditingController icdCtrl,
    required TextEditingController deptCtrl,
    required TextEditingController descCtrl,
    required String icdHint,
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
          initiallyExpanded: true,
          title: RichText(
            text: TextSpan(
              text: title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              children: requiredIcon == true
                  ? const [
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: Colors.red),
                      ),
                    ]
                  : [],
            ),
          ),

          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Add Diagnosis ',
                      style: TextStyle(fontSize: 14, color: Colors.black87),

                      children: [],
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_isDiagnosisListVisible)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      padding: const EdgeInsets.all(8.0),
                      // ListView.builder taaki list dynamically render ho
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap:
                            true, // Column ke andar ListView use karne ke liye zaroori hai
                        physics:
                            const NeverScrollableScrollPhysics(), // Scroll list tile ki jagah parent page se hoga
                        itemCount: _diagnosis.length,
                        itemBuilder: (context, index) {
                          final item = _diagnosis[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10.0,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment
                                  .start, // Checkbox aur text upar se align ho
                              children: [
                                // 1. Aapka Custom Checkbox
                                GlobalCheckbox(
                                  label:
                                      '', // Agar aapke GlobalCheckbox me text nahi dikhana yahan, toh empty chhod dein
                                  value: item['isCheck'],
                                  onChanged: (bool isSelected) {
                                    setState(() {
                                      // Map ki value update kar rahe hain
                                      _diagnosis[index]['isCheck'] = isSelected;
                                    });
                                  },
                                ),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      Text(
                                        item['title'],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          height: 1.3,
                                        ),
                                      ),
                                      const SizedBox(height: 4),

                                      // Subtitle (ICD Code)
                                      Text(
                                        item['subtitle'],
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  else
                    Container(
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: searchCtrl,
                        readOnly:
                            true, // IMPORTANT: Prevents keyboard from showing
                        onTap: () {
                          // TEXTFIELD PAR CLICK HONE PAR STATE CHANGE HOGI
                          setState(() {
                            _isDiagnosisListVisible = true;
                          });
                          // Aap apna purana dialog wala function bhi call kar sakte hain agar chahiye toh:
                          // _showDiagnosisDialog();
                        },
                        style: const TextStyle(fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: "--Search--",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.search, color: Colors.grey),
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // ICD Code Row (Label + Radios)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // const Text(
                      //   "ICD Code for",
                      //   style: TextStyle(fontSize: 14, color: Colors.black87),
                      // ),
                      RichText(
                        text: const TextSpan(
                          text: "ICD Code for ",
                          style: TextStyle(fontSize: 14, color: Colors.black87),

                          children: [],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<String>(
                            value: "All",
                            groupValue: icdRadioValue,
                            activeColor: const Color(0xFF117A7A),
                            visualDensity: VisualDensity.compact,
                            onChanged: onIcdRadioChanged,
                          ),
                          const Text(
                            "All",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Radio<String>(
                            value: "Cardiology",
                            groupValue: icdRadioValue,
                            activeColor: const Color(0xFF117A7A),
                            visualDensity: VisualDensity.compact,
                            onChanged: onIcdRadioChanged,
                          ),
                          const Text(
                            "Cardiology",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (_isIcdListVisible)
                    // 1. Agar True hai, toh yeh Table display hogi
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ), // Outer border
                      ),
                      // Table widget is perfect for this UI
                      child: Table(
                        columnWidths: const {
                          0: FixedColumnWidth(
                            90.0,
                          ), // Pehle column ki fix width
                          1: FlexColumnWidth(), // Doosre column ko baaki space milega
                        },
                        // Table ke andar ki lines (horizontal & vertical)
                        border: TableBorder(
                          horizontalInside: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                          verticalInside: BorderSide(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        children: _icdCodesList.map((item) {
                          return TableRow(
                            children: [
                              // Column 1: Short Code
                              InkWell(
                                // Row pe click handle karne ke liye (Optional)
                                onTap: () {
                                  // Yahan aap selection logic laga sakte hain
                                  setState(() {
                                    icdCtrl.text =
                                        item['code']!; // Textfield me value set
                                    _isIcdListVisible =
                                        false; // Table wapas hide
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20.0,
                                    horizontal: 8.0,
                                  ),
                                  child: Center(
                                    child: Text(
                                      item['code']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // Column 2: Full Description
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    icdCtrl.text = item['code']!;
                                    _isIcdListVisible = false;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    item['desc']!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    )
                  else
                    // 2. Agar False hai, toh aapka Original TextField show hoga
                    GestureDetector(
                      onTap: () {
                        // Jab bhi user textfield wale area par click kare
                        setState(() {
                          _isIcdListVisible = true;
                        });
                      },
                      // AbsorbPointer textfield ko type karne se rokega taki keyboard open na ho,
                      // aur click event GestureDetector ko pass ho jayega.
                      child: AbsorbPointer(
                        child: SharedComponents.buildTextField(
                          controller: icdCtrl,
                          hintText: icdHint,
                          height: 48,
                          // Agar aapke component me readOnly ya onTap parameter hai toh use yahan direct pass karein
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),

                  // Department Code
                  const Text(
                    "Department Code",
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(
                    controller: deptCtrl,
                    hintText: "Department Code",
                    height: 48,
                  ),
                  const SizedBox(height: 16),

                  // --- UPDATED: Diagnosis Text Area with Custom Icon ---
                  Text(
                    title,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(
                    controller: descCtrl,
                    hintText: title,
                    maxLines: 5,
                    // height: 120,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
