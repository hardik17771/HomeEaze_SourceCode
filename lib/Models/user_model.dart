import 'package:homeeaze_sourcecode/Models/user_address_model.dart';

class UserModel {
  final String username;
  final String userEmail;
  final String userUid;
  final String userMobileNumber;
  final String userDeviceToken;
  final int primaryAddressIndex;
  final List<UserAddressModel> userAddressList;
  UserModel({
    required this.username,
    required this.userEmail,
    required this.userUid,
    required this.userMobileNumber,
    required this.userDeviceToken,
    required this.primaryAddressIndex,
    required this.userAddressList,
  });

  UserModel copyWith({
    String? username,
    String? userEmail,
    String? userUid,
    String? userMobileNumber,
    String? userDeviceToken,
    int? primaryAddressIndex,
    List<UserAddressModel>? userAddressList,
  }) {
    return UserModel(
      username: username ?? this.username,
      userEmail: userEmail ?? this.userEmail,
      userUid: userUid ?? this.userUid,
      userMobileNumber: userMobileNumber ?? this.userMobileNumber,
      userDeviceToken: userDeviceToken ?? this.userDeviceToken,
      primaryAddressIndex: primaryAddressIndex ?? this.primaryAddressIndex,
      userAddressList: userAddressList ?? this.userAddressList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'userEmail': userEmail,
      'userUid': userUid,
      'userMobileNumber': userMobileNumber,
      'userDeviceToken': userDeviceToken,
      'primaryAddressIndex': primaryAddressIndex,
      'userAddressList': userAddressList.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      userEmail: map['userEmail'] as String,
      userUid: map['userUid'] as String,
      userMobileNumber: map['userMobileNumber'] as String,
      userDeviceToken: map['userDeviceToken'] as String,
      primaryAddressIndex: map['primaryAddressIndex'] as int,
      userAddressList: List<UserAddressModel>.from(
        (map['userAddressList'] as List<dynamic>).map<UserAddressModel>(
          (x) => UserAddressModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
