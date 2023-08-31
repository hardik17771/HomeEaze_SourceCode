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
import 'package:homeeaze_sourcecode/views/cart/widgets/service_card.dart';
import 'package:homeeaze_sourcecode/views/profile/my_profile.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final AuthController _authController = AuthController();

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
      showCustomToast(
          text: "Cart Items have been updated click on cart to Proceed");
      setState(() {
        service.selectedItems = updatedService.selectedItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          const SizedBox(height: 16),
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
                            itemCount: 0,
                            serviceImage: services[0].image,
                            serviceName: services[0].name,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await updateService(service: services[1]);
                          },
                          child: ServiceCard(
                            itemCount: 0,
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
                            itemCount: 0,
                            serviceImage: services[2].image,
                            serviceName: services[2].name,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await updateService(service: services[3]);
                          },
                          child: ServiceCard(
                            itemCount: 0,
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
      ),
    );
  }
}
