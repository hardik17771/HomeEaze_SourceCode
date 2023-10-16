import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/data_controller.dart';
import 'package:homeeaze_sourcecode/controllers/orders_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/Models/order_model.dart';
import 'package:homeeaze_sourcecode/Models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/orders/order_details_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/no_orders_widget.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatefulWidget {
  final OrderModel orderModel;
  const OrderCard({
    super.key,
    required this.orderModel,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  final DataController _dataController = DataController();
  final OrdersController _ordersController = OrdersController();

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
      child: StreamBuilder(
        stream: _dataController.getVendorData(
            vendorUid: widget.orderModel.vendorUid),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ColorLoader();
          } else if (snapshot.hasData) {
            VendorModel vendorModel = snapshot.data!;
            debugPrint("has VendorData");
            return FutureBuilder(
              future: _ordersController.fetchOrderSummary(
                  orderId: widget.orderModel.orderId),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ColorLoader();
                } else if (snapshot.hasData) {
                  debugPrint("has Order Summary");
                  List<Map<String, dynamic>> orderServices = snapshot.data;
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return OrderDetailsPage(
                            orderModel: widget.orderModel,
                            vendorModel: vendorModel,
                            orderServices: orderServices,
                          );
                        }),
                      );
                    },
                    child: myOrderCard(
                      size: size,
                      orderModel: widget.orderModel,
                      vendorModel: vendorModel,
                      orderServices: orderServices,
                    ),
                  );
                } else {
                  return const NoOrdersWidget();
                }
              },
            );
          } else {
            return const NoOrdersWidget();
          }
        },
      ),
    );
  }

  Widget myOrderCard({
    required Size size,
    required OrderModel orderModel,
    required VendorModel vendorModel,
    required List<Map<String, dynamic>> orderServices,
  }) {
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vendorModel.outletName,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      vendorModel.manualAddress,
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
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Status : ${widget.orderModel.orderStatus}",
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    Text(
                      "Pick up slot : ${widget.orderModel.pickUpTimeSlot}",
                      style: GoogleFonts.poppins(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                  ],
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
                "View Details  >",
                style: GoogleFonts.poppins(
                  color: AppColors.tertiaryTextColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
