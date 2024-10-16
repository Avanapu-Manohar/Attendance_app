import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendenceReport extends StatelessWidget {
  final String classId; // Class ID to retrieve students for the specific class

  AttendenceReport({super.key, required this.classId}); // Receive classId when navigating

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
            gradient: LinearGradient(
                colors: [Colors.lightBlue, Colors.orangeAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('classes').doc(classId).get(),
            builder: (context, snapshot) {
              // Check for loading state
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('No data found for this class.'));
              }

              // Extracting student references from the document
              List<dynamic> studentRefs = snapshot.data!['students'] ?? [];
              List<Future<Student>> studentFutures = [];

              for (var ref in studentRefs) {
                studentFutures.add(FirebaseFirestore.instance
                    .collection('users')
                    .doc(ref)
                    .get()
                    .then((studentDoc) {
                  // Fetching only the student's name
                  return Student(
                    name: studentDoc['name'], // Fetching the name
                    isPresent: false, // Keeping isPresent as default, or set your logic here
                  );
                }));
              }

              return FutureBuilder<List<Student>>(
                future: Future.wait(studentFutures),
                builder: (context, studentSnapshot) {
                  // Check for loading state for students
                  if (studentSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!studentSnapshot.hasData || studentSnapshot.data!.isEmpty) {
                    return const Center(child: Text('No students available.'));
                  }

                  List<Student> studentList = studentSnapshot.data!;

                  return ListView.builder(
                    itemCount: studentList.length,
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
                                    // Update attendance status locally
                                    studentList[index].isPresent = value; // Update present status
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
                                    // Update attendance status locally
                                    studentList[index].isPresent = !value; // Update absent status
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
              );
            },
          ),
        ),
      ),
    );
  }
}

// Assuming you have a Student class
class Student {
  String name;
  bool isPresent;

  Student({required this.name, required this.isPresent});
}
