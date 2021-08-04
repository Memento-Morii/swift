// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    this.serviceProviderId,
    this.serviceId,
    this.serviceCategoryId,
    this.serviceReceiveTime,
    this.createdAt,
    this.service,
    this.serviceCategory,
  });

  int serviceProviderId;
  int serviceId;
  int serviceCategoryId;
  DateTime serviceReceiveTime;
  DateTime createdAt;
  Service service;
  Service serviceCategory;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        serviceProviderId: json["service_provider_id"],
        serviceId: json["service_id"],
        serviceCategoryId: json["service_category_id"],
        serviceReceiveTime: DateTime.parse(json["service_receive_time"]),
        createdAt: DateTime.parse(json["createdAt"]),
        service: Service.fromJson(json["service"]),
        serviceCategory: Service.fromJson(json["serviceCategory"]),
      );

  Map<String, dynamic> toJson() => {
        "service_provider_id": serviceProviderId,
        "service_id": serviceId,
        "service_category_id": serviceCategoryId,
        "service_receive_time": serviceReceiveTime.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "service": service.toJson(),
        "serviceCategory": serviceCategory.toJson(),
      };
}

class Service {
  Service({
    this.name,
    this.image,
  });

  String name;
  String image;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        name: json["name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
      };
}
