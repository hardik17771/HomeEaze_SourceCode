import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';

class ServiceCard extends StatelessWidget {
  final int itemCount;
  final Image serviceImage;
  final String serviceName;
  const ServiceCard({
    super.key,
    required this.serviceImage,
    required this.itemCount,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 170,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 90, width: 90, child: serviceImage),
          Text(
            serviceName,
            style: GoogleFonts.poppins(
              color: AppColors.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          if (itemCount != 0)
            Container(
              height: 28,
              width: 150,
              decoration: const BoxDecoration(
                color: AppColors.primaryButtonColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  "$itemCount Items",
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
