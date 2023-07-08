import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'outlet_details.dart';

class CheckOut extends StatelessWidget {
  const  CheckOut({
    required this.amount,
    required this.pickUpSlot,
    required this.typeOfLaundery,
    Key? key,
  });
  final String typeOfLaundery;
  final int amount;
  final String pickUpSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: buttonColor,
        title: Text(
          "Found you a perfect match!",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFF80D6F4),
            borderRadius:
                BorderRadius.circular(20), // Adjust the radius value as needed
          ),
          child: Column(
            children: [
             const SizedBox(
                height: 30,
              ),
              Image.asset("lib/images/checkOut.png"),
             const SizedBox(
                height: 16,
              ),
              Container(
                  child: Column(
                    children: [
                      Text(
                        typeOfLaundery,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        amount.toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Pick up Slot-" + pickUpSlot,
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  width: 226,
                  height: 135,
                  decoration: BoxDecoration(
                    color: Color(0xFF1EA6D6),
                    borderRadius: BorderRadius.circular(
                        20), // Adjust the radius value as needed
                  )),
             const SizedBox(
                height: 64,
              ),
              Container(
                width: 244,
                height: 51,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {},
                  child: Text(
                    'Make Payment',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.poppins(
                        color:const Color(0xFF767272),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
