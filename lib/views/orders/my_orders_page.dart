import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/controllers/orders_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/models/order_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/widgets/no_orders_widget.dart';
import 'package:homeeaze_sourcecode/views/orders/widgets/order_card.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final AuthController _authController = AuthController();
  final OrdersController _ordersController = OrdersController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 90,
          backgroundColor: AppColors.primaryButtonColor,
          title: Text(
            "My Orders",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: StreamBuilder<List<OrderModel>>(
          stream: _ordersController.fetchUserOrdersData(
              userUid: _authController.currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<List<OrderModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const NoOrdersWidget();
            } else if (snapshot.hasData) {
              debugPrint("has Orders");
              return (snapshot.data!.isNotEmpty)
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        OrderModel orderModel = snapshot.data![index];
                        return StreamBuilder(
                          stream: _ordersController.getVendorData(
                              vendorUid: orderModel.vendorUid),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const ColorLoader();
                            } else if (snapshot.hasData) {
                              VendorModel vendorModel = snapshot.data!;
                              debugPrint("has VendorData");
                              return FutureBuilder(
                                future: _ordersController.fetchOrderSummary(
                                    orderId: orderModel.orderId),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const ColorLoader();
                                  } else if (snapshot.hasData) {
                                    debugPrint("has Order Summary");
                                    List<Map<String, dynamic>> orderServices =
                                        snapshot.data;
                                    return OrderCard(
                                      orderModel: orderModel,
                                      vendorModel: vendorModel,
                                      orderServices: orderServices,
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
                        );
                      },
                    )
                  : const NoOrdersWidget();
            } else {
              return const NoOrdersWidget();
            }
          },
        ),
      ),
    );
  }
}
