import 'package:flutter/material.dart';

class ExpandedDropdown extends StatefulWidget {
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final String hint;
  final bool enabled;

  const ExpandedDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint = "--Select--",
    this.enabled = true,
  });

  @override
  State<ExpandedDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<ExpandedDropdown> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: widget.enabled ? Colors.white : Colors.grey.shade100,

            // color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            enabled: widget.enabled,
            // onSelected: widget.onChanged,
            onOpened: () {
              setState(() => isOpen = true);
            },
            onCanceled: () {
              setState(() => isOpen = false);
            },
            onSelected: (value) {
              setState(() => isOpen = false);
              widget.onChanged(value);
            },
            offset: const Offset(0, 48),
            color: Colors.white,
            elevation: 0,
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.value ?? widget.hint,
                      style: TextStyle(
                        color: !widget.enabled
                            ? Colors.grey.shade500
                            : (widget.value == null ||
                                  widget.value == widget.hint)
                            ? Colors.grey.shade400
                            : Colors.black87,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: widget.enabled ? Colors.grey : Colors.grey.shade400,
                  ),
                ],
              ),
            ),
            itemBuilder: (context) => widget.items
                .map(
                  (item) => PopupMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
