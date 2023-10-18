import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/views/auth/user_info_page.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';
import 'package:pinput/pinput.dart';

class PhoneOTPVeriflyPage extends StatefulWidget {
  final String phoneNumber;
  const PhoneOTPVeriflyPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<PhoneOTPVeriflyPage> createState() => _PhoneOTPVeriflyPageState();
}

class _PhoneOTPVeriflyPageState extends State<PhoneOTPVeriflyPage> {
  bool? _isLoading;
  String? _verificationCode;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  final AuthController _authController = AuthController();

  @override
  void initState() {
    _verifyPhoneNumber();
    _isLoading = false;
    super.initState();
  }

  _navigateToUserInfoPage(User currentUser) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => UserInfoPage(
          user: currentUser,
        ),
      ),
          (route) => false,
    );
  }

  _navigateToHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomePage(currIndex: 0),
      ),
          (route) => false,
    );
  }

  _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            User? currentUser = value.user;
            debugPrint(currentUser.toString());
            if (currentUser != null) {
              // Check for Vendor Data with same number (Remain)

              bool hasUserData =
              await _authController.checkUserCredentials(currentUser);
              if (hasUserData == true) {
                _navigateToHomePage();
              } else {
                _navigateToUserInfoPage(currentUser);
              }
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint(e.message);
          showCustomDialog(
            context: context,
            title: "Authentication Error",
            message: e.message!,
          );
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 5));
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
        child: Form(
          key: _formKey,
          child: Container(
            width: screenWidth,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Enter the OTP we just sent to +91-${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 24),
                (_isLoading == true)
                    ? const ColorLoader()
                    : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Pinput(
                        length: 6,
                        defaultPinTheme: PinTheme(
                          width: 54,
                          height: 54,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            color: AppColors.tertiaryTextColor,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.primaryBorderColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        controller: _pinController,
                        pinAnimationType: PinAnimationType.fade,
                        onCompleted: (pin) async {
                          setState(() {
                            _isLoading = true;
                          });

                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(
                              PhoneAuthProvider.credential(
                                verificationId: _verificationCode!,
                                smsCode: pin,
                              ),
                            )
                                .then(
                                  (value) async {
                                User? currentUser = value.user;
                                if (currentUser != null) {
                                  // Check for Vendor Data with same number (Remain)
                                  bool hasUserData = await _authController
                                      .checkUserCredentials(currentUser);
                                  if (hasUserData == true) {
                                    _navigateToHomePage();
                                  } else {
                                    _navigateToUserInfoPage(currentUser);
                                  }
                                }
                              },
                            );
                          } on FirebaseException catch (e) {
                            showCustomDialog(
                              context: context,
                              title: "Authentication Error",
                              message: e.message!,
                            );
                          }

                          setState(() {
                            _isLoading = false;
                          });
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        _verifyPhoneNumber();
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      child: Text(
                        "Didn't recieve OTP?\n Resend",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: AppColors.tertiaryTextColor,
                          fontSize: 12,
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