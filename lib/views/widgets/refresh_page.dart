import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';

class RefreshPage extends StatelessWidget {
  const RefreshPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryButtonColor,
      body: Center(
        child: Text(
          "Droby",
          style: GoogleFonts.poppins(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w700,
            fontSize: 48,
          ),
        ),
      ),
    );
  }
}
