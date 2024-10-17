import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package

import 'periodic_attendance_report.dart';

class ReportsPage extends StatefulWidget {
  ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String? classChoose;
  String? subjectChoose;

  // List to hold the fetched classes and subjects
  List<String> classList = [];
  List<String> subjectList = [];

  // Store selected class and corresponding subjects
  Map<String, List<String>> classSubjectsMap = {};

  @override
  void initState() {
    super.initState();
    fetchClassesAndSubjects(); // Fetch data from Firestore
  }

  // Method to fetch classes and subjects from Firestore
  Future<void> fetchClassesAndSubjects() async {
    try {
      // Get the 'classes' collection from Firestore
      CollectionReference classesCollection =
          FirebaseFirestore.instance.collection('classes');

      QuerySnapshot querySnapshot = await classesCollection.get();

      // Clear the lists before adding data
      classList.clear();
      classSubjectsMap.clear();

      for (var doc in querySnapshot.docs) {
        String className = doc['name'];
        List<String> subjects = List<DocumentReference>.from(doc['subjects'])
            .map((ref) => ref.id)
            .toList();

        classList.add(className);

        classSubjectsMap[className] = subjects;
      }

      setState(() {});
    } catch (e) {
      print("Error fetching classes and subjects: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Attendance Report Screen',
          style: TextStyle(
              color: Color(0xFF081A52), fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Text(
              'Reports for a list of classes and subjects',
              style: TextStyle(
                  color: Color(0xFF081A52),
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dropdown for Class selection
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding inside the box
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white54,
                  ),
                  child: DropdownButton(
                    hint: const Text('Select class',style: TextStyle(
                        color: Color(0xFF081A52),
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),),
                    underline: Container(
                      height: 2,
                      color: Colors.black38,
                    ),
                    value: classChoose,
                    items: classList.map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value,style: TextStyle(
                          color: Color(0xFF081A52),
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        classChoose = newValue;
                        subjectList = classSubjectsMap[newValue!] ?? [];
                        subjectChoose = null; // Reset subject when class changes
                      });
                    },
                  ),
                ),
                SizedBox(width: 25),
                // Dropdown for Subject selection (based on selected class)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding inside the box
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white54,
                  ),
                  child: DropdownButton(
                    hint: const Text('Select subject',style: TextStyle(
                        color: Color(0xFF081A52),
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),),
                    underline: Container(
                      height: 2,
                      color: Colors.black38,
                    ),
                    value: subjectChoose,
                    items: subjectList.map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value,style: TextStyle(
                          color: Color(0xFF081A52),
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        subjectChoose = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (classChoose != null && subjectChoose != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PeriodicAttendanceReporter(
                          classId: classChoose!, subjectId: subjectChoose!),
                    ),
                  );
                } else {
                  // Show error message if class or subject is not selected
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please select both class and subject'),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF081A52)),
              child:const Padding(
                padding: EdgeInsets.symmetric(horizontal: 90.0, vertical:8.0),
                child: Text('Enter', style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,)),
              ),
              ),
          ],
        ),
      ),
    );
  }
}
