import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qc_hospital/Core/Utils/Button/cancel.dart';
import 'package:qc_hospital/Core/Utils/Button/save.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/download.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class EditTherapeuticPhlebotomy extends StatefulWidget {
  EditTherapeuticPhlebotomy({super.key});
  @override
  State<EditTherapeuticPhlebotomy> createState() => _BloodBankHomeState();
}

class _BloodBankHomeState extends State<EditTherapeuticPhlebotomy> {
  final dateOfDischargeController = TextEditingController();
  DateTime? toDate;
  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }

  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _indicationsController = TextEditingController();
  final TextEditingController _clinicController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _recommendedController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BloodBankBaseScaffold(
      title: "Therapeutic Phlebotomy",
      showDrawer: false,
      isPatientCard: true,
      patientName: 'Ram Sharma',
      crn: '2025000653',
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Therapeutic Phlebotomy',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 16),

          _buildOrderDetails(),
          const SizedBox(height: 16),

          _buildOrderDetails1(),
          const SizedBox(height: 16),

          _buildUploadFile(context),
          const SizedBox(height: 16),

          AppSaveButton(
            text: 'Save',
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 16),

          AppSaveButton(
            text: 'Accept & Save',
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 16),

          AppCancelButton(
            text: 'Reject',
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(height: 16),

          _buildPreviousHistory(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOrderDetails() {
    return CustomExpansionFrame(
      title: 'Order Details',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Order No"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: 'ORDER20252945543',
          enabled: false,
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Department"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Emergency', enabled: false),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Status"),
        ),
        SizedBox(height: 8),
        FunctionalDropdown(
          value: "Pending",
          items: [],
          onChanged: (val) {},
          enabled: false,
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildOrderDetails1() {
    return CustomExpansionFrame(
      title: 'Order Details-1',
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      "HB",
                      isRequired: true,
                    ),
                  ),
                  SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      "Transferrin",
                      isRequired: true,
                    ),
                  ),
                  SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      "PCV",
                      isRequired: true,
                    ),
                  ),
                  SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      "Vol Withdrawn",
                      isRequired: true,
                    ),
                  ),
                  SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      "Pulse Pre",
                      isRequired: true,
                    ),
                  ),
                  SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      "Pulse Post",
                      isRequired: true,
                    ),
                  ),
                  SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      "BP Pre",
                      isRequired: true,
                    ),
                  ),
                  SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel(
                      "BP Post",
                      isRequired: true,
                    ),
                  ),
                  SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel("Serrum Ferritin"),
                  ),
                  SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SharedComponents.buildFormLabel("MCV"),
                  ),
                  SizedBox(height: 8),
                  SharedComponents.buildTextField(),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Schedule Date"),
        ),
        SizedBox(height: 8),
        AppDateField(
          controller: dateOfDischargeController,
          onTap: () async {
            DateTime? pickedDate = await CustomCalendarDialog.show(
              context,
              initialDate: toDate ?? DateTime.now(),
            );
            if (pickedDate != null) {
              setState(() {
                toDate = pickedDate;
                dateOfDischargeController.text = formatDate(pickedDate);
              });
            }
            ;
          },
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Diagnosis", isRequired: true),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: "Diagnosis",
          maxLines: 5,
          controller: _diagnosisController,
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Indications"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: "Indications",
          maxLines: 5,
          controller: _indicationsController
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Clinic Features"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: "Clinic Features",
          maxLines: 5,
          controller: _clinicController
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Remarks"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: "Remarks",
          maxLines: 5,
          controller: _remarksController
        ),
        SizedBox(height: 16),

        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Recommended Schedule"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(
          hintText: "Recommended Schedule",
          maxLines: 5,
          controller: _recommendedController
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildUploadFile(BuildContext context) {
    return CustomExpansionFrame(
      title: 'Upload File',
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SharedComponents.buildFormLabel("Document Name"),
        ),
        SizedBox(height: 8),
        SharedComponents.buildTextField(),
        SizedBox(height: 16),
        UploadFileWidget(
          onImagePicked: (XFile file) {
            print("Selected File Path: ${file.path}");
            // Yahan aap file ko server par upload karne ka logic likh sakte hain
          },
        ),
        SizedBox(height: 16),
        DetailTableWrapper(
          children: [
            DetailRow(label: 'Doc Name', text: ''),
            DetailRow(label: 'File Name', text: ''),
            DetailRow(
              removePadding: true,
              label: 'Action',
              customWidget: Row(
                children: [
                  const SizedBox(width: 16,),
                  AppDownload(),
                  AppDeleteIcon(parentContext: context,)

                ],
              ),
              isLast: true,
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPreviousHistory() {
    return CustomExpansionFrame(
      title: 'Previous History',
      children: [
        DetailTableWrapper(
          children: [
            GroupedDetailRow(
              mainLabel: "Pulse",
              subLabel1: "Pre",
              subLabel2: "Post",
              // value1Widget: Text("72 bpm"), // Custom widgets bhi pass kar sakte hain
              // value2Widget: Text("75 bpm"),
            ),
            GroupedDetailRow(
              mainLabel: "BP",
              subLabel1: "Pre",
              subLabel2: "Post",
            ),
            DetailRow(label: "Diagnosis", text: ""),
            DetailRow(label: "Clinical Feature", text: ""),
            DetailRow(label: "Indications", text: ""),
            DetailRow(label: "Recommended Schedule", text: ""),
            DetailRow(label: "HB", text: ""),
            DetailRow(label: "Transferrin", text: ""),
            DetailRow(label: "PCV", text: ""),
            DetailRow(label: "Vol Withdrawn", text: ""),
            DetailRow(label: "Serrum Ferritin", text: ""),
            DetailRow(label: "MCV", text: ""),
            DetailRow(label: "Documents", text: "",isLast: true,),
          ],
        ),
        const SizedBox(height: 16,),
      ],
    );
  }
}

class GroupedDetailRow extends StatelessWidget {
  final String mainLabel; // Example: "Pulse"
  final String subLabel1; // Example: "Pre"
  final String subLabel2; // Example: "Post"
  final Widget? value1Widget; // Pre ki value/textfield
  final Widget? value2Widget; // Post ki value/textfield
  final bool isLast;
  final double totalLabelWidth;

  const GroupedDetailRow({
    super.key,
    required this.mainLabel,
    required this.subLabel1,
    required this.subLabel2,
    this.value1Widget,
    this.value2Widget,
    this.isLast = false,
    this.totalLabelWidth = 150, // Aapke DetailRow ki total width
  });

  @override
  Widget build(BuildContext context) {
    // Label area ko 2 hisso mein divide kar diya
    final double mainLabelWidth = totalLabelWidth * 0.45;
    final double subLabelWidth = totalLabelWidth * 0.55;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300, width: 2),
        ),
      ),
      // 🔥 Outer IntrinsicHeight taaki main label inner dono row ki combined height le
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- LEFT MAIN LABEL ("Pulse" / "BP") ---
            Container(
              width: mainLabelWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F8F8),
                border: Border(
                  right: BorderSide(color: Colors.grey.shade300, width: 2),
                ),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                mainLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),

            // --- RIGHT COLUMN (Contains Pre and Post Rows) ---
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 👉 TOP ROW ("Pre")
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: subLabelWidth,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F8F8),
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey.shade300,
                                width: 2,
                              ),
                              bottom: BorderSide(
                                color: Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            subLabel1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                            ),
                            alignment: Alignment.centerLeft,
                            child: value1Widget ?? const Text(""),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 👉 BOTTOM ROW ("Post")
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: subLabelWidth,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F8F8),
                            border: Border(
                              right: BorderSide(
                                color: Colors.grey.shade300,
                                width: 2,
                              ),
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            subLabel2,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            alignment: Alignment.centerLeft,
                            child: value2Widget ?? const Text(""),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UploadFileWidget extends StatefulWidget {
  final Function(XFile)? onImagePicked;
  final String? label;

  const UploadFileWidget({
    super.key,
    this.onImagePicked,
    this.label = 'Upload File',
  });

  @override
  State<UploadFileWidget> createState() => _UploadFileWidgetState();
}

class _UploadFileWidgetState extends State<UploadFileWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  // 🔥 Gallery se photo pick karne ka function
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85, // Image size optimize karne ke liye
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = pickedFile;
        });

        // Parent widget ko notify karne ke liye callback
        if (widget.onImagePicked != null) {
          widget.onImagePicked!(pickedFile);
        }
      }
    } catch (e) {
      debugPrint("Image pick karne mein error aaya: $e");
    }
  }

  // 🔥 Selected image remove karne ka function
  void _removeSelectedImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // UI ka theme color (Aapke custom upload box ke hisaab se color update kiya hai)
    const Color themeColor = Color(0xFF117A7A);

    // 🔥 Conditional content definition: Image preview ya default placeholder
    Widget content;

    if (_selectedImage != null) {
      // ✅ Agar image select ho chuki hai, toh preview display widget
      content = Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: InkWell(
              onTap: _pickImageFromGallery,
              child: Image.file(File(_selectedImage!.path), fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: _removeSelectedImage,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.close, color: themeColor, size: 20),
              ),
            ),
          ),
        ],
      );
    } else {
      // ❌ Yahan aapka naya _buildUploadBox wala content replace kiya gaya hai
      content = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Custom Upload SVG
          SvgPicture.asset(
            'assets/Upload icon.svg',
            height: 48,
            width: 48,
            colorFilter: const ColorFilter.mode(themeColor, BlendMode.srcIn),
          ),
          const SizedBox(height: 16),
          // RichText for "Drag & drop files or Browse"
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
                    color: themeColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Supported formats text
          const Text(
            "Supported formats: JPEG, PNG, MP4, PDF, Word, PPT",
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            '${widget.label}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),

        // Main Upload Card
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _selectedImage != null
                ? content
                : InkWell(onTap: _pickImageFromGallery, child: content),
          ),
        ),

        // Agar image select ho gayi ho toh uska naam niche dikhane ke liye
        if (_selectedImage != null) ...[
          const SizedBox(height: 10),
          Text(
            "Selected: ${_selectedImage!.name.toShortString()}",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
          ),
        ],
      ],
    );
  }
}

// String extension taaki bada file name design kharab na kare
extension on String {
  String toShortString() {
    if (length > 25) {
      return "${substring(0, 15)}...${substring(length - 8)}";
    }
    return this;
  }
}
