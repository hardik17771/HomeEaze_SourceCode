class OrderModel {
  final String userUid;
  final String vendorUid;
  final String orderId;
  final DateTime orderReceivingTime;
  final DateTime orderPickUpTime;
  final DateTime orderDeliveryTime;
  final int itemCount;
  final String orderStatus;
  final double orderAmount;
  final String paymentMode;
  final String paymentTransactionId;
  final String paymentTransactionRefId;
  final String paymentResponseCode;
  final String paymentApprovalRefNo;
  OrderModel({
    required this.userUid,
    required this.vendorUid,
    required this.orderId,
    required this.orderReceivingTime,
    required this.orderPickUpTime,
    required this.orderDeliveryTime,
    required this.itemCount,
    required this.orderStatus,
    required this.orderAmount,
    required this.paymentMode,
    required this.paymentTransactionId,
    required this.paymentTransactionRefId,
    required this.paymentResponseCode,
    required this.paymentApprovalRefNo,
  });

  OrderModel copyWith({
    String? userUid,
    String? vendorUid,
    String? orderId,
    DateTime? orderReceivingTime,
    DateTime? orderPickUpTime,
    DateTime? orderDeliveryTime,
    int? itemCount,
    String? orderStatus,
    double? orderAmount,
    String? paymentMode,
    String? paymentTransactionId,
    String? paymentTransactionRefId,
    String? paymentResponseCode,
    String? paymentApprovalRefNo,
  }) {
    return OrderModel(
      userUid: userUid ?? this.userUid,
      vendorUid: vendorUid ?? this.vendorUid,
      orderId: orderId ?? this.orderId,
      orderReceivingTime: orderReceivingTime ?? this.orderReceivingTime,
      orderPickUpTime: orderPickUpTime ?? this.orderPickUpTime,
      orderDeliveryTime: orderDeliveryTime ?? this.orderDeliveryTime,
      itemCount: itemCount ?? this.itemCount,
      orderStatus: orderStatus ?? this.orderStatus,
      orderAmount: orderAmount ?? this.orderAmount,
      paymentMode: paymentMode ?? this.paymentMode,
      paymentTransactionId: paymentTransactionId ?? this.paymentTransactionId,
      paymentTransactionRefId:
          paymentTransactionRefId ?? this.paymentTransactionRefId,
      paymentResponseCode: paymentResponseCode ?? this.paymentResponseCode,
      paymentApprovalRefNo: paymentApprovalRefNo ?? this.paymentApprovalRefNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userUid': userUid,
      'vendorUid': vendorUid,
      'orderId': orderId,
      'orderReceivingTime': orderReceivingTime.millisecondsSinceEpoch,
      'orderPickUpTime': orderPickUpTime.millisecondsSinceEpoch,
      'orderDeliveryTime': orderDeliveryTime.millisecondsSinceEpoch,
      'itemCount': itemCount,
      'orderStatus': orderStatus,
      'orderAmount': orderAmount,
      'paymentMode': paymentMode,
      'paymentTransactionId': paymentTransactionId,
      'paymentTransactionRefId': paymentTransactionRefId,
      'paymentResponseCode': paymentResponseCode,
      'paymentApprovalRefNo': paymentApprovalRefNo,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      userUid: map['userUid'] as String,
      vendorUid: map['vendorUid'] as String,
      orderId: map['orderId'] as String,
      orderReceivingTime:
          DateTime.fromMillisecondsSinceEpoch(map['orderReceivingTime'] as int),
      orderPickUpTime:
          DateTime.fromMillisecondsSinceEpoch(map['orderPickUpTime'] as int),
      orderDeliveryTime:
          DateTime.fromMillisecondsSinceEpoch(map['orderDeliveryTime'] as int),
      itemCount: map['itemCount'] as int,
      orderStatus: map['orderStatus'] as String,
      orderAmount: map['orderAmount'] as double,
      paymentMode: map['paymentMode'] as String,
      paymentTransactionId: map['paymentTransactionId'] as String,
      paymentTransactionRefId: map['paymentTransactionRefId'] as String,
      paymentResponseCode: map['paymentResponseCode'] as String,
      paymentApprovalRefNo: map['paymentApprovalRefNo'] as String,
    );
  }
}
