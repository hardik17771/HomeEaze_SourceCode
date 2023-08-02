import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateTimeCard extends StatelessWidget {
  final String text;
  const DateTimeCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFF0793C5);
    return Container(
      height: 25,
      width: 85,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
