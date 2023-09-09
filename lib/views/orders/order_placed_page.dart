import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/bottom_bar_button.dart';

class OrderPlacedPage extends StatelessWidget {
  const OrderPlacedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondaryBackgroundColor,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: size.height * 0.15),
            SizedBox(
              height: 120,
              width: 120,
              child: AppAssets.orderPlacedCheckFillImage,
            ),
            const SizedBox(height: 8),
            Text(
              "Order placed",
              style: GoogleFonts.poppins(
                fontSize: 24,
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Your order has been received and will be picked up soon.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.15),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePage(currIndex: 0); // Service Page
                          },
                        ),
                        (route) => false,
                      );
                    },
                    child: const BottomBarButton(
                      text: "Close",
                      textColor: AppColors.tertiaryTextColor,
                      bgColor: AppColors.whiteColor,
                      borderRadius: 10,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) {
                            return const HomePage(
                                currIndex: 2); // All Orders Page
                          },
                        ),
                        (route) => false,
                      );
                    },
                    child: const BottomBarButton(
                      text: "Order Details",
                      textColor: AppColors.tertiaryTextColor,
                      bgColor: AppColors.whiteColor,
                      borderRadius: 10,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
