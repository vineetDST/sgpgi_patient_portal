
import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Sidesheet/right_swipe_wrapper.dart';



/// 🔹 SHOW
void showRightSideSheet({
  required BuildContext context,
  required Widget child,
}) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Close",
    barrierColor: Colors.black.withOpacity(0.1),
    transitionDuration: const Duration(milliseconds: 300),
    useRootNavigator: true, // ⭐ IMPORTANT

    pageBuilder: (_, __, ___) {
      return Align(
        alignment: Alignment.centerRight,
        child: RightSwipeCloseWrapper(
          child: child,
        ),
      );
    },

    transitionBuilder: (_, animation, __, child) {
      final slide = Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeOut),
      );

      return SlideTransition(position: slide, child: child);
    },
  );
}

/// 🔹 CLOSE (USE EVERYWHERE)
void closeSideSheet(BuildContext context) {
  final navigator = Navigator.of(context, rootNavigator: true);
  if (navigator.canPop()) {
    navigator.pop();
  }
}
