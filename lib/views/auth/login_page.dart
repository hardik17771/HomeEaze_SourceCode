import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/views/auth/reset_password_page.dart';
import 'package:homeeaze_sourcecode/views/auth/signup_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool? _isLoading;
  bool? _isPasswordHidden;
  final _formKey = GlobalKey<FormState>();
  AuthController authController = AuthController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void initState() {
    _isLoading = false;
    _isPasswordHidden = true;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
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
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryBackgroundColor,
      ),
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
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 64),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.isValidEmail() ? null : "Enter a valid email",
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    errorStyle: GoogleFonts.poppins(fontSize: 10),
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryTextColor,
                    ),
                    labelText: "Enter your Email *",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    contentPadding: const EdgeInsets.all(20.0),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: passController,
                  obscureText: _isPasswordHidden!,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password cannot be less than 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden!;
                        });
                      },
                      child: _isPasswordHidden!
                          ? const Icon(Icons.visibility_rounded,
                              color: AppColors.primaryTextColor)
                          : const Icon(Icons.visibility_off_rounded,
                              color: AppColors.primaryTextColor),
                    ),
                    errorStyle: GoogleFonts.poppins(fontSize: 10),
                    labelStyle: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryTextColor),
                    labelText: 'Enter your Password *',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    contentPadding: const EdgeInsets.all(20.0),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const ResetPasswordPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Forgot password?',
                      style: GoogleFonts.poppins(
                        color: AppColors.tertiaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                (_isLoading == true)
                    ? const ColorLoader()
                    : Column(
                        children: [
                          CustomButton(
                            text: "Login",
                            bgColor: AppColors.primaryButtonColor,
                            textColor: AppColors.whiteColor,
                            onPress: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });

                                await authController.loginUser(
                                  email: emailController.text.trim(),
                                  password: passController.text.trim(),
                                  context: context,
                                );

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
                                    return const SignUpPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "SignUp Instead",
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
    );
  }
}
