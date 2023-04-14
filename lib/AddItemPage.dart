import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/button.dart';
import 'package:homeeaze_sourcecode/AddItemPage.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0793C5),
          title: Text("Pick your item",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w500)),
        ),
        body: Column(
          children: [
            AddButton("SHIRT", screenWidth, screenHeight),
            AddButton("T-SHIRT", screenWidth, screenHeight),
            AddButton("TROUSERS", screenWidth, screenHeight),
            AddButton("BLAZER", screenWidth, screenHeight),
            AddButton("WOMEN SUIT", screenWidth, screenHeight),
            AddButton("SAREE", screenWidth, screenHeight),
            AddButton("CURTAINS", screenWidth, screenHeight),
            AddButton("BEDSHEETS", screenWidth, screenHeight),
            AddButton("CARPET", screenWidth, screenHeight),
          ],
        ));
  }
}
