import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationPage extends StatefulWidget {
  LocationPage({
    super.key,
    required this.userID,
  });

  final String userID;

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Future<void> getLocationAndCreateDocument() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    double latitude = position.latitude;
    double longitude = position.longitude;

    if (widget.userID.isNotEmpty) {
      DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(widget.userID);
      await userDoc.set({
        'user_address': {
          'latitude': latitude,
          'longitude': longitude,
        },
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.04,
            top: screenHeight * 0.03,
            right: screenWidth * 0.04,
            bottom: screenHeight * 0.02),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/Pin.png',
              ),
            ),
            Text(
              'Want to see services near you?',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            SizedBox(
              height: screenHeight * 0.07,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: ElevatedButton(
                  onPressed: () => {
                    getLocationAndCreateDocument(),
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
              height: screenHeight * 0.02,
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
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Address Manually',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 10, color: Color(0xFFA8A7A7).withOpacity(.5)),
                    hintText: 'Enter Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 10, color: Color(0xFFA8A7A7).withOpacity(.5)),
                    hintText: 'Enter Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
