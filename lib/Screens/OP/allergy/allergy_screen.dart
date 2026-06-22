import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

// Import your shared components and the new screens
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/allergy/add_allergy_screen.dart';
import 'package:qc_hospital/Screens/OP/allergy/edit_allergy_screen.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';

class AllergyScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const AllergyScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<AllergyScreen> createState() => _AllergyScreenState();
}

class _AllergyScreenState extends State<AllergyScreen> {
  int _bottomNavIndex = 1;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Allergy",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction:
          'Allergy', // Highlights this icon in the Quick Actions list
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Existing Allergy",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled:
                        true, // Allows sheet to be taller than half screen
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

          // Table for Existing Allergies
          _buildAllergyTable(context),
          const SizedBox(height: 24),

          // Add Allergy Button
          
          AppSaveButton(text: 'Add Allergy',onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddAllergyScreen(
                  patientName: widget.patientName,
                  crn: widget.crn,
                ),
              ),
            );
          },),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildAllergyTable(BuildContext context) {

    
    return ScrollableDataTable(
        labels: [
          'Visit No',
          'Allergy Category',
          'Allergic To',
          'Status',
          'Date & Time',
          'Action',
        ],
        rowValues: [
          [
             const TableText('OP-003'),
            const TableText('OP-003'),
            const TableText('OP-003'),
            const TableText('OP-003'),
          ],
          [
            const TableText('Drug'),
            const TableText('Food'),
            const TableText('Drug'),
            const TableText('Food'),
          ],
          [
            const TableText('PROPANOL OL'),
            const TableText('Gluten'),
            const TableText('PROPANOL OL'),
            const TableText('Gluten'),
          ],
          [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                decoration: BoxDecoration(
                    color: const Color(0xFFC7F9CC),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: const TableText('Active')
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                decoration: BoxDecoration(
                    color: const Color(0xFFC7F9CC),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: const TableText('Active')
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                decoration: BoxDecoration(
                    color: const Color(0xFFC7F9CC),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: const TableText('Active')
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 4),
                decoration: BoxDecoration(
                    color: const Color(0xFFC7F9CC),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: const TableText('Active')
            ),

          ],
          [
            const TableText('08-10-2025 | 13:20'),
            const TableText('14-10-2025 | 13:20'),
            const TableText('18-10-2025 | 13:20'),
            const TableText('24-10-2025 | 13:20'),
          ],
          [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAllergyScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/editicon.png', // 👈 your image path
                    height: 15,
                    width: 15,
                    color: Colors.black,
                  ),
                ),
                NoPaddingCell(child: AppDeleteIcon()),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAllergyScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/editicon.png', // 👈 your image path
                    height: 15,
                    width: 15,
                    color: Colors.black,
                  ),
                ),
                NoPaddingCell(child: AppDeleteIcon()),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAllergyScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/editicon.png', // 👈 your image path
                    height: 15,
                    width: 15,
                    color: Colors.black,
                  ),
                ),
                NoPaddingCell(child: AppDeleteIcon()),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAllergyScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/editicon.png', // 👈 your image path
                    height: 15,
                    width: 15,
                    color: Colors.black,
                  ),
                ),
                NoPaddingCell(child: AppDeleteIcon()),
              ],
            ),
          ],
        ]);
  }








}
