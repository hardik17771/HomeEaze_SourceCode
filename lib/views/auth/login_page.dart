import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/views/auth/signup_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
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
    const buttonColor = Color(0xFF0793C5);
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF2F2F2),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 48),
                  Text(
                    "Droby",
                    style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 64),
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isValidEmail()
                          ? null
                          : "Please enter a valid email",
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFA8A7A7),
                        ),
                        hintText: "Enter your email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        // contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: passController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Password cannot be less than 6 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFA8A7A7),
                        ),
                        hintText: 'Enter Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        // contentPadding: const EdgeInsets.all(16.0),
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
                  const SizedBox(height: 12),
                  CustomButton(
                    text: "Login",
                    bgColor: buttonColor,
                    textColor: Colors.white,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        // Navigate to HomePage
                        loginUser(
                          context: context,
                          email: emailController.text.trim(),
                          password: passController.text.trim(),
                        );
                      }
                    },
                  ),
                  TextButton(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
