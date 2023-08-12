import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import '../../core/colors.dart';

class NoOrdersWidget extends StatelessWidget {
  const NoOrdersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Place some orders!',
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                color: AppColors.secondaryTextColor,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              child: AppAssets.noOrdersImage,
            )
          ],
        ),
      ),
    );
  }
}
