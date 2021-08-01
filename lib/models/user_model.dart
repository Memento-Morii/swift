// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.userImage,
    this.siteName,
    this.blockNumber,
    this.houseNumber,
    this.isServiceProvider,
  });

  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  dynamic userImage;
  String siteName;
  String blockNumber;
  String houseNumber;
  int isServiceProvider;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        userImage: json["user_image"],
        siteName: json["site_name"],
        blockNumber: json["block_number"],
        houseNumber: json["house_number"],
        isServiceProvider: json["is_service_provider"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "user_image": userImage,
        "site_name": siteName,
        "block_number": blockNumber,
        "house_number": houseNumber,
        "is_service_provider": isServiceProvider,
      };
}
