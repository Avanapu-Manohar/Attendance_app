import 'package:attendence_app/dashboard/student_daily_attendance_table.dart';
import 'package:flutter/material.dart';
import 'package:attendence_app/dashboard/student_attendance_percentage_table.dart'; // Import the percentage table

class StudentAttendanceReport extends StatefulWidget {
  final String? classId;
  final String? studentId;

  const StudentAttendanceReport({
    required this.classId,
    required this.studentId,
  });

  @override
  State<StudentAttendanceReport> createState() => _StudentAttendanceReportState(
    classId: classId!,
    studentId: studentId!,
  );
}

class _StudentAttendanceReportState extends State<StudentAttendanceReport> {
  final String classId;
  final String studentId;

  // Selected year and month
  int _selectedYear = DateTime.now().year;
  int _selectedMonth = DateTime.now().month;

  _StudentAttendanceReportState({
    required this.classId,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          "Student Attendance Report",
          style: TextStyle(
            color: Color(0xFF081A52),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Daily View',
                style: TextStyle(
                  color: Color(0xFF081A52),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
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
                      100,
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
                        child: Text(_getMonthName(index + 1)),
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
            // Display the attendance table based on the selected year and month
            StudentDailyAttendanceTable(
              classId: classId,
              studentId: studentId,
              year: _selectedYear,
              month: _selectedMonth,
            ),
            SizedBox(height: 15,),
            // Add the percentage-wise attendance report
            Text(
              'Percentage-wise Attendance Report',
              style: TextStyle(
                color: Color(0xFF081A52),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            StudentAttendancePercentageTable(
              classId: classId,
              studentId: studentId,
              year: _selectedYear,
              month: _selectedMonth,
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to get month name from number
  String _getMonthName(int month) {
    const monthNames = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return monthNames[month - 1];
  }
}
