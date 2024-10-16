import 'package:attendence_app/classes%20data/studentsData.dart';
import 'package:flutter/material.dart';

class AttendenceReport extends StatelessWidget {
  final ValueNotifier<List<Student>> studentsNotifier = ValueNotifier<List<Student>>(students);

  AttendenceReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text(
          'Student Attendance',
          style: TextStyle(
            color: Color(0xFF081A52),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.lightBlue, Colors.orangeAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'List of Students in a Class',
                  style: TextStyle(
                    color: Color(0xFF081A52),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<List<Student>>(
                  valueListenable: studentsNotifier,
                  builder: (context, studentList, _) {
                    return ListView.builder(
                      itemCount: studentList.length, // Use the updated student list
                      itemBuilder: (context, int index) {
                        return Card(
                          margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                          child: ListTile(
                            leading: Text(
                              '${index + 1}', // Display serial number
                              style: const TextStyle(
                                color: Color(0xFF081A52),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            title: Text(
                              studentList[index].name,
                              style: const TextStyle(
                                  color: Color(0xFF081A52),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Present',
                                  style: TextStyle(
                                      color: Color(0xFF081A52),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Checkbox(
                                  value: studentList[index].isPresent,
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      studentsNotifier.value = List.from(studentList)
                                        ..[index].isPresent = value; // Update present status
                                  }
                                  },
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Absent',
                                  style: TextStyle(
                                      color: Color(0xFF081A52),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Checkbox(
                                  value: !studentList[index].isPresent, // Inverse of the present status
                                  onChanged: (bool? value) {
                                    if (value != null) {
                                      studentsNotifier.value = List.from(studentList)
                                        ..[index].isPresent = !value; // Update absent status
                                  }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
