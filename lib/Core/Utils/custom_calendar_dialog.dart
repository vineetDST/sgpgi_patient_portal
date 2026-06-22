import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendarDialog extends StatefulWidget {
  final DateTime? initialDate;

  const CustomCalendarDialog({super.key, this.initialDate});

  @override
  State<CustomCalendarDialog> createState() => _CustomCalendarDialogState();

  // --- HELPER METHOD TO CALL IT GLOBALLY ---
  static Future<DateTime?> show(BuildContext context, {DateTime? initialDate}) {
    return showDialog<DateTime>(
      context: context,
      builder: (context) => CustomCalendarDialog(initialDate: initialDate),
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
    // Default to the provided date's month, or the current month if none is provided
    DateTime init = widget.initialDate ?? DateTime.now();
    _currentMonth = DateTime(init.year, init.month);
  }

  void _changeMonth(int offset) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + offset,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Determine how many days are in the current month
    int daysInMonth = DateUtils.getDaysInMonth(
      _currentMonth.year,
      _currentMonth.month,
    );

    // Determine what day of the week the 1st falls on to add empty padding cells
    // DateTime.weekday returns 1 for Monday, 7 for Sunday.
    DateTime firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    int firstWeekday = firstDayOfMonth.weekday;

    // Our UI starts on Sunday. So if the 1st is Sunday(7), padding is 0. If Monday(1), padding is 1.
    int emptyPadding = firstWeekday == 7 ? 0 : firstWeekday;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- HEADER (Month Navigation) ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.grey.shade400),
                  onPressed: () => _changeMonth(-1),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                ),
                Text(
                  DateFormat('MMMM yyyy').format(_currentMonth),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF16203A),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right, color: Colors.grey.shade400),
                  onPressed: () => _changeMonth(1),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- DAYS OF WEEK ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ["SUN", "MON", "TUE", "WED", "THR", "FRI", "SAT"]
                  .map(
                    (d) => SizedBox(
                      width:
                          30, // Fixed width helps align the headers with the grid
                      child: Center(
                        child: Text(
                          d,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF16203A),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),

            // --- DATES GRID ---
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.2,
                mainAxisSpacing: 10,
              ),
              itemCount: emptyPadding + daysInMonth,
              itemBuilder: (context, index) {
                // Render empty slots before the 1st of the month
                if (index < emptyPadding) {
                  return const SizedBox();
                }

                int dayNumber = index - emptyPadding + 1;
                DateTime thisDay = DateTime(
                  _currentMonth.year,
                  _currentMonth.month,
                  dayNumber,
                );

                bool isSelected =
                    _selectedDate != null &&
                    _selectedDate!.year == thisDay.year &&
                    _selectedDate!.month == thisDay.month &&
                    _selectedDate!.day == thisDay.day;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = thisDay;
                    });

                    // Give a tiny delay so the user sees the teal circle appear before closing
                    Future.delayed(const Duration(milliseconds: 150), () {
                      if (context.mounted) {
                        Navigator.pop(
                          context,
                          _selectedDate,
                        ); // Return the selected date!
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: isSelected
                        ? const BoxDecoration(
                            color: Color(0xFF117A7A),
                            shape: BoxShape.circle,
                          )
                        : null,
                    child: Text(
                      "$dayNumber",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? Colors.white
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
