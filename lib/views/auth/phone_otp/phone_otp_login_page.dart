import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/views/auth/phone_otp/phone_otp_verifly_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

import '../../../core/animations/color_loader.dart';

class PhoneOTPLoginPage extends StatefulWidget {
  const PhoneOTPLoginPage({super.key});

  @override
  State<PhoneOTPLoginPage> createState() => _PhoneOTPLoginPageState();
}

class _PhoneOTPLoginPageState extends State<PhoneOTPLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();

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
                  'Enter your mobile number to get OTP',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _phoneNumberController,
                  validator: (value) {
                    if (value == null || value.length != 10) {
                      return 'Enter a valid mobile number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefix: const Text("+91 "),
                    filled: true,
                    fillColor: AppColors.whiteColor,
                    errorStyle: GoogleFonts.poppins(fontSize: 10),
                    labelText: 'Mobile Number *',
                    labelStyle: GoogleFonts.poppins(
                      color: AppColors.primaryTextColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primaryBorderColor,
                        width: 10,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
                const SizedBox(height: 36),
                CustomButton(
                  text: "Get OTP",
                  bgColor: AppColors.primaryButtonColor,
                  textColor: AppColors.whiteColor,
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return PhoneOTPVeriflyPage(
                              phoneNumber: _phoneNumberController.text.trim(),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
