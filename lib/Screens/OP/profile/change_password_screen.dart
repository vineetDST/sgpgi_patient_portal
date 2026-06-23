import 'package:flutter/material.dart';
import 'package:qc_hospital/Widgets/profile_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ChangePasswordScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _loginIdCtrl = TextEditingController(
    text: "98765456789",
  );
  final TextEditingController _oldPasswordCtrl = TextEditingController();
  final TextEditingController _newPasswordCtrl = TextEditingController();
  final TextEditingController _confirmPasswordCtrl = TextEditingController();

  @override
  void dispose() {
    _loginIdCtrl.dispose();
    _oldPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileBaseScaffold(
      title: "Change Password",
      showDrawer: true,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Patient Profile',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SharedComponents.buildFormLabel("User Login Id"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _loginIdCtrl,
            hintText: "Enter the User Login Id",
            readOnly: true,
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Old Password"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _oldPasswordCtrl,
            hintText: "Enter the Old Password",
            obscureText: true,
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("New Password"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _newPasswordCtrl,
            hintText: "Enter the New Password",
            obscureText: true,
          ),
          const SizedBox(height: 16),

          SharedComponents.buildFormLabel("Confirm Password"),
          const SizedBox(height: 8),
          SharedComponents.buildTextField(
            controller: _confirmPasswordCtrl,
            hintText: "Enter the Confirm Password",
            obscureText: true,
          ),
          const SizedBox(height: 16),

          // _buildInputField("User Login Id", _loginIdCtrl, readOnly: true),
          // const SizedBox(height: 16),
          // _buildInputField(
          //   "Old Password",
          //   _oldPasswordCtrl,
          //   hint: "Enter the old Password",
          //   obscureText: true,
          // ),
          // const SizedBox(height: 16),
          // _buildInputField(
          //   "New Password",
          //   _newPasswordCtrl,
          //   hint: "Enter the New Password",
          //   obscureText: true,
          // ),
          // const SizedBox(height: 16),
          // _buildInputField(
          //   "Confirm Password",
          //   _confirmPasswordCtrl,
          //   hint: "Enter the Confirm Password",
          //   obscureText: true,
          // ),

          // const SizedBox(height: 40),

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

  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    String? hint,
    bool obscureText = false,
    bool readOnly = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            readOnly: readOnly,
            style: TextStyle(
              fontSize: 14,
              color: readOnly ? Colors.black54 : Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
