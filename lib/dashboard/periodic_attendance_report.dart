import 'package:flutter/material.dart';
import 'daily_attendance_table.dart';
import 'monthly_attendance_table.dart';

class PeriodicAttendanceReporter extends StatefulWidget {
  final String? classId;
  final String? subjectId;
  const PeriodicAttendanceReporter(
      {required this.classId, required this.subjectId});

  @override
  _PeriodicAttendanceReporterState createState() =>
      _PeriodicAttendanceReporterState(classId: classId, subjectId: subjectId);
}

class _PeriodicAttendanceReporterState
    extends State<PeriodicAttendanceReporter> {
  final String? classId;
  final String? subjectId;
  // Toggle control variable (0 for daily, 1 for monthly)
  int _selectedView = 0;
  const _PeriodicAttendanceReporterState(
      {required this.classId, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance View"),
      ),
      body: Column(
        children: [
          // Toggle Button to switch between Daily and Monthly
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleButtons(
              isSelected: [_selectedView == 0, _selectedView == 1],
              onPressed: (int newIndex) {
                setState(() {
                  _selectedView = newIndex;
                });
              },
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Daily View'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Monthly View'),
                ),
              ],
            ),
          ),

          // Conditionally display the appropriate attendance view
          Expanded(
            child: _selectedView == 0
                ? DailyAttendanceTable(
                    classId: classId!,
                    subjectId: subjectId!,
                    year: 2024,
                    month: 10)
                : MonthlyAttendanceTable(
                    classId: 'classId123',
                    subjectId: 'subjectId456',
                    year: 2024),
          ),
        ],
      ),
    );
  }
}
