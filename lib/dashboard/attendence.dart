import 'package:flutter/material.dart';
import 'package:attendence_app/models/class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attendence_app/models/user.dart';

class StudentsScreen extends StatelessWidget {
  final Class classData; // Pass the Class object with studentIds
  final String subjectId;

  StudentsScreen({required this.classData, required this.subjectId});

  Future<List<User>> fetchStudentsForClass(String classId) async {
    var classDoc = await FirebaseFirestore.instance
        .collection('classes')
        .doc(classId)
        .get();
    List<String> studentIds =
        List<String>.from(classDoc.data()?['students'] ?? []);
    var studentSnapshots = await FirebaseFirestore.instance
        .collection('users')
        .where(FieldPath.documentId, whereIn: studentIds)
        .get();

    return studentSnapshots.docs.map((doc) => User.fromFirestore(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Students for ${classData.id}')),
      body: FutureBuilder<List<User>>(
        future: fetchStudentsForClass(classData.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No students found'));
          } else {
            var students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                var student = students[index];
                return ListTile(
                  title: Text(student.name),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Mark attendance for this student
                      markAttendance(student.id, classData.id, subjectId);
                    },
                    child: Text('Mark Present'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Dummy function to mark attendance
  void markAttendance(String studentId, String classId, String subjectId) {
    // Logic to mark attendance in Firestore
    FirebaseFirestore.instance.collection('attendance-sheet').add({
      'class': classId,
      'studentId': studentId,
      'datetime': FieldValue.serverTimestamp(),
      'present': true,
      'subject': subjectId
    });
  }
}
