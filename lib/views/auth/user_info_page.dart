import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/views/auth/location_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

class UserInfoPage extends StatefulWidget {
  final User user;
  const UserInfoPage({
    super.key,
    required this.user,
  });

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    mobileNumberController.dispose();
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
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Almost Done!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackColor,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Enter the details below to create an account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      errorStyle: GoogleFonts.poppins(fontSize: 10),
                      labelText: 'Name *',
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
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: mobileNumberController,
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length != 10) {
                        return 'Enter a valid Mobile Number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
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
                  const SizedBox(height: 24),
                  CustomButton(
                    text: "Next",
                    bgColor: AppColors.primaryButtonColor,
                    textColor: AppColors.whiteColor,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return LocationPage(
                                user: widget.user,
                                username: nameController.text.trim(),
                                mobileNumber:
                                    mobileNumberController.text.trim(),
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
      ),
    );
  }
}
