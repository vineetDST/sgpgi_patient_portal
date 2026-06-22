import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Utils/Dialog/remarks_dialog2.dart';

class OrderRemarksField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final double cellHeight;

  const OrderRemarksField({
    super.key,
    required this.controller,
    this.hintText = "Order Remarks",
    this.cellHeight = 60.0,
  });

  @override
  State<OrderRemarksField> createState() => _OrderRemarksFieldState();
}

class _OrderRemarksFieldState extends State<OrderRemarksField> {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.cellHeight,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Container(
        height: 38,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.shade300),
        ),
        // --- USING AN ACTUAL TEXT FIELD FOR THE TRIGGER ---
        child: TextField(
          controller: widget.controller,
          readOnly: true, // Makes it act like a button, stops keyboard
          enableInteractiveSelection: false, // Fixes the stuck black dot issue
          onTap: () async {
            await RemarksDialog.show(
              context,
              widget.controller,
              title: "Order Remarks",
              hintText: "Order Remarks",
            );

            setState(() {}); // Dialog close hone ke baad text refresh
          },
          style: const TextStyle(fontSize: 12, color: Colors.black87),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            border: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),

          ),
        ),
      ),
    );
  }
}
