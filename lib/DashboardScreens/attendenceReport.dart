import 'package:attendence_app/classes%20data/studentsData.dart';
import 'package:flutter/material.dart';

class AttendenceReport extends StatelessWidget {
  final ValueNotifier<List<Student>> studentsNotifier = ValueNotifier<List<Student>>(students);

  AttendenceReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Attendance',
          style: TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder<List<Student>>(
          valueListenable: studentsNotifier,
          builder: (context, studentList, _) {
            return ListView.builder(
              itemCount: studentList.length, // Use the updated student list
              itemBuilder: (context, int index) {
                return Card(
                  child: ListTile(
                    title: Text(studentList[index].name),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Present'),
                        Checkbox(
                          value: studentList[index].isPresent,
                          onChanged: (bool? value) {
                            if (value != null && value) {
                              studentsNotifier.value = List.from(studentList)
                                ..[index].isPresent = true;
                          }
                          },
                        ),
                        const SizedBox(width: 10,),
                        const Text('Absent'),
                        Checkbox(
                          value: !studentList[index].isPresent, // Inverse of the present status
                          onChanged: (bool? value) {
                            if (value != null && value) {
                              studentsNotifier.value = List.from(studentList)
                                ..[index].isPresent = false;
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
    );
  }
}
