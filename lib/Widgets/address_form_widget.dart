import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddressFormWidget extends StatefulWidget {
  @override
  _AddressFormWidgetState createState() => _AddressFormWidgetState();
}

class _AddressFormWidgetState extends State<AddressFormWidget> {
  TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Address',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        TypeAheadField<String>(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _addressController,
            decoration: InputDecoration(
              hintText: 'Enter your address',
            ),
          ),
          suggestionsCallback: (pattern) => getAddressSuggestions(pattern),
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) async {
            await selectAddress(suggestion);
          },
        ),
      ],
    );
  }
  Future<List<String>> getAddressSuggestions(String pattern) async {
    List<Location> locations = await GeocodingPlatform.instance.locationFromAddress(pattern);
    List<String> addresses = [];

    for (var location in locations) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude!,
        location.longitude!,
      );
      if (placemarks.isNotEmpty) {
        String address = placemarks.first.street ?? '';
        addresses.add(address);
      }
    }

    return addresses;
  }




  Future<void> selectAddress(String address) async {
    List<Location> locations = await GeocodingPlatform.instance.locationFromAddress(address);

    if (locations.isNotEmpty) {
      Location location = locations.first;
      // Handle the retrieved location as needed
    }
  }
}


