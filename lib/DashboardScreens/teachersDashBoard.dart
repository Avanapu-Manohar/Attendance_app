import 'package:attendence_app/DashboardScreens/attendenceReport.dart';
import 'package:attendence_app/classes%20data/ClassesData.dart';
import 'package:attendence_app/dashboard/attendenceReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
          'List of Classes Taught',
          style: TextStyle(
              color: Color(0xFF081A52),
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.lightBlue, Colors.orangeAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                  .collection('classes').snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final classes = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: classes.length,
                    itemBuilder: (context, int index) {
                      var classData = classes[index].data() as Map<String, dynamic>;
                      return Card(
                        margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                        color: Color(0xFFAEBDD0),
                        child: ListTile(
                          leading: Icon(
                            Icons.class_,
                            color: Color(0xFF081A52),
                          ),
                          title: Text(
                            classData['name'] ?? 'Class Name',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF081A52)),
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
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
