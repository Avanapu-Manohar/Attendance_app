import 'package:flutter/material.dart';

class StudentsDashBoard extends StatelessWidget {
  final String userId;

  StudentsDashBoard({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Student Dashboard',style: TextStyle(
            color: Color(0xFF081A52), fontSize: 18, fontWeight: FontWeight.w700
        ),),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Text(
              'Welcome, Student!',
              style: TextStyle(fontSize: 24,color: Color(0xFF081A52),fontWeight: FontWeight.w800),
            ),
            SizedBox(height: 20),
            Text(
              'This is a temporary page for user ID: $userId',
              style: TextStyle(fontSize: 13,fontWeight: FontWeight.w500,color: Color(0xFF081A52)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can add any action or route to another page here
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF081A52)),
              child: Text('Dummy Action',style: TextStyle(
                fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
