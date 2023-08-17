class UserModel {
  final String username;
  final String userEmail;
  final String userUid;
  final String userMobileNumber;
  final double userLatitude;
  final double userLongitude;
  final String userManualAddress;
  final String userManualPincode;
  final String userLiveAddress;
  final String userLivePincode;
  UserModel({
    required this.username,
    required this.userEmail,
    required this.userUid,
    required this.userMobileNumber,
    required this.userLatitude,
    required this.userLongitude,
    required this.userManualAddress,
    required this.userManualPincode,
    required this.userLiveAddress,
    required this.userLivePincode,
  });

  UserModel copyWith({
    String? username,
    String? userEmail,
    String? userUid,
    String? userMobileNumber,
    double? userLatitude,
    double? userLongitude,
    String? userManualAddress,
    String? userManualPincode,
    String? userLiveAddress,
    String? userLivePincode,
  }) {
    return UserModel(
      username: username ?? this.username,
      userEmail: userEmail ?? this.userEmail,
      userUid: userUid ?? this.userUid,
      userMobileNumber: userMobileNumber ?? this.userMobileNumber,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      userManualAddress: userManualAddress ?? this.userManualAddress,
      userManualPincode: userManualPincode ?? this.userManualPincode,
      userLiveAddress: userLiveAddress ?? this.userLiveAddress,
      userLivePincode: userLivePincode ?? this.userLivePincode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'userEmail': userEmail,
      'userUid': userUid,
      'userMobileNumber': userMobileNumber,
      'userLatitude': userLatitude,
      'userLongitude': userLongitude,
      'userManualAddress': userManualAddress,
      'userManualPincode': userManualPincode,
      'userLiveAddress': userLiveAddress,
      'userLivePincode': userLivePincode,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      userEmail: map['userEmail'] as String,
      userUid: map['userUid'] as String,
      userMobileNumber: map['userMobileNumber'] as String,
      userLatitude: map['userLatitude'] as double,
      userLongitude: map['userLongitude'] as double,
      userManualAddress: map['userManualAddress'] as String,
      userManualPincode: map['userManualPincode'] as String,
      userLiveAddress: map['userLiveAddress'] as String,
      userLivePincode: map['userLivePincode'] as String,
    );
  }
}
