import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';

import 'package:qc_hospital/Screens/Blood_Bank/Collection/collection.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Donor/donor.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Blood%20Issue/blood_component_cross_match.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Blood%20Issue/blood_component_request_status.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Blood%20Issue/blood_component_requistion.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Blood%20Issue/blood_inventory.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Blood%20Issue/receive_back_discard.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Donor_Registration/donor_capture_photo.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Donor_Registration/donor_registration_camp.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/General/blood_bag_number_generation.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/General/donor_blood_bleeding_details.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/General/donor_screening.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/General/donor_screening_browser.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/General/reserve_blood_bags_for_camp.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Laboratory/blood_component_seperation.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Laboratory/blood_group_validation.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Laboratory/cell_grouping.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Laboratory/serilogy_positive_confirmation.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Laboratory/serological_investigation_result_entry.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Laboratory/serum_grouping.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Procedure/platelet_pheresis.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Drawer/Procedure/therapeutic_phlebotomy.dart';
import 'package:qc_hospital/Widgets/blood_bank_module_shell.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BloodbankDrawer extends StatefulWidget {
  const BloodbankDrawer({super.key});

  @override
  State<BloodbankDrawer> createState() => _CustomAccordionDrawerState();
}

class _CustomAccordionDrawerState extends State<BloodbankDrawer> {
  // -1 matlab shuru mein koi bhi open nahi hai (All Closed)
  int _expandedIndex = -1;

  // Menu Data List
  final List<Map<String, dynamic>> _menuData = [
    {
      'title': 'Donor Registration',
      'icon': 'donorreg',
      'subItems': [
        'Donor Registration',
        'Donor Registration Camp',
        'Donor-Capture Photo',
        'Donor Registration Browser',
        // 'Donor Certificate Print',
      ],
    },
    {
      'title': 'General',
      'icon': 'general',
      'subItems': [
        'Donor Screening Browser',
        'Donor Screening',
        'Bag Number Generation',
        'Print Camp Blood Bag',
        'Donor Blood Bleeding details',
      ],
    },
    {
      'title': 'Laboratory',
      'icon': 'labs',
      'subItems': [
        'Blood Component Separation',
        'Serological Investigation Result Entry',
        'Cell Grouping',
        'Serum Grouping',
        'Blood Group Validation',
        'Serology Positive Confirmation',
      ],
    },
    {
      'title': 'Procedure',
      'icon': 'procedures',
      'subItems': ['Platelet Pheresis', 'Therapeutic Phlebotomy'],
    },
    {
      'title': 'Blood Issue/Receive',
      'icon': 'bloodissues',
      'subItems': [
        'Blood Component Requisition',
        'Blood Component Cross Match',
        'Blood Component Request Status',
        'Blood Bank Receive Back',
        'Blood Inventory',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFBEE9E8),
              Color(0xFFBEE9E8),
              Color(0xFFBEE9E8),
              Color(0xFFBEE9E8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.01,
                    ),
                    color: Colors.transparent,
                    child: Icon(
                      Icons.close,
                      size: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ),
                ),
              ),

              // --- Menu List ---
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _menuData.length,
                  itemBuilder: (context, index) {
                    return _buildMenuItem(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(int index) {
    final item = _menuData[index];
    final bool isOpen = _expandedIndex == index;
    final Color titleColor = isOpen
        ? AppColor.color117A7A
        : AppColor.color1E1E1E;
    final Color iconColor = isOpen
        ? AppColor.color117A7A
        : AppColor.color1E1E1E;
    const Color subItemColor = AppColor.color1E1E1E;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (_expandedIndex == index) {
                // Agar same item par click kiya to use band kar do (Toggle off)
                _expandedIndex = -1;
              } else {
                // Naya item open karo, purana apne aap band ho jayega
                _expandedIndex = index;
              }
            });
          },
          splashColor: Colors.red.withOpacity(0.1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Row(
              children: [
                // Icon(
                //   item['icon'],
                //   color: iconColor,
                //   size: MediaQuery.of(context).size.height * 0.025,
                // ),
                SvgPicture.asset(
                  // item['icon'],
                  "assets/${item['icon']}.svg",
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 12),
                Text(
                  item['title'],
                  style: TextStyle(
                    color: titleColor, // Red if Open, Black if Closed
                    fontWeight: FontWeight.w400,
                    fontSize: MediaQuery.of(context).size.height * 0.018,
                  ),
                ),
              ],
            ),
          ),
        ),

        if (isOpen)
          Column(
            children: (item['subItems'] as List<String>).map((subItemTitle) {
              return _buildSubMenuItem(subItemTitle, subItemColor);
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildSubMenuItem(String text, Color color) {
    return InkWell(
      onTap: () {
        print("Clicked: $text");
        Widget? targetScreen;

        // Tab index track karne ke liye (Optional)
        int? targetTabIndex;

        if (text == "Donor Registration Camp") {
          targetScreen = DonorRegistrationCamp();
        } else if (text == "Donor Registration") {
          targetScreen = Collection();
        } else if (text == "Donor Registration Browser") {
          targetScreen = Donor();
        } else if (text == 'Donor-Capture Photo') {
          targetScreen = DonorCapturePhoto();
        } else if (text == 'Donor Screening Browser') {
          targetScreen = DonorScreeningBrowser();
        } else if (text == 'Donor Screening') {
          targetScreen = DonorScreening();
        } else if (text == 'Bag Number Generation') {
          targetScreen = BloodBagNumberGeneration();
        } else if (text == 'Print Camp Blood Bag') {
          targetScreen = ReserveBloodBagsForCamp();
        } else if (text == 'Donor Blood Bleeding details') {
          targetScreen = DonorBloodBleedingDetails();
        } else if (text == 'Blood Component Separation') {
          targetScreen = BloodComponentSeperation();
        } else if (text == 'Serological Investigation Result Entry') {
          targetScreen = SerologicalInvestigationResultEntry();
        } else if (text == 'Cell Grouping') {
          targetScreen = CellGrouping();
        } else if (text == 'Serum Grouping') {
          targetScreen = SerumGrouping();
        } else if (text == 'Blood Group Validation') {
          targetScreen = BloodGroupValidation();
        } else if (text == 'Serology Positive Confirmation') {
          targetScreen = SerilogyPositiveConfirmation();
        } else if (text == 'Platelet Pheresis') {
          targetScreen = PlateletPheresis();
        } else if (text == 'Therapeutic Phlebotomy') {
          targetScreen = TherapeuticPhlebotomy();
        } else if (text == 'Blood Component Requisition') {
          targetScreen = BloodComponentRequistion();
        } else if (text == 'Blood Component Cross Match') {
          targetScreen = BloodComponentRequestMatch();
        } else if (text == 'Blood Component Request Status') {
          targetScreen = BloodComponentRequestStatus();
        } else if (text == 'Blood Bank Receive Back') {
          targetScreen = ReceiveBackDiscard();
        } else if (text == 'Blood Inventory') {
          targetScreen = BloodInventory();
        }

        if (targetScreen != null) {
          // 1. Sabse pehle drawer ko close karein
          Navigator.of(context).pop();

          // 2. Naya screen Shell ke andar push karein taaki Bottom Nav chhupe nahi
          // Note: Agar wo tab ka main screen hai, toh aap directly changeTab bhi kar sakte hain
          if (targetTabIndex != null) {
            // Tab switch karega
            bloodBankShellKey.currentState?.changeTab(targetTabIndex);
          } else {
            // Agar sub-screen hai toh current tab ke andar push karega
            bloodBankShellKey.currentState?.pushToCurrentTab(targetScreen!);
          }
        }
      },
      child: Container(
        width: double.infinity,
        // Indentation: 24 (parent) + 20 (icon) + 12 (gap) = 56
        padding: const EdgeInsets.only(left: 56, top: 8, bottom: 8, right: 20),
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: MediaQuery.of(context).size.height * 0.018,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
