import 'package:flutter/material.dart';

class InnnerDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  double? size ;
  final String hint;
  final bool enabled;

    InnnerDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.size = 11,
      this.hint = '--Select--',
      this.enabled = true,
  });

  // 🔥 Yeh function click hone par screen par menu show karega
  void _showCustomMenu(BuildContext context) async {
    // 1. Button ka current size aur position get karna
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    // 2. Menu kahan khulega uski position set karna (Button ke theek neeche)
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomLeft(Offset.zero), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    // 3. Menu show karna
    final selectedValue = await showMenu<String>(
      context: context,
      position: position,
      color: Colors.white,
      elevation: 0,
      // 🔥 Yahan par hum width fixed kar rahe hain (Button ke size ke barabar)
      constraints: BoxConstraints(
        minWidth: button.size.width,
        maxWidth: button.size.width,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Colors.grey.shade300, width: 1.5),
      ),
      items: items.map((item) {
        return PopupMenuItem<String>(
          value: item,
          child: Text(
            item,
            style:  TextStyle(
              color: Colors.black87,
              fontSize: size == 16 ? 14 : 11,
            ),
          ),
        );
      }).toList(),
    );

    // 4. Agar user ne kuch select kiya h, to usko update karna
    if (selectedValue != null) {
      onChanged(selectedValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 🔥 GestureDetector ka use karke hum pure container ko clickable bana rahe hain
    return GestureDetector(
      onTap: () => _showCustomMenu(context),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: size!,
        ),
        width: double.infinity, // Ye space le lega apne parent (Expanded) ke hisaab se
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  value ?? hint,
                  style:  TextStyle(
                    color: !enabled
                        ? Colors.grey.shade500
                        : (value == null || value == hint)
                        ? Colors.grey.shade400
                        : Colors.black87,
                    fontSize: size == 16 ? 14 :11,
                    fontWeight: FontWeight.w500
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
                Icon(
                Icons.arrow_drop_down,
                size: 16,
                color:  enabled ? Colors.grey : Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}