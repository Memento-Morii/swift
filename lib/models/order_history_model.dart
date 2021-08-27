// To parse this JSON data, do
//
//     final orderHistoryModel = orderHistoryModelFromJson(jsonString);

import 'dart:convert';

List<OrderHistoryModel> orderHistoryModelFromJson(String str) =>
    List<OrderHistoryModel>.from(json.decode(str).map((x) => OrderHistoryModel.fromJson(x)));

String orderHistoryModelToJson(List<OrderHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderHistoryModel {
  OrderHistoryModel({
    this.id,
    this.orderId,
    this.userId,
    this.serviceProviderId,
    this.serviceId,
    this.serviceCategoryId,
    this.serviceReceiveTime,
    this.orderHistory,
    this.service,
    this.serviceCategory,
  });

  int id;
  String orderId;
  int userId;
  dynamic serviceProviderId;
  int serviceId;
  int serviceCategoryId;
  DateTime serviceReceiveTime;
  OrderHistory orderHistory;
  Service service;
  Service serviceCategory;

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) => OrderHistoryModel(
        id: json["id"],
        orderId: json["order_id"],
        userId: json["user_id"],
        serviceProviderId: json["service_provider_id"],
        serviceId: json["service_id"],
        serviceCategoryId: json["service_category_id"],
        serviceReceiveTime: DateTime.parse(json["service_receive_time"]),
        orderHistory: OrderHistory.fromJson(json["order_history"]),
        service: Service.fromJson(json["service"]),
        serviceCategory: Service.fromJson(json["service_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "user_id": userId,
        "service_provider_id": serviceProviderId,
        "service_id": serviceId,
        "service_category_id": serviceCategoryId,
        "service_receive_time": serviceReceiveTime.toIso8601String(),
        "order_history": orderHistory.toJson(),
        "service": service.toJson(),
        "service_category": serviceCategory.toJson(),
      };
}

class OrderHistory {
  OrderHistory({
    this.id,
    this.status,
  });

  int id;
  int status;

  factory OrderHistory.fromJson(Map<String, dynamic> json) => OrderHistory(
        id: json["id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
      };
}

class Service {
  Service({
    this.name,
    this.image,
    this.id,
  });

  String name;
  String image;
  int id;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        name: json["name"],
        image: json["image"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "id": id,
      };
}
