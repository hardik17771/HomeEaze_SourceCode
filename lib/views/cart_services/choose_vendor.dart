import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/data_controller.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/views/widgets/datetime_card.dart';

class ChooseVendorPage extends StatefulWidget {
  const ChooseVendorPage({super.key});

  @override
  State<ChooseVendorPage> createState() => _ChooseVendorPageState();
}

class _ChooseVendorPageState extends State<ChooseVendorPage> {
  final DataController dataController = DataController();

  @override
  Widget build(BuildContext context) {
    const buttonColor = Color(0xFF0793C5);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.09,
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
        child: StreamBuilder<Object>(
          stream: dataController.fetchvendorOutletData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            } else if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot vendor = snapshot.data.docs[index];
                  return Container(
                    height: 124,
                    width: screenWidth,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFD0D2D5),
                          offset: Offset(4.0, 4.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.only(left: 8, right: 8, top: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vendor["outletName"],
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    vendor["outletAddress"],
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF767272),
                                      fontSize: 7,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: SvgPicture.asset(
                                        "assets/icons/point_pin_icon.svg"),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "${2} kms",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      color: const Color(0xFF767272),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(
                              left: 20, top: 4, bottom: 4),
                          child: Text(
                            "Choose a pickup slot convenient for you:",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                              color: const Color(0xFFC4C4C4),
                              fontStyle: FontStyle.italic,
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            DateTimeCard(text: "In 60 mins."),
                            DateTimeCard(text: "1 PM"),
                            DateTimeCard(text: "5 PM"),
                          ],
                        ),
                        const Divider(thickness: 1),
                        Container(
                          margin: const EdgeInsets.only(left: 8, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 32,
                                height: 14,
                                color: const Color(0xFFD9D9D9),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      vendor["outletRating"].toString(),
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      size: 10,
                                      color: buttonColor,
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                "Grand Total    ₹ 540",
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF767272),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
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
        ),
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
                  "Thorat Laundry",
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
                      onTap: () {},
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
