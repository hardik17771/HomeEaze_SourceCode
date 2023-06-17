import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationPage extends StatelessWidget {
   LocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(

      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.only(left: screenWidth*0.04,top: screenHeight*0.03,right: screenWidth*0.04,bottom: screenHeight*0.02),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/Pin.png',
              ),

            ),
            Text('Want to see services near you?',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),),
            SizedBox(
              height: screenHeight*0.05,
            ),
            SizedBox(

              height: screenHeight*0.07,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: ElevatedButton(

                    onPressed:()=>{

    },

                    child: Center(
                      child: Text(
                        'Use my Current Location',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight*0.02,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1.0,
                    width: 120.0,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'OR',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    width: 120.0,
                    color: Colors.grey,
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
