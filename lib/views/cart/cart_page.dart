import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/views/cart/add_item_page.dart';
import 'package:homeeaze_sourcecode/views/cart/my_basket_page.dart';
import 'package:homeeaze_sourcecode/views/cart/widgets/service_card.dart';
import 'package:homeeaze_sourcecode/views/profile/my_profile.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final AuthController _authController = AuthController();
  int _itemCount = 0;

  Future<void> updateService({required Service service}) async {
    final updatedService = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddItem(service: service);
        },
      ),
    );

    if (updatedService != null) {
      showCustomToast(text: "Cart Items have been updated");
      setState(() {
        service.selectedItems = updatedService.selectedItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _itemCount = 0;
      for (int i = 0; i < services.length; i++) {
        _itemCount += services[i].selectedItems.length;
      }
    });

    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        body: Container(
          height: size.height,
          width: size.width,
          color: AppColors.primaryBackgroundColor,
          child: Stack(
            children: [
              Container(
                height: size.height / 2.5,
                width: size.width,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: AppColors.primaryButtonColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: StreamBuilder(
                  stream: _authController
                      .getUserData(_authController.currentUser!.uid),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ColorLoader();
                    } else if (snapshot.hasData) {
                      debugPrint("has UserData");
                      final UserModel userModel = snapshot.data!;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 28,
                                    width: 28,
                                    child: AppAssets.locationPinPointIconFilled,
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "Home",
                                        style: GoogleFonts.poppins(
                                          color: AppColors.whiteColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "${userModel.userManualAddress}, ${userModel.userManualPincode}",
                                        style: GoogleFonts.poppins(
                                          color: AppColors.whiteColor,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const MyProfilePage();
                                      },
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 28,
                                  width: 28,
                                  child: AppAssets.profileIcon,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: Text(
                              "Welcome back!",
                              style: GoogleFonts.poppins(
                                color: AppColors.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 12),
                            child: Text(
                              userModel.username,
                              style: GoogleFonts.poppins(
                                color: AppColors.whiteColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            margin: const EdgeInsets.only(left: 13),
                            child: Text(
                              "How can we serve you today?",
                              style: GoogleFonts.poppins(
                                color: AppColors.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: Text("No Data"));
                    }
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: 16, right: 16, top: size.height / 3.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            await updateService(service: services[0]);
                          },
                          child: ServiceCard(
                            itemCount: services[0].selectedItems.length,
                            serviceImage: services[0].image,
                            serviceName: services[0].name,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await updateService(service: services[1]);
                          },
                          child: ServiceCard(
                            itemCount: services[1].selectedItems.length,
                            serviceImage: services[1].image,
                            serviceName: services[1].name,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () async {
                            await updateService(service: services[2]);
                          },
                          child: ServiceCard(
                            itemCount: services[2].selectedItems.length,
                            serviceImage: services[2].image,
                            serviceName: services[2].name,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await updateService(service: services[3]);
                          },
                          child: ServiceCard(
                            itemCount: services[3].selectedItems.length,
                            serviceImage: services[3].image,
                            serviceName: services[3].name,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: AppAssets.shoppingBagIcon,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      " $_itemCount ITEMS ADDED",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 12, top: 12.0, bottom: 12.0),
                child: GestureDetector(
                  onTap: () async {
                    if (_itemCount != 0) {
                      final updatedServices = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyBasketPage(cartServices: services);
                          },
                        ),
                      );

                      if (updatedServices != null) {
                        setState(() {
                          services = updatedServices;
                        });
                      }
                    } else {
                      showCustomDialog(
                        context: context,
                        title: "Cart is Empty",
                        message: "Select some items to Procced",
                      );
                    }
                  },
                  child: Container(
                    height: 36,
                    width: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primaryButtonColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.whiteColor,
                        width: 1,
                      ),
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
                        "NEXT",
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
