import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/BED%20SWAP/ip_bed_swap.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/BLOOD%20REQUEST/ip_blood_request.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/CHANGE%20BED/ip_change_bed.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/INFECTION%20REC/ip_infection_rec.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/POMR/ip_pomr.dart';

import 'package:qc_hospital/Screens/IP/Action_Screen/CROSS CONSULT/cross_consultation_screen.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/Patient%20Form/ip_patient_form.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/SEND SMS/send_sms_screen.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/PRINT/print_invest_report_screen.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/SURGERY REQUEST/ip_surgery_request.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/PED WITHDRAW/ped_withdrawal_request_screen.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/CONSULTANT TRANSFER/consultant_transfer_screen.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/FLUID BALANCE/fluid_balance_chart_screen.dart'; // Adjust path based on where you put it

import 'package:qc_hospital/Screens/IP/Action_Screen/PROGRESS%20NOTES/ip_progress_notes.dart';
import 'package:qc_hospital/Screens/IP/Action_Screen/VITAL/ip_vital_signs_screen.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_service_order.dart';
import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/DISCHARGE/discharge.dart';
import 'package:qc_hospital/Screens/IP/in_patient_screen.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';

class IpActionBottomSheet extends StatelessWidget {
  final String patientName;
  final String crn;
  const IpActionBottomSheet({
    required this.patientName,
    required this.crn,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // List of actions matching Action IP.png

    // final List<Map<String, String>> actions = [
    //   {'label': 'Create POMR', 'icon': 'create_pomr'},
    //   {'label': 'Cross Consult', 'icon': 'cross_consult'},
    //   {'label': 'Patient Referral', 'icon': 'patient_referral'},
    //   {'label': 'Blood Request', 'icon': 'blood_request'},
    //   {'label': 'Send SMS', 'icon': 'send_sms'},
    //   {'label': 'Admission', 'icon': 'admission'},
    //   {'label': 'DayCare Admission', 'icon': 'daycare_admission'},
    //   {'label': 'Print Invest Report', 'icon': 'print_invest_report'},
    //   {'label': 'Print Invest Requisition', 'icon': 'print_invest_report'},
    //   {'label': 'Print OP Visit Summary', 'icon': 'print_invest_report'},
    //   {'label': 'Print IP Visit Summary', 'icon': 'print_invest_report'},
    // ];
    final List<Map<String, dynamic>> actions = [
      {
        'label': 'Start Consult',
        'icon': 'cross_consult',
        'screen': const InPatientScreen(),
      },
      {
        'label': 'Vital Signs',
        'icon': 'vital',
        'screen': IPVitalSignsScreen(patientName: patientName, crn: crn),
      },
      {
        'label': 'Discharge Rec',
        'icon': 'dischargeblue',
        'screen': IPDischarge(patientName: patientName, crn: crn),
      },
      {
        'label': 'Progress Notes',
        'icon': 'progressnotes',
        'screen': IPProgressNotes(patientName: patientName, crn: crn),
      },
      {
        'label': 'POMR',
        'icon': 'create_pomr',
        'screen': IPPomrScreen(patientName: patientName, crn: crn),
      },
      {
        'label': 'Inv Order Prin',
        'icon': 'print_invest_report',
        'screen': IPServiceOrder(patientName: patientName, crn: crn),
      },
      {
        'label': 'Infection Rec',
        'icon': 'infections',
        'screen': IPInfectionRec(patientName: patientName, crn: crn),
      },
      {
        'label': 'Bed Swap',
        'icon': 'bedswap',
        'screen': IPBedSwap(patientName: patientName, crn: crn),
      }, // Represents bed swap
      {
        'label': 'Change Bed',
        'icon': 'bedchange',
        'screen': IPChangeBed(patientName: patientName, crn: crn),
      },
      {
        'label': 'Blood Request',
        'icon': 'blood_request',
        'screen': IPBloodRequest(patientName: patientName, crn: crn),
      },
      {
        'label': 'Surgery Request',
        'icon': 'surgeryreq',
        'screen': IpSurgeryRequestScreen(patientName: patientName, crn: crn),
      },
      {
        'label': 'Send SMS',
        'icon': 'send_sms',
        'screen': SendSmsScreen(patientName: patientName, crn: crn),
      },

      {
        'label': 'Consultant Transfer',
        'icon': 'cross_consult',
        'screen': ConsultantTransferScreen(patientName: patientName, crn: crn),
      },
      {
        'label': 'Print Invest Report',
        'icon': 'print_invest_report',
        'screen': PrintInvestReportScreen(patientName: patientName, crn: crn),
      },
      {
        'label': 'Mark Patient Absconded',
        'icon': 'patients',
        'screen': IPBloodRequest(patientName: patientName, crn: crn),
      },
      {
        'label': 'PED Withdrawal Request',
        'icon': 'chart',
        'screen': PedWithdrawalRequestScreen(
          patientName: patientName,
          crn: crn,
        ),
      },
      {
        'label': 'Cross Consultation',
        'icon': 'cross_consult',
        'screen': CrossConsultationScreen(patientName: patientName, crn: crn),
      },
      {
        'label': 'Fluid Balance Chart',
        'icon': 'chart',
        'screen': FluidBalanceChartScreen(patientName: patientName, crn: crn),
      },
      {
        'label': 'Patient ACC Statement',
        'icon': 'patients',
        'screen': IPBloodRequest(patientName: patientName, crn: crn),
      },
      {
        'label': 'Patient Form',
        'icon': 'patients',
        'screen': IpPatientForm(patientName: patientName, crn: crn),
      },
    ];

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.65,
      ),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.65,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
          children: [
            Center(
              child: Container(
                width: 100,
                height: 4,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColor.color1E1E1E),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  spacing: 15,
                  runSpacing: 25,
                  children: actions.map((action) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 40 - 30) / 3,
                      child: _buildActionItem(
                        context,
                        action['label'] as String,
                        action['icon'] as String,
                        action['screen'] as Widget?,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context,
    String label,
    String iconData,
    Widget? targetScreen,
  ) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);

        // if(targetScren != null) {
        //   Navigator.push(context, MaterialPageRoute(builder: (context) => targetScren));
        // }
        if (targetScreen != null) {
          doctorShellKey.currentState?.pushToCurrentTab(targetScreen);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Circular Icon Background
          Container(
            height: 54,
            width: 54,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.color117A7A.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/$iconData.svg",
              colorFilter: const ColorFilter.mode(
                AppColor.color117A7A,
                BlendMode.srcIn,
              ),
              fit: BoxFit.contain,
              placeholderBuilder: (context) => const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Label Text
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColor.color1E1E1E,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}
