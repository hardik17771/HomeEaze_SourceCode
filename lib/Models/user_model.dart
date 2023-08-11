class UserModel {
  final String username;
  final String userEmail;
  final String userUid;
  final String userMobileNumber;
  final double userLatitude;
  final double userLongitude;
  final String userAddress;
  final String userPincode;
  UserModel({
    required this.username,
    required this.userEmail,
    required this.userUid,
    required this.userMobileNumber,
    required this.userLatitude,
    required this.userLongitude,
    required this.userAddress,
    required this.userPincode,
  });

  UserModel copyWith({
    String? username,
    String? userEmail,
    String? userUid,
    String? userMobileNumber,
    double? userLatitude,
    double? userLongitude,
    String? userAddress,
    String? userPincode,
  }) {
    return UserModel(
      username: username ?? this.username,
      userEmail: userEmail ?? this.userEmail,
      userUid: userUid ?? this.userUid,
      userMobileNumber: userMobileNumber ?? this.userMobileNumber,
      userLatitude: userLatitude ?? this.userLatitude,
      userLongitude: userLongitude ?? this.userLongitude,
      userAddress: userAddress ?? this.userAddress,
      userPincode: userPincode ?? this.userPincode,
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
      'userAddress': userAddress,
      'userPincode': userPincode,
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
      userAddress: map['userAddress'] as String,
      userPincode: map['userPincode'] as String,
    );
  }
}
