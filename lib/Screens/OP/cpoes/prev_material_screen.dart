import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

import 'package:qc_hospital/Screens/OP/cpoes/material_screen.dart';

// --- Import the Custom Calendar Dialog ---
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

class PrevMaterialScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const PrevMaterialScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<PrevMaterialScreen> createState() => _PrevMaterialScreenState();
}

class _PrevMaterialScreenState extends State<PrevMaterialScreen> {
  // Controllers
  final TextEditingController _qtyCtrl1 = TextEditingController(text: "1.0");
  final TextEditingController _qtyCtrl2 = TextEditingController(text: "1.0");

  @override
  void dispose() {
    _qtyCtrl1.dispose();
    _qtyCtrl2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClinicalBaseScaffold(
      title: "Material",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: 'Material',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Existing Material Order",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MaterialScreen(
                          patientName: widget.patientName,
                          crn: widget.crn,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "New Order",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      AppFilterDialog.show(
                        context: context,
                        title: "Search",
                        showFooter: true,
                        child: _MaterialFilterSidebar(),
                      );

                    },
                    child: const Icon(
                      Icons.filter_alt_outlined,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          _buildSyncedTable(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSyncedTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF9F9),
                border: Border(right: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Column(
                children: [
                  _buildLeftCell("Material Name", 60),
                  _buildDivider(),
                  _buildLeftCell("Qty", 60),
                  _buildDivider(),
                  _buildLeftCell("Unit Price", 60),
                  // _buildDivider(),
                  // _buildLeftCell("Store", 60),
                  _buildDivider(),
                  _buildLeftCell("Status", 60),
                  _buildDivider(),
                  _buildLeftCell("Effective From", 60),
                  _buildDivider(),
                  _buildLeftCell("Action", 60),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: IntrinsicWidth(
                  child: Row(
                    children: [
                      _buildItemColumn(
                        "SYRINGE INSULIN WITH\nNEEDLE 1001U",
                        _qtyCtrl1,
                        "6.8",
                        "Ordered",
                        "08-10-2025",
                      ),
                      Container(width: 1, color: Colors.grey.shade300),
                      _buildItemColumn(
                        "SYRINGE INSULIN WITH\nNEEDLE 1001U",
                        _qtyCtrl2,
                        "6.8",
                        "Ordered",
                        "08-10-2025",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemColumn(
    String name,
    TextEditingController qtyCtrl,
    String price,
    String status,
    String date,
  ) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          _buildRightTextCell(name, 60),
          _buildDivider(),
          _buildRightQtyCell(qtyCtrl, 60),
          _buildDivider(),
          _buildRightTextCell(price, 60),
          // _buildDivider(),
          // _buildRightDropdownCell(60),
          _buildDivider(),
          _buildRightPillCell(status, 60),
          _buildDivider(),
          _buildRightTextCell(date, 60),
          _buildDivider(),
          _buildRightActionCell(60),
        ],
      ),
    );
  }

  Widget _buildLeftCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Colors.black87,
      ),
    ),
  );

  Widget _buildRightTextCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(
      text,
      style: const TextStyle(fontSize: 12, color: Colors.black87),
    ),
  );

  Widget _buildRightPillCell(String text, double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    ),
  );

  Widget _buildRightActionCell(double height) => Container(
    height: height,
    alignment: Alignment.centerLeft,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      children: [
        const Icon(Icons.print, color: Colors.black87, size: 20),

        AppDeleteIcon(),
      ],
    ),
  );

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);

  Widget _buildRightQtyCell(TextEditingController ctrl, double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            child: TextField(
              controller: ctrl,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
              selectionControls: NoCursorHandleControls(),

              contextMenuBuilder: (_, __) => const SizedBox.shrink(),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 14),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text("Nos", style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRightDropdownCell(double height) {
    return Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("001_NEW OPD HRF PHARMA", style: TextStyle(fontSize: 10)),
            Icon(Icons.arrow_drop_down, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // MODALS & SIDEBARS
  // =========================================================================

  void _showDeleteModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.red, width: 1.5),
                ),
                child: const Icon(Icons.close, color: Colors.red, size: 32),
              ),
              const SizedBox(height: 24),
              const Text(
                "Are you sure you want to\ndelete the record?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
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
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC60000),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Material Filter Sidebar (Material Filter.png)
  void _showMaterialFilterSidebar(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Filter",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: const _MaterialFilterSidebar(),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: const Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }
}

// Isolated Sidebar Widget for PrevMaterialScreen (Material Filter.png)
class _MaterialFilterSidebar extends StatefulWidget {
  const _MaterialFilterSidebar();

  @override
  State<_MaterialFilterSidebar> createState() => _MaterialFilterSidebarState();
}

class _MaterialFilterSidebarState extends State<_MaterialFilterSidebar> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now().add(const Duration(days: 10));
  final _materialNameCtrl = TextEditingController();

  @override
  void dispose() {
    _materialNameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Row(
          children: [
            Expanded(
              child: _buildDateSection(
                "Order From Date",
                _fromDate,
                    (d) => setState(() => _fromDate = d),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDateSection(
                "To Date",
                _toDate,
                    (d) => setState(() => _toDate = d),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        SharedComponents.buildFormLabel("Material Name"),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(
          controller: _materialNameCtrl,
          hintText: "Material Name",
        ),
        const SizedBox(height: 16),


      ],
    );
  }

  Widget _buildDateSection(
    String label,
    DateTime date,
    ValueChanged<DateTime> onDateSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedComponents.buildFormLabel(label),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? picked = await CustomCalendarDialog.show(
              context,
              initialDate: date,
            );
            if (picked != null) onDateSelected(picked);
          },
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd-MM-yy').format(date),
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
                const Icon(
                  Icons.calendar_month,
                  size: 18,
                  color: Colors.black87,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
