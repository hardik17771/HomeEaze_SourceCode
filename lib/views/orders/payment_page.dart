import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/controllers/orders_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';

class PaymentPage extends StatefulWidget {
  final List<Service> cartServices;
  final List<Map<String, dynamic>> outletServiceMenu;
  final VendorModel vendorModel;
  final double totalAmount;
  final int itemCount;
  const PaymentPage({
    super.key,
    required this.cartServices,
    required this.outletServiceMenu,
    required this.vendorModel,
    required this.totalAmount,
    required this.itemCount,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool? isLoading;
  final AuthController _authController = AuthController();
  final OrdersController _ordersController = OrdersController();
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 90,
          backgroundColor: AppColors.primaryButtonColor,
          title: Text(
            "PAYMENT",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                decoration: const BoxDecoration(
                  color: AppColors.primaryContainerColor,
                ),
                child: Text(
                  "PAYMENT OPTIONS",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: size.width,
                margin: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 20,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      "Pay on Delivery",
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // const Divider(thickness: 1.5),
              Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 12, bottom: 12),
                padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
                decoration: const BoxDecoration(
                  color: AppColors.primaryContainerColor,
                ),
                child: Text(
                  "PRICE DETAILS (${widget.itemCount} ITEMS)",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Divider(thickness: 1.5),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 24, top: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Amount",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Delivery Fee",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Convenience Fee",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹ ${widget.totalAmount}",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "₹ 60",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "(Free)",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
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
                padding: const EdgeInsets.only(
                    left: 12, right: 24, top: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Grand Total",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "₹ ${widget.totalAmount + 60}",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1.5),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: (isLoading == true)
              ? SizedBox(
                  width: size.width,
                  height: 120,
                  child: const ColorLoader(),
                )
              : SizedBox(
                  width: size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                width: 18,
                                height: 16,
                                child: AppAssets.deliveryBoyIcon,
                              ),
                              Text(
                                "Pickup at Home",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      StreamBuilder<UserModel>(
                        stream: _authController
                            .getUserData(_authController.currentUser!.uid),
                        builder: (BuildContext context,
                            AsyncSnapshot<UserModel> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const ColorLoader();
                          } else if (snapshot.hasData) {
                            UserModel? userModel = snapshot.data;
                            _userModel = userModel;
                            return Container(
                              margin: const EdgeInsets.only(left: 36),
                              child: Text(
                                userModel!.userManualAddress,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: ColorLoader(),
                            );
                          }
                        },
                      ),
                      const Divider(thickness: 1),
                      Container(
                        color: AppColors.primaryBackgroundColor,
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                  height: 46,
                                  margin: const EdgeInsets.only(
                                      left: 8, right: 8, bottom: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryButtonColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.primaryBoxShadowColor,
                                        offset: Offset(4.0, 4.0),
                                        blurRadius: 4.0,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: GoogleFonts.poppins(
                                        color: AppColors.whiteColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  if (_userModel != null) {
                                    setState(() {
                                      isLoading = true;
                                    });

                                    _ordersController.placeOrder(
                                      context: context,
                                      userModel: _userModel!,
                                      outletServiceMenu:
                                          widget.outletServiceMenu,
                                      vendorModel: widget.vendorModel,
                                      cartServices: widget.cartServices,
                                      itemCount: widget.itemCount,
                                      orderAmount: widget.totalAmount + 60,
                                    );
                                  }
                                },
                                child: Container(
                                  height: 46,
                                  margin: const EdgeInsets.only(
                                      left: 8, right: 8, bottom: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryButtonColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: AppColors.primaryBoxShadowColor,
                                        offset: Offset(4.0, 4.0),
                                        blurRadius: 4.0,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Proceed   >",
                                      style: GoogleFonts.poppins(
                                        color: AppColors.whiteColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
