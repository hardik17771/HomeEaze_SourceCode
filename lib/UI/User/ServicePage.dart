import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Models/auth.dart';
import '../../Models/cart_model.dart';
import '../../Widgets/button.dart';
import 'AddItemPage.dart';
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
        body: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            final totalSelectedItems = service.selectedItems.length;
            return Container(
              margin:
              EdgeInsets.only(top: screenHeight * .04, left: screenWidth * .025),
              width: screenWidth * .95,
              height: screenHeight * .12,
              child: GestureDetector(

                child: FloatingActionButton(
                  onPressed: () async {
                    final updatedService = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddItem(service: service),
                      ),
                    );
                    if (updatedService != null) {
                      setState(() {
                        service.selectedItems = updatedService.selectedItems;
                      });
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        service.name,
                        style: GoogleFonts.poppins(
                          color: Color(0xFFFFFFFF), // Update text color based on tap state
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                          'Selected Item Types: $totalSelectedItems',
                        style: GoogleFonts.poppins(
                          color: Color(0xFFFFFFFF), // Update text color based on tap state
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  backgroundColor: Color(0xFF0793C5), // Update background color based on tap state
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            );
          },
        ),);
  }
}
