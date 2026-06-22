import 'package:flutter/material.dart';

class CustomExpansionFrame extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;

  final String? actionText;
  final VoidCallback? onActionPressed;

  const CustomExpansionFrame({
    super.key,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,

    this.actionText, // Jaise ki 'Add'
    this.onActionPressed, // Tap event ke liye

  });

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
      margin: const EdgeInsets.symmetric(vertical: 4.0), // Outer margin kam kiya
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Theme(
        // Splash aur divider effect hatane ke liye
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          visualDensity: VisualDensity.compact, // Height kam karne mein help karta hai
        ),
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(() {
              _isExpanded = value;
            });
          },

          visualDensity: VisualDensity.compact,
          tilePadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),

          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 14, // Font size thoda chota kiya image match karne ke liye
              color: Colors.black87,
              fontWeight: FontWeight.w400,
            ),
          ),



          // Trailing ko modify karke Row banaya
          trailing: Row(
            mainAxisSize: MainAxisSize.min, // Jaroori hai taaki Row pura space na le
            children: [
              // Agar actionText pass kiya gaya hai, tabhi Text show karein
              if (widget.actionText != null)
                GestureDetector(
                  onTap: () {
                    // ExpansionTile ke click se alag sirf Text par click handle karne ke liye
                    if (widget.onActionPressed != null) {
                      widget.onActionPressed!();
                    }
                  },
                  // HitTestBehavior.opaque ensure karega ki text ke aas-paas ka empty space bhi clickable ho
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(right: 4.0, left: 8.0, top: 8.0, bottom: 8.0),
                    child: Text(
                      widget.actionText!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500, // Image se match karne ke liye thoda bold
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


          childrenPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
          expandedAlignment: Alignment.topLeft,
          children: widget.children,
        ),
      ),
    );
  }
}