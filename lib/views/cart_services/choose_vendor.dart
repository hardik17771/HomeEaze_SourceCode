import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/controllers/data_controller.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/widgets/laundry_card.dart';

class ChooseVendorPage extends StatefulWidget {
  const ChooseVendorPage({super.key});

  @override
  State<ChooseVendorPage> createState() => _ChooseVendorPageState();
}

class _ChooseVendorPageState extends State<ChooseVendorPage> {
  final AuthController _authController = AuthController();
  final DataController _dataController = DataController();
  int _selectedIndex = -1;
  VendorModel? _selectedVendor;
  UserModel? _userModel;

  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFF0793C5);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: buttonColor,
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
                return const Loader();
              } else if (snapshot.hasData) {
                UserModel? userModel = snapshot.data;
                _userModel = userModel;
                return StreamBuilder<List<VendorModel>>(
                  stream: _dataController.fetchVendorOutletData(
                    userLatitude: userModel!.userLatitude,
                    userLongitude: userModel.userLongitude,
                  ),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<VendorModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Loader();
                    } else if (snapshot.hasData) {
                      debugPrint("hasData");
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          VendorModel vendor = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;
                                _selectedVendor = vendor;
                              });
                            },
                            child: Container(
                              height: 134,
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: (_selectedIndex == index)
                                      ? buttonColor
                                      : const Color(0xFFC4C4C4),
                                  width: (_selectedIndex == index) ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: screenWidth,
                              child: Center(
                                child: LaundaryCard(
                                  vendor: vendor,
                                  userLatitude: userModel.userLatitude,
                                  userLongitude: userModel.userLongitude,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("No Data"),
                      );
                    }
                  },
                );
              } else {
                return const Center(
                  child: Text("No Data"),
                );
              }
            }),
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
                        child: SvgPicture.asset(
                          "assets/icons/delivery_boy_icon.svg",
                        ),
                      ),
                      Text(
                        "Pickup in 30 mins.",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 24),
                    child: TextButton(
                      child: Row(
                        children: [
                          Text(
                            "7 Items ",
                            style: GoogleFonts.poppins(
                              color: buttonColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: buttonColor,
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 36),
                child: Text(
                  (_selectedIndex != -1)
                      ? _selectedVendor!.outletName
                      : "Select a Vendor",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Divider(thickness: 1),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 46,
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFA8A7A7),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFFD0D2D5),
                              offset: Offset(4.0, 4.0),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
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
                        _dataController.placeOrder(
                          userUid: _userModel!.userUid,
                          vendorUid: _selectedVendor!.vendorUid,
                          context: context,
                        );
                      },
                      child: Container(
                        height: 46,
                        margin: const EdgeInsets.only(
                            left: 8, right: 8, bottom: 12),
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFFD0D2D5),
                              offset: Offset(4.0, 4.0),
                              blurRadius: 4.0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Next    >",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }
}
