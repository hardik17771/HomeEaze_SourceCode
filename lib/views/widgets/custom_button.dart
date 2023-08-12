import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onPress;
  const CustomButton({
    super.key,
    required this.text,
    required this.bgColor,
    required this.textColor,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 51,
        width: size.width,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.whiteColor,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.primaryBoxShadowColor,
              offset: Offset(4.0, 4.0),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: AppColors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
