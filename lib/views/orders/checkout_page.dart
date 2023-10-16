import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/controllers/data_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/user_address_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/cart/widgets/pickup_time_card.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';
import 'package:homeeaze_sourcecode/views/orders/payment_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/bottom_bar_button.dart';
import 'package:intl/intl.dart';

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
  int _itemCount = 0;
  double _subTotalAmount = 0;
  int _selectedPickUpIndex = -1;
  String? _selectedPickUpOption;

  static List<DateTime> todayDateTimeOptions = [
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      8,
    ),
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      14,
    ),
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      18,
    ),
  ];
  static List<DateTime> tomorrowDateTimeOptions = [
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
      8,
    ),
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
      14,
    ),
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
      18,
    ),
  ];

  List<String> pickUpSlotDayOptions = ['Today', 'Today', 'Today'];
  List<String> pickUpSlotTimeOptions = ["8-9 AM", "2-3 PM", "6-7 PM"];
  List<String> pickUpSlotDateOptions = [
    DateFormat('EEE, d-M-y').format(todayDateTimeOptions[0]),
    DateFormat('EEE, d-M-y').format(todayDateTimeOptions[1]),
    DateFormat('EEE, d-M-y').format(todayDateTimeOptions[2]),
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      _itemCount = 0;
      _subTotalAmount = 0;

      _subTotalAmount = _dataController.getTotalOrderAmount(
        cartServices: widget.cartServices,
        outletServiceMenu: widget.outletServiceMenu,
      );

      for (int i = 0; i < widget.cartServices.length; i++) {
        _itemCount += widget.cartServices[i].selectedItems.length;
      }

      /// Change piclUpSlotDateOptions as per Curent Date Time
      for (int i = 0; i < 3; i++) {
        if (DateTime.now().isAfter(todayDateTimeOptions[i])) {
          pickUpSlotDayOptions[i] = 'Tomorrow';
          pickUpSlotDateOptions[i] =
              DateFormat('EEE, d-M-y').format(tomorrowDateTimeOptions[i]);
        }
      }
    });

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: AppColors.primaryButtonColor,
        title: Text(
          widget.vendorModel.outletName,
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
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: AppAssets.pickUpTimeAlarmIcon,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Choose a pickup slot convenient for you:",
                    style: GoogleFonts.poppins(
                      color: AppColors.secondaryTextColor,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: size.width,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedPickUpIndex = 0;
                        _selectedPickUpOption =
                            "${pickUpSlotTimeOptions[0]} ${pickUpSlotDateOptions[0]}";
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          pickUpSlotDayOptions[0],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        PickUpTimeCard(
                          text: pickUpSlotTimeOptions[0],
                          bgColor: (_selectedPickUpIndex != 0)
                              ? AppColors.primaryButtonColor
                              : AppColors.secondaryButtonColor,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedPickUpIndex = 1;
                        _selectedPickUpOption =
                            "${pickUpSlotTimeOptions[1]} ${pickUpSlotDateOptions[1]}";
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          pickUpSlotDayOptions[1],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        PickUpTimeCard(
                          text: pickUpSlotTimeOptions[1],
                          bgColor: (_selectedPickUpIndex != 1)
                              ? AppColors.primaryButtonColor
                              : AppColors.secondaryButtonColor,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedPickUpIndex = 2;
                        _selectedPickUpOption =
                            "${pickUpSlotTimeOptions[2]} ${pickUpSlotDateOptions[2]}";
                      });
                    },
                    child: Column(
                      children: [
                        Text(
                          pickUpSlotDayOptions[2],
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        PickUpTimeCard(
                          text: pickUpSlotTimeOptions[2],
                          bgColor: (_selectedPickUpIndex != 2)
                              ? AppColors.primaryButtonColor
                              : AppColors.secondaryButtonColor,
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
                                        width: 24,
                                        height: 24,
                                        child: itemImageMap[currentItem.name],
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
                                              color:
                                                  AppColors.secondaryTextColor,
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
                                              InkWell(
                                                child: const Icon(Icons.remove,
                                                    size: 16,
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
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                child: const Icon(
                                                  Icons.add,
                                                  size: 16,
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
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return const HomePage(currIndex: 0);
                  }),
                  (route) => false,
                );
              },
              child: Container(
                width: size.width,
                margin: const EdgeInsets.only(top: 16, bottom: 16),
                padding: const EdgeInsets.only(
                    top: 16, left: 16, right: 40, bottom: 16),
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
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: AppColors.blackColor,
                    ),
                  ],
                ),
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
                        "₹ ${_subTotalAmount.toString()}",
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
                builder:
                    (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ColorLoader();
                  } else if (snapshot.hasData) {
                    UserModel userModel = snapshot.data!;
                    UserAddressModel userAddressModel =
                        userModel.userAddressList[
                            userModel.primaryAddressIndex]; // To be changed
                    return Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 36),
                        child: Text(
                          userAddressModel.userManualAddress,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
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
                      onTap: () {
                        // Payment Page
                        if (_itemCount != 0 && _selectedPickUpIndex != -1) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return PaymentPage(
                                  cartServices: widget.cartServices,
                                  outletServiceMenu: widget.outletServiceMenu,
                                  vendorModel: widget.vendorModel,
                                  totalAmount: _subTotalAmount,
                                  itemCount: _itemCount,
                                  pickUpTimeSlot: _selectedPickUpOption!,
                                );
                              },
                            ),
                          );
                        } else if (_itemCount == 0) {
                          showCustomDialog(
                            context: context,
                            title: "Cart is Empty",
                            message: "Choose some item from cart to continue",
                          );
                        } else {
                          showCustomDialog(
                            context: context,
                            title: "Pickup a time slot",
                            message: "Select a Pickup time slot to proceed",
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
