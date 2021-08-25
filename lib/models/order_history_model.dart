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
        "service": service.toJson(),
        "service_category": serviceCategory.toJson(),
      };
}

class Service {
  Service({
    this.id,
    this.status,
    this.name,
    this.image,
    this.serviceId,
  });

  int id;
  int status;
  String name;
  String image;
  int serviceId;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        status: json["status"],
        name: json["name"],
        image: json["image"],
        serviceId: json["service_id"] == null ? null : json["service_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "name": name,
        "image": image,
        "service_id": serviceId == null ? null : serviceId,
      };
}
