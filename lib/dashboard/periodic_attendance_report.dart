import 'package:flutter/material.dart';
import 'daily_attendance_table.dart';
import 'monthly_attendance_table.dart';

class PeriodicAttendanceReporter extends StatefulWidget {
  final String? classId;
  final String? subjectId;

  const PeriodicAttendanceReporter({
    required this.classId,
    required this.subjectId,
  });

  @override
  _PeriodicAttendanceReporterState createState() =>
      _PeriodicAttendanceReporterState(
        classId: classId!,
        subjectId: subjectId!,
      );
}

class _PeriodicAttendanceReporterState
    extends State<PeriodicAttendanceReporter> {
  final String classId;
  final String subjectId;

  // Selected year and month values
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  _PeriodicAttendanceReporterState({
    required this.classId,
    required this.subjectId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Attendance View",
          style: TextStyle(
              color: Color(0xFF081A52),
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Daily View',
                style: TextStyle(
                    color: Color(0xFF081A52),
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Year Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding inside the box
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white54,
                  ),
                  child: DropdownButton<int>(
                    value: _selectedYear,
                    items: List.generate(
                      31,
                          (index) => DropdownMenuItem(
                        value: 2000 + index,
                        child: Text((2000 + index).toString()),
                      ),
                    ),
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedYear = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                // Month Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding inside the box
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white54,
                  ),
                  child: DropdownButton<int>(
                    value: _selectedMonth,
                    items: List.generate(
                      12,
                          (index) => DropdownMenuItem(
                        value: index + 1,
                        child: Text(
                          _getMonthName(index + 1),
                        ),
                      ),
                    ),
                    onChanged: (int? newValue) {
                      setState(() {
                        _selectedMonth = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            // Conditionally display the appropriate attendance view
            Padding(
              padding: EdgeInsets.all(10.0),
              child: DailyAttendanceTable(
                classId: classId,
                subjectId: subjectId,
                year: _selectedYear,
                month: _selectedMonth,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get month name from number
  String _getMonthName(int month) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames[month - 1];
  }
}
