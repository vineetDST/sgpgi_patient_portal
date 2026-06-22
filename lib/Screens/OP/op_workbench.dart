import 'package:flutter/material.dart';

// ================= REQUIRED IMPORTS =================
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

// Shell & Routing
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Screens/OP/op_consultation.dart';

class OpWorkbench extends StatefulWidget {
  final String patientName;
  final String crn;

  const OpWorkbench({super.key, required this.patientName, required this.crn});

  @override
  State<OpWorkbench> createState() => _OpWorkbenchState();
}

class PatientData {
  final String name;
  final String crn;

  PatientData({required this.name, required this.crn});

  @override
  String toString() {
    return '$name - $crn';
  }
}

class _OpWorkbenchState extends State<OpWorkbench> {
  final List<PatientData> patientList = [
    PatientData(name: "Ram Sharma", crn: "20251000438"),
    PatientData(name: "Chandra Bhan", crn: "20251000465"),
    PatientData(name: "Gautem Kumar", crn: "20251000487"),
    PatientData(name: "John Michael", crn: "20251000547"),
    PatientData(name: "Peter", crn: "20251000146"),
  ];
  List<Map<String, dynamic>> _patients = [
    {"name": "Anil Srivastava", "crn": "20251000438", "selected": true},
    {"name": "Chandra Bhan", "crn": "20251000465", "selected": false},
    {"name": "Gautem Kumar", "crn": "20251000487", "selected": false},
    {"name": "John Michael", "crn": "20251000547", "selected": false},
    {"name": "Chandra Bhan", "crn": "20251000465", "selected": false},
    {"name": "Gautem Kumar", "crn": "20251000487", "selected": false},
    {"name": "John Michael", "crn": "20251000547", "selected": false},
    {"name": "Peter", "crn": "20251000146", "selected": false},
  ];
  int _selectedRowIndex = 0;

  String _searchQuery = "";
  List<Map<String, dynamic>> get _filteredAdmittedPatients {
    if (_searchQuery.isEmpty) {
      return _patients;
    }
    return _patients.where((patient) {
      final name = patient["name"].toString().toLowerCase();
      final crn = patient["crn"].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();

      // Name ya CRN kisi mein bhi match ho toh true return karega
      return name.contains(query) || crn.contains(query);
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    TextEditingController _controller = TextEditingController();
    FocusNode _focusNode = FocusNode();
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: OpAppbar(
        appheight: true,
        title: "OutPatient",
        onLeadingPressed: () {
          doctorShellScaffoldKey.currentState?.openDrawer();
        },
      ),
      extendBody: true,
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16,   0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              _buildTopSection(),

              const SizedBox(height: 16),
              Text(
                'Search',
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColor.color1E1E1E,
                ),
              ),
              const SizedBox(height: 8),





              const SizedBox(height: 24),


              SharedComponents.buildTextField(
                hintText: 'Search by CR No./ Patient name',
                suffix: const Icon(
                Icons.search,
                color: Colors.grey,
                 ) ,
                onChanged: (value) {
                  // 🔥 हर एक की-स्ट्रोक पर स्टेट अपडेट होगी और लिस्ट फ़िल्टर होगी
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              _buildAdmittedTable(),
              const SizedBox(height: 124),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets (UNCHANGED BELOW) ---

  Widget _buildAdmittedTable() {
    if (_filteredAdmittedPatients.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("No patient found"),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 50,
                  color: const Color(0xFFEAF9F9),
                  alignment: Alignment.center,
                  child: const Text(
                    "Select",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
                Container(width: 1, height: 50, color: Colors.grey.shade300),
                Expanded(
                  child: Container(
                    height: 50,
                    color: const Color(0xFFEAF9F9),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Patient Name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Icon(Icons.unfold_more, size: 16),
                      ],
                    ),
                  ),
                ),
                Container(width: 1, height: 50, color: Colors.grey.shade300),
                Expanded(
                  child: Container(
                    height: 50,
                    color: const Color(0xFFEAF9F9),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "CRN Number",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Icon(Icons.unfold_more, size: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ..._filteredAdmittedPatients
                .map(
                  (row) => Column(
                children: [
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade300,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              for (var patient in _patients) {
                                patient["selected"] = false;
                              }
                              row["selected"] = true;
                            });
                          },
                          child: Container(
                            width: 60,
                            alignment: Alignment.center,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200), // स्मूथ ट्रांजिशन के लिए
                              height: 20,
                              width: 20,
                              padding: const EdgeInsets.all(3.5), // ये पैडिंग बीच के व्हाइट गैप को कंट्रोल करेगी
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // सिलेक्ट होने पर बाहरी बॉर्डर ग्रीन होगा, अनसिलेक्ट होने पर ग्रे
                                border: Border.all(
                                  color: row['selected'] == true ? const Color(0xFF117A7A) : Colors.grey.shade400,
                                  width: 2,
                                ),
                                // बाहरी सर्कल का बैकग्राउंड कलर हमेशा व्हाइट रहेगा
                                color: Colors.white,
                              ),
                              child: row['selected'] == true
                                  ? Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF117A7A), // सिलेक्ट होने पर अंदर का छोटा डॉट ग्रीन होगा
                                ),
                              )
                                  : null, // अनसिलेक्ट होने पर अंदर कुछ नहीं दिखेगा (सिर्फ़ खाली ग्रे बॉर्डर वाला सर्कल)
                            ),
                          ),
                        ),

                        Container(width: 1, color: Colors.grey.shade300),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              print("Patient Name : ${row["name"]}");

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OpConsultation(patientName: row["name"], crn: row["crn"]),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              child: Text(
                                row["name"] as String,
                                style: const TextStyle(
                                  color: Color(0xFF117A7A),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(width: 1, color: Colors.grey.shade300),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            child: Text(
                              row["crn"] as String,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
                .toList(),
          ],
        ),
      ),
    );
  }
  Widget _buildTopSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'OutPatient',
          style: AppTextStyles.RegH3.copyWith(
            fontSize: 18,
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
                patientName: patientList[_selectedRowIndex].name,
                crn: patientList[_selectedRowIndex].crn,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.color1E1E1E,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          ),
          child: Text(
            'Action',
            style: AppTextStyles.RegH3.copyWith(color: AppColor.white),
          ),
        ),
      ],
    );
  }

  Widget headerCell(
    String title,
    int flex, {
    bool showSort = false,
    bool lastCell = false,
    VoidCallback? onTap,
  }) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
          decoration: BoxDecoration(
            border: Border(
              right: lastCell
                  ? BorderSide.none
                  : const BorderSide(color: AppColor.colorB7B7B7, width: 1.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: flex == 1
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.RegH3.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (showSort) ...[
                const SizedBox(width: 5),
                const Icon(
                  Icons.unfold_more,
                  size: 16,
                  color: AppColor.color717171,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRow(
    int index,
    String name,
    String crn, {
    bool isSelected = false,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedRowIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          border: const Border(
            left: BorderSide(color: AppColor.colorB7B7B7, width: 1.0),
            right: BorderSide(color: AppColor.colorB7B7B7, width: 1.0),
            bottom: BorderSide(color: AppColor.colorB7B7B7, width: 1.0),
          ),
          borderRadius: isLast
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                )
              : BorderRadius.zero,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(color: AppColor.colorB7B7B7, width: 1.0),
                  ),
                ),
                child: Center(
                  child: Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColor.color117A7A
                            : AppColor.colorB7B7B7,
                        width: isSelected ? 2 : 1.5,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                color: AppColor.color117A7A,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
            dataCell(
              name,
              2,
              isName: true,
              isSelected: isSelected,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OpConsultation(patientName: name, crn: crn),
                  ),
                );
              },
            ),
            dataCell(crn, 2, isName: false),
          ],
        ),
      ),
    );
  }

  Widget dataCell(
    String text,
    int flex, {
    bool isName = false,
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
              right: BorderSide(color: AppColor.colorB7B7B7, width: 1.0),
            ),
          ),
          child: Text(
            text,
            style: AppTextStyles.RegH3.copyWith(
              color: isName ? AppColor.color117A7A : AppColor.color1E1E1E,
              fontWeight: isName ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
