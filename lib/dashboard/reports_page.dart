import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package

import 'attendance_screen.dart';

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
        title: Text(
          'Attendance Report Screen',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'Reports for a list of classes',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Dropdown for Class selection
                DropdownButton(
                  hint: const Text('Select class'),
                  value: classChoose,
                  items: classList.map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      classChoose = newValue;
                      subjectList = classSubjectsMap[newValue!] ?? [];
                      subjectChoose = null; // Reset subject when class changes
                    });
                  },
                ),
                SizedBox(width: 15),
                // Dropdown for Subject selection (based on selected class)
                DropdownButton(
                  hint: const Text('Select subject'),
                  value: subjectChoose,
                  items: subjectList.map((String value) {
                    return DropdownMenuItem(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      subjectChoose = newValue;
                    });
                  },
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
                      builder: (context) => AttendanceScreen(
                        userId: '',
                      ),
                    ),
                  );
                } else {
                  // Show error message if class or subject is not selected
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please select both class and subject'),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'Enter',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
