import 'package:flutter/material.dart';
import 'package:attendence_app/models/class.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attendence_app/models/user.dart';

class StudentsScreen extends StatelessWidget {
  final Class classData; // Pass the Class object with studentIds
  final String subjectId;

  StudentsScreen({required this.classData, required this.subjectId});

  Future<List<User>> fetchStudentsForClass(String classId) async {
    var studentSnapshots = await FirebaseFirestore.instance
        .collection('users')
        .where(FieldPath.documentId, whereIn: classData.studentIds)
        .get();

    return studentSnapshots.docs.map((doc) => User.fromFirestore(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text('Students for ${classData.id}',style:
          TextStyle(
              color: Color(0xFF081A52),fontSize: 18,fontWeight: FontWeight.w700
          ),
          )),
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
<<<<<<< Updated upstream
                return Card(
                  margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                  color: Color(0xFF748BEA),
                  child: ListTile(
                    leading: Text(
                      '${index + 1}', // Display serial number
                      style: const TextStyle(
                        color: Color(0xFF081A52),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    title: Text(student.name,style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF081A52)
                    ),),
                    trailing: Row(
                      mainAxisSize: MainAxisSize
                          .min, // Ensures the buttons don't take up unnecessary space
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            markAttendance(
                                student.id, classData.id, subjectId, true);
                          },
                          child: Text('Present',style: TextStyle(
                            color: Colors.white,fontSize: 18,fontWeight: FontWeight.w800
                          ),),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                        SizedBox(
                            width: 8), // Add some spacing between the buttons
                        ElevatedButton(
                          onPressed: () async {
                            markAttendance(
                                student.id, classData.id, subjectId, false);
                          },
                          child: Text('Absent',style: TextStyle(
                            color: Colors.white, fontSize: 18,fontWeight: FontWeight.w800
                          ),),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                        ),
                      ],
                    ),
=======
                return ListTile(
                  title: Text(student.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Ensures the buttons don't take up unnecessary space
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          markAttendance(
                              student, classData.id, subjectId, true);
                        },
                        child: Text('Present'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                      ),
                      SizedBox(
                          width: 8), // Add some spacing between the buttons
                      ElevatedButton(
                        onPressed: () async {
                          markAttendance(
                              student, classData.id, subjectId, false);
                        },
                        child: Text('Absent'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                      ),
                    ],
>>>>>>> Stashed changes
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
  Future<void> markAttendance(
      User student, String classId, String subjectId, bool present) async {
    // Daily and monthly integer representations
    DateTime now = DateTime.now();
    int dailyDate = int.parse(
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}");
    int monthlyDate =
        int.parse("${now.year}${now.month.toString().padLeft(2, '0')}");
    String docId = '${classId}_${subjectId}_${dailyDate}_${student.id}';
    final attendanceCollection =
        FirebaseFirestore.instance.collection('attendance-sheet');
    DocumentSnapshot doc = await attendanceCollection.doc(docId).get();
    if (!doc.exists) {
      FirebaseFirestore.instance.collection('attendance-sheet').doc(docId).set({
        'class': classId,
        'className': classData.name,
        'studentId': student.id,
        'studentName': student.name,
        'datetime': FieldValue.serverTimestamp(),
        'dailyDate': dailyDate, // Save integer format for daily queries
        'monthlyDate': monthlyDate, // Save integer format for monthly queries
        'present': present,
        'subject': subjectId
      });
    } else {
      await attendanceCollection.doc(docId).update({'present': present});
    }
  }
}
