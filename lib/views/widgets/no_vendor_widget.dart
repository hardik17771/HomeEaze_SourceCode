import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              'Seeking the best service to meet your needs!',
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                color: const Color(0xFF767272),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              child: Image.asset("assets/checkOut.png"),
            )
          ],
        ),
      ),
    );
  }
}
