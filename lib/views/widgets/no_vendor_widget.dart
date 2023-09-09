import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';

class NoVendorWidget extends StatelessWidget {
  const NoVendorWidget({super.key});

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
              'Sorry, we don\'t deliver at your location yet. We\'ll be there soon - hang tight!',
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                color: AppColors.secondaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              child: AppAssets.noVendorImage,
            )
          ],
        ),
      ),
    );
  }
}
