import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class EditAllergyScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const EditAllergyScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<EditAllergyScreen> createState() => _EditAllergyScreenState();
}

class _EditAllergyScreenState extends State<EditAllergyScreen> {
  // --- FUNCTIONAL STATE VARIABLES ---
  String? _allergyType = 'Drug'; // Pre-filled for Edit
  String _allergyStatus = 'Active'; // Pre-filled for Edit
  String? _durationUnit = 'Days';

  final TextEditingController _allergicToController = TextEditingController(
    text: "Gluten",
  );
  final TextEditingController _reactionSearchController =
      TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController(
    text: "Patient reported mild itching.",
  );

  final List<String> _reactions = [
    'Cough',
    'Dizziness',
    'Head Ache',
    'Itching',
    'Deramatographism',
    'Jaundice',
  ];

  String? _reaction = null;

  @override
  void dispose() {
    _allergicToController.dispose();
    _reactionSearchController.dispose();
    _durationController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _addReaction(String reaction) {
    if (reaction.trim().isNotEmpty && !_reactions.contains(reaction.trim())) {
      setState(() {
        _reactions.add(reaction.trim());
        _reactionSearchController.clear();
      });
    }
  }

  void _removeReaction(String reaction) {
    setState(() {
      _reactions.remove(reaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClinicalBaseScaffold(
      title: "Allergy",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Edit Allergy',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Edit Allergy",
            style: AppTextStyles.RegH3.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Allergy Type"),
          const SizedBox(height: 8),

          // _buildFunctionalDropdown(
          //   value: _allergyType,
          //   hint: "--Select--",
          //   items: ["Drug", "Food", "Environmental", "Insect"],
          //   onChanged: (val) => setState(() => _allergyType = val),
          // ),
          FunctionalDropdown(
            value: _allergyType,
            hint: "--Select--",
            items: ["--Select--", "Drug", "Food", "Environmental", "Insect"],
            onChanged: (val) => setState(() => _allergyType = val),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Allergic To", isRequired: true),
          const SizedBox(height: 8),
          _buildSearchField(
            controller: _allergicToController,
            hint: "Search allergen...",
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Reactions", isRequired: true),
          const SizedBox(height: 8),
          _buildAddReactionField(),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _reactions
                  .map((reaction) => _buildReactionChip(reaction))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Allergy Status"),
          Row(
            children: [
              _buildRadio("Active"),
              const SizedBox(width: 8),
              _buildRadio("Inactive"),
              const SizedBox(width: 8),
              _buildRadio("Resolved"),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Duration"),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildFunctionalTextField(
                  controller: _durationController,
                  hint: " ",
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildFunctionalDropdown(
                  value: _durationUnit,
                  hint: "Days",
                  items: ["Days", "Weeks", "Months", "Years"],
                  onChanged: (val) => setState(() => _durationUnit = val),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Remarks"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
              hintText: "Remarks",
              maxLines: 5,
              controller: _remarksController

          ),
          const SizedBox(height: 16),
          const SizedBox(height: 32),

          SharedComponents.buildActionButtons(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // --- FUNCTIONAL WIDGET BUILDERS ---

  // --- UPDATED: Uses PopupMenuButton to force an outline border and a true "Dropdown" attachment ---
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
                width: 1,
              ), // THE OUTLINE BORDER
            ),
            // The visible button part
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value ?? hint,
                    style: TextStyle(
                      color: value == null
                          ? Colors.grey.shade400
                          : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
            // The dropdown menu items
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

  Widget _buildFunctionalTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    double height = 48,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          suffixIcon: const Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildAddReactionField() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: _reactionSearchController,
        onSubmitted:
            _addReaction, // Adds reaction when pressing enter on keyboard
        decoration: InputDecoration(
          hintText: "Type reaction and add...",
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
            onPressed: () => _addReaction(_reactionSearchController.text),
          ),
        ),
      ),
    );
  }

  Widget _buildReactionChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF117A7A),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () => _removeReaction(label), // Function to remove chip
            child: const Icon(Icons.close, size: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildRadio(String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: _allergyStatus,
          activeColor: const Color(0xFF117A7A),
          onChanged: (val) => setState(() => _allergyStatus = val!),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }
}
