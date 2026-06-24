import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Tab/switching_tab.dart';

// --- Import the Base Shell to access the Master Drawer Key ---
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// --- Imports for the routed screens ---
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/clinical_history_screen.dart';
import 'package:qc_hospital/Screens/OP/clinical_summary_screen.dart';
import 'package:qc_hospital/Screens/OP/allergy/allergy_screen.dart';
import 'package:qc_hospital/Screens/OP/vital_signs/vital_signs_screen.dart';
import 'package:qc_hospital/Screens/OP/examinations/examination_screen.dart';
import 'package:qc_hospital/Screens/OP/cpoe_screen.dart';

class Dashboard extends StatefulWidget {
  final String patientName;
  final String crn;

  const Dashboard({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<Dashboard> createState() => _OpConsultationState();
}

class _OpConsultationState extends State<Dashboard> {

  int _currentTabIndex = 0;

  final List<String> _myTabs = [
    "My Visit",
    "My Appointmetns",

  ];

  final List<Widget> _tabViews = [
    MyVisit(), // Pehle tab ka content
    MyAppointmetns(),    // Doosre tab ka content
           // Teesre tab ka content
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ClinicalBaseScaffold(
      title: "Dashboard",
      showDrawer: true,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Admission',

      // ONLY pass the content that is unique to this screen
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchingTab(
            tabs: _myTabs,
            currentIndex: _currentTabIndex,
            fontSize: 16.0, // Yahan se aap globally font size customize kar sakte hain
            onTabChanged: (index) {
              setState(() {
                _currentTabIndex = index;
              });
            },
          ),
          const SizedBox(height: 16,),

          _tabViews[_currentTabIndex],

        ],
      ),
    );
  }




}

class MyVisit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('MY Visit');
  }

}
class MyAppointmetns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text('My Appointmetns');
  }

}

