import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class BloodRequestModal extends StatelessWidget {
  const BloodRequestModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height *
          0.85, // Matches the tall look of the modal
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Blood Request",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColor.color1E1E1E),
                ),
              ],
            ),
          ),

          // Scrollable Form Body
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SharedComponents.buildFormLabel(
                    "Department",
                    isRequired: true,
                  ),
                  const SizedBox(height: 8),
                  SharedComponents.buildDropdown(hintText: "Cardiology"),
                  const SizedBox(height: 16),

                  SharedComponents.buildFormLabel("Ward No / Type"),
                  const SizedBox(height: 8),
                  // Greyed out read-only field
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Text(
                      "1703 Endocrinology Transgender A04 /\nNursing Station",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SharedComponents.buildFormLabel("Bed No"),
                            const SizedBox(height: 8),
                            SharedComponents.buildTextField(hintText: "5"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SharedComponents.buildFormLabel("Type"),
                            const SizedBox(height: 8),
                            SharedComponents.buildTextField(
                              hintText: "General",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SharedComponents.buildFormLabel("Admission Date"),
                            const SizedBox(height: 8),
                            SharedComponents.buildTextField(
                              hintText: "10-10-2025",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SharedComponents.buildFormLabel("Blood Group"),
                            const SizedBox(height: 8),
                            SharedComponents.buildTextField(hintText: "AB+"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  SharedComponents.buildFormLabel("Indication for Tx"),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(
                    hintText: "Indication for Tx",
                  ),
                  const SizedBox(height: 16),

                  SharedComponents.buildFormLabel("Past Tx History"),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(hintText: "Past Tx History"),
                  const SizedBox(height: 16),

                  SharedComponents.buildFormLabel("Remarks"),
                  const SizedBox(height: 8),
                  SharedComponents.buildTextField(
                    hintText: "Remarks",
                    maxLines: 5,
                    // height: 80,
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
