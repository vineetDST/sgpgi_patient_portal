import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RemarksDialog {
  static Future<void> show(
      BuildContext context,
      TextEditingController controller, {
        String title = "Remarks",
        String hintText = "Remarks",
      }) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Container(
                // height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Stack(
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: hintText ?? title,
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final lineCount = '\n'.allMatches(newValue.text).length + 1;

                          if (lineCount > 5) {
                            return oldValue; // 6th line allow nahi karega
                          }

                          return newValue;
                        }),
                      ],
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Image.asset(
                        'assets/txtarea.png', // Uses the uploaded icon
                        width: 14,
                        height: 14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}