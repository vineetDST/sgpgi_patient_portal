import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomRemarksField extends StatefulWidget {
  final String title;
  final String hintText;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String? remarksHintText;

  const CustomRemarksField({
    super.key,
    this.title = "Remarks",
    this.hintText = "Remarks",
    this.initialValue,
    this.onChanged,
    this.remarksHintText,
  });

  @override
  State<CustomRemarksField> createState() => _CustomRemarksFieldState();
}

class _CustomRemarksFieldState extends State<CustomRemarksField> {
  late TextEditingController _controller;
  String _displayText = "";

  @override
  void initState() {
    super.initState();
    // Default text set karna agar kuch pass kiya gaya ho
    _displayText = widget.initialValue ?? "";
    _controller = TextEditingController(text: _displayText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Dialog Box Open karne ka function
  void _showRemarksModal() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Container(
                // height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Stack(
                  children: [
                    TextField(
                      controller: _controller,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: widget.remarksHintText ?? widget.title,
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(12),
                      ),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          final lineCount =
                              '\n'.allMatches(newValue.text).length + 1;

                          if (lineCount > 5) {
                            return oldValue; // 6th line allow nahi karega
                          }

                          return newValue;
                        }),
                      ],
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Image.asset(
                        'assets/txtarea.png', // Uses the uploaded icon
                        width: 14,
                        height: 14,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).then((_) {
      // Jab dialog close ho (close icon ya bahar click karne se), tab state update karein
      setState(() {
        _displayText = _controller.text;
      });
      // Agar parent widget ko data chahiye toh callback trigger karein
      if (widget.onChanged != null) {
        widget.onChanged!(_displayText);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showRemarksModal,
      child: Container(
        height: 38,
        width: double.infinity, // Taki ye puri width cover kare
        padding: const EdgeInsets.symmetric(horizontal: 6),
        alignment: Alignment.centerLeft, // Text left me align rahe
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          _displayText.isEmpty ? widget.hintText : _displayText,
          maxLines: 1, // Text overlow na ho isliye maxline 1
          overflow:
              TextOverflow.ellipsis, // Bada text ho to last me "..." aa jaye
          style: TextStyle(
            fontSize: 11,
            // Agar user ne type kiya hai to text dark dikhega, warna grey
            color: _displayText.isEmpty ? Colors.grey : Colors.black87,
          ),
        ),
      ),
    );
  }
}
