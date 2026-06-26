import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Utils/scaffold_messenger.dart';
import 'package:qc_hospital/Screens/Login/login.dart';
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
            keyboardType: TextInputType.number,
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


          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                _changePassword(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A), // Theme Teal
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Submit",
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

  void _changePassword(BuildContext context) {

    var userid = _loginIdCtrl.text.toString();
    var oldPwd = _oldPasswordCtrl.text.toString() ;
    var newPwd = _newPasswordCtrl.text.toString() ;
    var cnfPwd = _confirmPasswordCtrl.text.toString() ;

    if(userid == null || userid.isEmpty ) {
      _showError(context, 'Please enter User Login Id field');
    }


    else if(oldPwd == null || oldPwd.isEmpty) {
    _showError(context, 'Please enter Old Password field');
    }
    else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$').hasMatch(oldPwd)) {
      _showError(context, 'Old Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a number, and a special character, and must not contain spaces.');
    }
    else if(oldPwd != DummyData.password){
      _showError(context, 'Old Passwrod is not correct');
    }

    else if(newPwd == null || newPwd.isEmpty) {
      _showError(context, 'Please enter New Password field');
    }
    else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$').hasMatch(newPwd)) {
      _showError(context, 'New Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a number, and a special character, and must not contain spaces.');
    }

    else if(cnfPwd == null || cnfPwd.isEmpty) {
      _showError(context, 'Please enter Confirm Password field');
    }
    else if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&#!])[A-Za-z\d@$!%*?&#!]{8,}$').hasMatch(cnfPwd)) {
      _showError(context, 'Confirm Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a number, and a special character, and must not contain spaces.');
    }
    else if(newPwd != cnfPwd){
      _showError(context, 'New Password & Confirm Password should be same');
    }
    else {
      DummyData.password = cnfPwd.toString();
      scaffoldMessenger(
        context,
        title: "Change Password",
        message: 'Password is changed sucessfully',
        type: NotificationType.success,
      );

      Future.delayed(const Duration(seconds: 3), () {

        if (context.mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) {
              return LoginScreen(loginby: '');
            }),
                (route) => false,
          );
        }
      });
    }



  }

  void _showError(BuildContext context,String message) {
    scaffoldMessenger(
      context,
      title: "Change Password",
      message: message,
      type: NotificationType.error,
    );
  }
}
