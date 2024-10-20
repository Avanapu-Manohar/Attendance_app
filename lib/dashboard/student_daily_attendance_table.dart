import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentDailyAttendanceTable extends StatelessWidget {
  final String classId;
  final String studentId;
  final int year;
  final int month;

  const StudentDailyAttendanceTable(
      {required this.classId,
      required this.studentId,
      required this.year,
      required this.month});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, Map<String, bool>>>(
      future: getDailyAttendance(classId, studentId, year, month),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No attendance data available.');
        }

        Map<String, Map<String, bool>> attendanceData = snapshot.data!;

        List<String> dates = List.generate(31, (index) {
          String date =
              '${year}${month.toString().padLeft(2, '0')}${(index + 1).toString().padLeft(2, '0')}'; // YYYYMMDD format
          return date;
        }).where((date) => DateTime.tryParse(date) != null).toList();

        List<DataRow> rows = attendanceData.entries.map((entry) {
          String studentId = entry.key;
          Map<String, bool> studentAttendance = entry.value;

          List<DataCell> cells = [
            DataCell(Text(studentId)),
          ];

          cells.addAll(dates.map((date) {
            bool isPresent = studentAttendance[date] ?? false;
            return DataCell(Text(isPresent ? 'Present' : 'Absent'));
          }).toList());

          return DataRow(cells: cells);
        }).toList();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1), // Adding a border
              borderRadius: BorderRadius.circular(8), // Adding rounded corners if needed
            ),
            child: DataTable(
              columns: [
                DataColumn(label: Text('Date / Subject',style: TextStyle(
                  color: Color(0xFF081A52),fontSize: 15,fontWeight: FontWeight.bold
                ),)),
                ...dates
                    .map((date) => DataColumn(label: Text(date.substring(6),style: TextStyle(
                    color: Color(0xFF081A52),fontSize: 15,fontWeight: FontWeight.w500
                ),))),
              ],
              rows: rows,
            ),
          ),
        );
      },
    );
  }

  Future<Map<String, Map<String, bool>>> getDailyAttendance(
      String classId, String studentId, int year, int month) async {
    final attendanceCollection =
        FirebaseFirestore.instance.collection('attendance-sheet');

    // Query for attendance records in the specified class and subject for the specified month
    QuerySnapshot querySnapshot = await attendanceCollection
        .where('class', isEqualTo: classId)
        .where('studentId', isEqualTo: studentId)
        .where('dailyDate',
            isGreaterThanOrEqualTo:
                int.parse('$year$month' + '01')) // YYYYMMDD format
        .where('dailyDate',
            isLessThan:
                int.parse('$year$month' + '32')) // To get all days of the month
        .get();

    // Initialize a map to store attendance by student and date
    Map<String, Map<String, bool>> attendanceMap = {};

    // Iterate over the query results and populate the map
    for (var doc in querySnapshot.docs) {
      String subjectId = doc['subject'];
      int dailyDate = doc['dailyDate'];
      bool isPresent = doc['present'];

      // Extract the date as YYYYMMDD format
      String date = dailyDate.toString();
      String formattedDate =
          '${date.substring(0, 4)}${date.substring(4, 6)}${date.substring(6, 8)}'; // YYYYMMDD

      // Initialize student entry if not present
      if (!attendanceMap.containsKey(subjectId)) {
        attendanceMap[subjectId] = {};
      }

      // Store the attendance status (present or absent)
      attendanceMap[subjectId]![formattedDate] = isPresent;
    }

    return attendanceMap; // Map of studentId -> (Map of date -> present status)
  }
}
