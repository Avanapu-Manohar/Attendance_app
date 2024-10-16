import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classes data/studentsData.dart';

class AttendenceReport extends StatefulWidget {
  final String classId; // Pass the class ID (e.g., 'class 8') to the constructor

  AttendenceReport({super.key, required this.classId});

  @override
  _AttendenceReportState createState() => _AttendenceReportState();
}

class _AttendenceReportState extends State<AttendenceReport> {
  List<Student> students = []; // List to hold the fetched student data
  bool isLoading = true; // To show loading indicator while fetching data

  @override
  void initState() {
    super.initState();
    _fetchStudents(); // Call the function to fetch students
  }

  Future<void> _fetchStudents() async {
    try {
      // Fetch the class document
      DocumentSnapshot classDoc = await FirebaseFirestore.instance
          .collection('classes')
          .doc(widget.classId)
          .get();

      if (classDoc.exists) {
        // Get the array of student references
        List<dynamic> studentRefs = classDoc['students'];

        // Fetch each student document and create a Student object
        for (var ref in studentRefs) {
          DocumentSnapshot studentDoc = await FirebaseFirestore.instance
              .collection('users')
              .doc(ref.id) // Assuming ref is a DocumentReference
              .get();

          if (studentDoc.exists) {
            students.add(Student.fromFirestore(studentDoc)); // Assuming you have a method to create Student from Firestore document
          }
        }
      }
    } catch (e) {
      print('Error fetching students: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading when data fetch is complete
      });
    }
  }

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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.orangeAccent],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
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
                child: ListView.builder(
                  itemCount: students.length,
                  itemBuilder: (context, int index) {
                    return Card(
                      margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
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
                          students[index].name,
                          style: const TextStyle(
                            color: Color(0xFF081A52),
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        trailing: Checkbox(
                          value: students[index].isPresent,
                          onChanged: (bool? value) {
                            if (value != null) {
                              setState(() {
                                students[index].isPresent = value; // Update present status
                              });
                            }
                          },
                        ),
                      ),
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
