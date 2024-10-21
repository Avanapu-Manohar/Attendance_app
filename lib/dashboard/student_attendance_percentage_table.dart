import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentAttendancePercentageTable extends StatelessWidget {
  final String classId;
  final String studentId;
  final int year;
  final int month;

  const StudentAttendancePercentageTable({
    required this.classId,
    required this.studentId,
    required this.year,
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: getAttendancePercentage(classId, studentId, year, month),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No attendance data available.');
        }

        Map<String, double> attendancePercentageData = snapshot.data!;

        List<DataRow> rows = attendancePercentageData.entries.map((entry) {
          String subjectId = entry.key;
          double percentage = entry.value;

          return DataRow(cells: [
            DataCell(Text(subjectId)),
            DataCell(Text('${percentage.toStringAsFixed(2)}%')),
          ]);
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1), // Adding a border
              borderRadius: BorderRadius.circular(8), // Adding rounded corners if needed
            ),
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Subject',
                    style: TextStyle(
                      color: Color(0xFF081A52),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Attendance Percentage',
                    style: TextStyle(
                      color: Color(0xFF081A52),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: rows,
              // To add borders between rows and columns
              border: TableBorder(
                horizontalInside: BorderSide(
                  width: 1,
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<Map<String, double>> getAttendancePercentage(
      String classId, String studentId, int year, int month) async {
    final attendanceCollection =
    FirebaseFirestore.instance.collection('attendance-sheet');

    // Query for attendance records in the specified class and student for the specified month
    QuerySnapshot querySnapshot = await attendanceCollection
        .where('class', isEqualTo: classId)
        .where('studentId', isEqualTo: studentId)
        .where('dailyDate', isGreaterThanOrEqualTo: int.parse('$year${month.toString().padLeft(2, '0')}01')) // YYYYMMDD format
        .where('dailyDate', isLessThanOrEqualTo: int.parse('$year${month.toString().padLeft(2, '0')}31')) // YYYYMMDD format
        .get();

    // Initialize maps to store total days and present days by subject.
    Map<String, int> totalDaysMap = {};
    Map<String, int> presentDaysMap = {};

    // Iterate over the query results and populate the maps
    for (var doc in querySnapshot.docs) {
      String subjectId = doc['subject'];
      bool isPresent = doc['present'];

      // Initialize maps for the subject if not already present
      if (!totalDaysMap.containsKey(subjectId)) {
        totalDaysMap[subjectId] = 0;
        presentDaysMap[subjectId] = 0;
      }

      // Increment total days for the subject
      totalDaysMap[subjectId] = totalDaysMap[subjectId]! + 1;

      // Increment present days if the student was present
      if (isPresent) {
        presentDaysMap[subjectId] = presentDaysMap[subjectId]! + 1;
      }
    }

    // Calculate the percentage for each subject
    Map<String, double> percentageMap = {};

    totalDaysMap.forEach((subjectId, totalDays) {
      int presentDays = presentDaysMap[subjectId] ?? 0; // Default to 0 if not found
      double percentage = totalDays > 0 ? (presentDays / totalDays) * 100 : 0; // Avoid division by zero
      percentageMap[subjectId] = percentage;
    });

    return percentageMap;
  }
}
