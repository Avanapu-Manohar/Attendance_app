import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard/teachersDashBoard.dart';
import 'dashboard/studentDashBoard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Web-specific Firebase initialization

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyB-Qx0cL_oO6wEJpOTsuvIWRocImxwQJyY",
      appId: "1:974951677749:web:1e1bbc268a6fba322cd67c",
      messagingSenderId: "974951677749",
      projectId: "attendenceapp-25337",
      storageBucket: "attendenceapp-25337.appspot.com",
      authDomain: "attandenceapp-25337.firebaseapp.com",
    ),
  );

  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Student Attendence Application',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/teacherHome': (context) => TeachersDashboard(),
          '/studentHome': (context) => StudentDashboard(),
        });
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginUser() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Get user role
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.email)
          .get();
      String role = userDoc['role'];

      // Navigate based on role
      if (role == 'teacher') {
        Navigator.pushReplacementNamed(context, '/teacherHome');
      } else if (role == 'student') {
        Navigator.pushReplacementNamed(context, '/studentHome');
      }
    } catch (e) {
      print('Login failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: loginUser,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
