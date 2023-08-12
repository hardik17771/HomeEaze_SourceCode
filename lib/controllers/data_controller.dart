import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/order_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/orders/order_placed_page.dart';
import 'package:uuid/uuid.dart';

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
          debugPrint(e.toString());
        }
      }
      return vendors;
    });
  }

  // Calculate basket Amoount based on Vendor
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

  // Place order
  Future placeOrder({
    required BuildContext context,
    required UserModel userModel,
    required VendorModel vendorModel,
    required List<Service> cartServices,
    required int itemCount,
    required double orderAmount,
  }) async {
    final orderId = const Uuid().v1();
    final OrderModel order = OrderModel(
      userUid: userModel.userUid,
      vendorUid: vendorModel.vendorUid,
      orderId: orderId,
      orderReceivingTime: DateTime.now(),
      orderPickUpTime: DateTime.now(),
      orderDeliveryTime: DateTime.now(),
      paymentMode: "Cash On Delivery",
      orderStatus: "Waiting",
      orderAmount: orderAmount,
      itemCount: itemCount,
    );

    try {
      await _firestore.collection("orders").doc(orderId).set(order.toMap());

      // cartServices to db in "orderServices"

      // set all services to 0 quantity
      for (int i = 0; i < services.length; i++) {
        for (int j = 0; j < services[i].items.length; j++) {
          services[i].items[j].quantity = 0;
        }
      }

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const OrderPlacedPage();
          },
        ),
      );
    } on FirebaseException catch (e) {
      showSnackBar(
        context: context,
        text: e.message!,
      );
    }
  }

  Stream<List<OrderModel>> fetchUserOrdersData({required String userUid}) {
    return _firestore
        .collection("orders")
        .where('userUid', isEqualTo: userUid)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => OrderModel.fromMap(e.data())).toList());
  }
}
