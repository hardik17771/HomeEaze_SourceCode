import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/views/cart/choose_vendor.dart';

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
  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFF0793C5);
    const textColor = Color(0xFFA8A7A7);
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        appBar: AppBar(
          toolbarHeight: 72,
          backgroundColor: buttonColor,
          title: Text(
            "My Basket",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: ListView.builder(
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
                      left: 4, right: 4, top: 8, bottom: 8),
                  child: Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: textColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(16),
                              width: 24,
                              height: 24,
                              child: SvgPicture.asset(
                                "assets/icons/tshirt_icon.svg",
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentService.name,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  currentItem.name,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF767272),
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
                              GestureDetector(
                                child: const Icon(
                                  Icons.remove,
                                  size: 17,
                                  color: buttonColor,
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
                                    color: buttonColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: const Icon(
                                  Icons.add,
                                  size: 17,
                                  color: buttonColor,
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
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.all(12),
            width: screenWidth,
            child: Container(
              color: const Color(0xFFF2F2F2),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(widget.cartServices);
                      },
                      child: Container(
                        height: 46,
                        margin: const EdgeInsets.only(right: 8),
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
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return ChooseVendorPage(
                                cartServices: widget.cartServices,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 46,
                        margin: const EdgeInsets.only(left: 8),
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
                            "Proceed   >",
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
            ),
          ),
        ),
      ),
    );
  }
}
