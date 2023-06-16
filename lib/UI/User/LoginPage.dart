import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Models/auth.dart';
import 'ServicePage.dart';
import 'SignUp.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errMessage = '';
  bool isLogin= false;
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passController=TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      Auth().signInWithEmailAndPassword(email: emailController.text, password: passController.text);
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServicePage()));
    } on FirebaseAuthException catch(e) {
      setState(() {
        errMessage=e.message;
        print(errMessage);
      });
    }
  }
  Future<void> createUserWithEmailAndPassword() async {
    try {
      Auth().createUserWithEmailAndPassword(email: emailController.text, password: passController.text);
    } on FirebaseAuthException catch(e) {
      setState(() {
        errMessage=e.message;
      });
    }
  }
  @override
  Widget build(BuildContext context) {


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: screenHeight * .10,
              ),
              Image.asset(
                'assets/image1.png',
                height: screenHeight * 0.35,
              ),
              SizedBox(height: screenHeight * .04),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 10, color: Color(0xFFA8A7A7).withOpacity(.5)),
                  hintText: " Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 10, color: Color(0xFFA8A7A7).withOpacity(.5)),
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: TextButton(

                  onPressed: () {
                    // Navigate to password recovery page
                  },
                  child: Text('Forgot password?'),
                  style:
                      TextButton.styleFrom(foregroundColor: Color(0xFF1EA6D6)),
                ),
              ),
              SizedBox(height: screenHeight * .015),

                SizedBox(
                  width: screenWidth * .7,
                  child: FloatingActionButton(

                    onPressed: () {

                      isLogin ? signInWithEmailAndPassword() : createUserWithEmailAndPassword();
                    },
                    backgroundColor: Color(0xFF0793C5),
                    child: Text(isLogin? 'Login': 'Register'),
                  ),
                ),

              SizedBox(height: screenHeight * .005),
              SizedBox(
                width: screenWidth * .7,
                child: TextButton(

                  onPressed: () {

                   setState(() {
                     isLogin=!isLogin;
                   });
                  },
                  child: Text(isLogin? 'Register Instead': 'Login Instead'),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );

                },
                child: Text('Sign up'),
                style: TextButton.styleFrom(
                  foregroundColor: Color(0xFF1EA6D6),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
