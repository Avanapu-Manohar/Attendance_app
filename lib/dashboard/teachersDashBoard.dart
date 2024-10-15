import 'package:attendence_app/dashboard/attendenceReport.dart';
import 'package:attendence_app/classes%20data/ClassesData.dart';
import 'package:flutter/material.dart';

class TeachersDashboard extends StatelessWidget {
  const TeachersDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Teachers  Dashboard',
          style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
          itemCount: classes.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                  leading: Icon(Icons.class_),
                  title: Text(classes[index].name),
                  subtitle: Text(
                      'Time: ${classes[index].time}\nLocation: ${classes[index].location}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendenceReport(),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
