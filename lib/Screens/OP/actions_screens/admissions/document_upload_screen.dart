import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // REQUIRED FOR SVG ICONS
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/scrollable_table.dart';
import 'package:qc_hospital/Core/Utils/Table/table_text.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

import 'package:qc_hospital/Screens/OP/actions_screens/admissions/admission_screen.dart'; // Ensure this imports SharedAdmissionComponents
// --- IMPORT THIS TO ACCESS AdmDetailsModal ---
import 'package:qc_hospital/Screens/OP/actions_screens/admissions/accompanied_by_screen.dart';

class DocumentUploadScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const DocumentUploadScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  int _bottomNavIndex = 1;

  // --- FUNCTIONAL STATE VARIABLES ---
  String? _selectedDocType;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ClinicalBaseScaffold(
      title: "Admission",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Admission',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SharedAdmissionComponents.buildTabs(
            context,
            widget.patientName,
            widget.crn,
            activeTabIndex: 0,
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Admission",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  // --- FUNCTIONAL DETAILS BUTTON ---
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => AdmDetailsModal(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.print, color: Colors.black87),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedAdmissionComponents.buildQuickActions(
            context,
            screenWidth,
            widget.patientName,
            widget.crn,
            activeLabel: 'Upload Ext. Health Rec',
          ),
          const SizedBox(height: 24),

          Text(
            "Document Upload",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Document Type"),
          const SizedBox(height: 8),
          // _buildFunctionalDropdown(
          //   value: _selectedDocType,
          //   hint: "--Select--",
          //   items: [
          //     "Health Report",
          //     "Lab Results",
          //     "Prescription",
          //     "ID Proof",
          //     "Other",
          //   ],
          //   onChanged: (val) => setState(() => _selectedDocType = val),
          // ),

          FunctionalDropdown(
            value: _selectedDocType,
            hint: "--Select--",
            items: [
              "--Select--",
              "Health Report",
              "Lab Results",
              "Prescription",
              "ID Proof",
              "Other",
            ],
            onChanged: (val) => setState(() => _selectedDocType = val),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Upload File"),
          const SizedBox(height: 8),
          _buildUploadBox(),
          const SizedBox(height: 24),

          // --- HORIZONTALLY SCROLLABLE MATRIX ---
          _buildDocumentTable(),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text(
                "Admit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.white,
              ),
              child: const Text(
                "Back to Patient List",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- UPDATED: Uses PopupMenuButton for Dropdown ---
  Widget _buildFunctionalDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            onSelected: onChanged,
            offset: const Offset(0, 48), // Drops down exactly below the field
            color: Colors.white,
            elevation: 0, // Flat look
            constraints: BoxConstraints(
              minWidth: constraints
                  .maxWidth, // Matches the exact width of the container
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5,
              ), // THE OUTLINE BORDER
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? hint,
                      style: TextStyle(
                        color: value == null
                            ? Colors.grey.shade400
                            : Colors.black87,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
            itemBuilder: (context) => items
                .map(
                  (item) => PopupMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1.5),
      ),
      child: Column(
        children: [
          // Custom Upload SVG
          SvgPicture.asset(
            'assets/Upload icon.svg',
            height: 48,
            width: 48,
            colorFilter: const ColorFilter.mode(
              Color(0xFF117A7A),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: const TextSpan(
              text: "Drag & drop files or ",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              children: [
                TextSpan(
                  text: "Browse",
                  style: TextStyle(
                    color: Color(0xFF117A7A),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Supported formats: JPEG, PNG, MP4, PDF, Word, PPT",
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // DOCUMENT TABLE MATRIX (Matching Group 40192.jpg)
  // =========================================================================
  Widget _buildDocumentTable() {
    // final List<Map<String, String>> docsData = [
    //   {
    //     "docName": "Health Report",
    //     "fileName": "Health Report",
    //     "docType": "PDF",
    //   },
    //   {"docName": "Scan Report", "fileName": "MRI", "docType": "Doc"},
    // ];
    //
    // return Container(
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(8),
    //     border: Border.all(color: Colors.grey.shade300),
    //   ),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // Fixed Left Column (Headers)
    //       Container(
    //         width: 140,
    //         decoration: BoxDecoration(
    //           color: const Color(0xFFEAF9F9),
    //           border: Border(right: BorderSide(color: Colors.grey.shade300)),
    //           borderRadius: const BorderRadius.only(
    //             topLeft: Radius.circular(8),
    //             bottomLeft: Radius.circular(8),
    //           ),
    //         ),
    //         child: Column(
    //           children: [
    //             _buildMatrixCell("Document Name", isHeader: true),
    //             _buildDivider(),
    //             _buildMatrixCell("File Name", isHeader: true),
    //             _buildDivider(),
    //             _buildMatrixCell("Document Type", isHeader: true),
    //             _buildDivider(),
    //             _buildMatrixCell("Action", isHeader: true, isLast: true),
    //           ],
    //         ),
    //       ),
    //       // Horizontally Scrollable Data Columns
    //       Expanded(
    //         child: SingleChildScrollView(
    //           scrollDirection: Axis.horizontal,
    //           child: Row(
    //             children: docsData.asMap().entries.map((entry) {
    //               int idx = entry.key;
    //               var doc = entry.value;
    //               bool isLastCol = idx == docsData.length - 1;
    //
    //               return Container(
    //                 width: 220,
    //                 decoration: BoxDecoration(
    //                   border: Border(
    //                     right: isLastCol
    //                         ? BorderSide.none
    //                         : BorderSide(color: Colors.grey.shade300),
    //                   ),
    //                 ),
    //                 child: Column(
    //                   children: [
    //                     _buildMatrixCell(doc["docName"]!),
    //                     _buildDivider(),
    //                     _buildMatrixCell(doc["fileName"]!),
    //                     _buildDivider(),
    //                     _buildMatrixCell(doc["docType"]!),
    //                     _buildDivider(),
    //                     _buildMatrixActionCell(),
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
       labels: [
          'Document Name',
         'File Name',
         'Document Type',
         'Action'
       ],
        rowValues: [
          [
            TableText('Health Report',),
            TableText('Scam Report',),
          ],

          [
            TableText('Health Report',),
            TableText('MRI',),
          ],

          [
            TableText('PDF',),
            TableText('Doc',),
          ],
          [
            Row(
              children: [
                const Icon(Icons.print, color: Colors.black87, size: 20),
                NoPaddingCell(child: AppDeleteIcon()),
              ],
            ),

            Row(
              children: [
                const Icon(Icons.print, color: Colors.black87, size: 20),
                NoPaddingCell(child: AppDeleteIcon()),
              ],
            ),

          ]
        ]);
  }

  Widget _buildMatrixCell(
    String text, {
    bool isHeader = false,
    bool isLast = false,
  }) {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
          color: Colors.black87,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildMatrixActionCell() {
    return Container(
      height: 60,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // Custom Download SVG
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
          const SizedBox(width: 16),
          // Custom Delete SVG and Delete Modal Trigger
          AppDeleteIcon()
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  // --- STANDARD DELETE MODAL ---
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
