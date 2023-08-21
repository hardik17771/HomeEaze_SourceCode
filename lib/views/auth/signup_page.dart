import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/animations.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/views/auth/email_verifly_page.dart';
import 'package:homeeaze_sourcecode/views/auth/login_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool? _isLoading;
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = AuthController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 48),
                  Text(
                    "Droby",
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 64),
                  Container(
                    color: AppColors.whiteColor,
                    child: TextFormField(
                      controller: emailController,
                      validator: (value) => value!.isValidEmail()
                          ? null
                          : "Please enter a valid email",
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        errorStyle: GoogleFonts.poppins(fontSize: 10),
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryTextColor,
                        ),
                        labelText: "Enter your email *",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        contentPadding: const EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    color: AppColors.whiteColor,
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
                        errorStyle: GoogleFonts.poppins(fontSize: 10),
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryTextColor,
                        ),
                        labelText: 'Enter Password *',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        contentPadding: const EdgeInsets.all(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  (_isLoading == true)
                      ? const ColorLoader()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomButton(
                              text: "Sign Up",
                              bgColor: AppColors.primaryButtonColor,
                              textColor: AppColors.whiteColor,
                              onPress: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  User? user = await authController.signUpUser(
                                    context: context,
                                    email: emailController.text.trim(),
                                    password: passController.text.trim(),
                                  );

                                  if (user != null) {
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (context) {
                                        return const EmailVerificationPage();
                                      }),
                                      (route) => false,
                                    );
                                  }

                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const LoginPage();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "Login Instead",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                          ],
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
