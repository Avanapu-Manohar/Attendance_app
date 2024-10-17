import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dashboard/teacherDashBoard.dart';
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
      debugShowCheckedModeBanner: false,
        title: 'Student Attendence Application',
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/teacherHome': (context) {
            final Map arguments =
                ModalRoute.of(context)!.settings.arguments as Map;
            return TeacherDashboard(userId: arguments['userId']);
          },
          '/studentHome': (context) {
            final Map arguments =
                ModalRoute.of(context)!.settings.arguments as Map;
            return StudentsDashBoard(userId: arguments['userId']);
          }
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
      String userId = userCredential.user!.uid;
      // Get user role
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      String role = userDoc['role'];

      // Navigate based on role
      if (role == 'teacher') {
        Navigator.pushReplacementNamed(context, '/teacherHome', arguments: {
          'userId': userId, // Passing the userId to the route
        });
      } else if (role == 'student') {
        Navigator.pushReplacementNamed(context, '/studentHome', arguments: {
          'userId': userId, // Passing the userId to the route
        });
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
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: const Text('Login',
          style: TextStyle(
          color: Color(0xFF081A52),
          fontWeight: FontWeight.w800,
        ),)),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFF3D98EA)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Icon(Icons.account_circle,size: 150,color: Color(0xFF081A52),),
                SizedBox(height: 15,),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Color(0xFF081A52),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF081A52),
                            width: 2.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF081A52),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Color(0xFF081A52),
                          width: 1.0, // Border width when not focused
                        ),
                      ),
                      prefixIcon: Icon(Icons.email,color: Color(0xFF081A52),size:25,),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        color: Color(0xFF081A52)
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'password',
                      labelStyle: TextStyle(
                          color: Color(0xFF081A52),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF081A52),
                            width: 2.0,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Color(0xFF081A52),
                          width: 1.0, // Border width when not focused
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF081A52),
                          width: 2.0,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock,size: 25,color: Color(0xFF081A52),),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF081A52)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
                    child: Text('Login', style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,)),
                  ),
                ),
                const SizedBox(height: 20),
                // Sign-Up Navigation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?",style: TextStyle(
                    color: Color(0xFF081A52),fontSize: 18,fontWeight: FontWeight.w500
                    ),),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text('Sign Up',style: TextStyle(
                          color: Color(0xFF081A52),fontSize: 18,fontWeight: FontWeight.w700
                      ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.lightBlue,
          centerTitle: true,
          title: Text('Sign Up',
            style: TextStyle(
              color: Color(0xFF081A52),
              fontWeight: FontWeight.w800,
            ),)),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFF3D98EA)],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Icon(Icons.account_circle,size: 150,color: Color(0xFF081A52),),
                SizedBox(height: 15,),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: Color(0xFF081A52),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF081A52),
                            width: 2.0,
                          )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF081A52),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Color(0xFF081A52),
                          width: 1.0, // Border width when not focused
                        ),
                      ),
                      prefixIcon: Icon(Icons.email,color: Color(0xFF081A52),size:25,),
                    ),
                    onChanged: (value) => email = value,
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'password',
                      labelStyle: TextStyle(
                          color: Color(0xFF081A52),
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF081A52),
                            width: 2.0,
                          )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                          color: Color(0xFF081A52),
                          width: 1.0, // Border width when not focused
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF081A52),
                          width: 2.0,
                        ),
                      ),
                      prefixIcon: Icon(Icons.lock,size: 25,color: Color(0xFF081A52),),
                    ),
                    obscureText: true,
                    onChanged: (value) => password = value,
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding inside the box
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38, width: 2.0),
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white54,
                  ),
                  child: DropdownButton<String>(
                    hint: const Text('Select a Role',
                      style: TextStyle(color: Colors.black, fontSize: 16),),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black), // Custom icon color
                    iconSize: 30,
                    underline: Container(
                      height: 2,
                      color: Colors.black38,
                    ),
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
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: () => signUpUser(),
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF081A52)),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 90.0, vertical:8.0),
                    child: Text('Sign Up', style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,)),
                  ),
                ),
              ],
            ),
          ),
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
