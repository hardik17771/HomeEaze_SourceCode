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
  final _formKey = GlobalKey<FormState>();
  TextEditingController upiController = TextEditingController();
  final OrdersController _orderController = OrdersController();

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  void dispose() {
    upiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 90,
          backgroundColor: AppColors.primaryButtonColor,
          title: Text(
            "UPI Payment",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: upiController,
                    validator: (value) {
                      if (value == null) {
                        return 'Enter a valid upi';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.whiteColor,
                      errorStyle: GoogleFonts.poppins(fontSize: 10),
                      labelStyle: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryTextColor,
                      ),
                      labelText: "Enter your upi *",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      contentPadding: const EdgeInsets.all(20.0),
                    ),
                  ),
                  const SizedBox(height: 36),
                  (_isLoading == true)
                      ? const ColorLoader()
                      : CustomButton(
                          text: "Pay Now",
                          bgColor: AppColors.primaryButtonColor,
                          textColor: AppColors.whiteColor,
                          onPress: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              TransactionDetailModel? transactionDetailModel =
                                  await _orderController.makeUPIPayment(
                                context: context,
                                amount: widget.orderAmount,
                                payeeVpa: upiController.text.trim(),
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
                                  transactionDetailModel:
                                      transactionDetailModel,
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
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
