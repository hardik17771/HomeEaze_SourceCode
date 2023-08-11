import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/widgets/datetime_card.dart';

class LaundaryCard extends StatelessWidget {
  final double userLatitude;
  final double userLongitude;
  final VendorModel vendor;
  final double orderAmount;
  const LaundaryCard({
    super.key,
    required this.vendor,
    required this.userLatitude,
    required this.userLongitude,
    required this.orderAmount,
  });

  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFF0793C5);
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 124,
      width: screenWidth,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // boxShadow: const [
        //   BoxShadow(
        //     color: Color(0xFFD0D2D5),
        //     offset: Offset(4.0, 4.0),
        //     blurRadius: 4.0,
        //   ),
        // ],
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vendor.outletName,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      vendor.outletAddress,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF767272),
                        fontSize: 7,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 15,
                      height: 15,
                      child:
                          SvgPicture.asset("assets/icons/point_pin_icon.svg"),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${Geolocator.distanceBetween(
                        userLatitude,
                        userLongitude,
                        vendor.outletLatitude,
                        vendor.outletLongitude,
                      ).toStringAsFixed(3)} kms",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF767272),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 20, top: 4, bottom: 4),
            child: Text(
              "Choose a pickup slot convenient for you:",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                color: const Color(0xFFC4C4C4),
                fontStyle: FontStyle.italic,
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DateTimeCard(text: "In 60 mins."),
              DateTimeCard(text: "In 2 hrs."),
              DateTimeCard(text: "In 4 hrs."),
            ],
          ),
          const Divider(thickness: 1),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 14,
                  color: const Color(0xFFD9D9D9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        vendor.outletRating.toString(),
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        size: 10,
                        color: buttonColor,
                      )
                    ],
                  ),
                ),
                Text(
                  "Grand Total    ₹ $orderAmount",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF767272),
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
