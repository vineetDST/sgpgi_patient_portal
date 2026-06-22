import 'package:flutter/material.dart';

class CustomBottomSheet {
  static void show(
      BuildContext context, {
        required String title,
        required Widget child,
        double height = 0.7,
      }) {
    showModalBottomSheet(
      context: context,

      isScrollControlled: true, // Taki bada form hone par screen ke upar tak ja sake
      backgroundColor: Colors.transparent, // Transparent taki hum apna custom border radius de sakein
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * height,
          // Keyboard open hone par bottom sheet ko upar push karne ke liye padding
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          constraints: BoxConstraints(
            // Max height screen ki 90% set ki hai
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Content ke hisaab se height lega
            children: [
              const SizedBox(height: 12),

              // 1. Top Drag Handle (Chota sa grey line)
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 8),

              // 2. Header Row (Title & Close Button)
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.black54),
                      onPressed: () => Navigator.of(context).pop(), // Dialog close karne ke liye
                    ),
                  ],
                ),
              ),

              // 3. Dynamic Content Area (Jo aap pass karenge)
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: child, // Yahan aapka dynamic form/content aayega
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}