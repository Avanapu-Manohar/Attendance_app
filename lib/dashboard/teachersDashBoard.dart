import 'package:attendence_app/dashboard/attendenceReport.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeachersDashboard extends StatelessWidget {
  const TeachersDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teachers Dashboard',
          style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('classes').snapshots(),
        builder: (context, snapshot) {
          // Check for connection errors or loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No classes available.'));
          }

          final classDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: classDocs.length,
            itemBuilder: (BuildContext context, int index) {
              var classData = classDocs[index].data() as Map<String, dynamic>;
              String className = classData['name'] ?? 'Unnamed Class';  // Get class name

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.class_),
                  title: Text(className),
                  onTap: () {
                    // Navigate to AttendanceReport screen, passing class ID or other relevant data
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
    );
  }
}
