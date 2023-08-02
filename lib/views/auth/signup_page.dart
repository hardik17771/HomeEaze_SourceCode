import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/views/auth/login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthController authController = AuthController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    if (email.isEmpty || password.isEmpty) {
      showSnackBar(
        context: context,
        text: "Please fill all the Values",
      );
    } else if (password.length < 6) {
      showSnackBar(
        context: context,
        text: "Password of atleast 6 characters is required",
      );
    } else {
      authController.signUpUser(
        context: context,
        email: email,
        password: password,
      );
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: screenHeight * .10,
              ),
              // Image.asset(
              //   'assets/image1.png',
              //   height: screenHeight * 0.35,
              // ),
              Text(
                "Drobease",
                style: GoogleFonts.poppins(
                  fontSize: 36,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * .04),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 10,
                    color: const Color(0xFFA8A7A7).withOpacity(.5),
                  ),
                  hintText: "   Enter your email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              TextField(
                controller: passController,
                obscureText: true,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 10,
                    color: const Color(0xFFA8A7A7).withOpacity(.5),
                  ),
                  hintText: '   Enter Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .015),
              Container(
                width: screenWidth * 0.70,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    signUpUser(
                      context: context,
                      email: emailController.text.trim(),
                      password: passController.text.trim(),
                    );
                  },
                  label: const Text('Sign Up'),
                  backgroundColor: const Color(0xFF0793C5),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.7,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      }),
                    );
                  },
                  child: Text(
                    "Login Instead",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
