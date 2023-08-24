import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool? _isLoading;
  final _formKey = GlobalKey<FormState>();
  AuthController authController = AuthController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
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
                  Container(
                    color: AppColors.whiteColor,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          value!.isValidEmail() ? null : "Enter a valid email",
                      decoration: InputDecoration(
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
                  ),
                  const SizedBox(height: 36),
                  (_isLoading == true)
                      ? const ColorLoader()
                      : CustomButton(
                          text: "Reset Password",
                          bgColor: AppColors.primaryButtonColor,
                          textColor: AppColors.whiteColor,
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              await authController.resetUserPassword(
                                context: context,
                                email: emailController.text.trim(),
                              );

                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
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
