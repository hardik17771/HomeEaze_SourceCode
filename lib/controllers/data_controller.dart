import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/order_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/order_placed_page.dart';
import 'package:uuid/uuid.dart';

class DataController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  // Choose Vendor Based on Longitude & latitude
  Stream<List<VendorModel>> fetchVendorOutletData({
    required double userLatitude,
    required double userLongitude,
  }) {
    return _firestore.collection("vendors").snapshots().map((event) {
      List<VendorModel> vendors = [];
      for (var doc in event.docs) {
        VendorModel currentVendor = VendorModel.fromMap(doc.data());
        double distance = Geolocator.distanceBetween(
          userLatitude,
          userLongitude,
          currentVendor.outletLatitude,
          currentVendor.outletLongitude,
        );
        if (distance <= 10) {
          vendors.add(currentVendor);
        }
      }
      return vendors;
    });
  }

  // Place order
  Future placeOrder({
    required String userUid,
    required String vendorUid,
    required BuildContext context,
  }) async {
    final orderId = const Uuid().v1();
    final OrderModel order = OrderModel(
      userUid: userUid,
      vendorUid: vendorUid,
      orderId: orderId,
      orderDateTime: DateTime.now(),
    );

    try {
      await _firestore.collection("orders").doc(orderId).set(order.toMap());

      // ignore: use_build_context_synchronously
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return const OrderPlacedPage();
        }),
      );
    } on FirebaseException catch (e) {
      showSnackBar(
        context: context,
        text: e.message!,
      );
    }
  }

  // Currently Static Data which need to be taken by outlet form vendor App form
  Future putVendorOutletData(BuildContext context) async {
    final vendorData = VendorModel(
      vendorUid: "Godan123456", // temporary
      vendorName: "Godan",
      outletName: "Godan Laundry",
      vendorMobileNumber: "9898989898",
      outletMobileNumber: "9898989898",
      outletAddress: "Kalyani Nagar, Pune",
      outletRating: 4.2,
      outletProfilePicUrl: "outletPhotoPicUrl",
      openingTime1: DateTime(8, 30),
      closingTime1: DateTime(2, 30),
      openingTime2: DateTime(4, 00),
      closingTime2: DateTime(10, 00),
      outletLatitude: 37.7749,
      outletLongitude: -122.4194,
    );

    var vendorId = const Uuid().v1();
    try {
      await _firestore
          .collection("vendors")
          .doc(vendorId)
          .set(vendorData.toMap());
    } on FirebaseException catch (e) {
      showSnackBar(
        context: context,
        text: e.message!,
      );
    }
  }
}
