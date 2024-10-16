import 'package:flutter/material.dart';

class StudentsDashBoard extends StatelessWidget {
  final String userId;

  StudentsDashBoard({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome, Student!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'This is a temporary page for user ID: $userId',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can add any action or route to another page here
              },
              child: Text('Dummy Action'),
            ),
          ],
        ),
      ),
    );
  }
}
