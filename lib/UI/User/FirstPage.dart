import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 52, 158, 245),
          body: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: screenHeight * .30,
                ),
                child: Text(
                  "Homeaze",
                  style: GoogleFonts.poppins(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w700,
                      fontSize: 65),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: screenHeight * .20,
                ),
                width: screenWidth * .80,
                height: screenHeight * .10,
                child: FloatingActionButton(
                    onPressed: () {},
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.poppins(
                          color: Color(0xFF056D92),
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 17),
                    ),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
            ],
          )),
    );
  }
}
