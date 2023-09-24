import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/views/auth/email_password/signup_page.dart';
import 'package:homeeaze_sourcecode/views/auth/phone_otp/phone_otp_login_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2500,
      splash: Text(
        "Droby",
        style: GoogleFonts.poppins(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w700,
          fontSize: 48,
        ),
      ),
      // nextScreen: const PhoneOTPLoginPage(),
      nextScreen: const SignUpPage(),
      splashTransition: SplashTransition.scaleTransition,
      backgroundColor: AppColors.primaryButtonColor,
    );
  }
}
