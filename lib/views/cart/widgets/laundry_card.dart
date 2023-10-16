import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/Models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/cart/widgets/pickup_time_card.dart';

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
    final List<String> pickUpOptions = ["8-9 AM", "2-3 PM", "6-7 PM"];
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
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
                        vendor.manualAddress,
                        style: GoogleFonts.poppins(
                          color: AppColors.secondaryTextColor,
                          fontSize: 7,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 15,
                      height: 15,
                      child: AppAssets.locationPinPointIcon,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${(Geolocator.distanceBetween(
                            userLatitude,
                            userLongitude,
                            vendor.outletLatitude,
                            vendor.outletLongitude,
                          ) / 1000).toStringAsFixed(2)} kms",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: AppColors.secondaryTextColor,
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
              "Available pickup slots:",
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                color: const Color(0xFFC4C4C4),
                fontStyle: FontStyle.italic,
                fontSize: 8,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PickUpTimeCard(
                text: pickUpOptions[0],
                bgColor: AppColors.primaryButtonColor,
              ),
              PickUpTimeCard(
                text: pickUpOptions[1],
                bgColor: AppColors.primaryButtonColor,
              ),
              PickUpTimeCard(
                text: pickUpOptions[2],
                bgColor: AppColors.primaryButtonColor,
              ),
            ],
          ),
          const Divider(thickness: 1),
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 14,
                  color: AppColors.primaryContainerColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        vendor.outletRating.toString(),
                        style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Icon(
                        Icons.star,
                        size: 10,
                        color: AppColors.primaryButtonColor,
                      )
                    ],
                  ),
                ),
                Text(
                  "Grand Total    ₹ $orderAmount",
                  style: GoogleFonts.poppins(
                    color: AppColors.secondaryTextColor,
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
