// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

ServiceModel serviceModelFromJson(String str) =>
    ServiceModel.fromJson(json.decode(str));

String serviceModelToJson(ServiceModel data) => json.encode(data.toJson());

class ServiceModel {
  ServiceModel({
    this.success,
    this.results,
  });

  bool success;
  List<Result> results;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        success: json["success"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.uuid,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.serviceCategories,
    this.serviceId,
  });

  int id;
  String uuid;
  String name;
  String image;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<Result> serviceCategories;
  int serviceId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        uuid: json["uuid"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        serviceCategories: json["service_categories"] == null
            ? null
            : List<Result>.from(
                json["service_categories"].map((x) => Result.fromJson(x))),
        serviceId: json["service_id"] == null ? null : json["service_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "name": name,
        "image": image,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "service_categories": serviceCategories == null
            ? null
            : List<dynamic>.from(serviceCategories.map((x) => x.toJson())),
        "service_id": serviceId == null ? null : serviceId,
      };
}
