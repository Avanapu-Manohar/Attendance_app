import 'package:attendence_app/dashboard/attendance_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attendence_app/models/class.dart';
import 'subjects_screen.dart';

class TeacherDashboard extends StatelessWidget {
  final String userId; // Assuming the teacher is logged in

  TeacherDashboard({required this.userId});

  // Fetch the classes for the teacher from Firestore
  Future<List<Class>> fetchClassesForTeacher() async {
    var classesSnapshot =
        await FirebaseFirestore.instance.collection('classes').get();

    return classesSnapshot.docs.map((doc) => Class.fromFirestore(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teacher Dashboard')),
      body: FutureBuilder<List<Class>>(
        future: fetchClassesForTeacher(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No classes found'));
          } else {
            var classes = snapshot.data!;
            return ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index) {
                var classData = classes[index];
                return ListTile(
                  title: Text('${classData.id}'),
                  onTap: () {
                    // Navigate to SubjectScreen with the class id and subjects list
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SubjectsScreen(classData: classData),
                      ),
                    );
                  },
                  // Add another button in the trailing section
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to AttendanceReport when this button is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendanceScreen(),
                            ),
                          );
                        },
                        child: Text('Attendance Report'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
