import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/user_address_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';

class DataController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserModel> getUserModelData(
      {required BuildContext context, required User currentUser}) async {
    DocumentSnapshot userDoc =
        await _firestore.collection("users").doc(currentUser.uid).get();
    UserModel userModel =
        UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    return userModel;
  }

  Future<void> addUserAddress({
    required UserAddressModel userAddressModel,
    required BuildContext context,
  }) async {
    try {
      UserModel userModel =
          await getUserModelData(context: context, currentUser: currentUser!);

      List<UserAddressModel> userAddressList = userModel.userAddressList;
      userAddressList.add(userAddressModel);

      UserModel updatedUserModel = UserModel(
        username: userModel.username,
        userEmail: userModel.userEmail,
        userUid: userModel.userUid,
        userMobileNumber: userModel.userMobileNumber,
        userDeviceToken: userModel.userDeviceToken,
        primaryAddressIndex: userModel.primaryAddressIndex,
        userAddressList: userAddressList,
      );

      await _firestore
          .collection("users")
          .doc(currentUser!.uid)
          .update(updatedUserModel.toMap())
          .then((value) {
        showCustomToast(text: "Address Added sucessfully");
        return Navigator.of(context).pop();
      });
    } on FirebaseException catch (e) {
      showCustomDialog(
        context: context,
        title: "Error",
        message: e.message!,
      );
    }
  }

  Future<void> editUserAddress({
    required BuildContext context,
    required int selectedAddressIndex,
    required UserAddressModel updatedUserAddressModel,
  }) async {
    try {
      UserModel userModel =
          await getUserModelData(context: context, currentUser: currentUser!);

      List<UserAddressModel> userAddressList = userModel.userAddressList;
      userAddressList[selectedAddressIndex] = updatedUserAddressModel;

      UserModel updatedUserModel = UserModel(
        username: userModel.username,
        userEmail: userModel.userEmail,
        userUid: userModel.userUid,
        userMobileNumber: userModel.userMobileNumber,
        userDeviceToken: userModel.userDeviceToken,
        primaryAddressIndex: userModel.primaryAddressIndex,
        userAddressList: userAddressList,
      );

      await _firestore
          .collection("users")
          .doc(currentUser!.uid)
          .update(updatedUserModel.toMap())
          .then((value) {
        showCustomToast(text: "Address Added sucessfully");
        return Navigator.of(context).pop();
      });
    } on FirebaseException catch (e) {
      showCustomDialog(
        context: context,
        title: "Error",
        message: e.message!,
      );
    }
  }

  Future<void> deleteUserAddress({
    required BuildContext context,
    required int selectedAddressIndex,
  }) async {
    try {
      UserModel userModel =
          await getUserModelData(context: context, currentUser: currentUser!);

      List<UserAddressModel> userAddressList = [];
      for (int idx = 0; idx < userModel.userAddressList.length; idx++) {
        if (selectedAddressIndex != idx) {
          userAddressList.add(userModel.userAddressList[idx]);
        }
      }

      UserModel updatedUserModel = UserModel(
        username: userModel.username,
        userEmail: userModel.userEmail,
        userUid: userModel.userUid,
        userMobileNumber: userModel.userMobileNumber,
        userDeviceToken: userModel.userDeviceToken,
        primaryAddressIndex: userModel.primaryAddressIndex,
        userAddressList: userAddressList,
      );

      await _firestore
          .collection("users")
          .doc(currentUser!.uid)
          .update(updatedUserModel.toMap())
          .then((value) {
        showCustomToast(text: "Address Added sucessfully");
        return Navigator.of(context).pop();
      });
    } on FirebaseException catch (e) {
      showCustomDialog(
        context: context,
        title: "Error",
        message: e.message!,
      );
    }
  }

  Future<void> updateUserPrimaryAddressIndex({
    required BuildContext context,
    required int updatedPrimaryAddressIndex,
  }) async {
    try {
      await _firestore
          .collection("users")
          .doc(currentUser!.uid)
          .update({'primaryAddressIndex': updatedPrimaryAddressIndex});

      showCustomToast(text: "Primary Address updated sucessfully");
    } on FirebaseException catch (e) {
      showCustomDialog(
        context: context,
        title: "Error",
        message: e.message!,
      );
    }
  }

  Stream<VendorModel> getVendorData({
    required String vendorUid,
  }) {
    return _firestore
        .collection("vendors")
        .doc(vendorUid)
        .snapshots()
        .map((event) => VendorModel.fromMap(
              event.data() as Map<String, dynamic>,
            ));
  }

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
          showCustomDialog(
            context: context,
            title: "Location Error",
            message: e.toString(),
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
        .collection("outletServices")
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
    // debugPrint(orderAmount.toString());
    return orderAmount;
  }
}
