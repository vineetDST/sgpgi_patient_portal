import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qc_hospital/Core/Utils/Drawer/drawer.dart';
import 'package:qc_hospital/Core/Utils/Header/custom_header.dart';
import 'package:qc_hospital/Screens/OP/op_workbench.dart'; // Your OP Consultant/Workbench screen
import 'package:qc_hospital/Screens/OP/search_profile_screen.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart'; // The profile screen

class Workbench extends StatefulWidget {
  const Workbench({super.key});

  @override
  State<Workbench> createState() => _WorkbenchState();
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

class _WorkbenchState extends State<Workbench> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // The provided list of patients
  final List<PatientData> patients = [
    PatientData(name: "Ram Sharma", crn: "20251000438"),
    PatientData(name: "Chandra Bhan", crn: "20251000465"),
    PatientData(name: "Gautem Kumar", crn: "20251000487"),
    PatientData(name: "John Michael", crn: "20251000547"),
    PatientData(name: "Peter", crn: "20251000146"),
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      drawer: AppWidgets.commonDrawer(context),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          DynamicHeader(
            title: "Search by CRN",
            isDrawer: true,
            onLeadingPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),

          // Autocomplete Search Bar
          Transform.translate(
            offset: const Offset(0, -30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Autocomplete<PatientData>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<PatientData>.empty();
                  }
                  return patients.where((PatientData option) {
                    return option.crn.contains(textEditingValue.text) ||
                        option.name.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        );
                  });
                },
                displayStringForOption: (PatientData option) => option.crn,
                onSelected: (PatientData selection) {
                  // --- ROUTE 1: Search -> Search Profile Screen ---
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchProfileScreen(
                        patientName: selection.name,
                        crn: selection.crn,
                      ),
                    ),
                  );
                },
                fieldViewBuilder:
                    (context, controller, focusNode, onFieldSubmitted) {
                      return Material(
                        elevation: 4,
                        shadowColor: Colors.black26,
                        borderRadius: BorderRadius.circular(8),
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintText: "Search by CRN Number",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        ),
                      );
                    },
                optionsViewBuilder: (context, onSelected, options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40,
                        constraints: const BoxConstraints(maxHeight: 200),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final PatientData option = options.elementAt(index);
                            return ListTile(
                              leading: const Icon(
                                Icons.person_search,
                                color: Color(0xFF117A7A),
                              ),
                              title: Text(
                                option.crn,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(option.name),
                              onTap: () => onSelected(option),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Center Logo and Generic Cards
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Image.asset(
                  "assets/op_ip_workbench_logo_3.png",
                  height: height * 0.2,
                ),
                SizedBox(height: height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginOptionCard(
                        title: "OP Workbench",
                        image: "op_workbench",
                        onTap: () {
                          // Safely switches to Tab 1 without pushing a new screen over the footer
                          doctorShellKey.currentState?.changeTab(1);
                        },
                      ),
                      SizedBox(height: height * 0.03),

                      LoginOptionCard(
                        title: "IP Workbench",
                        image: "ip_workbench",
                        onTap: () {
                          // Safely switches to Tab 2
                          doctorShellKey.currentState?.changeTab(2);
                        },
                      ),
                      SizedBox(height: height * 0.2),

                      // LoginOptionCard(
                      //   title: "OP Workbench",
                      //   image: "ip_workbench",
                      //   onTap: () {
                      //     // --- ROUTE 2: Generic OP Workbench Entry ---
                      //     // You can pass empty strings or make them optional in OpWorkbench
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) =>
                      //             const OpWorkbench(patientName: "", crn: ""),
                      //       ),
                      //     );
                      //   },
                      // ),
                      // SizedBox(height: height * 0.03),
                      // LoginOptionCard(
                      //   title: "IP Workbench",
                      //   image: "ip_workbench",
                      //   onTap: () {},
                      // ),
                      // SizedBox(height: height * 0.2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Ensure this component is available for the buttons
class LoginOptionCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const LoginOptionCard({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(0, 0),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFBEE9E8), Color(0xFFC7F9CC)],
                ),
              ),
              child: SvgPicture.asset(
                "assets/$image.svg",
                height: MediaQuery.of(context).size.height * 0.03,
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(strokeWidth: 1),
              ),
            ),
            const SizedBox(width: 20),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.02,
                  color: const Color(0xFF1E1E1E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
