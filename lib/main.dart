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
          '/signup': (context) => SignUpScreen(),
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
          .doc(userCredential.user!.uid)
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
      // Optionally, show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );
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
            const SizedBox(height: 20),
            // Sign-Up Navigation
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String email = '';
  String password = '';
  String selectedRole = 'student'; // default role

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) => email = value,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Password'),
              obscureText: true,
              onChanged: (value) => password = value,
            ),
            DropdownButton<String>(
              value: selectedRole,
              items: ['student', 'teacher'].map((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) => setState(() {
                selectedRole = value!;
              }),
            ),
            ElevatedButton(
              onPressed: () => signUpUser(),
              child: Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  void signUpUser() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Add user to Firestore with role
        await _firestore.collection('users').doc(user.uid).set({
          'email': email,
          'role': selectedRole,
        });

        // Navigate to the dashboard or home screen
        Navigator.pushNamed(context, '/');
      }
    } catch (e) {
      print(e);
      // Handle sign-up error (show Snackbar or Dialog)
    }
  }
}
