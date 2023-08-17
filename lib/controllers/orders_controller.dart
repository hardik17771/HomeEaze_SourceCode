import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/order_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/orders/order_placed_page.dart';
import 'package:uuid/uuid.dart';

class OrdersController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Place order
  Future placeOrder({
    required BuildContext context,
    required UserModel userModel,
    required VendorModel vendorModel,
    required List<Service> cartServices,
    required List<Map<String, dynamic>> outletServiceMenu,
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

      // [cartServices, outletServiceMenu] to db in "orderServices"
      for (int i = 0; i < cartServices.length; i++) {
        Map<String, dynamic> itemQuantityPrice = {};
        for (int j = 0; j < cartServices[i].selectedItems.length; j++) {
          String itemName = cartServices[i].selectedItems[j].name;
          int itemQuantity = cartServices[i].selectedItems[j].quantity;
          int itemPrice = outletServiceMenu[i][itemName];
          itemQuantityPrice[itemName] = [itemQuantity, itemPrice];
        }
        await _firestore
            .collection("orderServices")
            .doc(orderId)
            .collection("services")
            .doc(cartServices[i].name)
            .set(itemQuantityPrice);
      }

      // set all services to 0 quantity
      for (int i = 0; i < services.length; i++) {
        for (int j = 0; j < services[i].items.length; j++) {
          services[i].items[j].quantity = 0;
        }
      }
      for (int i = 0; i < services.length; i++) {
        services[i].selectedItems = [];
      }

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) {
            return const OrderPlacedPage();
          },
        ),
        (route) => false,
      );
    } on FirebaseException catch (e) {
      showAlertDialogBox(
        context: context,
        title: "Error placing order",
        message: e.message!,
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

  Stream<VendorModel> getVendorData({required String vendorUid}) {
    return _firestore
        .collection("vendors")
        .doc(vendorUid)
        .snapshots()
        .map((event) => VendorModel.fromMap(
              event.data() as Map<String, dynamic>,
            ));
  }

  Future<List<Map<String, dynamic>>> fetchOrderSummary({
    required String orderId,
  }) async {
    QuerySnapshot collectionSnapshot = await _firestore
        .collection("orderServices")
        .doc(orderId)
        .collection("services")
        .get();

    List<DocumentSnapshot> tempList = collectionSnapshot.docs;
    List<Map<String, dynamic>> list =
        tempList.map((DocumentSnapshot docSnapshot) {
      return docSnapshot.data() as Map<String, dynamic>;
    }).toList();

    return list;
  }
}
