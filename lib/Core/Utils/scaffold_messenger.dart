import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';

enum NotificationType { success, error, information, warning }

void scaffoldMessenger(
    BuildContext context, {
      required String title,
      required String message,
      required NotificationType type,
      Duration duration = const Duration(seconds: 3), // Thoda duration badhaya taaki user padh sake
    }) {
  final overlay = Overlay.of(context);
  late OverlayEntry barrierEntry;
  late OverlayEntry notificationEntry;

  // 1️⃣ Barrier entry (background unclickable)
  barrierEntry = OverlayEntry(
    builder: (_) => const ModalBarrier(
      dismissible: false,
      color: Colors.transparent,
    ),
  );

  // 2️⃣ Notification entry
  notificationEntry = OverlayEntry(
    builder: (context) {
      Color bgColor;
      Color textColor = Colors.white; // Default text color

      // Color aur Text Color ki logic
      switch (type) {
        case NotificationType.error:
          bgColor = const Color(0xFFE54D4D); // Red for Error (matching your image)
          break;
        case NotificationType.information:
          bgColor = const Color(0xFF3B82F6); // Blue for Information
          break;
        case NotificationType.success:
          bgColor = const Color(0xFF22C55E); // Green for Success
          break;
        case NotificationType.warning:
          bgColor = const Color(0xFFFACC15); // Yellow for Warning
          textColor = Colors.black; // Warning par text/icon black rahega
          break;
      }

      return _BottomNotificationWidget(
        title: title,
        message: message,
        bgColor: bgColor,
        textColor: textColor,
        onDismiss: () {
          notificationEntry.remove();
          barrierEntry.remove(); // remove barrier when notification is gone
        },
        duration: duration,
      );
    },
  );

  // 3️⃣ Insert barrier first, then notification on top
  overlay.insert(barrierEntry);
  overlay.insert(notificationEntry);
}

/// Widget for the notification
class _BottomNotificationWidget extends StatefulWidget {
  final String title;
  final String message;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onDismiss;
  final Duration duration;

  const _BottomNotificationWidget({
    Key? key,
    required this.title,
    required this.message,
    required this.bgColor,
    required this.textColor,
    required this.onDismiss,
    required this.duration,
  }) : super(key: key);

  @override
  _BottomNotificationWidgetState createState() =>
      _BottomNotificationWidgetState();
}

class _BottomNotificationWidgetState extends State<_BottomNotificationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Ab animation neeche se upar aayegi
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5), // start off-screen bottom
      end: Offset.zero, // slide to original position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    // Auto dismiss after duration
    _timer = Timer(widget.duration, _dismissNotification);
  }

  void _dismissNotification() {
    if (mounted) {
      _controller.reverse().then((value) => widget.onDismiss());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Positioned(
      bottom: 110 + keyboardHeight,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(30), // Image ki tarah rounded
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // Wrap content height
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: widget.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.message,
                        style: TextStyle(
                          color: widget.textColor,
                          fontSize: 12.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Trailing Close (x) Button
                GestureDetector(
                  onTap: () {
                    _timer?.cancel();
                    _dismissNotification(); // Manual close par bhi animate hoga
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      color: widget.textColor,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}