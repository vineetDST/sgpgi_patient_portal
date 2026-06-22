import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class IPBlockedService extends StatefulWidget {
  final String patientName;
  final String crn;
  const IPBlockedService({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<IPBlockedService> createState() => _IPBlockedServiceState();
}

class _IPBlockedServiceState extends State<IPBlockedService> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return IpBaseScaffold(
      title: "Blocked Services",
      quickActionLabel: "Blocked Services",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: true,

      // We only pass the content that is unique to the Visit Summary screen below the Quick Actions
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Blocked Services",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IPActionButton(),

            ],
          ),
          const SizedBox(height: 16),
          _buildFormTile("Blocked Services Orders", _buildBlockedServiceOrders()),
          const SizedBox(height: 16),

          _buildFormTile("Blocked Drug and Material Orders", _buildDrugAndMaterialOrders()),
          const SizedBox(height: 16),
        ],
      ),


    );
  }

  Widget _buildBlockedServiceOrders() {
    const double rowHeight = 56.0;
    Widget left(String text, {bool isRed = false, bool isLast = false}) =>
        Container(
          height: rowHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF9F9),
            border: Border(
              bottom: isLast
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: isRed
              ? RichText(
            text: TextSpan(
              text: text.replaceAll('*', ''),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
              children: const [
                TextSpan(
                  text: "*",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          )
              : Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        );

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  left("Service Name"),
        
        
                  left("Quantity"),
                  left("Rate"),
                  left("Action", isLast: true),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildDrugColumn(
        
        
                      "01. HGB (M-Spectrometric)",
                      "1.0",
                      "55.0",
                      rowHeight,
                    ),
                    _buildDrugColumn(
        
        
                      "01. HGB (M-Spectrometric)",
                      "1.0",
                      "55.0",
                      rowHeight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildDrugAndMaterialOrders() {
    const double rowHeight = 56.0;
    Widget left(String text, {bool isRed = false, bool isLast = false}) =>
        Container(
          height: rowHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF9F9),
            border: Border(
              bottom: isLast
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: isRed
              ? RichText(
            text: TextSpan(
              text: text.replaceAll('*', ''),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
              children: const [
                TextSpan(
                  text: "*",
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          )
              : Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        );

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  left("Service Name"),


                  left("Quantity"),
                  left("Rate"),
                  left("Action", isLast: true),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildDrugColumn(


                     "Optium Plus",
                      "20.0",
                      "179.0",
                      rowHeight,
                    ),
                    _buildDrugColumn(


                      "Optium Plus",
                      "20.0",
                      "179.0",
                      rowHeight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormTile(String title, Widget tableContent) {
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
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          children: [tableContent],
        ),
      ),
    );
  }

  Widget _buildDrugColumn(


      String serviceName,
      String quanity,
      String rate,

      double height,
      ) {
    Widget cell(Widget child, {bool isLast = false}) => Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding:  EdgeInsets.symmetric(horizontal: isLast ? 0 : 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: child,
    );



    return SizedBox(
      width: 260,
      child: Column(
        children: [


          cell(Text(serviceName, style: const TextStyle(fontSize: 12))),
          cell(Text(quanity, style: const TextStyle(fontSize: 12))),
          cell(Text(rate, style: const TextStyle(fontSize: 12))),

          cell(
            AppDeleteIcon(),
            isLast: true,
          ),
        ],
      ),
    );
  }

  void _showDeleteModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 1.5),
                ),
                child: const Icon(Icons.close, color: Colors.red, size: 32),
              ),
              const SizedBox(height: 24),
              const Text(
                "Are you sure you want to\ndelete the record?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC60000),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
