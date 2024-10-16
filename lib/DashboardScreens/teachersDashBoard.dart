import 'package:attendence_app/DashboardScreens/attendenceReport.dart';
import 'package:attendence_app/dashboard/attendenceReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class TeachersDashboard extends StatefulWidget {
  const TeachersDashboard({super.key});

  @override
  _TeachersDashboardState createState() => _TeachersDashboardState();
}

class _TeachersDashboardState extends State<TeachersDashboard> {
  // Initialize Firebase in the stateful widget
  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        // Show loading spinner while Firebase initializes
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Error initializing Firebase")),
          );
        } else {
          // After Firebase is initialized, load the UI
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.lightBlue,
              centerTitle: true,
              title: const Text(
                'List of Classes Taught',
                style: TextStyle(
                  color: Color(0xFF081A52),
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.orangeAccent],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Select a class to Post attendance ',
                      style: TextStyle(
                        color: Color(0xFF081A52),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('classes') // Fetching 'classes' collection from Firestore
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final classes = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: classes.length,
                          itemBuilder: (context, index) {
                            var classData = classes[index].data() as Map<String, dynamic>;
                            return Card(
                              margin: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                              color: const Color(0xFFAEBDD0),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.class_,
                                  color: Color(0xFF081A52),
                                ),
                                title: Text(
                                  classData['name'] ?? 'Class Name',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF081A52),
                                  ),
                                ),
                                subtitle: Text(
                                  'Time: ${classData['time'] ?? 'N/A'}\nLocation: ${classData['location'] ?? 'N/A'}',
                                  style: const TextStyle(
                                    color: Color(0xFF081A52),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AttendenceReport(),
                                    ),
                                  );
                                },
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
          );
        }
      },
    );
  }
}
