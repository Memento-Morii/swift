// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

List<ServiceModel> serviceModelFromJson(String str) =>
    List<ServiceModel>.from(json.decode(str).map((x) => ServiceModel.fromJson(x)));

String serviceModelToJson(List<ServiceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceModel {
  ServiceModel({
    this.id,
    this.name,
    this.image,
    this.serviceCategories,
    this.serviceId,
  });

  int id;
  String name;
  String image;
  List<ServiceModel> serviceCategories;
  int serviceId;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        serviceCategories: json["service_categories"] == null
            ? null
            : List<ServiceModel>.from(
                json["service_categories"].map((x) => ServiceModel.fromJson(x))),
        serviceId: json["service_id"] == null ? null : json["service_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "service_categories": serviceCategories == null
            ? null
            : List<dynamic>.from(serviceCategories.map((x) => x.toJson())),
        "service_id": serviceId == null ? null : serviceId,
      };
}
