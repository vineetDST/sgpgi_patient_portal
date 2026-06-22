import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';

class PatientFilterModal extends StatelessWidget {
  const PatientFilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40), // More bottom padding
      child: Column(
        mainAxisSize: MainAxisSize.min, // Hugs content
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Search Criteria",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.black87),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // First Block
          Align(
            alignment: Alignment.centerRight,
            child: const Icon(Icons.remove_circle, color: Colors.red, size: 20),
          ),
          Row(
            children: [
              Expanded(flex: 2, child: _buildDropdown("Patient Status")),
              const SizedBox(width: 16),
              Expanded(flex: 1, child: _buildDropdown("Is")),
            ],
          ),
          const SizedBox(height: 12),
          _buildDropdown("Under IP Care"),
          const SizedBox(height: 24),

          // Second Block
          Align(
            alignment: Alignment.centerRight,
            child: const Icon(Icons.remove_circle, color: Colors.red, size: 20),
          ),
          Row(
            children: [
              Expanded(flex: 2, child: _buildDropdown("Department")),
              const SizedBox(width: 16),
              Expanded(flex: 1, child: _buildDropdown("Is")),
            ],
          ),
          const SizedBox(height: 12),
          _buildDropdown("Cardiology"),
          const SizedBox(height: 24),

          // Third Block
          Align(
            alignment: Alignment.centerRight,
            child: const Icon(Icons.add_circle, color: Colors.green, size: 20),
          ),
          Row(
            children: [
              Expanded(flex: 2, child: _buildDropdown("CRNO")),
              const SizedBox(width: 16),
              Expanded(flex: 1, child: _buildDropdown("Like")),
            ],
          ),
          const SizedBox(height: 12),
          _buildDropdown("2025000653", isFaded: true),
          const SizedBox(height: 32),

          // Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Clear",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF117A7A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(String hint, {bool isFaded = false}) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hint,
            style: TextStyle(
              fontSize: 14,
              color: isFaded ? Colors.grey.shade400 : Colors.black87,
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: isFaded ? Colors.grey.shade400 : Colors.grey,
          ),
        ],
      ),
    );
  }
}
