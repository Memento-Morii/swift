import 'dart:convert';

List<LocationModel> locationModelFromJson(String str) =>
    List<LocationModel>.from(json.decode(str).map((x) => LocationModel.fromJson(x)));

String locationModelToJson(List<LocationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocationModel {
  LocationModel({
    this.name,
    this.lat,
    this.lng,
  });

  String name;
  double lat;
  double lng;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        name: json["name"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lat": lat,
        "lng": lng,
      };
}
