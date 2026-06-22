import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Check_Radio_Button/check_box.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// Import detail screens
// import 'systemic_detail_screens.dart'; // We will group the detail screens in one file for cleanliness
import 'package:qc_hospital/Screens/OP/examinations/systemic_detail_screens.dart';

class SystemicExaminationScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const SystemicExaminationScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<SystemicExaminationScreen> createState() =>
      _SystemicExaminationScreenState();
}

class _SystemicExaminationScreenState extends State<SystemicExaminationScreen> {
  int _bottomNavIndex = 1;

  final List<String> systems = [
    "Nervous System",
    "Respiratory System",
    "Circulatory System",
    "Digestive System",
    "Endocrine System",
    "Immune System",
    "Musculoskeletal System",
    "Urinary / Reproductive System",
    "Eye",
  ];

  bool? _action_a = false;
  bool? _action_b = false;
  bool? _action_c = false;
  bool? _action_d = false;
  bool? _action_e = false;
  bool? _action_f = false;
  bool? _action_g = false;
  bool? _action_h = false;
  bool? _action_i = false;

  // Store checkbox states
  Map<String, bool> nadStates = {};

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Systemic Examinations",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Systemic Examinations',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Systematic Examination",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Horizontally Scrollable Matrix
          _buildSystemicMatrix(context),
          const SizedBox(height: 32),

          SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20),
        ],
      ),

      // bottomNavigationBar: CustomCurvedNavigationBar(
      //   index: _bottomNavIndex,
      //   height: 75.0,
      //   items: const <Widget>[
      //     Icon(Icons.home_filled, size: 26, color: Colors.white),
      //     Icon(Icons.medical_services, size: 26, color: Colors.white),
      //     Icon(Icons.add_business_outlined, size: 26, color: Colors.white),
      //     Icon(Icons.notifications, size: 26, color: Colors.white),
      //   ],
      //   color: AppColor.white,
      //   buttonBackgroundColor: AppColor.color117A7A,
      //   backgroundColor: Colors.transparent,
      //   onTap: (index) => setState(() => _bottomNavIndex = index),
      // ),
    );
  }

  Widget _buildSystemicMatrix(BuildContext context) {
    const double rowHeight = 65.0;
    const double leftWidth = 140.0;
    const double colWidth = 200.0;

    // return Container(
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(8),
    //     border: Border.all(color: Colors.grey.shade300),
    //   ),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // Fixed Left Column
    //       Container(
    //         width: leftWidth,
    //         decoration: BoxDecoration(
    //           color: const Color(0xFFEAF9F9),
    //           borderRadius: const BorderRadius.only(
    //             topLeft: Radius.circular(8),
    //             bottomLeft: Radius.circular(8),
    //           ),
    //           border: Border(right: BorderSide(color: Colors.grey.shade300)),
    //         ),
    //         child: Column(
    //           children: [
    //             _buildLeftCell("Systems", rowHeight),
    //             _buildDivider(),
    //             _buildLeftCell("NAD", rowHeight),
    //             _buildDivider(),
    //             _buildLeftCell("Findings", rowHeight),
    //             _buildDivider(),
    //             _buildLeftCell("Full Examination", rowHeight),
    //           ],
    //         ),
    //       ),
    //       // Scrollable Right Area
    //       Expanded(
    //         child: SingleChildScrollView(
    //           scrollDirection: Axis.horizontal,
    //           child: Row(
    //             children: systems.map((sys) {
    //               return Container(
    //                 width: colWidth,
    //                 decoration: BoxDecoration(
    //                   border: Border(
    //                     right: BorderSide(color: Colors.grey.shade300),
    //                   ),
    //                 ),
    //                 child: Column(
    //                   children: [
    //                     _buildRightTextCell(sys, rowHeight),
    //                     _buildDivider(),
    //                     _buildRightCheckboxCell(sys, rowHeight),
    //                     _buildDivider(),
    //                     CustomRemarksField(
    //                       title: "Findings",
    //                       hintText: "",
    //                       onChanged: (value) {
    //                         print("User ne type kiya: $value");
    //                         // Yahan aap value ko apne API model ya variables me save kar sakte hain
    //                       },
    //                     ),
    //                     _buildDivider(),
    //                     _buildRightDetailsCell(sys, rowHeight, context),
    //                   ],
    //                 ),
    //               );
    //             }).toList(),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    return ScrollableDataTable(
      labels: ['Systems', 'NAD', 'Finding', 'Full Examination'],
      rowValues: [
        [
          const TableText('Nervous System'),
          const TableText('Respiratory System'),
          const TableText('Circulatory System'),
          const TableText('Digestive System'),
          const TableText('Endicrine System'),
          const TableText('Immune System'),
          const TableText('Muscloskeletel System'),
          const TableText('Unary/Reproductive System'),
          const TableText('Eye'),
        ],

        [
          GlobalCheckbox(
            label:
                '', // Label blank hai kyunki hum text par alag action chahte hain
            value: _action_a ?? false,
            onChanged: (bool newValue) {
              setState(() {
                _action_a = newValue; // Checkbox ka state update
              });
            },
          ),
          GlobalCheckbox(
            label:
                '', // Label blank hai kyunki hum text par alag action chahte hain
            value: _action_b ?? false,
            onChanged: (bool newValue) {
              setState(() {
                _action_b = newValue; // Checkbox ka state update
              });
            },
          ),
          GlobalCheckbox(
            label:
                '', // Label blank hai kyunki hum text par alag action chahte hain
            value: _action_c ?? false,
            onChanged: (bool newValue) {
              setState(() {
                _action_c = newValue; // Checkbox ka state update
              });
            },
          ),
          GlobalCheckbox(
            label:
                '', // Label blank hai kyunki hum text par alag action chahte hain
            value: _action_d ?? false,
            onChanged: (bool newValue) {
              setState(() {
                _action_d = newValue; // Checkbox ka state update
              });
            },
          ),
          GlobalCheckbox(
            label:
                '', // Label blank hai kyunki hum text par alag action chahte hain
            value: _action_e ?? false,
            onChanged: (bool newValue) {
              setState(() {
                _action_e = newValue; // Checkbox ka state update
              });
            },
          ),
          GlobalCheckbox(
            label:
                '', // Label blank hai kyunki hum text par alag action chahte hain
            value: _action_f ?? false,
            onChanged: (bool newValue) {
              setState(() {
                _action_f = newValue; // Checkbox ka state update
              });
            },
          ),
          GlobalCheckbox(
            label:
                '', // Label blank hai kyunki hum text par alag action chahte hain
            value: _action_g ?? false,
            onChanged: (bool newValue) {
              setState(() {
                _action_g = newValue; // Checkbox ka state update
              });
            },
          ),
          GlobalCheckbox(
            label:
                '', // Label blank hai kyunki hum text par alag action chahte hain
            value: _action_h ?? false,
            onChanged: (bool newValue) {
              setState(() {
                _action_h = newValue; // Checkbox ka state update
              });
            },
          ),
          GlobalCheckbox(
            label:
                '', // Label blank hai kyunki hum text par alag action chahte hain
            value: _action_i ?? false,
            onChanged: (bool newValue) {
              setState(() {
                _action_i = newValue; // Checkbox ka state update
              });
            },
          ),
        ],

        [
          CustomRemarksField(
            title: "Findings",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Findings",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Findings",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Findings",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Findings",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Findings",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Findings",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Findings",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
          CustomRemarksField(
            title: "Findings",
            hintText: "",
            onChanged: (value) {
              print("User ne type kiya: $value");
              // Yahan aap value ko apne API model ya variables me save kar sakte hain
            },
          ),
        ],
        [
          _buildRightDetailsCell('Nervous System', rowHeight, context),
          _buildRightDetailsCell('Respiratory System', rowHeight, context),
          _buildRightDetailsCell('Circulatory System', rowHeight, context),
          _buildRightDetailsCell('Digestive System', rowHeight, context),
          _buildRightDetailsCell('Endocrine System', rowHeight, context),
          _buildRightDetailsCell('Immune System', rowHeight, context),
          _buildRightDetailsCell('Musculoskeletal System', rowHeight, context),
          _buildRightDetailsCell(
            'Urinary / Reproductive System',
            rowHeight,
            context,
          ),
          _buildRightDetailsCell('Eye', rowHeight, context),
        ],
      ],
    );
  }

  Widget _buildLeftCell(String text, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildRightTextCell(String text, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.black87),
      ),
    );
  }

  Widget _buildRightCheckboxCell(String sys, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 20,
        width: 20,
        child: Checkbox(
          value: nadStates[sys] ?? false,
          activeColor: const Color(0xFF117A7A),
          side: BorderSide(color: Colors.grey.shade400),
          onChanged: (val) => setState(() => nadStates[sys] = val!),
        ),
      ),
    );
  }

  // Widget _buildRightTextFieldCell(double height) {
  //   return Container(
  //     height: height,
  //     alignment: Alignment.center,
  //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(8),
  //         border: Border.all(color: Colors.grey.shade300),
  //       ),
  //       child: const TextField(
  //         decoration: InputDecoration(
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildRightTextFieldCell(double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: const TextField(
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(fontSize: 13, height: 1.2),
          decoration: InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildRightDetailsCell(
    String sys,
    double height,
    BuildContext context,
  ) {
    return InkWell(
      onTap: () {
        // Route to the specific screen based on the system name
        Widget nextScreen;
        if (sys == "Nervous System")
          nextScreen = NervousSystemScreen(
            patientName: widget.patientName,
            crn: widget.crn,
          );
        else if (sys == "Respiratory System")
          nextScreen = RespiratorySystemScreen(
            patientName: widget.patientName,
            crn: widget.crn,
          );
        else if (sys == "Circulatory System")
          nextScreen = CirculatorySystemScreen(
            patientName: widget.patientName,
            crn: widget.crn,
          );
        else if (sys == "Digestive System")
          nextScreen = DigestiveSystemScreen(
            patientName: widget.patientName,
            crn: widget.crn,
          );
        else if (sys == "Endocrine System")
          nextScreen = EndocrineSystemScreen(
            patientName: widget.patientName,
            crn: widget.crn,
          );
        else if (sys == "Immune System")
          nextScreen = ImmuneSystemScreen(
            patientName: widget.patientName,
            crn: widget.crn,
          );
        else if (sys == "Musculoskeletal System")
          nextScreen = MusculoskeletalSystemScreen(
            patientName: widget.patientName,
            crn: widget.crn,
          );
        else if (sys == "Urinary / Reproductive System")
          nextScreen = ReproductiveSystemScreen(
            patientName: widget.patientName,
            crn: widget.crn,
          );
        else if (sys == "Eye")
          nextScreen = EyeSystemScreen(
            patientName: widget.patientName,
            crn: widget.crn,
          ); // NEW ROUTE
        else
          nextScreen = NervousSystemScreen(
            patientName: widget.patientName,
            crn: widget.crn,
          );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
        );
      },
      child: Container(
        height: height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: const Text(
          "Details",
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF117A7A),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);
}
