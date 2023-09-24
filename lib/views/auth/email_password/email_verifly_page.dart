import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/views/auth/user_info_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({
    super.key,
  });

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    sendEmail();
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => checkEmailVerification(),
    );
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void sendEmail() {
    try {
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
    } on FirebaseException catch (e) {
      showCustomDialog(
        context: context,
        title: "Authentication Error",
        message: e.message!,
      );
    }
  }

  Future<void> checkEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.reload();
    bool isEmailVerified = false;
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return UserInfoPage(user: FirebaseAuth.instance.currentUser!);
        }),
        (route) => false,
      );

      timer!.cancel();
    }
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
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
          child: Column(
            children: [
              Text(
                'Check your Email',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'We have sent you a Email on  ${FirebaseAuth.instance.currentUser!.email}',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              const Center(child: ColorLoader()),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Verifying email....',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryTextColor,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: "Resend",
                bgColor: AppColors.primaryButtonColor,
                textColor: AppColors.whiteColor,
                onPress: () {
                  sendEmail();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
