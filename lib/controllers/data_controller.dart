import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:uuid/uuid.dart';

class DataController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future putVendorOutletData(BuildContext context) async {
    // Currently Static Data which need to be taken by outlet form vendor App form
    final vendorData = VendorModel(
      vendorName: "Thorat",
      outletName: "Thorat Laundry",
      vendorMobileNumber: "9898989898",
      outletMobileNumber: "9898989898",
      outletAddress: "Kalyani Nagar, Pune",
      outletRating: 4.5,
      outletProfilePicUrl: "outletPhotoPicUrl",
      openingTime1: DateTime(9, 30),
      closingTime1: DateTime(1, 30),
      openingTime2: DateTime(3, 30),
      closingTime2: DateTime(9, 30),
      outletLatitude: 22.5,
      outletLongitude: 10.5,
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

  Stream<Object>? fetchvendorOutletData() {
    return _firestore.collection("vendors").snapshots();
  }
}
