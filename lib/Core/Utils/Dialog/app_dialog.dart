import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppDialog {
  static Future<void> show({
    required BuildContext context,
    required Widget child,
    String? title,
    bool showClose = true,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.1),
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// 🔹 HEADER
                if (title != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (showClose)
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                    ],
                  ),

                /// 🔹 BODY
                child,
              ],
            ),
          ),
        );
      },
    );
  }
}