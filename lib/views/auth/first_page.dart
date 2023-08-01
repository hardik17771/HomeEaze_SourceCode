import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/views/auth/signup_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF0793C5),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: screenHeight * .25,
            ),
            child: Text(
              "Drobease",
              style: GoogleFonts.poppins(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 65,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: screenHeight * .36,
            ),
            width: screenWidth * .80,
            height: screenHeight * .10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return const SignUpPage();
                  }),
                  (route) => false,
                );
              },
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Get Started",
                style: GoogleFonts.poppins(
                  color: const Color(0xFF056D92),
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
