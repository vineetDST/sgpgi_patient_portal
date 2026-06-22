import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // REQUIRED FOR DATE FORMATTING
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/OP/op_action.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';

// --- Import the Base Scaffold ---
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class IpChangeBedStatusScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const IpChangeBedStatusScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });
  @override
  State<IpChangeBedStatusScreen> createState() =>
      _IpChangeBedStatusScreenState();
}

class _IpChangeBedStatusScreenState extends State<IpChangeBedStatusScreen> {
  OverlayEntry? _popupEntry;
  final Map<String, LayerLink> _bedLinks = {};

  // --- FUNCTIONAL STATE VARIABLES ---
  String? _selectedUnit;
  String? _selectedDepartment;
  String? _selectedWard;
  DateTime _filterDate = DateTime.now();
  DateTime _blockFromDate = DateTime.now();
  DateTime _blockToDate = DateTime.now().add(const Duration(days: 1));

  LayerLink _getLink(String id) {
    _bedLinks.putIfAbsent(id, () => LayerLink());
    return _bedLinks[id]!;
  }

  void _removePopup() {
    _popupEntry?.remove();
    _popupEntry = null;
  }

  @override
  void dispose() {
    _removePopup();
    super.dispose();
  }

  // --- FILTER SIDEBAR ---
  void _showFilterSidebar() {
    final List<String> unitOptions = [
      "1 Day General Bed",
      "1 Day Private Bed",
      "2 Days General Bed",
      "2 Days Private Bed",
      "7 Days General Bed",
      "7 Days Private Bed",
      ">7 Days General Bed",
      ">7 Days Private Bed",
      "Admission for Surgery",
      "MICU Admission",
      "SICU Admission",
      "Pre-Operative Ward",
      "Kidney Transplantation Unit",
      "Bone Marrow Transplantation Unit",
    ];

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Filter",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: double.infinity,
              color: Colors.white,
              child: SafeArea(
                child: StatefulBuilder(
                  builder: (context, setSidebarState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Search",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Department",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await CustomCalendarDialog.show(
                                              context,
                                              initialDate: _filterDate,
                                            );
                                        if (pickedDate != null) {
                                          setSidebarState(
                                            () => _filterDate = pickedDate,
                                          );
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            DateFormat(
                                              'dd-MM-yy',
                                            ).format(_filterDate),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Icon(
                                            Icons.calendar_month,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // _buildFunctionalDropdown(
                                //   value: null,
                                //   hint: "--Select--",
                                //   items: ["Dept A", "Dept B"],
                                //   onChanged: (v) {},
                                // ),
                                FunctionalDropdown(
                                  value: _selectedDepartment,
                                  hint: "--Select--",
                                  items: ["--Select--", "Dept A", "Dept B"],
                                  onChanged: (val) => setSidebarState(
                                    () => _selectedDepartment = val,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                const Text(
                                  "Unit",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // _buildFunctionalDropdown(
                                //   value: _selectedUnit,
                                //   hint: "1 Day General Bed",
                                //   items: unitOptions,
                                //   onChanged: (val) => setSidebarState(
                                //     () => _selectedUnit = val,
                                //   ),
                                // ),
                                FunctionalDropdown(
                                  value: _selectedUnit,
                                  hint: "--Select--",
                                  items: unitOptions,
                                  onChanged: (val) => setSidebarState(
                                    () => _selectedUnit = val,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                const Text(
                                  "Ward",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // _buildFunctionalDropdown(
                                //   value: null,
                                //   hint: "--Select--",
                                //   items: ["Ward A", "Ward B"],
                                //   onChanged: (v) {},
                                // ),
                                FunctionalDropdown(
                                  value: _selectedWard,
                                  hint: "--Select--",
                                  items: ["--Select--", "Ward A", "Ward B"],
                                  onChanged: (val) => setSidebarState(
                                    () => _selectedWard = val,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Bed Status",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          _buildFunctionalDropdown(
                                            value: null,
                                            hint: "--Select--",
                                            items: ["Vacant", "Occupied"],
                                            onChanged: (v) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Bed Type",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          _buildFunctionalDropdown(
                                            value: null,
                                            hint: "--Select--",
                                            items: ["Normal", "ICU"],
                                            onChanged: (v) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40),

                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: OutlinedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                          side: const BorderSide(
                                            color: Colors.grey,
                                          ),
                                        ),
                                        child: const Text(
                                          "Clear",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF117A7A,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              24,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          "Search",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
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

  // --- BLOCK BED MODAL ---
  void _showBlockBedModal() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
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
                        "Block Bed",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        _buildModalTableRow("Patient Name", widget.patientName),
                        _buildModalTableRow("CR No", widget.crn),
                        _buildModalTableRow("Consultant", "Sudeep Kumar"),
                        _buildModalTableRow("Reservation Date From", ""),
                        _buildModalTableRow("Reservation Date To", ""),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    "Reservation Date From",
                    style: TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: _blockFromDate,
                      );
                      if (pickedDate != null) {
                        setModalState(() => _blockFromDate = pickedDate);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd-MM-yy').format(_blockFromDate)),
                          const Icon(Icons.calendar_month),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    "Reservation Date To",
                    style: TextStyle(color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await CustomCalendarDialog.show(
                        context,
                        initialDate: _blockToDate,
                      );
                      if (pickedDate != null) {
                        setModalState(() => _blockToDate = pickedDate);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(DateFormat('dd-MM-yy').format(_blockToDate)),
                          const Icon(Icons.calendar_month),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF117A7A),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            "Block",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- DYNAMIC RED POPUP (Speech Bubble) ---
  void _showRedPopup(String uniqueId, int index) {
    _removePopup();

    // Dynamically alternate so edges never clip on standard layouts
    bool isLeftTail = (index % 4) < 2;

    _popupEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _removePopup,
            ),
          ),
          CompositedTransformFollower(
            link: _getLink(uniqueId),
            targetAnchor: Alignment.topCenter,
            followerAnchor: isLeftTail
                ? Alignment.bottomLeft
                : Alignment.bottomRight,
            // Automatically position the offset so tail always points right at target center
            offset: isLeftTail ? const Offset(-25, -5) : const Offset(25, -5),
            child: Material(
              color: Colors.transparent,
              child: CustomPaint(
                painter: _SpeechBubblePainter(isLeftTail: isLeftTail),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 49),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPopupText("CR.No:", widget.crn),
                      const SizedBox(height: 12),
                      _buildPopupText("Name:", widget.patientName),
                      const SizedBox(height: 12),
                      _buildPopupText("Blocked By:", "Aakriti Yadav"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_popupEntry!);
  }

  Widget _buildPopupText(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 105,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // --- UPDATED: Uses PopupMenuButton for Dropdown ---
  Widget _buildFunctionalDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 48,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            onSelected: onChanged,
            offset: const Offset(0, 48),
            color: Colors.white,
            elevation: 0,
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? hint,
                      style: TextStyle(
                        color: value == null
                            ? Colors.grey.shade400
                            : Colors.black87,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
            itemBuilder: (context) => items
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

  Widget _buildModalTableRow(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        children: [
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            color: const Color(0xFFF0F8F8),
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Text(value, style: const TextStyle(color: Colors.black87)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Bed Status",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bed Status",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: _showFilterSidebar,
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

          // Legend Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Legend",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Icon(Icons.arrow_forward, size: 20),
            ],
          ),
          const SizedBox(height: 16),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildLegendItem(
                  color: const Color(0xFF107500),
                  text: "Vacant(7)",
                ),
                const SizedBox(width: 16),
                _buildLegendItem(
                  color: const Color(0xFF98AF6E),
                  text: "House Keeping(0)",
                ),
                const SizedBox(width: 16),
                _buildLegendItem(
                  color: const Color(0xFFFFFF80),
                  text: "Marked for Discharge(2)",
                  isDarkText: true,
                ),
                const SizedBox(width: 16),
                _buildLegendItem(
                  color: const Color(0xFF117A7A),
                  text: "Booked(1)",
                ),
                const SizedBox(width: 16),
                _buildLegendItem(
                  color: const Color(0xFFCD0606),
                  text: "Occupied(14)",
                ),
                const SizedBox(width: 16),
                _buildLegendItem(
                  color: const Color(0xFFBF3EFF),
                  text: "Reserved(0)",
                ),
                const SizedBox(width: 16),
                _buildLegendItem(
                  color: const Color(0xFF8B4513),
                  text: "Under Maintenance(0)",
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Bed Categories
          _buildBedCategory("General", [
            _BedData("1", color: const Color(0xFFD31A1A)),
            _BedData("2", color: const Color(0xFFD31A1A)),
            _BedData("3", color: const Color(0xFFD31A1A)),
            _BedData("4", color: const Color(0xFF117A7A)),
            _BedData("5", color: const Color(0xFFFFFF99), isDarkText: true),
            _BedData("6", color: const Color(0xFF1B8019)),
            _BedData("7", color: const Color(0xFFD31A1A)),
            _BedData("8", color: const Color(0xFF1B8019)),
            _BedData("9", color: const Color(0xFF117A7A)),
            _BedData("10", color: const Color(0xFFD31A1A)),
            _BedData("11", color: const Color(0xFF1B8019)),
            _BedData("12", color: const Color(0xFFD31A1A)),
          ]),
          const SizedBox(height: 24),
          _buildBedCategory("Isolation", [
            _BedData("1", color: const Color(0xFF1B8019)),
            _BedData("2", color: const Color(0xFF1B8019)),
          ]),
          const SizedBox(height: 24),
          _buildBedCategory("POP", [
            _BedData("1", color: const Color(0xFFD31A1A)),
            _BedData("2", color: const Color(0xFFD31A1A)),
            _BedData("3", color: const Color(0xFFD31A1A)),
            _BedData("4", color: const Color(0xFF1B8019)),
            _BedData("5", color: const Color(0xFFFFFF99), isDarkText: true),
            _BedData("6", color: const Color(0xFF1B8019)),
            _BedData("7", color: const Color(0xFFD31A1A)),
            _BedData("8", color: const Color(0xFF1B8019)),
            _BedData("9", color: const Color(0xFF1B8019)),
            _BedData("10", color: const Color(0xFFD31A1A)),
            _BedData("11", color: const Color(0xFF1B8019)),
            _BedData("12", color: const Color(0xFFD31A1A)),
          ]),
          const SizedBox(height: 24),
          _buildBedCategory("Private", [
            _BedData("1", color: const Color(0xFF1B8019)),
            _BedData("2", color: const Color(0xFF1B8019)),
          ]),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildLegendItem({
    Color? color,
    Gradient? gradient,
    required String text,
    bool isDarkText = false,
  }) {
    return Row(
      children: [
        _buildBedBox(
          "",
          color: color,
          gradient: gradient,
          width: 60,
          height: 28,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBedCategory(String title, List<_BedData> beds) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: beds.asMap().entries.map((entry) {
            int index = entry.key; // Track position
            var b = entry.value;
            final uniqueId = "${title}_${b.id}";
            Widget bedWidget = _buildBedBox(
              b.id,
              color: b.color,
              gradient: b.gradient,
              isDarkText: b.isDarkText,
            );

            if (b.color == const Color(0xFFD31A1A)) {
              bedWidget = CompositedTransformTarget(
                link: _getLink(uniqueId),
                child: bedWidget,
              );
            }

            return GestureDetector(
              onTap: () {
                _removePopup();
                if (b.color == const Color(0xFF1B8019)) {
                  _showBlockBedModal();
                } else if (b.color == const Color(0xFFD31A1A)) {
                  _showRedPopup(
                    uniqueId,
                    index,
                  ); // Pass index to alternate popup direction
                }
              },
              child: bedWidget,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBedBox(
    String text, {
    Color? color,
    Gradient? gradient,
    double width = 75,
    double height = 36,
    bool isDarkText = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 18,
            margin: const EdgeInsets.only(left: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isDarkText ? Colors.black87 : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}

class _BedData {
  final String id;
  final Color? color;
  final Gradient? gradient;
  final bool isDarkText;
  _BedData(this.id, {this.color, this.gradient, this.isDarkText = false});
}

// --- Custom Shape for Dynamically Pointed Tail ---
class _SpeechBubblePainter extends CustomPainter {
  final bool isLeftTail;

  _SpeechBubblePainter({this.isLeftTail = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF151515)
      ..style = PaintingStyle.fill;
    final path = Path();
    final double radius = 12.0;

    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, size.height - 25 - radius);
    path.quadraticBezierTo(
      size.width,
      size.height - 25,
      size.width - radius,
      size.height - 25,
    );

    // Dynamically draw the tail either on the Left or Right
    if (!isLeftTail) {
      // Tail on Right
      path.lineTo(size.width - 20, size.height - 25);
      path.lineTo(size.width - 25, size.height);
      path.lineTo(size.width - 45, size.height - 25);
    } else {
      // Tail on Left
      path.lineTo(45, size.height - 25);
      path.lineTo(25, size.height);
      path.lineTo(20, size.height - 25);
    }

    path.lineTo(radius, size.height - 25);
    path.quadraticBezierTo(0, size.height - 25, 0, size.height - 25 - radius);
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SpeechBubblePainter oldDelegate) {
    return oldDelegate.isLeftTail != isLeftTail;
  }
}
