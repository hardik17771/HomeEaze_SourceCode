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
      orderReceivingTime: DateTime.now(),
      orderPickUpTime: DateTime.now(),
      orderDeliveryTime: DateTime.now(),
      paymentMode: "UPI",
      orderStatus: "Recieved",
      orderAmount: 540,
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
}
