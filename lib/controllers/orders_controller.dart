import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:homeeaze_sourcecode/controllers/cart_controller.dart';
import 'package:homeeaze_sourcecode/controllers/notification_controller.dart';
import 'package:homeeaze_sourcecode/core/utils.dart';
import 'package:homeeaze_sourcecode/models/cart_model.dart';
import 'package:homeeaze_sourcecode/models/order_model.dart';
import 'package:homeeaze_sourcecode/models/user_address_model.dart';
import 'package:homeeaze_sourcecode/models/user_model.dart';
import 'package:homeeaze_sourcecode/models/vendor_model.dart';
import 'package:homeeaze_sourcecode/views/orders/order_placed_page.dart';
import 'package:uuid/uuid.dart';
import 'package:vibration/vibration.dart';

class OrdersController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final NotificationController _notificationController =
      NotificationController();
  final CartController _cartController = CartController();

  Future placeOrder({
    required BuildContext context,
    required int itemCount,
    required String paymentMode,
    required String pickUpTimeSlot,
    required UserModel userModel,
    required VendorModel vendorModel,
    required List<Service> cartServices,
    required List<Map<String, dynamic>> outletServiceMenu,
    required TransactionDetailModel transactionDetailModel,
    required UserAddressModel userAddressModel,
  }) async {
    final orderId = const Uuid().v1();

    // pickUpTimeSLot
    final OrderModel order = OrderModel(
      userUid: userModel.userUid,
      vendorUid: vendorModel.vendorUid,
      orderId: orderId,
      pickUpTimeSlot: pickUpTimeSlot,
      orderReceivingTime: DateTime.now(),
      orderPickUpTime: DateTime.now(),
      orderDeliveryTime: DateTime.now(),
      itemCount: itemCount,
      orderStatus: "To be picked up",
      orderAmount: double.parse(transactionDetailModel.amount!),
      paymentMode: paymentMode,
      paymentTransactionId: transactionDetailModel.transactionId!,
      paymentTransactionRefId: transactionDetailModel.transactionRefId!,
      paymentResponseCode: transactionDetailModel.responseCode!,
      paymentApprovalRefNo: (transactionDetailModel.approvalRefNo == null)
          ? transactionDetailModel.transactionId!
          : transactionDetailModel.approvalRefNo!,
      userAddressModel: userAddressModel,
    );

    try {
      // orders -> orderId -> orderModel
      await _firestore.collection("orders").doc(orderId).set(order.toMap());

      // orderServices -> orderId -> services -> serviceName-> Map<ItemName, <Array>[ItemQuantity, ItemPrice]>
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

      // remove all items from cartController
      for (int idx = 0; idx < services.length; idx++) {
        bool isServiceExist =
            await _cartController.isServiceExist(services[idx].name);
        if (isServiceExist) {
          _cartController.remove(services[idx].name);
        }
      }

      await _notificationController.sendOrderNotification(
        orderModel: order,
        orderStatus: "New Order Recieved",
        userModel: userModel,
        vendorModel: vendorModel,
      );

      bool? checkPermission = await Vibration.hasVibrator();
      if (checkPermission == true) {
        Vibration.vibrate();
        await Future.delayed(const Duration(milliseconds: 1000));
        Vibration.vibrate();
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
      showCustomDialog(
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
        .orderBy('orderReceivingTime', descending: true)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => OrderModel.fromMap(e.data())).toList());
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

  Future<TransactionDetailModel?> makeUPIPayment({
    required BuildContext context,
    required double amount,
    required String payeeVpa,
  }) async {
    try {
      TransactionDetailModel? transactionDetailModel =
          await EasyUpiPaymentPlatform.instance.startPayment(
        EasyUpiPaymentModel(
          payeeVpa: payeeVpa, // Change UPI
          payeeName: 'Droby', // Change NAME
          amount: amount,
          description: 'Droby Payment',
        ),
      );

      return transactionDetailModel;
    } on EasyUpiPaymentException catch (e) {
      showCustomDialog(
        context: context,
        title: "Payment Error",
        message: e.message!,
      );
    }
  }
}
