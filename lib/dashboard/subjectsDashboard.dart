import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'attendenceReport.dart';
class SubjectsDashboard extends StatelessWidget {
  const SubjectsDashboard({super.key});

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
        stream: FirebaseFirestore.instance.collection('subjects').snapshots(),
        builder: (context, snapshot) {
          // Check for connection errors or loading state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No subjects are available.'));
          }

          final classDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: classDocs.length,
            itemBuilder: (BuildContext context, int index) {
              // Use the document ID as the class name
              String subjectName = classDocs[index].id;

              return Card(
                child: ListTile(
                  leading: const Icon(Icons.class_),
                  title: Text(subjectName), // Displaying document ID as class name
                  onTap: () {
                    // Navigate to AttendanceReport screen, passing class ID
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
