import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';

class LaundaryCard extends StatefulWidget {
  String pickupSlot;
  final double userLatitude;
  final double userLongitude;
  final VendorModel vendor;
  final double orderAmount;
  LaundaryCard({
    super.key,
    required this.pickupSlot,
    required this.vendor,
    required this.userLatitude,
    required this.userLongitude,
    required this.orderAmount,
  });

  @override
  State<LaundaryCard> createState() => _LaundaryCardState();
}

class _LaundaryCardState extends State<LaundaryCard> {
  int selectedPickUpIndex = -1;
  List<String> pickUpOptions = [
    "In 12 hours",
    "In 24 hours",
    "In 48 hours",
  ];

  @override
  Widget build(BuildContext context) {
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.vendor.outletName,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.vendor.manualAddress,
                      style: GoogleFonts.poppins(
                        color: AppColors.secondaryTextColor,
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
                      child: AppAssets.locationPinPointIcon,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "${Geolocator.distanceBetween(
                        widget.userLatitude,
                        widget.userLongitude,
                        widget.vendor.outletLatitude,
                        widget.vendor.outletLongitude,
                      ).toStringAsFixed(3)} kms",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.pickupSlot = pickUpOptions[0];
                    selectedPickUpIndex = 0;
                  });
                },
                child: Container(
                  height: 25,
                  width: 85,
                  decoration: BoxDecoration(
                    color: (selectedPickUpIndex != 0)
                        ? AppColors.primaryButtonColor
                        : AppColors.secondaryButtonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      pickUpOptions[0],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.pickupSlot = pickUpOptions[1];
                    selectedPickUpIndex = 1;
                  });
                },
                child: Container(
                  height: 25,
                  width: 85,
                  decoration: BoxDecoration(
                    color: (selectedPickUpIndex != 1)
                        ? AppColors.primaryButtonColor
                        : AppColors.secondaryButtonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      pickUpOptions[1],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    widget.pickupSlot = pickUpOptions[2];
                    selectedPickUpIndex = 2;
                  });
                },
                child: Container(
                  height: 25,
                  width: 85,
                  decoration: BoxDecoration(
                    color: (selectedPickUpIndex != 2)
                        ? AppColors.primaryButtonColor
                        : AppColors.secondaryButtonColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      pickUpOptions[2],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
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
                        widget.vendor.outletRating.toString(),
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
                  "Grand Total    ₹ ${widget.orderAmount}",
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
