// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  OrderDetailsModel({
    this.id,
    this.userId,
    this.serviceProviderId,
    this.serviceId,
    this.serviceCategoryId,
    this.serviceProvider,
    this.orderDetail,
  });

  int id;
  int userId;
  int serviceProviderId;
  int serviceId;
  int serviceCategoryId;
  ServiceProvider serviceProvider;
  OrderDetail orderDetail;

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
        id: json["id"],
        userId: json["user_id"],
        serviceProviderId: json["service_provider_id"],
        serviceId: json["service_id"],
        serviceCategoryId: json["service_category_id"],
        serviceProvider: ServiceProvider.fromJson(json["service_provider"]),
        orderDetail: OrderDetail.fromJson(json["order_detail"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "service_provider_id": serviceProviderId,
        "service_id": serviceId,
        "service_category_id": serviceCategoryId,
        "service_provider": serviceProvider.toJson(),
        "order_detail": orderDetail.toJson(),
      };
}

class OrderDetail {
  OrderDetail({
    this.id,
    this.uuid,
    this.orderId,
    this.userHouseNumber,
    this.latLng,
    this.userSiteName,
    this.userBlockNumber,
    this.serviceProviderAddress,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String uuid;
  int orderId;
  String userHouseNumber;
  dynamic latLng;
  String userSiteName;
  String userBlockNumber;
  dynamic serviceProviderAddress;
  DateTime createdAt;
  DateTime updatedAt;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        id: json["id"],
        uuid: json["uuid"],
        orderId: json["order_id"],
        userHouseNumber: json["user_house_number"],
        latLng: json["lat_lng"],
        userSiteName: json["user_site_name"],
        userBlockNumber: json["user_block_number"],
        serviceProviderAddress: json["service_provider_address"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "order_id": orderId,
        "user_house_number": userHouseNumber,
        "lat_lng": latLng,
        "user_site_name": userSiteName,
        "user_block_number": userBlockNumber,
        "service_provider_address": serviceProviderAddress,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class ServiceProvider {
  ServiceProvider({
    this.id,
    this.userId,
    this.description,
    this.document,
    this.lat,
    this.lng,
    this.address,
    this.priceRangeFrom,
    this.priceRangeTo,
    this.timeRangeFrom,
    this.timeRangeTo,
    this.serviceId,
    this.serviceCategoryId,
    this.status,
    this.user,
  });

  int id;
  int userId;
  String description;
  Document document;
  double lat;
  double lng;
  String address;
  int priceRangeFrom;
  int priceRangeTo;
  String timeRangeFrom;
  String timeRangeTo;
  int serviceId;
  int serviceCategoryId;
  int status;
  User user;

  factory ServiceProvider.fromJson(Map<String, dynamic> json) => ServiceProvider(
        id: json != null ? json["id"] : null,
        userId: json["user_id"],
        description: json["description"],
        document: Document.fromJson(json["document"]),
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        address: json["address"],
        priceRangeFrom: json["price_range_from"],
        priceRangeTo: json["price_range_to"],
        timeRangeFrom: json["time_range_from"],
        timeRangeTo: json["time_range_to"],
        serviceId: json["service_id"],
        serviceCategoryId: json["service_category_id"],
        status: json["status"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "description": description,
        "document": document.toJson(),
        "lat": lat,
        "lng": lng,
        "address": address,
        "price_range_from": priceRangeFrom,
        "price_range_to": priceRangeTo,
        "time_range_from": timeRangeFrom,
        "time_range_to": timeRangeTo,
        "service_id": serviceId,
        "service_category_id": serviceCategoryId,
        "status": status,
        "user": user.toJson(),
      };
}

class Document {
  Document({
    this.type,
    this.data,
  });

  String type;
  List<int> data;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        type: json != null ? json["type"] : null,
        data: json != null ? List<int>.from(json["data"].map((x) => x)) : null,
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}

class User {
  User({
    this.id,
    this.uuid,
    this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.userImage,
    this.siteName,
    this.blockNumber,
    this.houseNumber,
    this.status,
    this.isServiceProvider,
  });

  int id;
  String uuid;
  String email;
  String firstName;
  String lastName;
  String phoneNumber;
  dynamic userImage;
  String siteName;
  String blockNumber;
  String houseNumber;
  int status;
  int isServiceProvider;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        uuid: json["uuid"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phoneNumber: json["phone_number"],
        userImage: json["user_image"],
        siteName: json["site_name"],
        blockNumber: json["block_number"],
        houseNumber: json["house_number"],
        status: json["status"],
        isServiceProvider: json["is_service_provider"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "user_image": userImage,
        "site_name": siteName,
        "block_number": blockNumber,
        "house_number": houseNumber,
        "status": status,
        "is_service_provider": isServiceProvider,
      };
}
