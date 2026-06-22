import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dialog/delete_dialog.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filterTextField.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class DynamicExpansionTable extends StatefulWidget {
  final String title;
  final String column1Header;
  final String column2Header;
  final List<Map<String, String>> dataList; // Dynamic Data
  final String patientName;
  final double ratio1; // Column 1 ka ratio
  final double ratio2; // Column 2 ka ratio

  const DynamicExpansionTable({
    Key? key,
    required this.title,
    required this.column1Header,
    required this.column2Header,
    required this.dataList,
    required this.patientName,
    this.ratio1 = 3,
    this.ratio2 = 2,
  }) : super(key: key);

  @override
  _DynamicExpansionTableState createState() => _DynamicExpansionTableState();
}

class _DynamicExpansionTableState extends State<DynamicExpansionTable> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Dynamic Header Section
          GestureDetector(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              color: Colors.transparent, // Full width click support
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),

          // Dynamic Table Section
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(widget.ratio1),
                    1: FlexColumnWidth(widget.ratio2),
                  },
                  border: TableBorder.symmetric(
                    inside: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  children: [
                    // Dynamic Table Header
                    TableRow(
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0F7F9),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      children: [
                        _buildCell(widget.column1Header, isHeader: true),
                        _buildCell(widget.column2Header, isHeader: true),
                      ],
                    ),
                    // Dynamic Table Rows
                    ...widget.dataList.map((item) {
                      // Hum 'key' agnostic bana rahe hain (pehle do values pick karenge)
                      List<String> values = item.values.toList();
                      return TableRow(
                        children: [
                          _buildCell(values.isNotEmpty ? values[0] : ""),
                          _buildCell(values.length > 1 ? values[1] : ""),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 8),
      child: GestureDetector(
        onTap: () {
          _showAdmittedPatientDialog(context);
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  void _showAdmittedPatientDialog(BuildContext parentContext) {
    AppDialog.show(
      context: parentContext,
      title: "Patient Details",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: Column(
                children: [
                  DetailRow(label: "Bed", text: "General - 1"),
                  DetailRow(
                    label: "Patient Name",
                    customWidget: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: widget.patientName,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                          const TextSpan(
                            text: "M 45 Y",
                            style: TextStyle(
                              color: Color(0xFF117A7A), // 🔵 Blue
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DetailRow(label: "CRN Number", text: "2025000438"),
                  DetailRow(label: "HRF Type", text: "Medium"),
                  DetailRow(label: "DOA", text: "08-10-2025 | 15:30"),
                  DetailRow(label: "Consultant", text: "Satyendra Tiwari"),
                  DetailRow(label: "Patient Status", text: "Under IP Care"),

                  DetailRow(
                    isLast: true,
                    label: "Bal.Amount",
                    removePadding: true, // 🔥 important
                    customWidget: GestureDetector(
                      onTap: () async {
                        Navigator.of(
                          context,
                          rootNavigator: true,
                        ).pop(); // ✅ sirf dialog close

                        await Future.delayed(const Duration(milliseconds: 100));

                        _showPendingRequestDialog(parentContext);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        color: Colors.yellow,
                        child: const Text(
                          "20,435.75",
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPendingRequestDialog(BuildContext parentContext) {
    AppDialog.show(
      context: parentContext,
      title: "Pending Requests",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: Column(
                children: [
                  DetailRow(label: "Requistion No.", text: "REQ5879641"),

                  DetailRow(label: "Date", text: "08-10-2025 | 15:30"),
                  DetailRow(label: "Req. By", text: "Doctor"),
                  DetailRow(label: "Amount", text: "5000.00"),

                  DetailRow(
                    isLast: true,
                    label: "Action",
                    removePadding: true, // 🔥 important
                    customWidget: Container(
                      width: double.infinity,
                      // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: const Icon(
                              Icons.print,
                              color: Colors.black87,
                              size: 20,
                            ),
                          ),


                          // --- UPDATED: Wrapped in GestureDetector to trigger the modal ---
                          GestureDetector(
                            onTap: () async {
                              final result = await showDeleteDialog(
                                parentContext,
                              ); // ✅ correct

                              if (result == true) {
                                print("Deleted");
                              } else {
                                print("Cancel");
                              }
                            },
                            child: Image.asset(
                              'assets/deleteicon.png', // 👈 your image path
                              height: 15,
                              width: 15,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SharedComponents.buildFormLabel("Collection Request"),
          const SizedBox(height: 8),

          FilterTextField(
            hintText: "Enter Collection Request",
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    side: const BorderSide(color: Colors.grey),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(
                    context,
                    rootNavigator: true,
                  ).pop(), // ✅ sirf dialog close
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF117A7A),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
