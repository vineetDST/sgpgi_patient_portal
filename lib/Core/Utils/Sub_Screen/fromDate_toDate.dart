import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qc_hospital/Core/Theme/app_color.dart';
import 'package:qc_hospital/Core/Utils/Sub_Screen/filterLabel.dart';
import 'package:table_calendar/table_calendar.dart';
class DateRangePicker extends StatefulWidget {
  const DateRangePicker({super.key});

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? fromDate;
  DateTime? toDate;

  final fromController = TextEditingController();
  final toController = TextEditingController();

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year.toString().substring(2)}";
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: dateField(
            label: "From Date",
            controller: fromController,
            onTap: () => pickDate(isFrom: true),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: dateField(
            label: "To Date",
            controller: toController,
            onTap: () => pickDate(isFrom: false),
          ),
        ),
      ],
    );
  }




  Future<void> pickDate({
    required bool isFrom,
  }) async {
    DateTime initialDate = DateTime.now();

    // Agar pehle se koi date selected hai, to calendar wahi se khule
    if (isFrom && fromDate != null) initialDate = fromDate!;
    if (!isFrom && toDate != null) initialDate = toDate!;

    // showDatePicker ki jagah showDialog
    final picked = await showDialog<DateTime>(
      context: context,
      builder: (context) => CustomDatePickerDialog(
        initialDate: initialDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
      ),
    );

    if (picked != null) {
      setState(() {
        if (isFrom) {
          fromDate = picked;
          // Apka formatDate function use karein
          fromController.text = formatDate(picked);
        } else {
          toDate = picked;
          toController.text = formatDate(picked);
        }
      });
    }
  }

  Widget dateField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Filterlabel(text: label,showStar: true,),
        const SizedBox(height: 6),
        Container(
          padding :   EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
            horizontal: MediaQuery.of(context).size.height * 0.015,
          ) ,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: Color(0xFFEAEAEA),
                width: 1.5
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  readOnly: true,
                  onTap: onTap,
                  style: TextStyle(fontSize:  14),
                  decoration: InputDecoration(
                    hintText: "00",
                    hintStyle: TextStyle(color: Color(0xFFB7B7B7), fontWeight: FontWeight.w400,fontSize: MediaQuery.of(context).size.height * 0.016),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                    isDense: true,


                    border: InputBorder.none,


                  ),
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child:
                Container(


                    child:  Icon(
                      Icons.calendar_month,
                      color: Color(0xFF000000),
                      size: 15,
                    )
                ),
              )
            ],
          ),
        ),
      ],
    );
  }



}



class CustomDatePickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const CustomDatePickerDialog({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height ;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      insetPadding: const EdgeInsets.all(20),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: 1.0,
        ),
        child: Container(

         width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TableCalendar(
                rowHeight: MediaQuery.of(context).size.height * 0.045,

                firstDay: widget.firstDate,
                lastDay: widget.lastDate,
                focusedDay: _focusedDay,
                currentDay: _selectedDay,

                // Selection Logic
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  // Date select hote hi dialog close karein aur date wapas bhejein
                  Navigator.pop(context, selectedDay);
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },

                // HEADER STYLE (Month Year & Arrows)
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false, // "2 Weeks" wala button hatana
                  titleTextStyle:  TextStyle(
                    fontSize: height * 0.017,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0A1B39) // Dark grey text
                  ),
                  leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.grey),
                  rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.grey),
                  headerPadding:  EdgeInsets.symmetric(vertical: 6,horizontal: 4),
                  leftChevronMargin: EdgeInsets.zero,
                  leftChevronPadding: EdgeInsets.zero,
                  rightChevronMargin: EdgeInsets.zero,
                  rightChevronPadding: EdgeInsets.zero,
                ),

                // CALENDAR STYLE (Dates Grid)
                calendarStyle: CalendarStyle(
                  // Selected Date (Teal Circle)
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xFF1E8186), // Image wala Teal color
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle:  TextStyle(color: Colors.white, fontSize: height * 0.017,fontWeight: FontWeight.w400),

                  // Today Date (Agar select nahi hai to normal dikhe)
                  todayDecoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.transparent),
                  ),
                  todayTextStyle:  TextStyle(
                    color: Colors.black, // Aaj ki date ko highlight nahi karna image jaisa
                      fontSize: height * 0.017,fontWeight: FontWeight.w400
                  ),

                  // Default Text
                  defaultTextStyle:   TextStyle(color: Color(0xFF0A1B39), fontSize: height * 0.014,fontWeight: FontWeight.w400),
                  weekendTextStyle:   TextStyle(color: Color(0xFF0A1B39), fontSize: height * 0.014,fontWeight: FontWeight.w400),

                  // Grid spacing
                  cellMargin: EdgeInsets.all(1),

                  cellPadding: EdgeInsets.zero,


                ),

                // DAYS OF WEEK STYLE (SUN, MON...)
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Color(0xFF0A1B39), fontSize: height * 0.014,fontWeight: FontWeight.w400),
                  weekendStyle: TextStyle(color: Color(0xFF0A1B39), fontSize: height * 0.014,fontWeight: FontWeight.w400),
                  // Text ko Uppercase karne ke liye builder use karenge
                  dowTextFormatter: (date, locale) =>
                      DateFormat.E(locale).format(date).toUpperCase(),


                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
