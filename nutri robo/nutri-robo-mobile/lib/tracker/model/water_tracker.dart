// To parse this JSON data, do
//
//     final waterTracker = waterTrackerFromJson(jsonString);

import 'dart:convert';

List<WaterTracker> waterTrackerFromJson(String str) => List<WaterTracker>.from(
    json.decode(str).map((x) => WaterTracker.fromJson(x)));

String waterTrackerToJson(List<WaterTracker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WaterTracker {
  WaterTracker({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory WaterTracker.fromJson(Map<String, dynamic> json) => WaterTracker(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.user,
    required this.date,
    required this.description,
    required this.water,
    required this.time,
  });

  int user;
  DateTime date;
  String description;
  int water;
  String time;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        water: json["water"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "date": date.toIso8601String(),
        "description": description,
        "water": water,
        "time": time,
      };
}
