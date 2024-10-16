import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'dashboard/attendenceReport.dart';

class TeachersDashboard extends StatelessWidget {
  const TeachersDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: const Text(
          'Classes Taught',
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
                'Select a Class to Post Attendance',
                style: TextStyle(
                  color: Color(0xFF081A52),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('classes').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final classes = snapshot.data!.docs;
                  if (classes.isEmpty) {
                    return const Center(child: Text('No classes available'));
                  }
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
}
