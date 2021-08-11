// To parse this JSON data, do
//
//     final serviceCategoryModel = serviceCategoryModelFromJson(jsonString);

import 'dart:convert';

List<ServiceCategoryModel> serviceCategoryModelFromJson(String str) =>
    List<ServiceCategoryModel>.from(json.decode(str).map((x) => ServiceCategoryModel.fromJson(x)));

String serviceCategoryModelToJson(List<ServiceCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceCategoryModel {
  ServiceCategoryModel({
    this.id,
    this.name,
    this.serviceId,
    this.image,
  });

  int id;
  String name;
  int serviceId;
  String image;

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) => ServiceCategoryModel(
        id: json["id"],
        name: json["name"],
        serviceId: json["service_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "service_id": serviceId,
        "image": image,
      };
}
