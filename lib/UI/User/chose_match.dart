

import 'package:flutter/material.dart';


import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/laundery_card.dart';
import 'checkout_page.dart';
import 'outlet_details.dart';


class ChoseMatch extends StatefulWidget {
  @override
  _ChoseMatchState createState() => _ChoseMatchState();
}

class _ChoseMatchState extends State<ChoseMatch> {
  List<String> thoratLaundrySlots = ['Immediate', '2:00 PM', '5:00 PM'];
  List<String> cleanupLaundrySlots = ['Immediate', '2:00 PM', '5:00 PM'];

  String? selectedThoratLaundrySlot;
  String? selectedCleanupLaundrySlot;
  int priceThoratLaundery = 200;
  int priceCleanupLaundery = 400;
  void thoratupdateTimeSlot(String timeSlot) {
    setState(() {
      selectedThoratLaundrySlot = timeSlot;
    });
  }

  void cleanupupdateTimeSlot(String timeSlot) {
    setState(() {
      selectedCleanupLaundrySlot = timeSlot;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: selectedThoratLaundrySlot != null ||
              selectedCleanupLaundrySlot != null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    selectedCleanupLaundrySlot != null
                        ? Text("Amount - " + priceCleanupLaundery.toString(),
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600))
                        : Text("Amount - " + priceThoratLaundery.toString(),
                            style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckOut(
                                amount: selectedCleanupLaundrySlot != null
                                    ? priceCleanupLaundery
                                    : priceThoratLaundery,
                                pickUpSlot: (selectedCleanupLaundrySlot ?? selectedThoratLaundrySlot)!,
                                typeOfLaundery:
                                    selectedCleanupLaundrySlot != null
                                        ? "Cleanup Laundry"
                                        : "Thorat Laundery",
                              ),
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Container(
                        width: 100,
                        height: 36,
                        alignment: Alignment.center,
                        child: Text(
                          'Pay Now',
                          style: GoogleFonts.poppins(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  ]),
            )
          : Text(""),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: buttonColor,
        title: Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_back)),
            Text(
              '  Chose your perfect match!',
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          const  SizedBox(
              height: 8,
            ),
            Container(
              width: double.infinity,
              height: 400,
              child: Image.asset(
                "assets/image1.png",
                alignment: Alignment.center,
              ),
            ),
            selectedThoratLaundrySlot == null
                ? UnselectedCard(
                    otherLaundery: selectedCleanupLaundrySlot,
                    amount: priceThoratLaundery,
                    time: thoratLaundrySlots,
                    type: "Thorat Laundry",
                    selection: thoratupdateTimeSlot)
                : SelectedCard(
                    amount: priceThoratLaundery,
                    selectedTime: selectedThoratLaundrySlot!,
                    type: "Thorat Laundry"),
            selectedCleanupLaundrySlot == null
                ? UnselectedCard(
                    otherLaundery: selectedThoratLaundrySlot,
                    amount: priceCleanupLaundery,
                    time: cleanupLaundrySlots,
                    type: "Cleanup Laundery",
                    selection: cleanupupdateTimeSlot)
                : SelectedCard(
                    amount: priceCleanupLaundery,
                    selectedTime: selectedCleanupLaundrySlot!,
                    type: "Cleanup Laundry")
          ],
        ),
      ),
    );
  }
}
