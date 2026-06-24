import 'package:flutter/material.dart';

class CustomExpansionFrame extends StatefulWidget {
  final String? title;           // Optional kar diya
  final Widget? titleWidget;     // Custom widget ke liye naya parameter
  final List<Widget> children;
  final bool initiallyExpanded;

  final String? actionText;
  final VoidCallback? onActionPressed;

  final ExpansionTileController? controller;

  const CustomExpansionFrame({
    super.key,
    this.title,                  // Required hata diya
    this.titleWidget,            // Naya parameter
    required this.children,
    this.initiallyExpanded = false,
    this.actionText,
    this.onActionPressed,
    this.controller,
  }) : assert(title != null || titleWidget != null,
  'Aapko title ya titleWidget mein se koi ek pass karna zaroori hai!');
  // Ye ensure karega ki dono mein se ek zaroor pass ho

  @override
  State<CustomExpansionFrame> createState() => _CustomExpansionFrameState();
}

class _CustomExpansionFrameState extends State<CustomExpansionFrame> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          visualDensity: VisualDensity.compact,
        ),
        child: ExpansionTile(
          controller: widget.controller,
          onExpansionChanged: (value) {
            setState(() {
              _isExpanded = value;
            });
          },
          visualDensity: VisualDensity.compact,
          tilePadding: const EdgeInsets.only(left: 12.0, right: 8),

          // YAHAN MAIN CHANGE HAI:
          // Agar titleWidget available hai toh usko dikhayein, warna purana Text dikhayein
          title: widget.titleWidget ?? Text(
            widget.title ?? '', // Null safety ke liye fallback
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.actionText != null)
                GestureDetector(
                  onTap: () {
                    if (widget.onActionPressed != null) {
                      widget.onActionPressed!();
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(right: 4.0, left: 8.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      widget.actionText!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.grey,
                size: 24,
              ),
            ],
          ),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          expandedAlignment: Alignment.topLeft,
          children: widget.children,
        ),
      ),
    );
  }
}