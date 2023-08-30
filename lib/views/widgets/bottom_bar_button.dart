import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';

class BottomBarButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final double borderRadius;
  const BottomBarButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primaryBorderColor,
            offset: Offset(2.0, 2.0),
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
