import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qc_hospital/Widgets/profile_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class ChangeContactScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ChangeContactScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ChangeContactScreen> createState() => _ChangeContactScreenState();
}

class _ChangeContactScreenState extends State<ChangeContactScreen> {
  final TextEditingController _mobileCtrl = TextEditingController(
    text: "+91 9876543210",
  );
  final TextEditingController _emailCtrl = TextEditingController(
    text: "ramsharma@gmail.com",
  );

  bool isValid = false ;
  @override
  void dispose() {
    _mobileCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileBaseScaffold(
      title: "Change Contact",
      showDrawer: true, // Matches hamburger menu in the design
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction:
          'Patient Profile', // Highlights Dashboard based on context
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildInputField("Mobile", _mobileCtrl),
          SharedComponents.buildFormLabel("Mobile"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _mobileCtrl,
            hintText: "Enter the Mobile Number",
            keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(14),

              ],
            onChanged: (value) {
              if (value.isNotEmpty &&
                  !value.startsWith("+91 ")) {
                _mobileCtrl.text =
                    "+91 " + value;
                _mobileCtrl.selection =
                    TextSelection.fromPosition(
                      TextPosition(
                          offset:
                          _mobileCtrl
                              .text.length),
                    );
              }
              if (value == "+91 ") {
                _mobileCtrl.clear();
              }



            },


          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Email"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _emailCtrl,
            hintText: "Enter the Email ID",
          ),
          const SizedBox(height: 16),

          // _buildInputField("Email", _emailCtrl),
          const SizedBox(height: 40),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // Handle Save
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A), // Theme Teal
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
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

  // Widget _buildInputField(
  //   String label,
  //   TextEditingController controller, {
  //   String? hint,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: const TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.w400,
  //           color: Colors.black87,
  //         ),
  //       ),
  //       const SizedBox(height: 8),
  //       Container(
  //         height: 48,
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(color: Colors.grey.shade300),
  //         ),
  //         child: TextField(
  //           controller: controller,
  //           style: const TextStyle(fontSize: 14, color: Colors.black54),
  //           decoration: InputDecoration(
  //             hintText: hint,
  //             hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
  //             border: InputBorder.none,
  //             contentPadding: const EdgeInsets.symmetric(
  //               horizontal: 16,
  //               vertical: 14,
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
