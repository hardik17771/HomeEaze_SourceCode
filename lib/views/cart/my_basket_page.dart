import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/views/cart/choose_vendor.dart';
import 'package:homeeaze_sourcecode/views/widgets/bottom_bar_button.dart';

class MyBasketPage extends StatefulWidget {
  final List<Service> cartServices;
  const MyBasketPage({
    super.key,
    required this.cartServices,
  });

  @override
  State<MyBasketPage> createState() => _MyBasketPageState();
}

class _MyBasketPageState extends State<MyBasketPage> {
  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _itemCount = 0;
      for (int i = 0; i < services.length; i++) {
        _itemCount += services[i].selectedItems.length;
      }
    });
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: AppColors.primaryButtonColor,
        title: Text(
          "My Basket",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.cartServices.length,
          itemBuilder: (BuildContext context, int index) {
            Service currentService = widget.cartServices[index];
            return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: currentService.selectedItems.length,
              itemBuilder: (BuildContext context, int index) {
                Item currentItem = currentService.selectedItems[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 8),
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.primaryBoxShadowColor,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(16),
                              width: 28,
                              height: 28,
                              child: itemImageMap[currentItem.name],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentService.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  currentItem.name,
                                  style: GoogleFonts.poppins(
                                    color: AppColors.secondaryTextColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 24.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                child: const Icon(
                                  Icons.remove,
                                  size: 24,
                                  color: AppColors.primaryButtonColor,
                                ),
                                onTap: () {
                                  setState(() {
                                    if (currentItem.quantity > 0) {
                                      currentItem.quantity--;
                                      if (currentItem.quantity == 0) {
                                        currentService.selectedItems
                                            .remove(currentItem);
                                      }
                                    }
                                  });
                                },
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Text(
                                  currentItem.quantity.toString(),
                                  style: GoogleFonts.poppins(
                                    color: AppColors.primaryButtonColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              InkWell(
                                child: const Icon(
                                  Icons.add,
                                  size: 24,
                                  color: AppColors.primaryButtonColor,
                                ),
                                onTap: () {
                                  setState(() {
                                    currentItem.quantity++;
                                    if (!currentService.selectedItems
                                        .contains(currentItem)) {
                                      currentService.selectedItems
                                          .add(currentItem);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(widget.cartServices);
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
                    if (_itemCount != 0) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ChooseVendorPage(
                              cartServices: widget.cartServices,
                            );
                          },
                        ),
                      );
                    } else {
                      showCustomDialog(
                        context: context,
                        title: "Cart is Empty",
                        message: "Select some items to Procced",
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
        ),
      ),
    );
  }
}
