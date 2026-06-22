import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class PatientReferralScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const PatientReferralScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<PatientReferralScreen> createState() => _PatientReferralScreenState();
}

class _PatientReferralScreenState extends State<PatientReferralScreen> { 
  
  @override
  Widget build(BuildContext context) {


    return ClinicalBaseScaffold(
      title: "Patient Referral",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Patient Referral',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Patient Referral",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _buildReferralTable(),
          const SizedBox(height: 20),
        ],
      ),

      // bottomNavigationBar: CustomCurvedNavigationBar(
      //   index: 1,
      //   height: 75.0,
      //   color: AppColor.white,
      //   buttonBackgroundColor: AppColor.color117A7A,
      //   backgroundColor: Colors.transparent,
      //   items: const [
      //     Icon(Icons.home_filled, size: 26, color: Colors.white),
      //     Icon(Icons.medical_services, size: 26, color: Colors.white),
      //     Icon(Icons.add_business_outlined, size: 26, color: Colors.white),
      //     Icon(Icons.notifications, size: 26, color: Colors.white),
      //   ],
      //   onTap: (index) {},
      // ),
    );
  }

  Widget _buildReferralTable() {
    return DetailTableWrapper(

      children: [
        DetailRow(
          label: 'Patient Name',
          text: '', // यहाँ अपनी वैल्यू पास करें
        ),
        DetailRow(
          label: 'From Department',
          text: '',
        ),
        DetailRow(
          label: 'From Consultant',
          text: '',
        ),
        DetailRow(
          label: 'To Department',
          text: '',
        ),
        DetailRow(
          label: 'To Consultant',
          text: '',
        ),
        DetailRow(
          label: 'Requested Date',
          text: '',
        ),
        DetailRow(
          label: 'Approval Status',
          text: '',
        ),
        DetailRow(
          label: 'Priority',
          text: '',
        ),
        DetailRow(
          label: 'Type',
          text: '',
        ),
        DetailRow(
          label: 'Opinion',
          text: '',
          isLast: true, // आखिरी रो के लिए
        ),
      ],
    );
  }


}
