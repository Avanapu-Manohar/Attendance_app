import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  // Toggle control variable (0 for daily, 1 for monthly)
  int _selectedView = 0;

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
                    classId: 'classId123',
                    subjectId: 'subjectId456',
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
