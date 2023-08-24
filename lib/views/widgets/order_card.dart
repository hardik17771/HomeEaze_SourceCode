import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/order_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final OrderModel orderModel;
  final VendorModel vendorModel;
  final List<Map<String, dynamic>> orderServices;
  const OrderCard({
    super.key,
    required this.orderModel,
    required this.vendorModel,
    required this.orderServices,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 4, right: 4, top: 4, bottom: 4),
      padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primaryBoxShadowColor,
            offset: Offset(4.0, 4.0),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.vendorModel.outletName,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    widget.vendorModel.manualAddress,
                    style: GoogleFonts.poppins(
                      color: AppColors.secondaryTextColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat().format(widget.orderModel.orderReceivingTime),
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryTextColor,
                      fontSize: 6,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                widget.orderModel.orderStatus,
                style: GoogleFonts.poppins(
                  color: AppColors.secondaryTextColor,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "Rate",
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryButtonColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.star_outlined,
                    size: 14,
                    color: AppColors.primaryButtonColor,
                  ),
                  const Icon(
                    Icons.star_outlined,
                    size: 14,
                    color: AppColors.primaryButtonColor,
                  ),
                  const Icon(
                    Icons.star_outlined,
                    size: 14,
                    color: AppColors.primaryButtonColor,
                  ),
                  const Icon(
                    Icons.star_outlined,
                    size: 14,
                    color: AppColors.primaryButtonColor,
                  ),
                  const Icon(
                    Icons.star_outlined,
                    size: 14,
                    color: AppColors.primaryButtonColor,
                  ),
                ],
              ),
              Text(
                "View Pricings  >",
                style: GoogleFonts.poppins(
                  color: AppColors.tertiaryTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Divider(thickness: 1.5),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 32),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: widget.orderServices.length,
                  itemBuilder: (BuildContext context, int index) {
                    String serviceName = services[index].name;
                    Map<String, dynamic> orderItem =
                        widget.orderServices[index];
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: orderItem.length,
                      itemBuilder: (BuildContext context, int index) {
                        String itemName = orderItem.keys.elementAt(index);
                        int itemQuantity = orderItem[itemName][0];
                        int itemPrice = orderItem[itemName][1];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 8, right: 8, top: 16, bottom: 16),
                                    width: 22,
                                    height: 22,
                                    child: AppAssets.tShirtIcon,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "$itemQuantity * $itemName",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        serviceName,
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.poppins(
                                          color: AppColors.secondaryTextColor,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                "₹ ${itemQuantity * itemPrice}",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          const Divider(thickness: 1.5),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 32),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          width: 16,
                          height: 16,
                          child: AppAssets.deliveryBoyIcon,
                        ),
                        Text(
                          "Delivery Fee",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "₹ 60",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 3),
                          width: 20,
                          height: 20,
                          child: AppAssets.convenienceFeeIcon,
                        ),
                        Text(
                          " Convenience Fee",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "(Free)",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 1.5),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Grand Total",
                  style: GoogleFonts.poppins(
                    color: AppColors.secondaryTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "₹ ${widget.orderModel.orderAmount}",
                  style: GoogleFonts.poppins(
                    color: AppColors.secondaryTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
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
