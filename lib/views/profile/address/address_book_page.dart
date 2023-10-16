import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/Models/user_address_model.dart';
import 'package:homeeaze_sourcecode/views/profile/address/add_address_page.dart';
import 'package:homeeaze_sourcecode/views/profile/address/address_card.dart';

class AddressBookPage extends StatefulWidget {
  final int primaryAddressIndex;
  final List<UserAddressModel> userAddressList;
  const AddressBookPage({
    Key? key,
    required this.primaryAddressIndex,
    required this.userAddressList,
  }) : super(key: key);

  @override
  State<AddressBookPage> createState() => _AddressBookPageState();
}

class _AddressBookPageState extends State<AddressBookPage> {
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
          "Address book",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const AddAddressPage();
                  },
                ),
              );
            },
            child: Container(
              color: AppColors.whiteColor,
              padding: const EdgeInsets.only(
                  left: 16, right: 32, top: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.add,
                        size: 28,
                        color: AppColors.primaryButtonColor,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "Add Address",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
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
          const SizedBox(height: 8),
          Container(
            width: size.width,
            color: AppColors.whiteColor,
            padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text(
              "Saved Addresses",
              style: GoogleFonts.poppins(
                color: AppColors.secondaryTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: widget.userAddressList.length,
            itemBuilder: (BuildContext context, int index) {
              final UserAddressModel currentAddressModel =
                  widget.userAddressList[index];
              return AddressCard(
                selectedAddressIndex: index,
                primaryAddressIndex: widget.primaryAddressIndex,
                userAddressModel: currentAddressModel,
              );
            },
          ),
        ],
      ),
    );
  }
}
