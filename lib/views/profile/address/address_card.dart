import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/data_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/models/user_address_model.dart';
import 'package:homeeaze_sourcecode/views/profile/address/update_address_page.dart';

class AddressCard extends StatefulWidget {
  final int selectedAddressIndex;
  final int primaryAddressIndex;
  UserAddressModel userAddressModel;
  AddressCard({
    super.key,
    required this.selectedAddressIndex,
    required this.primaryAddressIndex,
    required this.userAddressModel,
  });

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  final DataController _dataController = DataController();
  bool? _isPrimaryAddressLoading;

  @override
  void initState() {
    super.initState();
    _isPrimaryAddressLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      color: AppColors.whiteColor,
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.only(left: 16, bottom: 8, right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: AppAssets.addressBookHomeIcon,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Home",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "${widget.userAddressModel.userManualAddress} ${widget.userAddressModel.userManualPincode}",
                  style: GoogleFonts.poppins(
                    color: AppColors.secondaryTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        final updateAddrees = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return UpdateAddressPage(
                                selectedAddressIndex:
                                    widget.selectedAddressIndex,
                                userAddressModel: widget.userAddressModel,
                              );
                            },
                          ),
                        );

                        setState(() {
                          if (updateAddrees != null) {
                            widget.userAddressModel = updateAddrees;
                          }
                        });
                      },
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                        child: Text(
                          "Update",
                          style: GoogleFonts.poppins(
                            color: AppColors.primaryButtonColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (widget.selectedAddressIndex != 0)
                      InkWell(
                        onTap: () async {
                          await _dataController.deleteUserAddress(
                            context: context,
                            selectedAddressIndex: widget.selectedAddressIndex,
                          );

                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 8, top: 8, bottom: 8),
                          child: Text(
                            "Delete",
                            style: GoogleFonts.poppins(
                              color: AppColors.redColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () async {
              if (widget.selectedAddressIndex != widget.primaryAddressIndex) {
                setState(() {
                  _isPrimaryAddressLoading = true;
                });

                await _dataController.updateUserPrimaryAddressIndex(
                  context: context,
                  updatedPrimaryAddressIndex: widget.selectedAddressIndex,
                );

                setState(() {
                  _isPrimaryAddressLoading = false;
                });
              }
            },
            child: (_isPrimaryAddressLoading == true)
                ? const ColorLoader()
                : Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      (widget.selectedAddressIndex ==
                              widget.primaryAddressIndex)
                          ? "Primary"
                          : "Set Primary",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: AppColors.tertiaryTextColor,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
