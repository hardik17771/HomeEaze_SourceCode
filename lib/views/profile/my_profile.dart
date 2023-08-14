import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/animations.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/views/home_page.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final AuthController _authController = AuthController();
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
            "My Account",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: StreamBuilder<UserModel>(
            stream:
                _authController.getUserData(_authController.currentUser!.uid),
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
                    Container(
                      color: AppColors.whiteColor,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      color: AppColors.whiteColor,
                      padding: const EdgeInsets.only(
                          left: 16, right: 32, top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Help Center",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(22)),
                                    child: Text(
                                      "Help Center Data",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    Container(
                      color: AppColors.whiteColor,
                      padding: const EdgeInsets.only(
                          left: 16, right: 32, top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Address Book",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryBackgroundColor,
                                        borderRadius:
                                            BorderRadius.circular(22)),
                                    child: Text(
                                      userModel.userAddress,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: AppColors.whiteColor,
                      padding: const EdgeInsets.only(
                          left: 16, right: 32, top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "My Orders",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const HomePage(currIndex: 3);
                                  },
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: AppColors.whiteColor,
                      padding: const EdgeInsets.only(
                          left: 16, right: 32, top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Payments",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: AppColors.whiteColor,
                      padding: const EdgeInsets.only(
                          left: 16, right: 32, top: 16, bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "About Droby",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBackgroundColor,
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: Text(
                                      "About Droby",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color: AppColors.blackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    GestureDetector(
                      onTap: () async {
                        await _authController.signOut(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
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
                    const SizedBox(height: 24),
                    const Divider(thickness: 1.5),
                  ],
                );
              } else {
                return const Text("No User");
              }
            }),
      ),
    );
  }
}