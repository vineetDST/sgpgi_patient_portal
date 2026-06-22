import 'package:flutter/material.dart';

class DetailRow extends StatelessWidget {
  final String label;

  // 🔥 Flexible value options
  final String? text;
  final TextStyle? textStyle;
  final Widget? customWidget;

  // 🔥 Interaction
  final VoidCallback? onTap;

  final bool showSort;
  final bool isLast;

  final double? width ;

  final bool removePadding;

  const DetailRow({
    super.key,
    required this.label,
    this.text,
    this.textStyle,
    this.customWidget,
    this.onTap,
    this.showSort = false,
    this.isLast = false,
    this.removePadding = false,
    this.width = 150,
  });

  @override
  Widget build(BuildContext context) {
    Widget value;

    // 🔥 Priority logic (enterprise pattern)
    if (customWidget != null) {
      value = customWidget!;
    } else {
      value = Text(
        text ?? "",
        style: textStyle ??
            const TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
      );
    }

    // 🔥 Click support
    if (onTap != null) {
      value = GestureDetector(
        onTap: onTap,
        child: value,
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300,width: 2),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // LEFT
            Container(
              width: width,

              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F8F8),
                border: Border(
                  right: BorderSide(color: Colors.grey.shade300,width: 2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(   // 🔥 FIX
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis, // 🔥 important
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  if (showSort) ...[
                    const Spacer(),
                    const Icon(Icons.unfold_more, size: 16),
                  ],
                ],
              ),
            ),

            // RIGHT
            Expanded(
              flex: 3,
              child: Container(
                padding: removePadding
                    ? EdgeInsets.zero
                    : const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                alignment: Alignment.centerLeft,
                child: value,
              ),
            ),
          ],
        ),
      ),
    );
  }
}