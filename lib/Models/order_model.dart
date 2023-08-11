class OrderModel {
  final String userUid;
  final String vendorUid;
  final String orderId;
  final DateTime orderReceivingTime;
  final DateTime orderPickUpTime;
  final DateTime orderDeliveryTime;
  final String paymentMode;
  final String orderStatus;
  final double orderAmount;
  final int itemCount;
  OrderModel({
    required this.userUid,
    required this.vendorUid,
    required this.orderId,
    required this.orderReceivingTime,
    required this.orderPickUpTime,
    required this.orderDeliveryTime,
    required this.paymentMode,
    required this.orderStatus,
    required this.orderAmount,
    required this.itemCount,
  });

  OrderModel copyWith({
    String? userUid,
    String? vendorUid,
    String? orderId,
    DateTime? orderReceivingTime,
    DateTime? orderPickUpTime,
    DateTime? orderDeliveryTime,
    String? paymentMode,
    String? orderStatus,
    double? orderAmount,
    int? itemCount,
  }) {
    return OrderModel(
      userUid: userUid ?? this.userUid,
      vendorUid: vendorUid ?? this.vendorUid,
      orderId: orderId ?? this.orderId,
      orderReceivingTime: orderReceivingTime ?? this.orderReceivingTime,
      orderPickUpTime: orderPickUpTime ?? this.orderPickUpTime,
      orderDeliveryTime: orderDeliveryTime ?? this.orderDeliveryTime,
      paymentMode: paymentMode ?? this.paymentMode,
      orderStatus: orderStatus ?? this.orderStatus,
      orderAmount: orderAmount ?? this.orderAmount,
      itemCount: itemCount ?? this.itemCount,
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
      'paymentMode': paymentMode,
      'orderStatus': orderStatus,
      'orderAmount': orderAmount,
      'itemCount': itemCount,
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
      paymentMode: map['paymentMode'] as String,
      orderStatus: map['orderStatus'] as String,
      orderAmount: map['orderAmount'] as double,
      itemCount: map['itemCount'] as int,
    );
  }
}
