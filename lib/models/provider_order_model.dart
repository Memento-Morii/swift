// To parse this JSON data, do
//
//     final providerOrderModel = providerOrderModelFromJson(jsonString);

import 'dart:convert';

List<ProviderOrderModel> providerOrderModelFromJson(String str) =>
    List<ProviderOrderModel>.from(json.decode(str).map((x) => ProviderOrderModel.fromJson(x)));

String providerOrderModelToJson(List<ProviderOrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProviderOrderModel {
  ProviderOrderModel({
    this.id,
    this.orderId,
    this.userId,
    this.serviceProviderId,
    this.serviceReceiveTime,
    this.isNew,
    this.service,
    this.serviceCategory,
  });

  int id;
  String orderId;
  int userId;
  int serviceProviderId;
  DateTime serviceReceiveTime;
  bool isNew;
  Service service;
  Service serviceCategory;

  factory ProviderOrderModel.fromJson(Map<String, dynamic> json) => ProviderOrderModel(
        id: json["id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        serviceProviderId: json["service_provider_id"],
        serviceReceiveTime: DateTime.parse(json["service_receive_time"]),
        isNew: json["is_new"],
        service: Service.fromJson(json["service"]),
        serviceCategory: Service.fromJson(json["service_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "user_id": userId,
        "service_provider_id": serviceProviderId,
        "service_receive_time": serviceReceiveTime.toIso8601String(),
        "is_new": isNew,
        "service": service.toJson(),
        "service_category": serviceCategory.toJson(),
      };
}

class Service {
  Service({
    this.id,
    this.image,
    this.name,
  });

  int id;
  String image;
  String name;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
      };
}
