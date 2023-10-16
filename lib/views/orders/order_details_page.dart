import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/orders_controller.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/order_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatefulWidget {
  final OrderModel orderModel;
  final VendorModel vendorModel;
  final List<Map<String, dynamic>> orderServices;
  const OrderDetailsPage({
    super.key,
    required this.orderModel,
    required this.vendorModel,
    required this.orderServices,
  });

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final OrdersController _orderController = OrdersController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: AppColors.primaryButtonColor,
        title: Text(
          "Order Details",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              padding:
                  const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          "${widget.vendorModel.outletName}  |  ${widget.vendorModel.outletMobileNumber}",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          children: [
                            Icon(
                              Icons.star_outlined,
                              size: 14,
                              color: AppColors.primaryButtonColor,
                            ),
                            Icon(
                              Icons.star_outlined,
                              size: 14,
                              color: AppColors.primaryButtonColor,
                            ),
                            Icon(
                              Icons.star_outlined,
                              size: 14,
                              color: AppColors.primaryButtonColor,
                            ),
                            Icon(
                              Icons.star_outlined,
                              size: 14,
                              color: AppColors.primaryButtonColor,
                            ),
                            Icon(
                              Icons.star_outlined,
                              size: 14,
                              color: AppColors.primaryButtonColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          "Order Accepted at ${DateFormat().format(widget.orderModel.orderReceivingTime)}",
                          style: GoogleFonts.poppins(
                            fontSize: 6,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Order Status ${widget.orderModel.orderStatus}",
                          style: GoogleFonts.poppins(
                            fontSize: 6,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (widget.orderModel.orderStatus == "Completed")
                          Text(
                            "Order Delivered at ${DateFormat().format(widget.orderModel.orderDeliveryTime)}",
                            style: GoogleFonts.poppins(
                              fontSize: 6,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primaryTextColor,
                            ),
                          ),
                        if (widget.orderModel.orderStatus == "To be picked up")
                          InkWell(
                            onTap: () async {
                              await _orderController.cancelOrder(
                                  orderId: widget.orderModel.orderId);

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel Order",
                              style: GoogleFonts.poppins(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: AppColors.redColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: const BoxDecoration(
                color: AppColors.primaryContainerColor,
              ),
              child: Text(
                "ITEM(S)",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 16),
                ListView.builder(
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
                        Image itemImage = itemImageMap[itemName];
                        return Container(
                          width: size.width,
                          color: AppColors.whiteColor,
                          padding: const EdgeInsets.only(right: 32),
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
                                    child: itemImage,
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
                const SizedBox(height: 16),
              ],
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              decoration: const BoxDecoration(
                color: AppColors.primaryContainerColor,
              ),
              child: Text(
                "BILL SUMMARY",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              width: size.width,
              padding: const EdgeInsets.only(
                  left: 16, right: 40, top: 16, bottom: 16),
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.whiteColor,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Subtotal",
                        style: GoogleFonts.poppins(
                          color: AppColors.secondaryTextColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "${widget.orderModel.orderAmount - 60}",
                        style: GoogleFonts.poppins(
                          color: AppColors.secondaryTextColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
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
                  const SizedBox(height: 8),
                  const Divider(thickness: 1.5),
                  const SizedBox(height: 4),
                  Row(
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
