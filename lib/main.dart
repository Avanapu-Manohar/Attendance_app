import 'package:attendence_app/auth/Roles/loginScreenTeacher.dart';
import 'package:flutter/material.dart';
import 'package:attendence_app/auth/Roles/loginScreenStudent.dart';

void main() {
  runApp(const myapp());
}
class myapp extends StatelessWidget {
  const myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: WelcomeScreen(),
      ),
    );
  }
}
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
    );
  }
}
