import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    const textColor = Color(0xFFA8A7A7);
    const buttonColor = Color(0xFF0793C5);
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.only(left: 8, right: 8, top: 48),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Almost Done!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Enter the details below to create an account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please a your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name *',
                        labelStyle: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textColor,
                            width: 10,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    color: Colors.white,
                    child: TextFormField(
                      controller: mobileNumberController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 10) {
                          return 'Please enter a valid Mobile Number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Mobile Number *',
                        labelStyle: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: textColor,
                            width: 10,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        contentPadding: const EdgeInsets.all(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: "Next",
                    bgColor: buttonColor,
                    textColor: Colors.white,
                    onPress: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return LocationPage(
                              user: widget.user,
                              username: nameController.text.trim(),
                              mobileNumber: mobileNumberController.text.trim(),
                            );
                          }),
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
