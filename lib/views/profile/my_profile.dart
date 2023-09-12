import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';
import 'package:homeeaze_sourcecode/views/profile/address_book_page.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final AuthController _authController = AuthController();
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
          "My Account",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: StreamBuilder<UserModel>(
        stream: _authController.getUserData(_authController.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ColorLoader();
          } else if (snapshot.hasData) {
            debugPrint("has User");
            UserModel userModel = snapshot.data!;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    showCustomBottomSheet(
                      context: context,
                      title: "Profile Details",
                      text: "Email :- ${userModel.userEmail}\n"
                          "Mobile Number :- ${userModel.userMobileNumber}",
                    );
                  },
                  child: Container(
                    color: AppColors.whiteColor,
                    width: size.width,
                    padding: const EdgeInsets.only(
                        left: 16, right: 32, top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  AppColors.tertiaryBackgroundColor,
                              child: Icon(
                                Icons.person_2_outlined,
                                color: AppColors.blackColor,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              userModel.username,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () {
                    showCustomBottomSheet(
                      context: context,
                      title: "Customer Care No.",
                      text: "+91-9079083981",
                    );
                  },
                  child: Container(
                    color: AppColors.whiteColor,
                    width: size.width,
                    padding: const EdgeInsets.only(
                        left: 16, right: 32, top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Help Center",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AddressBookPage(
                            locality: userModel.userManualAddress,
                            pincode: userModel.userManualPincode,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                    color: AppColors.whiteColor,
                    width: size.width,
                    padding: const EdgeInsets.only(
                        left: 16, right: 32, top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address Book",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const HomePage(currIndex: 2);
                        },
                      ),
                    );
                  },
                  child: Container(
                    color: AppColors.whiteColor,
                    width: size.width,
                    padding: const EdgeInsets.only(
                        left: 16, right: 32, top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "My Orders",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: AppColors.whiteColor,
                    width: size.width,
                    padding: const EdgeInsets.only(
                        left: 16, right: 32, top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Payments",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    showCustomBottomSheet(
                      context: context,
                      title: "Droby - A Laundry App",
                      text:
                          "We are committed to build a hassle-free online laundry experience so that you can focus on the things that matter.Choose your service, schedule your pickup, and we'll handle the rest.",
                    );
                  },
                  child: Container(
                    color: AppColors.whiteColor,
                    width: size.width,
                    padding: const EdgeInsets.only(
                        left: 16, right: 32, top: 16, bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "About Droby",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                          color: AppColors.blackColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () async {
                    await _authController.signOut(context);
                  },
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryBoxShadowColor,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Text(
                      "Logout",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: AppColors.tertiaryTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ), // LogOut
              ],
            );
          } else {
            return const Text("No User");
          }
        },
      ),
    );
  }
}
