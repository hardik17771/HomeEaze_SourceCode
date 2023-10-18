import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickUpTimeCard extends StatelessWidget {
  final String text;
  final Color bgColor;
  const PickUpTimeCard({
    super.key,
    required this.text,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 85,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
