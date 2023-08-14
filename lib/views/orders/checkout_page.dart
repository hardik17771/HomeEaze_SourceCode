import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/controllers/data_controller.dart';
import 'package:homeeaze_sourcecode/core/animations.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';
import 'package:homeeaze_sourcecode/views/orders/payment_page.dart';

class CheckOutPage extends StatefulWidget {
  final VendorModel vendorModel;
  final List<Service> cartServices;
  final List<Map<String, dynamic>> outletServiceMenu;
  const CheckOutPage({
    super.key,
    required this.vendorModel,
    required this.cartServices,
    required this.outletServiceMenu,
  });

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final AuthController _authController = AuthController();
  final DataController _dataController = DataController();

  @override
  Widget build(BuildContext context) {
    double _subTotalAmount = 0;
    int _itemCount = 0;
    setState(() {
      _subTotalAmount = _dataController.getTotalOrderAmount(
        cartServices: widget.cartServices,
        outletServiceMenu: widget.outletServiceMenu,
      );
      for (int i = 0; i < widget.cartServices.length; i++) {
        _itemCount += widget.cartServices[i].selectedItems.length;
      }
    });

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 90,
          backgroundColor: AppColors.primaryButtonColor,
          title: Text(
            widget.vendorModel.outletName,
            style: GoogleFonts.poppins(
              fontSize: 18,
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
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.alarm,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Pickup in 60 Minutes",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
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
                  "ITEM(S) ADDED",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                width: size.width,
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    const Divider(thickness: 1.5),
                    Padding(
                      padding: const EdgeInsets.only(right: 32),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: widget.cartServices.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> outletItem =
                              widget.outletServiceMenu[index];
                          Service currentService = widget.cartServices[index];
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: currentService.selectedItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              Item currentItem =
                                  currentService.selectedItems[index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 4),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              left: 8,
                                              right: 16,
                                              top: 16,
                                              bottom: 16),
                                          width: 22,
                                          height: 22,
                                          child: AppAssets.tShirtIcon,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              currentService.name,
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              currentItem.name,
                                              textAlign: TextAlign.start,
                                              style: GoogleFonts.poppins(
                                                color: AppColors
                                                    .secondaryTextColor,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  child: const Icon(
                                                      Icons.remove,
                                                      size: 15,
                                                      color: AppColors
                                                          .primaryButtonColor),
                                                  onTap: () {
                                                    setState(() {
                                                      if (currentItem.quantity >
                                                          0) {
                                                        currentItem.quantity--;
                                                        if (currentItem
                                                                .quantity ==
                                                            0) {
                                                          currentService
                                                              .selectedItems
                                                              .remove(
                                                                  currentItem);
                                                        }
                                                      }
                                                    });
                                                  },
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  child: Text(
                                                    currentItem.quantity
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                      color: AppColors
                                                          .primaryButtonColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 15,
                                                    color: AppColors
                                                        .primaryButtonColor,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      currentItem.quantity++;
                                                      if (!currentService
                                                          .selectedItems
                                                          .contains(
                                                              currentItem)) {
                                                        currentService
                                                            .selectedItems
                                                            .add(currentItem);
                                                      }
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "₹ ${(currentItem.quantity) * outletItem[currentItem.name]}",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
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
              ),
              Container(
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                padding: const EdgeInsets.only(
                    top: 8, left: 16, right: 40, bottom: 8),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.add_circle_outlined,
                          color: AppColors.primaryContainerColor,
                          size: 24,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Add More Items",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      iconSize: 20,
                      color: AppColors.blackColor,
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) {
                            return const HomePage(currIndex: 0);
                          }),
                          (route) => false,
                        );
                      },
                    )
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
                          _subTotalAmount.toString(),
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
                          "₹ ${_subTotalAmount + 60}",
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
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
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
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ColorLoader();
                    } else if (snapshot.hasData) {
                      UserModel? userModel = snapshot.data;
                      return Container(
                        margin: const EdgeInsets.only(left: 36),
                        child: Text(
                          userModel!.userAddress,
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
                            // Payment Page
                            if (_itemCount != 0) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PaymentPage(
                                      cartServices: widget.cartServices,
                                      outletServiceMenu:
                                          widget.outletServiceMenu,
                                      vendorModel: widget.vendorModel,
                                      totalAmount: _subTotalAmount,
                                      itemCount: _itemCount,
                                    );
                                  },
                                ),
                              );
                            } else {
                              showSnackBar(
                                context: context,
                                text: "Select some items",
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
