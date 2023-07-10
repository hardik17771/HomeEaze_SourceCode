import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Models/auth.dart';
import '../../Widgets/button.dart';
import 'LoginPage.dart';


class ServicePage extends StatefulWidget {
   ServicePage({super.key} );

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final User? user= Auth().currentUser;
  Future<void> signOut() async
  {
    await Auth().signOut();
  }
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
            "How can we serve you today?",
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Buttons("Wash + Iron"),
              Buttons("Wash Only"),
              Buttons("Iron"),
              Buttons("Dry Clean"),
              Buttons("Stitch"),
              TextButton(onPressed:()
                {
                  signOut;
                  Navigator.push(context,MaterialPageRoute(builder: (context)=> LoginPage())
                  );
                },
               child: Text('Sign Out'),)
               ],
          ),
        ));
  }
}
