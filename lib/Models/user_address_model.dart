class UserAddressModel {
  final double userLatitude;
  final double userLongitude;
  final String userLiveAddress;
  final String userLivePincode;
  final String userManualAddress;
  final String userManualPincode;
  UserAddressModel({
    required this.userLatitude,
    required this.userLongitude,
    required this.userLiveAddress,
    required this.userLivePincode,
    required this.userManualAddress,
    required this.userManualPincode,
  });

  UserAddressModel copyWith({
    double? userLatitude,
    double? userLongitude,
    String? userLiveAddress,
    String? userLivePincode,
    String? userManualAddress,
    String? userManualPincode,
  }) {
    return UserAddressModel(
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      userLiveAddress: userLiveAddress ?? this.userLiveAddress,
      userLivePincode: userLivePincode ?? this.userLivePincode,
      userManualAddress: userManualAddress ?? this.userManualAddress,
      userManualPincode: userManualPincode ?? this.userManualPincode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userLatitude': userLatitude,
      'userLongitude': userLongitude,
      'userLiveAddress': userLiveAddress,
      'userLivePincode': userLivePincode,
      'userManualAddress': userManualAddress,
      'userManualPincode': userManualPincode,
    };
  }

  factory UserAddressModel.fromMap(Map<String, dynamic> map) {
    return UserAddressModel(
      userLatitude: map['userLatitude'] as double,
      userLongitude: map['userLongitude'] as double,
      userLiveAddress: map['userLiveAddress'] as String,
      userLivePincode: map['userLivePincode'] as String,
      userManualAddress: map['userManualAddress'] as String,
      userManualPincode: map['userManualPincode'] as String,
    );
  }
}
