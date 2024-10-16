import 'package:flutter/material.dart';
class Signup extends StatelessWidget {
  Signup({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              const Text('Student Login',style: TextStyle(fontSize: 35,
                  fontWeight: FontWeight.bold,color: Color(0xFF081A52)),),
              const SizedBox(height:20),
              SizedBox(
                width: 300, // Set your desired width here
                child: TextField(
                  controller: emailController,
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
              const SizedBox(height:20),
              SizedBox(
                width: 300, // Set your desired width here
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'UserName',
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
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      color: Color(0xFF081A52)
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: passwordController,
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
              const SizedBox(height:20),
              SizedBox(
                width: 300, // Set your desired width here
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Role',
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
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      color: Color(0xFF081A52)
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  String email = emailController.text;
                  String password = passwordController.text;
                  // Handle the login logic here
                },
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF081A52)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 12.0),
                  child: Text('Sign UP', style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold,)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
