import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendarDialog extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? lastDate;

  const CustomCalendarDialog({
    super.key,
    this.initialDate,
    this.lastDate,
  });

  @override
  State<CustomCalendarDialog> createState() =>
      _CustomCalendarDialogState();

  // --- HELPER METHOD TO CALL IT GLOBALLY ---
  static Future<DateTime?> show(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? lastDate,
  }) {
    return showDialog<DateTime>(
      context: context,
      builder: (context) => CustomCalendarDialog(
        initialDate: initialDate,
        lastDate: lastDate,
      ),
    );
  }
}

class _CustomCalendarDialogState extends State<CustomCalendarDialog> {
  late DateTime _currentMonth;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();

    _selectedDate = widget.initialDate;

    final DateTime init =
        widget.initialDate ?? DateTime.now();

    _currentMonth = DateTime(
      init.year,
      init.month,
    );
  }

  // ----------------------------------------------------------
  // CHANGE MONTH USING ARROWS
  // ----------------------------------------------------------

  void _changeMonth(int offset) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + offset,
      );
    });
  }

  // ----------------------------------------------------------
  // MONTH + YEAR SCROLL PICKER
  // ----------------------------------------------------------

  void _showMonthYearPicker() {
    int selectedYear = _currentMonth.year;
    int selectedMonth = _currentMonth.month;

    // Current year
    final int currentYear = DateTime.now().year;

    // Allow 100 years in the past and 10 years in future.
    final int minYear = currentYear - 100;
    final int maxYear = currentYear + 10;

    // Controllers are used to automatically scroll to
    // the currently selected month/year.
    final FixedExtentScrollController monthController =
        FixedExtentScrollController(
      initialItem: selectedMonth - 1,
    );

    final FixedExtentScrollController yearController =
        FixedExtentScrollController(
      initialItem: selectedYear - minYear,
    );

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (
            context,
            setPickerState,
          ) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  16,
                  20,
                  20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // ------------------------------------------------
                    // HANDLE
                    // ------------------------------------------------

                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // ------------------------------------------------
                    // TITLE
                    // ------------------------------------------------

                    const Text(
                      'Select Month & Year',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF16203A),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ------------------------------------------------
                    // MONTH + YEAR WHEELS
                    // ------------------------------------------------

                    SizedBox(
                      height: 180,
                      child: Row(
                        children: [

                          // ==========================================
                          // MONTH
                          // ==========================================

                          Expanded(
                            child: Column(
                              children: [

                                const Text(
                                  'Month',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                        FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Expanded(
                                  child:
                                      ListWheelScrollView.useDelegate(
                                    controller:
                                        monthController,

                                    itemExtent: 45,

                                    perspective: 0.002,

                                    diameterRatio: 1.5,

                                    physics:
                                        const FixedExtentScrollPhysics(),

                                    onSelectedItemChanged:
                                        (index) {
                                      setPickerState(() {
                                        selectedMonth =
                                            index + 1;
                                      });
                                    },

                                    childDelegate:
                                        ListWheelChildLoopingListDelegate(
                                      children: List.generate(
                                        12,
                                        (index) {
                                          final month =
                                              index + 1;

                                          final isSelected =
                                              month ==
                                                  selectedMonth;

                                          return Center(
                                            child: Text(
                                              DateFormat(
                                                'MMMM',
                                              ).format(
                                                DateTime(
                                                  2000,
                                                  month,
                                                ),
                                              ),
                                              style: TextStyle(
                                                fontSize:
                                                    isSelected
                                                        ? 17
                                                        : 15,
                                                fontWeight:
                                                    isSelected
                                                        ? FontWeight
                                                            .w600
                                                        : FontWeight
                                                            .w400,
                                                color:
                                                    isSelected
                                                        ? const Color(
                                                            0xFF117A7A,
                                                          )
                                                        : Colors
                                                            .grey
                                                            .shade500,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 15),

                          // ==========================================
                          // YEAR
                          // ==========================================

                          Expanded(
                            child: Column(
                              children: [

                                const Text(
                                  'Year',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight:
                                        FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 5),

                                Expanded(
                                  child:
                                      ListWheelScrollView.useDelegate(
                                    controller:
                                        yearController,

                                    itemExtent: 45,

                                    perspective: 0.002,

                                    diameterRatio: 1.5,

                                    physics:
                                        const FixedExtentScrollPhysics(),

                                    onSelectedItemChanged:
                                        (index) {
                                      setPickerState(() {
                                        selectedYear =
                                            minYear + index;
                                      });
                                    },

                                    childDelegate:
                                        ListWheelChildBuilderDelegate(
                                      childCount:
                                          maxYear -
                                              minYear +
                                              1,

                                      builder:
                                          (context, index) {
                                        if (index == null) {
                                          return null;
                                        }

                                        final year =
                                            minYear + index;

                                        final isSelected =
                                            year ==
                                                selectedYear;

                                        return Center(
                                          child: Text(
                                            '$year',
                                            style: TextStyle(
                                              fontSize:
                                                  isSelected
                                                      ? 17
                                                      : 15,
                                              fontWeight:
                                                  isSelected
                                                      ? FontWeight
                                                          .w600
                                                      : FontWeight
                                                          .w400,
                                              color:
                                                  isSelected
                                                      ? const Color(
                                                          0xFF117A7A,
                                                        )
                                                      : Colors
                                                          .grey
                                                          .shade500,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // ------------------------------------------------
                    // SELECTED VALUE PREVIEW
                    // ------------------------------------------------

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F7F7),
                        borderRadius:
                            BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          DateFormat('MMMM yyyy').format(
                            DateTime(
                              selectedYear,
                              selectedMonth,
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF16203A),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // ------------------------------------------------
                    // DONE BUTTON
                    // ------------------------------------------------

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _currentMonth = DateTime(
                              selectedYear,
                              selectedMonth,
                            );
                          });

                          Navigator.pop(
                            bottomSheetContext,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF117A7A),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      monthController.dispose();
      yearController.dispose();
    });
  }

  // ----------------------------------------------------------
  // BUILD CALENDAR
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    // Number of days in current month
    final int daysInMonth =
        DateUtils.getDaysInMonth(
      _currentMonth.year,
      _currentMonth.month,
    );

    // First day of current month
    final DateTime firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );

    // DateTime.weekday:
    // Monday = 1
    // Tuesday = 2
    // ...
    // Sunday = 7
    final int firstWeekday =
        firstDayOfMonth.weekday;

    // Calendar starts from Sunday.
    final int emptyPadding =
        firstWeekday == DateTime.sunday
            ? 0
            : firstWeekday;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // ======================================================
            // HEADER
            // ======================================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [

                // Previous month
                IconButton(
                  icon: Icon(
                    Icons.chevron_left,
                    color: Colors.grey.shade400,
                  ),
                  onPressed: () =>
                      _changeMonth(-1),
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(),
                  splashRadius: 20,
                ),

                // Month + Year
                GestureDetector(
                  onTap: _showMonthYearPicker,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [

                        Text(
                          DateFormat(
                            'MMMM yyyy',
                          ).format(
                            _currentMonth,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.w600,
                            color:
                                Color(0xFF16203A),
                          ),
                        ),

                        const SizedBox(width: 4),

                        const Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color:
                              Color(0xFF16203A),
                        ),
                      ],
                    ),
                  ),
                ),

                // Next month
                IconButton(
                  icon: Icon(
                    Icons.chevron_right,
                    color: Colors.grey.shade400,
                  ),
                  onPressed: () =>
                      _changeMonth(1),
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(),
                  splashRadius: 20,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ======================================================
            // DAYS OF WEEK
            // ======================================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              children: [
                "SUN",
                "MON",
                "TUE",
                "WED",
                "THU",
                "FRI",
                "SAT",
              ].map(
                (day) {
                  return SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(
                        day,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight:
                              FontWeight.bold,
                          color:
                              Color(0xFF16203A),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),

            const SizedBox(height: 16),

            // ======================================================
            // DATE GRID
            // ======================================================

            GridView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),

              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.2,
                mainAxisSpacing: 10,
              ),

              itemCount:
                  emptyPadding + daysInMonth,

              itemBuilder:
                  (context, index) {

                // Empty cells before first day
                if (index < emptyPadding) {
                  return const SizedBox();
                }

                final int dayNumber =
                    index -
                        emptyPadding +
                        1;

                final DateTime thisDay =
                    DateTime(
                  _currentMonth.year,
                  _currentMonth.month,
                  dayNumber,
                );

                // final bool isSelected =
                //     _selectedDate != null &&
                //     _selectedDate!.year ==
                //         thisDay.year &&
                //     _selectedDate!.month ==
                //         thisDay.month &&
                //     _selectedDate!.day ==
                //         thisDay.day;

              final today = DateTime.now();

final dateOnly = DateTime(
  thisDay.year,
  thisDay.month,
  thisDay.day,
);

final todayOnly = DateTime(
  today.year,
  today.month,
  today.day,
);

final isFutureDate = dateOnly.isAfter(todayOnly);
final bool isSelected =
    _selectedDate != null &&
    _selectedDate!.year == thisDay.year &&
    _selectedDate!.month == thisDay.month &&
    _selectedDate!.day == thisDay.day;

return GestureDetector(
  onTap: isFutureDate
      ? null
      : () {
          setState(() {
            _selectedDate = thisDay;
          });

          Navigator.pop(
            context,
            _selectedDate,
          );
        },

                  child: Container(
                    alignment:
                        Alignment.center,

                    decoration:
                        isSelected
                            ? const BoxDecoration(
                                color:
                                    Color(
                                  0xFF117A7A,
                                ),
                                shape:
                                    BoxShape.circle,
                              )
                            : null,

                    child: Text(
                      '$dayNumber',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            FontWeight.w500,
                        color: isSelected
    ? Colors.white
    : isFutureDate
        ? Colors.grey.shade300
        : const Color(0xFF16203A),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}