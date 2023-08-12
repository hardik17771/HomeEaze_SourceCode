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
import 'package:homeeaze_sourcecode/views/orders/checkout_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/laundry_card.dart';
import 'package:homeeaze_sourcecode/views/widgets/no_vendor_widget.dart';

class ChooseVendorPage extends StatefulWidget {
  final List<Service> cartServices;
  const ChooseVendorPage({
    super.key,
    required this.cartServices,
  });

  @override
  State<ChooseVendorPage> createState() => _ChooseVendorPageState();
}

class _ChooseVendorPageState extends State<ChooseVendorPage> {
  final AuthController _authController = AuthController();
  final DataController _dataController = DataController();

  int _selectedIndex = -1;
  VendorModel? _selectedVendorModel;
  List<Map<String, dynamic>>? _selectedOutletServiceMenu;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 72,
          backgroundColor: AppColors.primaryButtonColor,
          title: Text(
            "Choose your perfect match!",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16, left: 2, right: 2),
          child: StreamBuilder<UserModel>(
            stream:
                _authController.getUserData(_authController.currentUser!.uid),
            builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const NoVendorWidget();
              } else if (snapshot.hasData) {
                // debugPrint("hasUserData");
                UserModel? userModel = snapshot.data;
                return StreamBuilder<List<VendorModel>>(
                  stream: _dataController.fetchVendorOutletData(
                    context: context,
                    userLatitude: userModel!.userLatitude,
                    userLongitude: userModel.userLongitude,
                  ),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<VendorModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const NoVendorWidget();
                    } else if (snapshot.hasData) {
                      // debugPrint("hasVendorData");
                      return (snapshot.data!.isEmpty)
                          ? const NoVendorWidget()
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                VendorModel vendor = snapshot.data![index];
                                return FutureBuilder(
                                  future:
                                      _dataController.fetchOutletServiceMenu(
                                          vendorUid: vendor.vendorUid),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: ColorLoader(),
                                      );
                                    } else if (snapshot.hasData) {
                                      // debugPrint("hasOutletServiceMenu");
                                      List<Map<String, dynamic>>
                                          outletServiceMenu = snapshot.data;
                                      double orderAmount =
                                          _dataController.getTotalOrderAmount(
                                        cartServices: widget.cartServices,
                                        outletServiceMenu: outletServiceMenu,
                                      );
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedIndex = index;
                                            _selectedVendorModel = vendor;
                                            _selectedOutletServiceMenu =
                                                outletServiceMenu;
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: (_selectedIndex == index)
                                                  ? AppColors.primaryButtonColor
                                                  : AppColors
                                                      .primaryBorderColor,
                                              width: (_selectedIndex == index)
                                                  ? 2
                                                  : 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: LaundaryCard(
                                              vendor: vendor,
                                              orderAmount: orderAmount,
                                              userLatitude:
                                                  userModel.userLatitude,
                                              userLongitude:
                                                  userModel.userLongitude,
                                            ),
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const NoVendorWidget();
                                    }
                                  },
                                );
                              },
                            );
                    } else {
                      return const NoVendorWidget();
                    }
                  },
                );
              } else {
                return const NoVendorWidget();
              }
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: SizedBox(
            width: screenWidth,
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
                            child: AppAssets.deliveryBoyIcon),
                        Text(
                          "Pickup in 60 mins.",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 36),
                  child: Text(
                    (_selectedIndex != -1)
                        ? _selectedVendorModel!.outletName
                        : "Select a Vendor",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Divider(thickness: 1),
                Container(
                  color: AppColors.primaryBackgroundColor,
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(widget.cartServices);
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
                            if (_selectedIndex != -1) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CheckOutPage(
                                      vendorModel: _selectedVendorModel!,
                                      cartServices: widget.cartServices,
                                      outletServiceMenu:
                                          _selectedOutletServiceMenu!,
                                    );
                                  },
                                ),
                              );
                            } else {
                              showSnackBar(
                                context: context,
                                text: "Choose a laundry",
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
                                "Next    >",
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
