import 'package:flutter/material.dart';
import 'package:attendence_app/models/class.dart';
import 'attendence.dart';

class SubjectsScreen extends StatelessWidget {
  late final Class classData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subjects for Class ${classData.id}')),
      body: ListView.builder(
        itemCount: classData.subjects.length,
        itemBuilder: (context, index) {
          var subject = classData.subjects[index];
          return ListTile(
            title: Text(subject),
            onTap: () {
              // Navigate to StudentsScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StudentsScreen(classData: classData, subjectId: subject),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
