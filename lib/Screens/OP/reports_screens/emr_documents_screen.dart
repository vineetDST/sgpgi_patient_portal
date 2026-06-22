import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:flutter_svg/flutter_svg.dart'; // REQUIRED FOR SVG ICONS

import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/IP/ip_action_button.dart';

import 'emr_list_screen.dart';

class EmrDocumentsScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  final String? mode;
  const EmrDocumentsScreen({
    super.key,
    required this.patientName,
    required this.crn,
    this.mode = "op",
  });
  @override
  State<EmrDocumentsScreen> createState() => _EmrDocumentsScreenState();
}

class _EmrDocumentsScreenState extends State<EmrDocumentsScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Widget content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Documents",
              style: AppTextStyles.RegH3.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                _buildBlackButton(
                  "List",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmrListScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                          mode: widget.mode,
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                widget.mode == "op"
                    ? _buildBlackButton(
                        "Action",
                        onTap: () {
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
                      )
                    : IPActionButton(),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        _buildSyncedTable(),
        const SizedBox(height: 20),
      ],
    );
    if (widget.mode == "ip") {
      return IpBaseScaffold(
        title: "EMR",
        quickActionLabel: "EMR",
        showDrawer: false,
        patientName: widget.patientName,
        crn: widget.crn,
        activeQuickAction: true,
        child: content,
      );
    } else {
      return ClinicalBaseScaffold(
        title: "EMR",
        showDrawer: false,
        patientName: widget.patientName,
        crn: widget.crn,
        activeQuickAction: 'EMR',
        child: content,
      );
    }
  }

  Widget _buildBlackButton(String text, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildSyncedTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF9F9),
              border: Border(right: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                _buildLeftCell("Document Name", 60),
                _buildDivider(),
                _buildLeftCell("File Name", 60),
                _buildDivider(),
                _buildLeftCell("Document Type", 60),
                _buildDivider(),
                _buildLeftCell("Action", 60),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: IntrinsicWidth(
                child: SizedBox(
                  width: 250,
                  child: Column(
                    children: [
                      _buildRightTextCell("Health Report", 60),
                      _buildDivider(),
                      _buildRightTextCell("Health Report", 60),
                      _buildDivider(),
                      _buildRightTextCell("PDF", 60),
                      _buildDivider(),
                      _buildRightActionCell(60),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
        color: Colors.black87,
      ),
    ),
  );
  Widget _buildRightTextCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Text(
      text,
      style: const TextStyle(fontSize: 13, color: Colors.black87),
    ),
  );
  Widget _buildRightActionCell(double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            // Download Logic
          },
          child: SvgPicture.asset(
            'assets/download.svg',
            height: 15,
            width: 15,
            colorFilter: const ColorFilter.mode(
              Colors.black87,
              BlendMode.srcIn,
            ),
          ),
        ),

        AppDeleteIcon()
      ],
    ),
  );
  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);
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
