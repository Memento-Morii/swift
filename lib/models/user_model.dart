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
    this.latLng,
    this.blockNumber,
    this.houseNumber,
    this.isServiceProvider,
    this.lat,
    this.lng,
  });

  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  String userImage;
  String siteName;
  LatLng latLng;
  String blockNumber;
  String houseNumber;
  int isServiceProvider;
  double lng;
  double lat;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        userImage: json["user_image"],
        siteName: json["site_name"],
        latLng: LatLng.fromJson(json["lat_lng"]),
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
        "lat_lng": latLng.toJson(),
        "block_number": blockNumber,
        "house_number": houseNumber,
        "is_service_provider": isServiceProvider,
      };
}

class LatLng {
  LatLng({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory LatLng.fromJson(Map<String, dynamic> json) => LatLng(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
