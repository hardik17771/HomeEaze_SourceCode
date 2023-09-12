import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/controllers/orders_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/orders/upi_payment_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/bottom_bar_button.dart';

class PaymentPage extends StatefulWidget {
  final List<Service> cartServices;
  final List<Map<String, dynamic>> outletServiceMenu;
  final VendorModel vendorModel;
  final double totalAmount;
  final int itemCount;
  final String pickUpTimeSlot;
  const PaymentPage({
    super.key,
    required this.cartServices,
    required this.outletServiceMenu,
    required this.vendorModel,
    required this.totalAmount,
    required this.itemCount,
    required this.pickUpTimeSlot,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool? _isLoading;
  UserModel? _userModel;
  String? _selectedPaymentMode;
  final AuthController _authController = AuthController();
  final OrdersController _ordersController = OrdersController();
  final List<String> paymentMode = [
    "Pay on Delivery",
    "UPI Payment",
  ];

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

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
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: paymentMode.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Radio(
                      value: paymentMode[index],
                      groupValue: _selectedPaymentMode,
                      activeColor: AppColors.primaryButtonColor,
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMode = value;
                        });
                      },
                    ),
                    Text(
                      paymentMode[index],
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                      color: AppColors.secondaryTextColor,
                    ),
                  ],
                );
              },
            ),
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
              padding:
                  const EdgeInsets.only(left: 12, right: 24, top: 8, bottom: 8),
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
        child: (_isLoading == true)
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
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const BottomBarButton(
                              text: "Cancel",
                              textColor: AppColors.whiteColor,
                              bgColor: AppColors.secondaryButtonColor,
                              borderRadius: 10,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (_userModel != null &&
                                  _selectedPaymentMode != null) {
                                setState(() {
                                  _isLoading = true;
                                });

                                if (_selectedPaymentMode == paymentMode[0]) {
                                  // Transaction Model for Pay on Delivery
                                  TransactionDetailModel
                                      transactionDetailModel =
                                      TransactionDetailModel(
                                    transactionId: "not-applied",
                                    responseCode: "pending",
                                    approvalRefNo: "not-applied",
                                    transactionRefId: "not-applied",
                                    amount:
                                        (widget.totalAmount + 60).toString(),
                                  );

                                  await _ordersController.placeOrder(
                                    pickUpTimeSlot: widget.pickUpTimeSlot,
                                    context: context,
                                    paymentMode: "Pay on Delivery",
                                    userModel: _userModel!,
                                    vendorModel: widget.vendorModel,
                                    cartServices: widget.cartServices,
                                    outletServiceMenu: widget.outletServiceMenu,
                                    itemCount: widget.itemCount,
                                    transactionDetailModel:
                                        transactionDetailModel,
                                  );
                                } else {
                                  // Navigate to UPI Payment Page
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UpiPaymentPage(
                                          pickUpTimeSlot: widget.pickUpTimeSlot,
                                          itemCount: widget.itemCount,
                                          orderAmount: widget.totalAmount + 60,
                                          userModel: _userModel!,
                                          vendorModel: widget.vendorModel,
                                          cartServices: widget.cartServices,
                                          outletServiceMenu:
                                              widget.outletServiceMenu,
                                        );
                                      },
                                    ),
                                  );
                                }

                                setState(() {
                                  _isLoading = false;
                                });
                              } else {
                                showCustomDialog(
                                  context: context,
                                  title: "Payment mode not selected",
                                  message:
                                      "Choose a payment mode from Payment Options to procced",
                                );
                              }
                            },
                            child: const BottomBarButton(
                              text: "Proceed   >",
                              textColor: AppColors.whiteColor,
                              bgColor: AppColors.primaryButtonColor,
                              borderRadius: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
