import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/auth_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/assets.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
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
  String _liveAddress = "";
  String _livePincode = "";
  bool? _isLocationLoading;
  bool? _isDataLoading;
  final _formKey = GlobalKey<FormState>();
  AuthController authController = AuthController();
  final TextEditingController manualHouseNoController = TextEditingController();
  final TextEditingController manualLocalityController =
      TextEditingController();
  final TextEditingController nearByAddressController = TextEditingController();
  final TextEditingController manualPincodeController = TextEditingController();

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Location Error",
        message: "Location services are disabled. Please enable the services",
      );
      _isLocationLoading = false;
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        showCustomDialog(
          context: context,
          title: "Location Error",
          message: "Location permissions are denied",
        );
        _isLocationLoading = false;
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      showCustomDialog(
        context: context,
        title: "Location Error",
        message:
            "Location permissions are permanently denied, we cannot request permissions.",
      );
      _isLocationLoading = false;
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng(_currentPosition!);
      });
    }).catchError((e) {
      debugPrint(e);
      _isLocationLoading = false;
      showCustomDialog(
        context: context,
        title: "Location Error",
        message: e.toString(),
      );
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
    ).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _liveAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}';
        _livePincode = '${place.postalCode}';
        _isLocationLoading = false;
      });
    }).catchError((e) {
      debugPrint(e);
      _isLocationLoading = false;
      showCustomDialog(
        context: context,
        title: "Location Error",
        message: e.toString(),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _isLocationLoading = false;
    _isDataLoading = false;
  }

  @override
  void dispose() {
    manualHouseNoController.dispose();
    manualLocalityController.dispose();
    nearByAddressController.dispose();
    manualPincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 250,
                        width: 250,
                        child: AppAssets.locationStarImage,
                      ),
                    ),
                    Positioned(
                      left: screenWidth / 2 - 75,
                      top: 75,
                      child: Container(
                        alignment: Alignment.center,
                        height: 120,
                        width: 150,
                        child: AppAssets.locationPinImage,
                      ),
                    ),
                  ],
                ),
                Text(
                  'Want to see services near you?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      (_isLocationLoading == true)
                          ? const ColorLoader()
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: CustomButton(
                                text: (_currentPosition != null)
                                    ? 'Current Address Applied'
                                    : 'Use My Current Address',
                                bgColor: AppColors.primaryButtonColor,
                                textColor: Colors.white,
                                onPress: () {
                                  setState(() {
                                    _isLocationLoading = true;
                                  });
                                  _getCurrentPosition();
                                },
                              ),
                            ),
                      const SizedBox(height: 16),
                      Text(
                        'Enter address details',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: manualHouseNoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter field value';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          errorStyle: GoogleFonts.poppins(fontSize: 10),
                          labelText: 'Flat / House no / Floor / Building *',
                          labelStyle: GoogleFonts.poppins(
                            color: AppColors.primaryTextColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryBorderColor,
                              width: 10,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: manualLocalityController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter your locality';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          errorStyle: GoogleFonts.poppins(fontSize: 10),
                          labelText: 'Enter your Locality *',
                          labelStyle: GoogleFonts.poppins(
                            color: AppColors.primaryTextColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryBorderColor,
                              width: 10,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: nearByAddressController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          labelText: 'NearBy Address (optional)',
                          labelStyle: GoogleFonts.poppins(
                            color: AppColors.primaryTextColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryBorderColor,
                              width: 10,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: manualPincodeController,
                        validator: (value) {
                          if (value == null || value.length != 6) {
                            return 'Enter your pincode';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.whiteColor,
                          errorStyle: GoogleFonts.poppins(fontSize: 10),
                          labelText: 'Enter your Pincode *',
                          labelStyle: GoogleFonts.poppins(
                            color: AppColors.primaryTextColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.primaryBorderColor,
                              width: 10,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.primaryBackgroundColor,
          child: (_isDataLoading == true)
              ? SizedBox(
                  height: 100,
                  width: screenWidth,
                  child: const ColorLoader(),
                )
              : GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate() &&
                        _isLocationLoading == false &&
                        _currentPosition != null &&
                        _liveAddress != "" &&
                        _livePincode != "") {
                      setState(() {
                        _isDataLoading = true;
                      });

                      await authController.saveUserDataToFirestore(
                        user: widget.user,
                        username: widget.username,
                        mobileNumber: widget.mobileNumber,
                        manualAddress:
                            '${manualHouseNoController.text.trim()}, ${manualLocalityController.text.trim()}, ${nearByAddressController.text.trim()}',
                        manualPincode: manualPincodeController.text.trim(),
                        liveAddress: _liveAddress,
                        livePincode: _livePincode,
                        userLongitude: _currentPosition!.longitude,
                        userLatitude: _currentPosition!.latitude,
                        context: context,
                      );

                      setState(() {
                        _isDataLoading = false;
                      });
                    } else if (_isLocationLoading == true ||
                        _currentPosition == null ||
                        _liveAddress == "" ||
                        _livePincode == "") {
                      showCustomDialog(
                        context: context,
                        title: "Use your current Location",
                        message:
                            "Please use your current Location by clicking on button",
                      );
                    }
                  },
                  child: Container(
                    height: 40,
                    width: screenWidth,
                    margin:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                    decoration: const BoxDecoration(
                      color: AppColors.whiteColor,
                    ),
                    child: Center(
                      child: Text(
                        "SAVE ADDRESS",
                        style: GoogleFonts.poppins(
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
