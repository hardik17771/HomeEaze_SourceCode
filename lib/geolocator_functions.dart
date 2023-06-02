import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class NearbyVendorsPage extends StatefulWidget {
  @override
  _NearbyVendorsPageState createState() => _NearbyVendorsPageState();
}

class _NearbyVendorsPageState extends State<NearbyVendorsPage> {
  late Position _userPosition;
  late String _userAddress;
  Position _vendorPosition = Position(latitude: 37.7749, longitude: -122.4194,
    speedAccuracy: 5,
    timestamp: null,
    accuracy: 10.0,
    altitude: 100.0,
    heading: 180.0,
    speed: 5.0,); // Sample vendor location
  double _distance = 0.0;
  double _radius = 1000.0; // Radius in meters

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        // Handle denied location permission
        return;
      }

      if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _userPosition = position;
        });
        _getUserAddress(position);
        _calculateDistance();
      }
    } catch (e) {
      // Handle location retrieval error
      print(e.toString());
    }
  }

  Future<void> _getUserAddress(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        setState(() {
          _userAddress = placemark.street!;
        });
      }
    } catch (e) {
      // Handle address retrieval error
      print(e.toString());
    }
  }

  void _calculateDistance() {
    if (_userPosition != null) {
      double distance = Geolocator.distanceBetween(
        _userPosition.latitude,
        _userPosition.longitude,
        _vendorPosition.latitude,
        _vendorPosition.longitude,
      );
      setState(() {
        _distance = distance;
      });
    }
  }

  bool _isWithinRadius() {
    return _distance <= _radius;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Vendors'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Address: $_userAddress',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Distance to Vendor: ${_distance.toStringAsFixed(2)} meters',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              _isWithinRadius() ? 'Vendor is within radius' : 'Vendor is outside radius',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NearbyVendorsPage(),
  ));
}
