import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard/teachersDashBoard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Web-specific Firebase initialization

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBife0DEe_x7KJXpEyJo-rPbtYvzPPRbt8",
      appId: "1:769123613709:web:53a3a55514081a3be86944",
      messagingSenderId: "769123613709",
      projectId: "attandenceapp-b01ea",
      storageBucket: "attandenceapp-b01ea.appspot.com",
      authDomain: "attandenceapp-b01ea.firebaseapp.com",
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
          '/studentHome': (context) => TeachersDashboard(),
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
<<<<<<< HEAD
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors:[Colors.blue,
          Colors.red],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft)
        ),
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               const Icon(Icons.account_circle_sharp,size: 200,color: Color(
                   0xFF081A52)),
               SizedBox(height:25,),
               const Text('welcome',style: TextStyle(fontSize: 55,
               color: Color(0xFF081A52),fontWeight: FontWeight.bold ),),
               const SizedBox(height: 10,),
               const Text('Login as a',style: TextStyle(fontSize:25,
                   color: Color(0xFF081A52),fontWeight: FontWeight.w600),),
               const SizedBox(height: 25,),
               ElevatedButton(onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => LoginTeacher()),
                 );
               },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Color(0xFF081A52), // Set the background color here
                   ),
                   child:
                   const Padding(
                       padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                     child: Text('Teacher', style: TextStyle(fontSize: 20,color: Colors.white)),
                   )
               ),
               SizedBox(height: 15,),
               const Text('OR',style: TextStyle(fontSize:20,
                   color: Colors.white,fontWeight: FontWeight.w900),),
               const SizedBox(height: 15,),
               ElevatedButton(onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => LoginStudent()),
                 );
               },
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Color(0xFF081A52), // Set the background color here
                   ),
                   child:
                   const Padding(
                     padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                     child: Text('Student', style: TextStyle(fontSize: 20,color: Colors.white)),
                   )
               ),
             ],
           ),
         ),
=======
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
>>>>>>> 5541f29d4c91c1552b93fdc230109994b80d8dbd
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(child: Text('Welcome!')),
    );
  }
}
