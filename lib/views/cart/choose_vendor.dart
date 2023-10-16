import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/controllers/data_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/Models/cart_model.dart';
import 'package:homeeaze_sourcecode/Models/user_address_model.dart';
import 'package:homeeaze_sourcecode/Models/user_model.dart';
import 'package:homeeaze_sourcecode/Models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/orders/checkout_page.dart';
import 'package:homeeaze_sourcecode/views/widgets/bottom_bar_button.dart';
import 'package:homeeaze_sourcecode/views/cart/widgets/laundry_card.dart';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: AppColors.primaryButtonColor,
        title: Text(
          "Choose your perfect match!",
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 2, right: 2),
        child: StreamBuilder<UserModel>(
          stream: _authController.getUserData(_authController.currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const NoVendorWidget();
            } else if (snapshot.hasData) {
              debugPrint("hasUserData");
              UserModel userModel = snapshot.data!;
              UserAddressModel userAddressModel =
                  userModel.userAddressList[userModel.primaryAddressIndex];
              return StreamBuilder<List<VendorModel>>(
                stream: _dataController.fetchVendorOutletData(
                  context: context,
                  userLatitude: userAddressModel.userLatitude,
                  userLongitude: userAddressModel.userLongitude,
                ),
                builder: (BuildContext context,
                    AsyncSnapshot<List<VendorModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const NoVendorWidget();
                  } else if (snapshot.hasData) {
                    debugPrint("hasVendorData");
                    return (snapshot.data!.isEmpty)
                        ? const NoVendorWidget()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              VendorModel vendor = snapshot.data![index];
                              return FutureBuilder(
                                future: _dataController.fetchOutletServiceMenu(
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
                                    debugPrint("hasOutletServiceMenu");
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
                                                : AppColors.primaryBorderColor,
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
                                                userAddressModel.userLatitude,
                                            userLongitude:
                                                userAddressModel.userLongitude,
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
                    UserAddressModel userAddressModel = userModel
                        .userAddressList[userModel.primaryAddressIndex];
                    return Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 36, right: 36),
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
                          showCustomDialog(
                            context: context,
                            title: "Choose a laundry",
                            message:
                                "Pick a laundry from the available laundries to proceed",
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
