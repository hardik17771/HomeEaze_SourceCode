import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/views/cart_services/choose_vendor.dart';

class MyBasketPage extends StatefulWidget {
  final List<Service> services;
  const MyBasketPage({
    super.key,
    required this.services,
  });

  @override
  State<MyBasketPage> createState() => _MyBasketPageState();
}

class _MyBasketPageState extends State<MyBasketPage> {
  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFF0793C5);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
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
        itemCount: services.length,
        itemBuilder: (BuildContext context, int index) {
          Service currentService = services[index];
          return ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: currentService.selectedItems.length,
            itemBuilder: (BuildContext context, int index) {
              Item currentItem = currentService.selectedItems[index];
              return Padding(
                padding:
                    const EdgeInsets.only(left: 1, right: 1, top: 8, bottom: 8),
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey),
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
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                currentItem.name,
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF767272),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Container(
                          height: 48,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: buttonColor,
                              width: 2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.white,
                                offset: Offset(4.0, 4.0),
                                blurRadius: 4.0,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.remove,
                                  size: 16,
                                  color: buttonColor,
                                ),
                                onPressed: () {
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
                              Text(
                                currentItem.quantity.toString(),
                                style: GoogleFonts.poppins(
                                  color: buttonColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.add,
                                  size: 16,
                                  color: buttonColor,
                                ),
                                onPressed: () {
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
        child: SizedBox(
          // height: 150,
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
                        "Pickup at Home",
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 40),
                    child: TextButton(
                      child: Text(
                        "Change",
                        style: GoogleFonts.poppins(
                          color: buttonColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(left: 36),
                child: Text(
                  "Row House 13/25, Windsor Estate, Pune",
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
                      onTap: () {},
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const ChooseVendorPage();
                          },
                        ));
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
            ],
          ),
        ),
      ),
    );
  }
}
