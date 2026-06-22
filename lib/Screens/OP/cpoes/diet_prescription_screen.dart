import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Core/Utils/Expansion/expansion_frame.dart';
import 'package:qc_hospital/Core/Utils/NavigationBar/navigationbar.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/Modals/save_order_set_modal.dart';

class DietPrescriptionScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const DietPrescriptionScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<DietPrescriptionScreen> createState() => _DietPrescriptionScreenState();
}

class _DietPrescriptionScreenState extends State<DietPrescriptionScreen> {
  final TextEditingController _nonRcDrugCtrl = TextEditingController();
  TextEditingController _remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;


    return ClinicalBaseScaffold(
      title: "Diet Prescription",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Diet Prescription',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Diet Prescription",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Theme(
              data: Theme.of(
                context,
              ).copyWith(dividerColor: Colors.transparent),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  title: const Text(
                    "Diet Prescription",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  children: [
                    _buildDivider(),
                    _buildNutrientRow("Non Protein Calorie", "Kcal"),
                    _buildDivider(),
                    _buildNutrientRow("Calorie", "Kcal"),
                    _buildDivider(),
                    _buildNutrientRow("Fat", "gm"),
                    _buildDivider(),
                    _buildNutrientRow("Carbohydrates", "gm"),
                    _buildDivider(),
                    _buildNutrientRow("Salt", "gm"),
                    _buildDivider(),
                    _buildNutrientRow("Protein", "gm"),
                    _buildDivider(),
                    _buildNutrientRow("Phosphorous", "mg"),
                    _buildDivider(),
                    _buildNutrientRow("Calcium", "mg"),
                    _buildDivider(),
                    _buildNutrientRow("Fluid", "ml"),
                    _buildDivider(),
                    _buildNutrientRow("Potassium", "Meq"),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Diet Type"),
          const SizedBox(height: 8),
          SharedComponents.buildDropdown(hintText: "Renal Feed"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Method of Administration"),
          const SizedBox(height: 8),
          SharedComponents.buildDropdown(hintText: "HP Feed"),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Remarks"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            hintText: "Remarks",
            maxLines: 5,

            controller: _remarksController,
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "Current Order Amount     ",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                "0.00",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF117A7A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          _buildFullWidthButton("Save Order", isFilled: true, onTap: () {}),
          const SizedBox(height: 12),
          _buildFullWidthButton(
            "Save as Order Set",
            isFilled: false,
            onTap: () => _showSaveOrderSetModal(context),
          ),
          const SizedBox(height: 20),
        ],
      ),

      
    );
  }

  Widget _buildNutrientRow(String label, String unit) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            color: const Color(0xFFEAF9F9),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.black87,
              ),
            ),
          ),
          Container(width: 1, color: Colors.grey.shade300),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: SharedComponents.buildTextField(
                        controller: _nonRcDrugCtrl,
                        hintText: "",
                        height: 50,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 40,
                    child: Text(
                      unit,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black87,
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

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  Widget _buildFullWidthButton(
    String text, {
    required bool isFilled,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: isFilled
          ? ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.white,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

  void _showSaveOrderSetModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          SaveOrderSetModal(onDeleteTap: () => _showDeleteModal(context)),
    );
  }
}
