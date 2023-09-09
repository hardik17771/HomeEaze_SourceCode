class VendorModel {
  final String vendorUid;
  final String vendorEmail;
  final String vendorName;
  final String outletName;
  final String vendorMobileNumber;
  final String outletMobileNumber;
  final String manualAddress;
  final String manualPincode;
  final String liveAddress;
  final String livePincode;
  final double outletRating;
  final String outletProfilePicUrl;
  final DateTime openingTime1;
  final DateTime closingTime1;
  final DateTime openingTime2;
  final DateTime closingTime2;
  final double outletLatitude;
  final double outletLongitude;
  final String vendorDeviceToken;
  final bool isDeliveryBoyAvailable;
  final List<String> outletOpenDays;
  VendorModel({
    required this.vendorUid,
    required this.vendorEmail,
    required this.vendorName,
    required this.outletName,
    required this.vendorMobileNumber,
    required this.outletMobileNumber,
    required this.manualAddress,
    required this.manualPincode,
    required this.liveAddress,
    required this.livePincode,
    required this.outletRating,
    required this.outletProfilePicUrl,
    required this.openingTime1,
    required this.closingTime1,
    required this.openingTime2,
    required this.closingTime2,
    required this.outletLatitude,
    required this.outletLongitude,
    required this.vendorDeviceToken,
    required this.isDeliveryBoyAvailable,
    required this.outletOpenDays,
  });

  VendorModel copyWith({
    String? vendorUid,
    String? vendorEmail,
    String? vendorName,
    String? outletName,
    String? vendorMobileNumber,
    String? outletMobileNumber,
    String? manualAddress,
    String? manualPincode,
    String? liveAddress,
    String? livePincode,
    double? outletRating,
    String? outletProfilePicUrl,
    DateTime? openingTime1,
    DateTime? closingTime1,
    DateTime? openingTime2,
    DateTime? closingTime2,
    double? outletLatitude,
    double? outletLongitude,
    String? vendorDeviceToken,
    bool? isDeliveryBoyAvailable,
    List<String>? outletOpenDays,
  }) {
    return VendorModel(
      vendorUid: vendorUid ?? this.vendorUid,
      vendorEmail: vendorEmail ?? this.vendorEmail,
      vendorName: vendorName ?? this.vendorName,
      outletName: outletName ?? this.outletName,
      vendorMobileNumber: vendorMobileNumber ?? this.vendorMobileNumber,
      outletMobileNumber: outletMobileNumber ?? this.outletMobileNumber,
      manualAddress: manualAddress ?? this.manualAddress,
      manualPincode: manualPincode ?? this.manualPincode,
      liveAddress: liveAddress ?? this.liveAddress,
      livePincode: livePincode ?? this.livePincode,
      outletRating: outletRating ?? this.outletRating,
      outletProfilePicUrl: outletProfilePicUrl ?? this.outletProfilePicUrl,
      openingTime1: openingTime1 ?? this.openingTime1,
      closingTime1: closingTime1 ?? this.closingTime1,
      openingTime2: openingTime2 ?? this.openingTime2,
      closingTime2: closingTime2 ?? this.closingTime2,
      outletLatitude: outletLatitude ?? this.outletLatitude,
      outletLongitude: outletLongitude ?? this.outletLongitude,
      vendorDeviceToken: vendorDeviceToken ?? this.vendorDeviceToken,
      isDeliveryBoyAvailable:
          isDeliveryBoyAvailable ?? this.isDeliveryBoyAvailable,
      outletOpenDays: outletOpenDays ?? this.outletOpenDays,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vendorUid': vendorUid,
      'vendorEmail': vendorEmail,
      'vendorName': vendorName,
      'outletName': outletName,
      'vendorMobileNumber': vendorMobileNumber,
      'outletMobileNumber': outletMobileNumber,
      'manualAddress': manualAddress,
      'manualPincode': manualPincode,
      'liveAddress': liveAddress,
      'livePincode': livePincode,
      'outletRating': outletRating,
      'outletProfilePicUrl': outletProfilePicUrl,
      'openingTime1': openingTime1.millisecondsSinceEpoch,
      'closingTime1': closingTime1.millisecondsSinceEpoch,
      'openingTime2': openingTime2.millisecondsSinceEpoch,
      'closingTime2': closingTime2.millisecondsSinceEpoch,
      'outletLatitude': outletLatitude,
      'outletLongitude': outletLongitude,
      'vendorDeviceToken': vendorDeviceToken,
      'isDeliveryBoyAvailable': isDeliveryBoyAvailable,
      'outletOpenDays': outletOpenDays,
    };
  }

  factory VendorModel.fromMap(Map<String, dynamic> map) {
    return VendorModel(
      vendorUid: map['vendorUid'] as String,
      vendorEmail: map['vendorEmail'] as String,
      vendorName: map['vendorName'] as String,
      outletName: map['outletName'] as String,
      vendorMobileNumber: map['vendorMobileNumber'] as String,
      outletMobileNumber: map['outletMobileNumber'] as String,
      manualAddress: map['manualAddress'] as String,
      manualPincode: map['manualPincode'] as String,
      liveAddress: map['liveAddress'] as String,
      livePincode: map['livePincode'] as String,
      outletRating: map['outletRating'] as double,
      outletProfilePicUrl: map['outletProfilePicUrl'] as String,
      openingTime1:
          DateTime.fromMillisecondsSinceEpoch(map['openingTime1'] as int),
      closingTime1:
          DateTime.fromMillisecondsSinceEpoch(map['closingTime1'] as int),
      openingTime2:
          DateTime.fromMillisecondsSinceEpoch(map['openingTime2'] as int),
      closingTime2:
          DateTime.fromMillisecondsSinceEpoch(map['closingTime2'] as int),
      outletLatitude: map['outletLatitude'] as double,
      outletLongitude: map['outletLongitude'] as double,
      vendorDeviceToken: map['vendorDeviceToken'] as String,
      isDeliveryBoyAvailable: map['isDeliveryBoyAvailable'] as bool,
      outletOpenDays: List<String>.from(map['outletOpenDays']),
    );
  }
}
