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
    this.serviceReceiveTime,
    this.service,
    this.serviceCategory,
    this.orderHistory,
  });

  int id;
  String orderId;
  DateTime serviceReceiveTime;
  Service service;
  Service serviceCategory;
  OrderHistory orderHistory;

  factory ProviderOrderModel.fromJson(Map<String, dynamic> json) => ProviderOrderModel(
        id: json["id"],
        orderId: json["order_id"],
        serviceReceiveTime: DateTime.parse(json["service_receive_time"]),
        service: Service.fromJson(json["service"]),
        serviceCategory: Service.fromJson(json["service_category"]),
        orderHistory: OrderHistory.fromJson(json["order_history"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "service_receive_time": serviceReceiveTime.toIso8601String(),
        "service": service.toJson(),
        "service_category": serviceCategory.toJson(),
        "order_history": orderHistory.toJson(),
      };
}

class OrderHistory {
  OrderHistory({
    this.status,
  });

  int status;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
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
