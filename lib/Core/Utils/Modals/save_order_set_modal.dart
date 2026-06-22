import 'package:flutter/material.dart';

class SaveOrderSetModal extends StatefulWidget {
  final VoidCallback onDeleteTap;

  const SaveOrderSetModal({super.key, required this.onDeleteTap});

  @override
  State<SaveOrderSetModal> createState() => _SaveOrderSetModalState();
}

class _SaveOrderSetModalState extends State<SaveOrderSetModal> {
  bool isConsultantChecked = true;
  bool isDepartmentChecked = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Order Set",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text("Order Set Name", style: TextStyle(fontSize: 13)),

            const SizedBox(height: 8),

            Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Dengue Analysis",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isConsultantChecked,
                      activeColor: const Color(0xFF117A7A),
                      onChanged: (v) {
                        setState(() {
                          isConsultantChecked = v ?? false;
                        });
                      },
                    ),
                    const Text("Consultant", style: TextStyle(fontSize: 13)),
                  ],
                ),

                const SizedBox(width: 16),

                Row(
                  children: [
                    Checkbox(
                      value: isDepartmentChecked,
                      activeColor: const Color(0xFF117A7A),
                      onChanged: (v) {
                        setState(() {
                          isDepartmentChecked = v ?? false;
                        });
                      },
                    ),
                    const Text("Department", style: TextStyle(fontSize: 13)),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("ICD Name", style: TextStyle(fontSize: 13)),
                Icon(Icons.add_circle, color: Color(0xFF4CAF50)),
              ],
            ),

            const SizedBox(height: 8),

            Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "ICD Name",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Column(
                  children: [
                    _buildOrderSetRow("ICD Code", "A90"),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                    _buildOrderSetRow("ICD Name", "A90: DENGUE FEVER"),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.shade300,
                    ),
                    _buildOrderSetRow("Action", "DELETE_ICON"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF117A7A),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Row(
            //   children: [
            //     Expanded(
            //       child: OutlinedButton(
            //         onPressed: () => Navigator.pop(context),
            //         child: const Text("Cancel"),
            //       ),
            //     ),

            //     const SizedBox(width: 16),

            //     Expanded(
            //       child: ElevatedButton(
            //         onPressed: () => Navigator.pop(context),
            //         child: const Text("Save"),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSetRow(String label, String value) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 120,
            padding: const EdgeInsets.all(12),
            color: const Color(0xFFEAF9F9),
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),

          Container(width: 1, color: Colors.grey.shade300),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.centerLeft,
              child: value == "DELETE_ICON"
                  ? GestureDetector(
                      onTap: widget.onDeleteTap,
                      child: Image.asset(
                        'assets/deleteicon.png',
                        height: 15,
                        width: 15,
                        color: Colors.red,
                      ),
                    )
                  : Text(value),
            ),
          ),
        ],
      ),
    );
  }
}
