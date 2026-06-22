import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Appbar/op_appbar.dart';
import 'package:qc_hospital/Widgets/doctor_module_shell.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';

class ServiceBrowserScreen extends StatefulWidget {
  final String patientName;
  final String crn;

  const ServiceBrowserScreen({
    super.key,
    required this.patientName,
    required this.crn,
  });

  @override
  State<ServiceBrowserScreen> createState() => _ServiceBrowserScreenState();
}

class _ServiceBrowserScreenState extends State<ServiceBrowserScreen> {
  bool _isActive = true;
  String? _searchBy = "Service Name";
  String? searchby;

  final TextEditingController _valueCtrl = TextEditingController();

  final List<String> _services = [
    "Full colonoscopy with polypectomy",
    "Pulmonary Function Test Standard",
    "CPP - 1 Unit",
    "LP - PRBC - 4 Units",
    "HLA-DSA BY LUMINEX",
    "PRA Class I BY LUMINEX",
    "Paracentesia",
    "BERA",
    "10.Star S. Magnesium",
  ];

  @override
  void dispose() {
    _valueCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: OpAppbar(
        appheight: true,
        title: "Service browser",
        showDrawer: false,
        onLeadingPressed: () {
          doctorShellScaffoldKey.currentState?.openDrawer();
        },
      ),

      // appBar: AppBar(
      //   backgroundColor: const Color(0xFFD9F4F4), // Light teal appbar
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black87),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   title: const Text(
      //     "Service browser",
      //     style: TextStyle(
      //       color: Colors.black87,
      //       fontSize: 18,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Service browser",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Checkbox(
                              value: _isActive,
                              onChanged: (v) => setState(() => _isActive = v!),
                              activeColor: const Color(0xFF117A7A),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text("Active", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Search By Dropdown
                  const Text(
                    "Search By",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  // _buildDropdown(),
                  FunctionalDropdown(
                    value: searchby,
                    hint: "--Select--",
                    items: [
                      "--Select--",
                      "Service Name",
                      "Service Code",
                      "CPT Code",
                      "Department",
                    ],
                    onChanged: (val) => setState(() => searchby = val),
                  ),
                  const SizedBox(height: 16),

                  // Value TextField
                  const Text(
                    "Value",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      controller: _valueCtrl,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Search Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF117A7A),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 0,
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
                  const SizedBox(height: 32),

                  // Services Table
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        children: [
                          // Table Header
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  color: const Color(0xFFEAF9F9),
                                  child: const Text(
                                    "Service Name",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 50,
                                color: Colors.grey.shade300,
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  color: const Color(0xFFEAF9F9),
                                  child: const Text(
                                    "Apply",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey.shade300,
                          ),
                          // Table Rows
                          ..._services.map(
                            (service) => _buildServiceRow(service),
                          ),

                          // Pagination Row
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildPageButton(
                                  Icons.chevron_left,
                                  isIcon: true,
                                ),
                                const SizedBox(width: 12),
                                _buildPageButton("01", isActive: true),
                                const SizedBox(width: 12),
                                _buildPageButton("02"),
                                const SizedBox(width: 12),
                                _buildPageButton(
                                  Icons.chevron_right,
                                  isIcon: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS ---

  Widget _buildDropdown() {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: PopupMenuButton<String>(
        onSelected: (val) => setState(() => _searchBy = val),
        offset: const Offset(0, 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_searchBy ?? "", style: const TextStyle(fontSize: 14)),
            const Icon(Icons.arrow_drop_down, color: Colors.grey),
          ],
        ),
        itemBuilder: (context) => ["Service Name", "Code"]
            .map(
              (item) => PopupMenuItem<String>(
                value: item,
                child: Text(item, style: const TextStyle(fontSize: 14)),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildServiceRow(String serviceName) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: () => _showServiceDetailsModal(context, serviceName),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      serviceName,
                      style: const TextStyle(
                        color: Color(0xFF117A7A),
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
              Container(width: 1, color: Colors.grey.shade300),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => _showServiceDetailsModal(context, serviceName),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.centerLeft,
                    child: const Icon(
                      Icons.add_circle,
                      color: Color(0xFF4CAF50),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
      ],
    );
  }

  Widget _buildPageButton(
    dynamic content, {
    bool isIcon = false,
    bool isActive = false,
  }) {
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey.shade200 : Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: isIcon
          ? Icon(content as IconData, size: 20, color: Colors.black54)
          : Text(
              content as String,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
    );
  }

  // --- MODAL AS PER FRAME 5549.PNG ---
  void _showServiceDetailsModal(BuildContext context, String serviceName) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Service Browser",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: Colors.black87),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Modal Table
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      _buildModalRow("Service Name", serviceName),
                      _buildDivider(),
                      _buildModalRow("Service Code", "T1286"),
                      _buildDivider(),
                      _buildModalRow("CPT Code", ""),
                      _buildDivider(),
                      _buildModalRow("Group", "Laboratory"),
                      _buildDivider(),
                      _buildModalRow(
                        "Department",
                        "Paediatric Gastroenterology",
                      ),
                      _buildDivider(),
                      _buildModalRow("Apply", "ICON"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModalRow(String label, String value) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            color: const Color(0xFFEAF9F9), // Light teal header
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ),
          Container(width: 1, color: Colors.grey.shade300),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              alignment: Alignment.centerLeft,
              child: value == "ICON"
                  ? const Icon(
                      Icons.add_circle,
                      color: Color(0xFF4CAF50),
                      size: 24,
                    )
                  : Text(
                      value,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() =>
      Divider(height: 1, thickness: 1, color: Colors.grey.shade300);
}
