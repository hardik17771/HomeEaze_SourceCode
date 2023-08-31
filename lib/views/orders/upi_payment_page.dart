import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/orders_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

class UpiPaymentPage extends StatefulWidget {
  final int itemCount;
  final double orderAmount;
  final UserModel userModel;
  final VendorModel vendorModel;
  final List<Service> cartServices;
  final List<Map<String, dynamic>> outletServiceMenu;
  const UpiPaymentPage({
    super.key,
    required this.itemCount,
    required this.orderAmount,
    required this.userModel,
    required this.vendorModel,
    required this.cartServices,
    required this.outletServiceMenu,
  });

  @override
  State<UpiPaymentPage> createState() => _UpiPaymentPageState();
}

class _UpiPaymentPageState extends State<UpiPaymentPage> {
  bool? _isLoading;
  final OrdersController _orderController = OrdersController();

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

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
            "UPI PAYMENT",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: (_isLoading == true)
              ? const ColorLoader()
              : CustomButton(
                  text: "Pay Now",
                  bgColor: AppColors.primaryButtonColor,
                  textColor: AppColors.whiteColor,
                  onPress: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    TransactionDetailModel? transactionDetailModel =
                        await _orderController.makeUPIPayment(
                      context: context,
                      amount: widget.orderAmount,
                    );

                    if (transactionDetailModel != null) {
                      // ignore: use_build_context_synchronously
                      await _orderController.placeOrder(
                        context: context,
                        paymentMode: "UPI Payment",
                        userModel: widget.userModel,
                        vendorModel: widget.vendorModel,
                        cartServices: widget.cartServices,
                        outletServiceMenu: widget.outletServiceMenu,
                        itemCount: widget.itemCount,
                        transactionDetailModel: transactionDetailModel,
                      );
                    } else {
                      // ignore: use_build_context_synchronously
                      showCustomDialog(
                        context: context,
                        title: "Payment Error",
                        message: "Payment not completed try again",
                      );
                    }

                    setState(() {
                      _isLoading = false;
                    });
                  },
                ),
        ),
      ),
    );
  }
}
