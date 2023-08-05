import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/views/auth/login_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
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
    authController.signUpUser(
      context: context,
      email: email,
      password: password,
    );
  }

  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFF0793C5);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: screenWidth,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 90),
                Text(
                  "Droby",
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFA8A7A7).withOpacity(0.7),
                    ),
                    hintText: "   Enter your email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Password of atleast 6 characters is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFFA8A7A7).withOpacity(0.7),
                    ),
                    hintText: '   Enter Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                const SizedBox(height: 36),
                CustomButton(
                  text: "Sign Up",
                  bgColor: buttonColor,
                  textColor: Colors.white,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigate to HomePage & Save Data to Firebase
                      signUpUser(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
