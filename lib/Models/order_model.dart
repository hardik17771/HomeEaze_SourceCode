class OrderModel {
  final String userUid;
  final String vendorUid;
  final String orderId;
  final DateTime orderDateTime;
  OrderModel({
    required this.userUid,
    required this.vendorUid,
    required this.orderId,
    required this.orderDateTime,
  });

  OrderModel copyWith({
    String? userUid,
    String? vendorUid,
    String? orderId,
    DateTime? orderDateTime,
  }) {
    return OrderModel(
      userUid: userUid ?? this.userUid,
      vendorUid: vendorUid ?? this.vendorUid,
      orderId: orderId ?? this.orderId,
      orderDateTime: orderDateTime ?? this.orderDateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userUid': userUid,
      'vendorUid': vendorUid,
      'orderId': orderId,
      'orderDateTime': orderDateTime.millisecondsSinceEpoch,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      userUid: map['userUid'] as String,
      vendorUid: map['vendorUid'] as String,
      orderId: map['orderId'] as String,
      orderDateTime:
          DateTime.fromMillisecondsSinceEpoch(map['orderDateTime'] as int),
    );
  }
}
