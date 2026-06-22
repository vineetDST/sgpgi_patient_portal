import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Theme/app_text_style.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/Icon_Action/delete.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row.dart';
import 'package:qc_hospital/Core/Utils/Modals/save_order_set_modal.dart';
import 'package:qc_hospital/Core/Utils/Table/detail_row_wrapper.dart';

import 'package:qc_hospital/Screens/IP/Quick_Action_Screen/CPOE/ip_pre_drug_order.dart';
import 'package:qc_hospital/Screens/IP/ip_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';
import 'package:qc_hospital/Screens/OP/cpoes/prev_drug_screen.dart';
import 'package:qc_hospital/Widgets/clinical_base_scaffold.dart';

class IPDrugScreen extends StatefulWidget {
  final String patientName;
  final String crn;
  const IPDrugScreen({super.key, required this.patientName, required this.crn});
  @override
  State<IPDrugScreen> createState() => _DrugScreenState();
}

class NoCursorHandleControls extends MaterialTextSelectionControls {
  @override
  Widget buildHandle(
    BuildContext context,
    TextSelectionHandleType type,
    double textLineHeight, [
    VoidCallback? onTap,
  ]) {
    return const SizedBox.shrink();
  }
}

class _DrugScreenState extends State<IPDrugScreen> {
  String typeRadio = "All Drugs";
  String nameRadio = "Trade Name";
  String? _store = "001_NEW OPD HRF PHARMACY STORE";
  String? _drugName = "Ampoule";
  final TextEditingController _searchCtrl = TextEditingController();

  bool _genCheck1 = false,
      _genCheck2 = false,
      _genCheck3 = false,
      _genCheck4 = false;
  bool _genFav1 = false, _genFav2 = false, _genFav3 = false, _genFav4 = false;
  bool _tradeCheck1 = true,
      _tradeCheck2 = true,
      _tradeCheck3 = false,
      _tradeCheck4 = false;

  final TextEditingController _intakeQty1 = TextEditingController(text: "1.0");
  final TextEditingController _intakeQty2 = TextEditingController(text: "1.0");
  final TextEditingController _duration1 = TextEditingController(text: "1.0");
  final TextEditingController _duration2 = TextEditingController(text: "1.0");
  String? _freq1 = "Daily", _freq2 = "Daily";
  String? _route1 = "Oral", _route2 = "Oral";
  String? _store1 = "001_NEW OPD HRF PHARMA",
      _store2 = "001_NEW OPD HRF PHARMA";

  @override
  void dispose() {
    _searchCtrl.dispose();
    _intakeQty1.dispose();
    _intakeQty2.dispose();
    _duration1.dispose();
    _duration2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IpBaseScaffold(
      title: "Drug",
      showDrawer: false,
      patientName: widget.patientName,
      crn: widget.crn,
      activeQuickAction: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Drug",
                style: AppTextStyles.RegH3.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IPPrevDrugScreen(
                      patientName: widget.patientName,
                      crn: widget.crn,
                    ),
                  ),
                ),
                child: const Text(
                  "Prev",
                  style: TextStyle(
                    color: Color(0xFF117A7A),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildRadio(
                "All Drugs",
                typeRadio,
                (v) => setState(() => typeRadio = v!),
              ),
              const SizedBox(width: 16),
              _buildRadio(
                "Available Drugs",
                typeRadio,
                (v) => setState(() => typeRadio = v!),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SharedComponents.buildFormLabel("Store"),
          const SizedBox(height: 8),

          FunctionalDropdown(
            value: _store,
            hint: "--Select--",
            items: [
              "--Select--",
              "001_NEW OPD HRF PHARMACY STORE",
              "002_MAIN STORE",
            ],
            onChanged: (v) => setState(() => _store = v),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildRadio(
                "Generic Name",
                nameRadio,
                (v) => setState(() => nameRadio = v!),
              ),
              const SizedBox(width: 8),
              _buildRadio(
                "Trade Name",
                nameRadio,
                (v) => setState(() => nameRadio = v!),
              ),
              const SizedBox(width: 8),
              _buildRadio(
                "Favorite",
                nameRadio,
                (v) => setState(() => nameRadio = v!),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SharedComponents.buildFormLabel("Search by Drug Name"),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: _searchCtrl,
              decoration: const InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                suffixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SharedComponents.buildFormLabel("Drug Name"),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildDropdown(_drugName, [
                  "Ampoule",
                  "Tablet",
                  "Syrup",
                ], (v) => setState(() => _drugName = v)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF117A7A),
                    padding: const EdgeInsets.symmetric(
                      vertical: 13,
                      horizontal: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Add Drug",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildFormTile("Generic", _buildGenericTable()),
          const SizedBox(height: 12),
          _buildFormTile("Trade", _buildTradeTable()),
          const SizedBox(height: 12),
          _buildFormTile("Drug", _buildDrugTable()),
          const SizedBox(height: 24),
          _buildFormTile("Total Cost", _buildTotalCostTable()),
          const SizedBox(height: 24),
          _buildFullWidthButton("Save Order", isFilled: true, onTap: () {}),
          const SizedBox(height: 12),
          _buildFullWidthButton(
            "Save as Order Set",
            isFilled: false,
            onTap: () => _showSaveOrderSetModal(context),
          ),
          const SizedBox(height: 12),
          _buildFullWidthButton(
            "Investigation Order Printing",
            isFilled: false,
            onTap: () {},
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildGenericTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 150,
              color: const Color(0xFFEAF9F9),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Text(
                "Generic",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            Container(width: 1, color: Colors.grey.shade300),
            Expanded(
              child: Column(
                children: [
                  _buildGenericRow(
                    "HEPARIN",
                    _genCheck1,
                    (v) => setState(() => _genCheck1 = v!),
                    _genFav1,
                    () => setState(() => _genFav1 = !_genFav1),
                  ),
                  Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
                  _buildGenericRow(
                    "HEPARIN",
                    _genCheck2,
                    (v) => setState(() => _genCheck2 = v!),
                    _genFav2,
                    () => setState(() => _genFav2 = !_genFav2),
                  ),
                  Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
                  _buildGenericRow(
                    "HEPARIN",
                    _genCheck3,
                    (v) => setState(() => _genCheck3 = v!),
                    _genFav3,
                    () => setState(() => _genFav3 = !_genFav3),
                  ),
                  Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
                  _buildGenericRow(
                    "HEPARIN",
                    _genCheck4,
                    (v) => setState(() => _genCheck4 = v!),
                    _genFav4,
                    () => setState(() => _genFav4 = !_genFav4),
                    isLast: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenericRow(
    String text,
    bool isChecked,
    Function(bool?) onChanged,
    bool isFav,
    VoidCallback onFavToggle, {
    bool isLast = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: isChecked,
              activeColor: const Color(0xFF117A7A),
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
          GestureDetector(
            onTap: onFavToggle,
            child: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Color(0xFF117A7A) : Colors.grey,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTradeTable() {
    const double rowHeight = 70.0;
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF9F9),
              border: Border(right: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                _buildLeftCell("Trade", rowHeight),
                Divider(height: 1, color: Colors.grey.shade300),
                _buildLeftCell("Store", rowHeight),
                Divider(height: 1, color: Colors.grey.shade300),
                _buildLeftCell("Stock", rowHeight),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildTradeColumn(
                    "Heparin Low Mol. 40mg Inj\n(LMWX PF) Abbott",
                    _tradeCheck1,
                    (v) => setState(() => _tradeCheck1 = v!),
                    "001_NEW OPD HRF PHARMACY STORE",
                    "200",
                    rowHeight,
                  ),
                  _buildTradeColumn(
                    "Paracetamol 500mg Tab\n(Calpol 500)",
                    _tradeCheck2,
                    (v) => setState(() => _tradeCheck2 = v!),
                    "001_NEW OPD HRF PHARMACY STORE",
                    "5359",
                    rowHeight,
                  ),
                  _buildTradeColumn(
                    "Heparin Low Mol. 40mg Inj\n(LMWX PF) Abbott",
                    _tradeCheck3,
                    (v) => setState(() => _tradeCheck3 = v!),
                    "001_NEW OPD HRF PHARMACY STORE",
                    "100",
                    rowHeight,
                  ),
                  _buildTradeColumn(
                    "Paracetamol 500mg Tab\n(Calpol 500)",
                    _tradeCheck4,
                    (v) => setState(() => _tradeCheck4 = v!),
                    "001_NEW OPD HRF PHARMACY STORE",
                    "2075",
                    rowHeight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTradeColumn(
    String label,
    bool isChecked,
    Function(bool?) onChanged,
    String store,
    String stock,
    double height,
  ) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        border: Border(right: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: isChecked,
                    activeColor: const Color(0xFF117A7A),
                    onChanged: onChanged,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              store,
              style: const TextStyle(fontSize: 11, color: Colors.black87),
              maxLines: 2,
            ),
          ),
          Divider(height: 1, color: Colors.grey.shade300),
          Container(
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.centerLeft,
            child: Text(
              stock,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrugTable() {
    const double rowHeight = 56.0;
    Widget left(String text, {bool isRed = false, bool isLast = false}) =>
        Container(
          height: rowHeight,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF9F9),
            border: Border(
              bottom: isLast
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey.shade300),
            ),
          ),
          child: isRed
              ? RichText(
                  text: TextSpan(
                    text: text.replaceAll('*', ''),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                    children: const [
                      TextSpan(
                        text: "*",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.black87,
                  ),
                ),
        );

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            decoration: BoxDecoration(
              border: Border(right: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Column(
              children: [
                left("Drug Name"),
                left("Freq Drip Set*", isRed: true),
                left("Intake Qty*", isRed: true),
                left("Duration*", isRed: true),
                left("Total Qty"),
                left("Already Issued Qty"),
                left("Requested Qty"),
                left("Unit price"),
                left("Route"),
                left("Store"),
                left("Stock Qty"),
                left("Action", isLast: true),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildDrugColumn(
                    "Heparin Low Mol. 40mg Inj\n(LMWX PF) Abbott ",
                    "mg PFS",
                    _freq1,
                    (v) => setState(() => _freq1 = v),
                    _intakeQty1,
                    _duration1,
                    "1.0",
                    "0.0",
                    "0.0",
                    "162.44",
                    _route1,
                    (v) => setState(() => _route1 = v),
                    _store1,
                    (v) => setState(() => _store1 = v),
                    "200.0",
                    rowHeight,
                  ),
                  _buildDrugColumn(
                    "Paracetamol 500mg Tab\n(Calpol 500) ",
                    "mg Tab",
                    _freq2,
                    (v) => setState(() => _freq2 = v),
                    _intakeQty2,
                    _duration2,
                    "1.0",
                    "0.0",
                    "0.0",
                    "162.44",
                    _route2,
                    (v) => setState(() => _route2 = v),
                    _store2,
                    (v) => setState(() => _store2 = v),
                    "200.0",
                    rowHeight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrugColumn(
    String dName1,
    String dName2,
    String? freq,
    Function(String?) onFreq,
    TextEditingController inQty,
    TextEditingController dur,
    String tQty,
    String aQty,
    String rQty,
    String uprice,
    String? route,
    Function(String?) onRoute,
    String? store,
    Function(String?) onStore,
    String stock,
    double height,
  ) {
    Widget cell(Widget child, {bool isLast = false}) => Container(
      height: height,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: isLast
              ? BorderSide.none
              : BorderSide(color: Colors.grey.shade300),
          right: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: child,
    );

    Widget inputWithSuffix(TextEditingController ctrl, String suffix) => Row(
      children: [
        Container(
          width: 60,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextField(
            controller: ctrl,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
            selectionControls: NoCursorHandleControls(),

            contextMenuBuilder: (_, __) => const SizedBox.shrink(),
            // enableInteractiveSelection: true,

            // // Remove magnifier bubble
            // magnifierConfiguration: TextMagnifierConfiguration.disabled,

            // Remove copy/paste toolbar
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(suffix, style: const TextStyle(fontSize: 12)),
      ],
    );

    return SizedBox(
      width: 260,
      child: Column(
        children: [
          cell(
            RichText(
              text: TextSpan(
                text: dName1,
                style: const TextStyle(color: Colors.red, fontSize: 12),
                children: [
                  TextSpan(
                    text: dName2,
                    style: const TextStyle(color: Color(0xFF117A7A)),
                  ),
                ],
              ),
            ),
          ),
          cell(_buildInnerDropdown(freq, ["Daily", "Weekly"], onFreq)),
          cell(inputWithSuffix(inQty, "Nos")),
          cell(inputWithSuffix(dur, "Days")),
          cell(Text(tQty, style: const TextStyle(fontSize: 12))),
          cell(Text(aQty, style: const TextStyle(fontSize: 12))),
          cell(Text(rQty, style: const TextStyle(fontSize: 12))),
          cell(Text(uprice, style: const TextStyle(fontSize: 12))),
          cell(_buildInnerDropdown(route, ["Oral", "IV"], onRoute)),
          cell(
            _buildInnerDropdown(store, [
              "001_NEW OPD HRF PHARMA",
              "MAIN STORE",
            ], onStore),
          ),
          cell(Text(stock, style: const TextStyle(fontSize: 12))),
          cell(
            Row(
              children: [
                const Icon(Icons.print, size: 20, color: Colors.black87),
                AppDeleteIcon()
              ],
            ),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLeftCell(String label, double height) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildFormTile(String title, Widget tableContent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            children: [tableContent],
          ),
        ),
      ),
    );
  }

  Widget _buildRadio(
    String value,
    String groupValue,
    Function(String?) onChanged,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Radio<String>(
            value: value,
            groupValue: groupValue,
            activeColor: const Color(0xFF117A7A),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // --- UPDATED: Uses PopupMenuButton for Main Dropdowns ---
  Widget _buildDropdown(
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
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
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? "--Select--",
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

  // --- UPDATED: Uses PopupMenuButton for Table Dropdowns ---
  Widget _buildInnerDropdown(
    String? value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 36,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: PopupMenuButton<String>(
            onSelected: onChanged,
            offset: const Offset(0, 36),
            color: Colors.white,
            elevation: 0,
            constraints: BoxConstraints(
              minWidth: constraints.maxWidth,
              maxWidth: constraints.maxWidth,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
              side: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      value ?? "Select",
                      style: TextStyle(
                        color: value == null ? Colors.grey : Colors.black87,
                        fontSize: 11,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 16,
                    color: Colors.grey,
                  ),
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
                        fontSize: 11,
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

  Widget _buildFullWidthButton(
    String text, {
    required bool isFilled,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: isFilled
          ? ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF117A7A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                backgroundColor: Colors.white,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }

  Widget _buildTotalCostTable() {
    const double rowHeight = 64.0;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),

      child: ClipRRect(
        child: Column(
          children: [
            DetailRow(
              label: "Current Order Amount",
              customWidget: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "170.00",
                      style: TextStyle(
                        color: Color(0xFF117A7A), // 🔵 Blue
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            DetailRow(
              label: "Balance Amount",
              customWidget: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "175.00",
                      style: TextStyle(
                        color: Color(0xFFFF0606), // 🔵 Blue
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DetailRow(
              label: "Blocked Amount",
              customWidget: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "0.00",
                      style: TextStyle(
                        color: Color(0xFF117A7A), // 🔵 Blue
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DetailRow(
              isLast: true,
              label: "Pending Amount",
              customWidget: Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: "170.00",
                      style: TextStyle(
                        color: Color(0xFF107500), // 🔵 Blue
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- MODALS ---
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

  void _showSaveOrderSetModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) =>
          SaveOrderSetModal(onDeleteTap: () => _showDeleteModal(context)),
    );
  }
}
