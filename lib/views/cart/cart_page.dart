import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/views/cart/add_item_page.dart';
import 'package:homeeaze_sourcecode/views/cart/my_basket_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    int _itemCount = 0;
    setState(() {
      for (int i = 0; i < services.length; i++) {
        _itemCount += services[i].selectedItems.length;
      }
    });

    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 90,
          backgroundColor: AppColors.primaryButtonColor,
          title: Text(
            "Anything else to add?",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: ListView.builder(
            itemCount: services.length,
            itemBuilder: (BuildContext context, int index) {
              final service = services[index];
              return Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, bottom: 6, top: 6),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final updatedService = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AddItem(service: service);
                            },
                          ),
                        );

                        if (updatedService != null) {
                          setState(() {
                            service.selectedItems =
                                updatedService.selectedItems;
                          });
                        }
                      },
                      child: Container(
                        height: 91,
                        width: screenWidth,
                        decoration: BoxDecoration(
                          color: AppColors.primaryButtonColor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: AppColors.whiteColor,
                            width: 4,
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
                            service.name,
                            style: GoogleFonts.poppins(
                              color: AppColors.whiteColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        height: 20,
                        width: 64,
                        padding: const EdgeInsets.only(left: 3, right: 3),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.primaryBoxShadowColor,
                              offset: Offset(0.0, 1.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "${service.selectedItems.length} Items",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 18,
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
                    const EdgeInsets.only(right: 8, top: 6.0, bottom: 10.0),
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
                      showSnackBar(
                        context: context,
                        text: "Select items to continue",
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
