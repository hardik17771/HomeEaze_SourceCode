import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

class LocationPage extends StatefulWidget {
  final User user;
  final String username;
  final String mobileNumber;
  const LocationPage({
    super.key,
    required this.user,
    required this.username,
    required this.mobileNumber,
  });

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position? _currentPosition;
  String _currentLocality = "";
  String _currentPincode = "";
  bool isLocationFetched = false;
  AuthController authController = AuthController();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      showSnackBar(
        context: context,
        text: "Location services are disabled. Please enable the services",
      );
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        showSnackBar(
          context: context,
          text: "Location permissions are denied",
        );
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      showSnackBar(
        context: context,
        text:
            "Location permissions are permanently denied, we cannot request permissions.",
      );
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng(_currentPosition!);
      });
    }).catchError((e) {
      debugPrint(e);
      showSnackBar(context: context, text: e.toString());
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    ).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        isLocationFetched = true;
        _currentLocality =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}';
        _currentPincode = '${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    const textColor = Color(0xFFA8A7A7);
    const buttonColor = Color(0xFF0793C5);
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SingleChildScrollView(
          child: SizedBox(
            width: screenWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          alignment: Alignment.center,
                          height: 250,
                          width: 250,
                          child: SvgPicture.asset("assets/location_star.svg"),
                        ),
                      ),
                      Positioned(
                        left: 120,
                        top: 70,
                        child: Container(
                          alignment: Alignment.topCenter,
                          height: 120,
                          width: 150,
                          child: SvgPicture.asset("assets/location_pin.svg"),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Want to see services near you?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: CustomButton(
                    text: "Use my Current Location",
                    bgColor: buttonColor,
                    textColor: Colors.white,
                    onPress: () {
                      _getCurrentPosition();
                    },
                  ),
                ),
                const SizedBox(height: 24),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: Container(
                //         height: 0.5,
                //         color: const Color(0xFFC4C4C4),
                //       ),
                //     ),
                //     Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //       child: Text(
                //         'OR',
                //         style: GoogleFonts.poppins(
                //           fontWeight: FontWeight.w700,
                //           fontSize: 16,
                //         ),
                //       ),
                //     ),
                //     Expanded(
                //       child: Container(
                //         height: 0.5,
                //         color: const Color(0xFFC4C4C4),
                //       ),
                //     ),
                //   ],
                // ),
                if (isLocationFetched)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Locality',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: screenWidth,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: textColor,
                              width: 1,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            _currentLocality,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your Pincode',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          width: screenWidth,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: textColor,
                              width: 1,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Text(
                            _currentPincode,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFFF2F2F2),
          child: GestureDetector(
            onTap: () {
              if (isLocationFetched) {
                authController.saveUserDataToFirestore(
                  user: widget.user,
                  username: widget.username,
                  mobileNumber: widget.mobileNumber,
                  address: _currentLocality,
                  pincode: _currentPincode,
                  userLongitude: _currentPosition!.longitude,
                  userLatitude: _currentPosition!.latitude,
                  context: context,
                );
              } else {
                showSnackBar(
                  context: context,
                  text: "Use your current Location",
                );
              }
            },
            child: Container(
              height: 40,
              width: screenWidth,
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  "SAVE ADDRESS",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
