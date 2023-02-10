import 'package:flutter/material.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
 import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_agri/calender/calendar.dart';
import 'package:smart_agri/main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final calendarController = CleanCalendarController(
    minDate: DateTime.now(),
    maxDate: DateTime.now().add(const Duration(days: 365)),
    onRangeSelected: (firstDate, secondDate) {},
    onDayTapped: (date) {
       Fluttertoast.showToast(msg: "Hello!");
    },
    // readOnly: true,
    onPreviousMinDateTapped: (date) {},
    onAfterMaxDateTapped: (date) {},
    weekdayStart: DateTime.monday,
    // initialFocusDate: DateTime(2023, 5),
    // initialDateSelected: DateTime(2022, 3, 15),
    // endDateSelected: DateTime(2022, 3, 20),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Scrollable Clean Calendar',
      // theme: ThemeData(
      //   colorScheme: const ColorScheme(
      //     primary: Color(0xFF3F51B5),
      //     primaryContainer: Color(0xFF002984),
      //     secondary: Color(0xFFD32F2F),
      //     secondaryContainer: Color(0xFF9A0007),
      //     surface: Color(0xFFDEE2E6),
      //     background: Color(0xFFF8F9FA),
      //     error: Color(0xFF96031A),
      //     onPrimary: Colors.white,
      //     onSecondary: Colors.white,
      //     onSurface: Colors.black,
      //     onBackground: Colors.black,
      //     onError: Colors.white,
      //     brightness: Brightness.light,
      //   ),
      // ),
      home: Scaffold(
        appBar: AppBar(
           backgroundColor:  const Color.fromARGB(255, 247, 82, 17),
           leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.of(context).pop(),
  ),
          title: const Text('Calendar'),
          actions: [
            IconButton(
              onPressed: () {
                calendarController.clearSelectedDates();
              },
              icon: const Icon(Icons.clear),
            ),
            Container(
              margin:  EdgeInsets.all(10),
            child:TextButton(
                    style: TextButton.styleFrom(
      backgroundColor: Colors.black,
    ),
              child:Text("Add Event",style: TextStyle(color: Colors.white),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => calender()));
                // calendarController.clearSelectedDates();
              },
              // icon: const Icon(Icons.clear),
            ))
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   child:  Icon(Icons.arrow_downward),
        //   onPressed: () {
        //     calendarController.jumpToMonth(date: DateTime(2022, 8));
        //   },
        // ),
        body: ScrollableCleanCalendar(
          calendarController: calendarController,
          layout: Layout.BEAUTY,
          calendarCrossAxisSpacing: 0.00005,
          calendarMainAxisSpacing: 0,
          // spaceBetweenCalendars: 2,
          // spaceBetweenMonthAndCalendar: 2,
        ),
      ),
    );
  }
}