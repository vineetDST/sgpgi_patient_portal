import 'package:flutter/material.dart';
import 'package:qc_hospital/Core/Data/dummy_data.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Datepicker/app_date_picker.dart';
import 'package:qc_hospital/Core/Utils/Dialog/app_filter_dialog.dart';
import 'package:qc_hospital/Core/Utils/Dropdown/functional_dropdown.dart';
import 'package:qc_hospital/Core/Utils/custom_calendar_dialog.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Collection/collection.dart';
import 'package:qc_hospital/Screens/Blood_Bank/Donor/donor_details.dart';
import 'package:qc_hospital/Screens/Blood_Bank/blood_bank_base_scaffold.dart';
import 'package:qc_hospital/Screens/OP/clinical_histories/shared_clinical_components.dart';


class Donor extends StatefulWidget {
  Donor({super.key});

  @override
  State<Donor> createState() => _BloodBankDonorState();
}

class _BloodBankDonorState extends State<Donor> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final Color borderColor = Colors.grey.withOpacity(0.3);
  final List<DonorData> donorList = [
    DonorData(queue: "063", regNo: "D-2025110400063", name: "Anil Srivastava"),
    DonorData(queue: "078", regNo: "D-2025110406523", name: "Chandra Bhan"),
    DonorData(queue: "045", regNo: "D-2025110401254", name: "Gautem Kumar"),
    DonorData(queue: "032", regNo: "D-2025110406547", name: "John Michael"),
    DonorData(queue: "047", regNo: "D-2025110401547", name: "Chandra Bhan"),
    DonorData(queue: "069", regNo: "D-2025110400471", name: "Gautem Kumar"),
    DonorData(queue: "101", regNo: "D-2025110400654", name: "John Michael"),
    DonorData(queue: "126", regNo: "D-2025110400147", name: "Peter"),

    DonorData(queue: "063", regNo: "D-2025110400063", name: "Anil Srivastava"),
    DonorData(queue: "078", regNo: "D-2025110406523", name: "Chandra Bhan"),
    DonorData(queue: "045", regNo: "D-2025110401254", name: "Gautem Kumar"),
    DonorData(queue: "032", regNo: "D-2025110406547", name: "John Michael"),
    DonorData(queue: "047", regNo: "D-2025110401547", name: "Chandra Bhan"),
    DonorData(queue: "069", regNo: "D-2025110400471", name: "Gautem Kumar"),
    DonorData(queue: "101", regNo: "D-2025110400654", name: "John Michael"),
    DonorData(queue: "126", regNo: "D-2025110400147", name: "Peter"),

    DonorData(queue: "063", regNo: "D-2025110400063", name: "Anil Srivastava"),
    DonorData(queue: "078", regNo: "D-2025110406523", name: "Chandra Bhan"),
    DonorData(queue: "045", regNo: "D-2025110401254", name: "Gautem Kumar"),
    DonorData(queue: "032", regNo: "D-2025110406547", name: "John Michael"),
    DonorData(queue: "047", regNo: "D-2025110401547", name: "Chandra Bhan"),
    DonorData(queue: "069", regNo: "D-2025110400471", name: "Gautem Kumar"),
    DonorData(queue: "101", regNo: "D-2025110400654", name: "John Michael"),
    DonorData(queue: "126", regNo: "D-2025110400147", name: "Peter"),

    DonorData(queue: "063", regNo: "D-2025110400063", name: "Anil Srivastava"),
    DonorData(queue: "078", regNo: "D-2025110406523", name: "Chandra Bhan"),
    DonorData(queue: "045", regNo: "D-2025110401254", name: "Gautem Kumar"),
    DonorData(queue: "032", regNo: "D-2025110406547", name: "John Michael"),
    DonorData(queue: "047", regNo: "D-2025110401547", name: "Chandra Bhan"),
    DonorData(queue: "069", regNo: "D-2025110400471", name: "Gautem Kumar"),
    DonorData(queue: "101", regNo: "D-2025110400654", name: "John Michael"),
    DonorData(queue: "126", regNo: "D-2025110400147", name: "Peter"),

    DonorData(queue: "001", regNo: "D-2025110400063", name: "Anil Srivastava"),
    DonorData(queue: "001", regNo: "D-2025110406523", name: "Chandra Bhan"),
    DonorData(queue: "001", regNo: "D-2025110401254", name: "Gautem Kumar"),
    DonorData(queue: "001", regNo: "D-2025110406547", name: "John Michael"),
    DonorData(queue: "001", regNo: "D-2025110401547", name: "Chandra Bhan"),
    DonorData(queue: "001", regNo: "D-2025110400471", name: "Gautem Kumar"),
    DonorData(queue: "001", regNo: "D-2025110400654", name: "John Michael"),
    DonorData(queue: "001", regNo: "D-2025110400147", name: "Peter"),

    DonorData(queue: "002", regNo: "D-2025110400063", name: "Anil Srivastava"),
    DonorData(queue: "002", regNo: "D-2025110406523", name: "Chandra Bhan"),
    DonorData(queue: "002", regNo: "D-2025110401254", name: "Gautem Kumar"),
    DonorData(queue: "002", regNo: "D-2025110406547", name: "John Michael"),
    DonorData(queue: "002", regNo: "D-2025110401547", name: "Chandra Bhan"),
    DonorData(queue: "002", regNo: "D-2025110400471", name: "Gautem Kumar"),
    DonorData(queue: "002", regNo: "D-2025110400654", name: "John Michael"),
    DonorData(queue: "002", regNo: "D-2025110400147", name: "Peter"),

    DonorData(queue: "003", regNo: "D-2025110400063", name: "Anil Srivastava"),
    DonorData(queue: "003", regNo: "D-2025110406523", name: "Chandra Bhan"),
    DonorData(queue: "003", regNo: "D-2025110401254", name: "Gautem Kumar"),
    DonorData(queue: "003", regNo: "D-2025110406547", name: "John Michael"),
    DonorData(queue: "003", regNo: "D-2025110401547", name: "Chandra Bhan"),
    DonorData(queue: "003", regNo: "D-2025110400471", name: "Gautem Kumar"),
    DonorData(queue: "003", regNo: "D-2025110400654", name: "John Michael"),
    DonorData(queue: "003", regNo: "D-2025110400147", name: "Peter"),

    DonorData(queue: "004", regNo: "D-2025110400063", name: "Anil Srivastava"),
    DonorData(queue: "004", regNo: "D-2025110406523", name: "Chandra Bhan"),
    DonorData(queue: "004", regNo: "D-2025110401254", name: "Gautem Kumar"),
    DonorData(queue: "004", regNo: "D-2025110406547", name: "John Michael"),
    DonorData(queue: "004", regNo: "D-2025110401547", name: "Chandra Bhan"),
    DonorData(queue: "004", regNo: "D-2025110400471", name: "Gautem Kumar"),
    DonorData(queue: "004", regNo: "D-2025110400654", name: "John Michael"),
    DonorData(queue: "004", regNo: "D-2025110400147", name: "Peter"),
  ];

  int _currentPage = 0;
  final int _rowsPerPage = 8;
  bool _isAscending = true;
  int? _sortColumnIndex;

  // Purane _sort function ko isse replace karein
  void _sort<T>(Comparable<T> Function(DonorData d) getField, int columnIndex) {
    setState(() {
      _sortColumnIndex = columnIndex;

      // 1. Pehle current page ka data nikaalein (8 items)
      int startIndex = _currentPage * _rowsPerPage;
      int endIndex = startIndex + _rowsPerPage;
      if (endIndex > donorList.length) endIndex = donorList.length;

      // 2. Sirf us particular range ke data ko nikaalein
      List<DonorData> localSubset = donorList.sublist(startIndex, endIndex);

      // 3. Sirf is subset (8 items) ko sort karein
      if (_isAscending) {
        localSubset.sort((a, b) => getField(a).compareTo(getField(b) as T));
      } else {
        localSubset.sort((a, b) => getField(b).compareTo(getField(a) as T));
      }

      // 4. Sorted subset ko wapis main list mein usi position par replace kar dein
      for (int i = 0; i < localSubset.length; i++) {
        donorList[startIndex + i] = localSubset[i];
      }

      _isAscending = !_isAscending;
    });
  }

  @override
  Widget build(BuildContext context) {
    // --- Calculation Logic Start ---
    int totalItems = donorList.length;
    int totalPages = (totalItems / _rowsPerPage).ceil();

    // Current page ka data nikalna
    int startIndex = _currentPage * _rowsPerPage;
    int endIndex = startIndex + _rowsPerPage;
    List<DonorData> paginatedList = donorList.sublist(
      startIndex,
      endIndex > totalItems ? totalItems : endIndex,
    );

    // Sliding Pagination Logic (Hamesha 2 numbers dikhane ke liye)
    int groupIndex = (_currentPage / 2).floor();
    int startPage = groupIndex * 2;
    int endPage = startPage + 2;
    if (endPage > totalPages) endPage = totalPages;
    return BloodBankBaseScaffold(
      title: 'Blood Donor Browser',
      showDrawer: true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: _buildHeader(),
          ),
          const SizedBox(height: 16,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(12),
            ),

            child: Column(

              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade200,
                        width: 0,
                      ),
                    ),

                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: IntrinsicHeight(
                      child: Row(
                    
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: const Color(0xFFF0FDFC),
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  child: Text(
                                    "Queue",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight
                                          .w600, // Thoda bold text labels ke liye
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                    
                          Container(width: 2, color: Colors.grey.shade200),
                    
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                _sort((d) => d.regNo, 1);
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 16),
                                color: const Color(
                                  0xFFF0FDFC,
                                ), // Matching the light teal/cyan color
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Donor Reg No",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight
                                              .w600, // Thoda bold text labels ke liye
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.unfold_more,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    
                          Container(width: 2, color: Colors.grey.shade200),
                    
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () {
                                _sort((d) => d.name, 2);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 20,
                                ),
                                color: const Color(0xFFF0FDFC),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Donor Name",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight
                                              .w600, // Thoda bold text labels ke liye
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.unfold_more,
                                      size: 16,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: paginatedList.length,
                  itemBuilder: (context, index) {
                    var donor = paginatedList[index];
                    return getListDetail(
                      donor,
                      isLast: index == paginatedList.length - 1,
                    );
                  },
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Back Button
                      paginationButton(
                        Icons.chevron_left,
                        _currentPage > 0
                            ? () {
                                setState(() => _currentPage--);
                              }
                            : null,
                      ),

                      SizedBox(width: 6),

                      // Sliding Page Numbers (01, 02 then 03, 04...)
                      ...List.generate(endPage - startPage, (index) {
                        int actualPage = startPage + index;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _currentPage = actualPage),
                            child: pageNumber(
                              (actualPage + 1).toString().padLeft(2, '0'),
                              isSelected: _currentPage == actualPage,
                            ),
                          ),
                        );
                      }),

                      SizedBox(width: 6),

                      // Next Button
                      paginationButton(
                        Icons.chevron_right,
                        _currentPage < totalPages - 1
                            ? () {
                                setState(() => _currentPage++);
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BloodBankDonorNavigationBar(index: 1, page: 1,onTap: _navigateToPage,),

    );
  }



  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Blood Donor Browser',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Collection();
                    },
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03,
                  vertical: MediaQuery.of(context).size.height * 0.007,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Text(
                  "New Donor Reg",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * 0.014,
                  ),
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                AppFilterDialog.show(
                  context: context,
                  title: "Search",
                  showFooter: true,
                  child: _FilterSidebar(),
                );
              },
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02,
                  top: MediaQuery.of(context).size.height * 0.01,
                  bottom: MediaQuery.of(context).size.height * 0.01,
                ),
                child: const Icon(Icons.filter_alt_outlined),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getListDetail(DonorData data, {bool isLast = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 2),
          bottom: isLast
              ? BorderSide(color: Colors.grey.shade200, width: 2)
              : BorderSide.none,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFFFFFFF),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                      "${data.queue}",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.014,
                        fontWeight:
                            FontWeight.w400, // Thoda bold text labels ke liye
                        color: AppColor.color1E1E1E,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Container(width: 2, color: Colors.grey.shade200),

            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                color: const Color(
                  0xFFFFFFFF,
                ), // Matching the light teal/cyan color
                alignment: Alignment.centerLeft,
                child: Text(
                  "${data.regNo}",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.014,
                    fontWeight:
                        FontWeight.w400, // Thoda bold text labels ke liye
                    color: AppColor.color1E1E1E,
                  ),
                ),
              ),
            ),

            Container(width: 2, color: Colors.grey.shade200),

            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => DonorDetailsDialog(data: data),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  color: const Color(0xFFFFFFFF),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${data.name}",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.014,
                      fontWeight:
                          FontWeight.w400, // Thoda bold text labels ke liye
                      color: AppColor.color117A7A,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageNumber(String num, {bool isSelected = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSelected ? 4 : 3.5,
        vertical: isSelected ? 2 : 1.5,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFE8E8E8) : Colors.transparent,
        borderRadius: BorderRadius.circular(2),
        border: isSelected
            ? Border.all(color: Colors.transparent, width: 0)
            : Border.all(color: borderColor, width: 1),
      ),
      child: Text(num, style: TextStyle(color: Colors.black87, fontSize: 13)),
    );
  }

  Widget paginationButton(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap, // Ye click event handle karega
      child: Container(

        width: 30,
        height: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.transparent),
        ),
        child: Container(

          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Icon(
            icon,
            size: 20,
            color: onTap == null
                ? Colors.grey[300]
                : Colors.black, // Disable color
          ),
        ),
      ),
    );
  }
}

class DonorData {
  final String queue;
  final String regNo;
  final String name;

  DonorData({required this.queue, required this.regNo, required this.name});
}

class _FilterSidebar extends StatefulWidget {
  const _FilterSidebar();
  @override
  State<_FilterSidebar> createState() => _OrderSetFilterSidebarState();
}

class _OrderSetFilterSidebarState extends State<_FilterSidebar> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  DateTime? fromDate;
  DateTime? toDate;

  String? _bloodComponent = null ;
  String? _department =  null;
  String? _bloodGroup =  null;
  String? _status =  null;

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Donor Name")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Donor Name'),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Queue No")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Queue No'),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Donor Reg.No")),
        const SizedBox(height: 8),
        SharedComponents.buildTextField(hintText: 'Donor Reg.No'),
        const SizedBox(height: 16),


        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Donor Type")),
        const SizedBox(height: 8),
        FunctionalDropdown(
            value: _bloodComponent,
            items: DummyData.donorTypes,
            onChanged: (val) {
              setState(() {
                _bloodComponent = val;
              });
            }
        ),
        const SizedBox(height: 16),

        Align(
            alignment: Alignment.centerLeft,
            child: SharedComponents.buildFormLabel("Donation Type")),
        const SizedBox(height: 8),
        FunctionalDropdown(
            value: _department,
            items: DummyData.donationTypes,
            onChanged: (val) {
              setState(() {
                _department = val;
              });
            }
        ),
        const SizedBox(height: 16),


        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel("From Date",isRequired: true)),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: fromController,
                    onTap: () async {
                      DateTime? pickedDate =
                      await CustomCalendarDialog.show(
                        context,
                        initialDate: fromDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          fromDate = pickedDate;
                          fromController.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },

                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: SharedComponents.buildFormLabel("To Date",isRequired: true)),
                  const SizedBox(height: 8),
                  AppDateField(
                    controller: toController,
                    onTap: () async {
                      DateTime? pickedDate =
                      await CustomCalendarDialog.show(
                        context,
                        initialDate: toDate ?? DateTime.now(),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          toDate = pickedDate;
                          toController.text = formatDate(pickedDate);
                        });
                      }
                      ;
                    },

                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )
          ],
        ),






      ],
    );
  }


}
