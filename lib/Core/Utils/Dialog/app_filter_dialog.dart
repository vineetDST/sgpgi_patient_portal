import 'package:flutter/material.dart';

class AppFilterDialog {
  static Future<void> show({
    required BuildContext context,
    required Widget child,

    /// 🔹 HEADER
    String? title,
    bool showClose = true,

    /// 🔹 FOOTER
    bool showFooter = false,
    VoidCallback? onClear,
    VoidCallback? onSubmit,
    String submitText = "Search",

    /// 🔹 CONFIG
    double widthFactor = 0.85,
    bool barrierDismissible = true,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierLabel: "Sidebar",
      barrierColor: Colors.black.withOpacity(0.1),
      transitionDuration: duration,

      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * widthFactor,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      /// 🔹 HEADER (Optional)
                      if (title != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (showClose)
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () => Navigator.pop(context),
                              ),
                          ],
                        ),

                      /// 🔹 BODY (Scrollable)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              child,
                              if (showFooter)
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () =>
                                            onClear ??
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop(), // ✅ sirf dialog close
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                          side: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: const Text(
                                          "Clear",
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
                                        onPressed: () =>
                                            onSubmit ??
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop(), // ✅ sirf dialog close
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF117A7A,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        child: const Text(
                                          "Search",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),

                      /// 🔹 FOOTER (Optional)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }
}
