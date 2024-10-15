import 'package:flutter/material.dart';

import '../../DashboardScreens/teachersDashBoard.dart';
class LoginTeacher extends StatelessWidget {
  LoginTeacher({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Teacher Login',style: TextStyle(fontSize: 18,
                fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),),
            const SizedBox(height: 15,),
            SizedBox(
              width: 300, // Set your desired width here
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 300,
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                String email = emailController.text;
                String password = passwordController.text;
                // Handle the login logic here
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeachersDashboard()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black38),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
                child: Text('Login', style: TextStyle(fontSize: 18,color: Colors.black87)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
