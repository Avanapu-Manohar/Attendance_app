import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'attendenceReport.dart';

class SubjectsDashboard extends StatelessWidget {
  const SubjectsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'List of Subjects',
          style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('subjects').snapshots(),
        builder: (context, snapshot) {
          // Check for connection errors or loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No subjects are available.'));
          }

          final subjectDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: subjectDocs.length,
            itemBuilder: (BuildContext context, int index) {
              // Access the subject name from the document data
              String subjectName = subjectDocs[index].get('name') ?? 'Unnamed Subject';
              String subjectId = subjectDocs[index].id; // Get the subject ID for later use

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                child: ListTile(
                  leading: const Icon(Icons.class_),
                  title: Text(subjectName), // Displaying the subject name
                  onTap: () {
                    // Navigate to AttendanceReport screen, passing subject ID
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendenceReport(classId: subjectId), // Pass subjectId or any other required data
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
