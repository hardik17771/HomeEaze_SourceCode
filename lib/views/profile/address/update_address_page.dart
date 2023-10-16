import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homeeaze_sourcecode/controllers/data_controller.dart';
import 'package:homeeaze_sourcecode/core/animations/color_loader.dart';
import 'package:homeeaze_sourcecode/core/colors.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/Models/user_address_model.dart';
import 'package:homeeaze_sourcecode/views/widgets/custom_button.dart';

class UpdateAddressPage extends StatefulWidget {
  final int selectedAddressIndex;
  final UserAddressModel userAddressModel;
  const UpdateAddressPage({
    super.key,
    required this.userAddressModel,
    required this.selectedAddressIndex,
  });

  @override
  State<UpdateAddressPage> createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  Position? _currentPosition;
  String _liveAddress = "";
  String _livePincode = "";
  late TextEditingController manualHouseNoController;
  late TextEditingController manualLocalityController;
  late TextEditingController nearByAddressController;
  late TextEditingController manualCityController;
  late TextEditingController manualPincodeController;
  bool? _isLocationLoading;
  bool? _isDataLoading;
  final _formKey = GlobalKey<FormState>();
  final DataController _dataController = DataController();

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
    List<String> fullAddress =
        widget.userAddressModel.userManualAddress.split(",");
    manualHouseNoController = TextEditingController(text: fullAddress[0]);
    manualLocalityController = TextEditingController(text: fullAddress[1]);
    nearByAddressController = TextEditingController(text: fullAddress[2]);
    manualCityController = TextEditingController(text: fullAddress[3]);
    manualPincodeController =
        TextEditingController(text: widget.userAddressModel.userManualPincode);
    _liveAddress = widget.userAddressModel.userLiveAddress;
    _livePincode = widget.userAddressModel.userLivePincode;

    _isLocationLoading = false;
    _isDataLoading = false;
  }

  @override
  void dispose() {
    manualHouseNoController.dispose();
    manualLocalityController.dispose();
    nearByAddressController.dispose();
    manualCityController.dispose();
    manualPincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 90,
        backgroundColor: AppColors.primaryButtonColor,
        title: Text(
          "UPDATE ADDRESS",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: CustomButton(
                              text: (_currentPosition != null)
                                  ? 'GPS Location Applied'
                                  : 'Use My GPS Location',
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
                      'Enter Address Manually',
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
                      controller: manualCityController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your City';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.whiteColor,
                        errorStyle: GoogleFonts.poppins(fontSize: 10),
                        labelText: 'Enter your City *',
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
                      _isLocationLoading == false) {
                    setState(() {
                      _isDataLoading = true;
                    });

                    UserAddressModel userAddressModel = UserAddressModel(
                      userManualAddress:
                          '${manualHouseNoController.text.trim()}, ${manualLocalityController.text.trim()}, ${nearByAddressController.text.trim()}, ${manualCityController.text.trim()}',
                      userManualPincode: manualPincodeController.text.trim(),
                      userLiveAddress: _liveAddress,
                      userLivePincode: _livePincode,
                      userLongitude: (_currentPosition != null)
                          ? _currentPosition!.longitude
                          : widget.userAddressModel.userLongitude,
                      userLatitude: (_currentPosition != null)
                          ? _currentPosition!.latitude
                          : widget.userAddressModel.userLatitude,
                    );

                    await _dataController.updateUserAddress(
                      selectedAddressIndex: widget.selectedAddressIndex,
                      updatedUserAddressModel: userAddressModel,
                      context: context,
                    );

                    setState(() {
                      _isDataLoading = false;
                    });
                  }
                },
                child: Container(
                  height: 40,
                  width: screenWidth,
                  margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(
                      width: 1,
                      color: AppColors.blackColor,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "UPDATE ADDRESS",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
