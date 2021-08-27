// To parse this JSON data, do
//
//     final myServicesModel = myServicesModelFromJson(jsonString);

import 'dart:convert';

List<MyServicesModel> myServicesModelFromJson(String str) =>
    List<MyServicesModel>.from(json.decode(str).map((x) => MyServicesModel.fromJson(x)));

String myServicesModelToJson(List<MyServicesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyServicesModel {
  MyServicesModel({
    this.id,
    this.uuid,
    this.lat,
    this.lng,
    this.description,
    this.document,
    this.address,
    this.priceRangeFrom,
    this.priceRangeTo,
    this.timeRangeFrom,
    this.timeRangeTo,
    this.status,
    this.service,
    this.serviceCategory,
  });

  int id;
  String uuid;
  double lat;
  double lng;
  String description;
  dynamic document;
  String address;
  double priceRangeFrom;
  double priceRangeTo;
  String timeRangeFrom;
  String timeRangeTo;
  int status;
  Service service;
  Service serviceCategory;

  factory MyServicesModel.fromJson(Map<String, dynamic> json) => MyServicesModel(
        id: json["id"],
        uuid: json["uuid"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        description: json["description"],
        document: json["document"],
        address: json["address"],
        priceRangeFrom: json["price_range_from"].toDouble(),
        priceRangeTo: json["price_range_to"].toDouble(),
        timeRangeFrom: json["time_range_from"],
        timeRangeTo: json["time_range_to"],
        status: json["status"],
        service: Service.fromJson(json["service"]),
        serviceCategory: Service.fromJson(json["service_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "lat": lat,
        "lng": lng,
        "description": description,
        "document": document,
        "address": address,
        "price_range_from": priceRangeFrom,
        "price_range_to": priceRangeTo,
        "time_range_from": timeRangeFrom,
        "time_range_to": timeRangeTo,
        "status": status,
        "service": service.toJson(),
        "service_category": serviceCategory.toJson(),
      };
}

class Service {
  Service({
    this.id,
    this.uuid,
    this.name,
    this.serviceId,
  });

  int id;
  String uuid;
  String name;
  int serviceId;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        serviceId: json["service_id"] == null ? null : json["service_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "service_id": serviceId == null ? null : serviceId,
      };
}
