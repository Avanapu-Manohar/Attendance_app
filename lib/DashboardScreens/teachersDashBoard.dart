import 'package:flutter/material.dart';
class TeachersDashboard extends StatelessWidget {
  const TeachersDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Teachers  Dashboard',style: TextStyle(color: Colors.black38,
          fontWeight: FontWeight.w500,fontSize: 18),),
          const SizedBox(height: 15,),
          ClassesList(),
        ],
      ),
    );
  }
}
class ClassesList extends StatelessWidget {
  final List<Class> classes = [
    Class(name: 'Mathematics', time: '10:00 AM - 11:30 AM', location: 'Room 101'),
    Class(name: 'Physics', time: '12:00 PM - 1:30 PM', location: 'Room 202'),
    Class(name: 'Chemistry', time: '2:00 PM - 3:30 PM', location: 'Room 303'),
    Class(name: 'Biology', time: '4:00 PM - 5:30 PM', location: 'Room 404'),
  ];

  ClassesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: classes.length,
        itemBuilder: (context, index){
          return Card(
            child: ListTile(
              leading: Icon(Icons.class_),
              
            ),
          );
        }
        );
  }
}

class Class {
  final String name;
  final String time;
  final String location;

  Class({required this.name, required this.time, required this.location});
}