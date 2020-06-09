import 'dart:convert';

HeroeModel heroeModelFromJson(String str) =>
    HeroeModel.fromJson(json.decode(str));

String heroeModelToJson(HeroeModel data) => json.encode(data.toJson());

class HeroeModel {
  String id;
  String name;
  double points;
  bool available;

  HeroeModel(
      {this.id,
      this.name = "Wonder Woman",
      this.points = 0.0,
      this.available = true});

  factory HeroeModel.fromJson(Map<String, dynamic> json) => HeroeModel(
        id: json["id"],
        name: json["name"],
        points: json["points"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "name": name,
        "points": points,
        "available": available,
      };
}
