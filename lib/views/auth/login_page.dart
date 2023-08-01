import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/views/auth/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errMessage = '';
  bool isLogin = false;
  AuthController authController = AuthController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    authController.loginUser(
      email: email,
      password: password,
      context: context,
    );
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
                height: screenHeight * 0.10,
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
              SizedBox(height: screenHeight * 0.04),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 10,
                    color: const Color(0xFFA8A7A7).withOpacity(.5),
                  ),
                  hintText: " Enter your email",
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
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    // Navigate to password recovery page
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF1EA6D6),
                  ),
                  child: const Text('Forgot password?'),
                ),
              ),
              Container(
                width: screenWidth * 0.70,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    loginUser(
                      context: context,
                      email: emailController.text.trim(),
                      password: passController.text.trim(),
                    );
                  },
                  label: const Text('Login'),
                  backgroundColor: const Color(0xFF0793C5),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.7,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return const SignUpPage();
                      }),
                    );
                  },
                  child: Text(
                    "SignUp Instead",
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
