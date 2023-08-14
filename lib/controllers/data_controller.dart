import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';

class DataController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  // Choose Vendor Based on Longitude & latitude
  Stream<List<VendorModel>> fetchVendorOutletData({
    required BuildContext context,
    required double userLatitude,
    required double userLongitude,
  }) {
    return _firestore.collection("vendors").snapshots().map((event) {
      List<VendorModel> vendors = [];
      for (var doc in event.docs) {
        try {
          VendorModel currentVendor = VendorModel.fromMap(doc.data());
          double distance = Geolocator.distanceBetween(
            userLatitude,
            userLongitude,
            currentVendor.outletLatitude,
            currentVendor.outletLongitude,
          );
          // debugPrint(distance.toString());
          if (distance <= 10000) {
            vendors.add(currentVendor);
          }
        } catch (e) {
          showSnackBar(
            context: context,
            text: e.toString(),
          );
        }
      }
      return vendors;
    });
  }

  // fetch Outlet ServicePrice Menu
  Future<List<Map<String, dynamic>>> fetchOutletServiceMenu({
    required String vendorUid,
  }) async {
    QuerySnapshot collectionSnapshot = await _firestore
        .collection("outletDetails")
        .doc(vendorUid)
        .collection("services")
        .get();

    List<DocumentSnapshot> tempList = collectionSnapshot.docs;
    List<Map<String, dynamic>> list =
        tempList.map((DocumentSnapshot docSnapshot) {
      return docSnapshot.data() as Map<String, dynamic>;
    }).toList();

    return list;
  }

  double getTotalOrderAmount({
    required List<Service> cartServices,
    required List<Map<String, dynamic>> outletServiceMenu,
  }) {
    double orderAmount = 0;
    for (int i = 0; i < cartServices.length; i++) {
      for (int j = 0; j < cartServices[i].items.length; j++) {
        String itemName = cartServices[i].items[j].name;
        int itemQuantity = cartServices[i].items[j].quantity;
        orderAmount += (outletServiceMenu[i][itemName] as int) * (itemQuantity);
      }
    }
    debugPrint(orderAmount.toString());
    return orderAmount;
  }
}
