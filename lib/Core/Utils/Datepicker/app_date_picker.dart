import 'package:flutter/material.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';

// tumhara custom dialog import karo
import 'custom_date_picker_dialog.dart';


class AppDatePicker {
  static Future<DateTime?> pick({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final picked = await showDialog<DateTime>(
      context: context,
      builder: (context) => CustomDatePickerDialog(
        initialDate: initialDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2020),
        lastDate: lastDate ?? DateTime(2100),
      ),
    );

    return picked;
  }
}

class AppDateField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool enabled;
  double? height ;
  final bool isDense ;

  // Constructor
  AppDateField({
    super.key,
    this.hintText, // Hint text optional hai
    required this.controller,
    required this.onTap,
    this.enabled = true,

    this.isDense = false,
    this.height ,
  }) {
    // Ye Logic Constructor mein hi add kar diya:
    // Agar hintText pass nahi hua hai AUR controller khali hai, toh Aaj ki Date set kar do
    if ((hintText == null || hintText!.isEmpty) && controller.text.isEmpty) {
      final now = DateTime.now();
      // Date Format: dd/mm/yyyy (Aap ise apne hisaab se change kar sakte hain)
      controller.text = "${now.day.toString().padLeft(2, '0')}-"
          "${now.month.toString().padLeft(2, '0')}-"
          "${now.year.toString().substring(2)}";
    }
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Container(
  //         padding: EdgeInsets.symmetric(
  //           vertical: MediaQuery.of(context).size.height * 0.015,
  //           horizontal: MediaQuery.of(context).size.height * 0.015,
  //         ),
  //         decoration: BoxDecoration(
  //           // 2. Disable hone par background thoda grey dikhega
  //           color: enabled ? Colors.white : Colors.grey.shade100,
  //           borderRadius: BorderRadius.circular(8),
  //           border: Border.all(
  //             color: enabled ? const Color(0xFFEAEAEA) : Colors.grey.shade300,
  //             width: 1.5,
  //           ),
  //         ),
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: TextField(
  //                 controller: controller,
  //                 readOnly: true,
  //                 enabled: enabled, // 3. TextField ko disable karna
  //                 // 4. Sirf tabhi click hoga jab enabled true ho
  //                 onTap: enabled ? onTap : null,
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   // Disable par text thoda light dikhega
  //                   color: enabled ? Colors.black87 : Colors.grey.shade500,
  //                 ),
  //                 decoration: InputDecoration(
  //                   hintText: hintText , // Aap isko "Select Date" ya "dd/mm/yyyy" bhi kar sakte hain
  //                   hintStyle: TextStyle(
  //                     color: const Color(0xFFB7B7B7),
  //                     fontWeight: FontWeight.w400,
  //                     fontSize: MediaQuery.of(context).size.height * 0.016,
  //                   ),
  //                   filled: true,
  //                   fillColor: Colors.transparent,
  //                   contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
  //                   isDense: true,
  //                   border: InputBorder.none,
  //                 ),
  //               ),
  //             ),
  //             GestureDetector(
  //               // Icon pe bhi tap tabhi hoga jab enabled true ho
  //               onTap: enabled ? onTap : null,
  //               child: Container(
  //                 child: Icon(
  //                   Icons.calendar_month,
  //                   // Icon ka color bhi disable hone par grey ho jayega
  //                   color: enabled ? const Color(0xFF000000) : Colors.grey.shade400,
  //                   size: 15,
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

    @override
    Widget build(BuildContext context) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Stack(
          children: [
            TextField(
              controller: controller,


              onTap: enabled ? onTap : null,

              enabled: enabled,
              selectionControls: NoCursorHandleControls(),
              readOnly: true,
              contextMenuBuilder: (_, __) => const SizedBox.shrink(),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                border: InputBorder.none,
                suffix: Container(
                  child: Icon(
                    Icons.calendar_month,
                    color: enabled ? const Color(0xFF000000) : Colors.grey.shade400,
                    size: 15,

                  ),
                ),
                isDense: isDense,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: isDense ? 10 : 14,
                ),
              ),
            ),

          ],
        ),
      );
    }
}