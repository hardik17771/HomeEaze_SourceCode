import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/button.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key} );

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: screenHeight * .1,
          backgroundColor: Color(0xFF0793C5),
          actions: [
            Image.asset(
              'assets/noImage.png',
            ),
          ],
          title: Text(
            "How can we surve you today?",
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            Buttons("Wash + Iron"),
            Buttons("Wash Only"),
            Buttons("Iron"),
            Buttons("Dry Clean"),
            Buttons("Stitch"),
          ],
        ));
  }
}
