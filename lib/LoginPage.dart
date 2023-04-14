import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 10, color: Color(0xFFA8A7A7).withOpacity(.5)),
                  hintText: "   Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 10, color: Color(0xFFA8A7A7).withOpacity(.5)),
                  hintText: '   Enter Password',
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
              Container(
                width: screenWidth * .70,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    // Perform login logic here
                  },
                  label: Text('Login'),
                  backgroundColor: Color(0xFF0793C5),
                ),
              ),
              SizedBox(height: screenHeight * .005),
              TextButton(
                onPressed: () {
                  // Navigate to signup page
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
