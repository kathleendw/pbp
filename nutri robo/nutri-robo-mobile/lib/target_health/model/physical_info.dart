// To parse this JSON data, do
//
//     final physicalInfo = physicalInfoFromJson(jsonString);

import 'dart:convert';

List<PhysicalInfo> physicalInfoFromJson(String str) => List<PhysicalInfo>.from(
    json.decode(str).map((x) => PhysicalInfo.fromJson(x)));

String physicalInfoToJson(List<PhysicalInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PhysicalInfo {
  PhysicalInfo({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory PhysicalInfo.fromJson(Map<String, dynamic> json) => PhysicalInfo(
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
    required this.weight,
    required this.height,
    required this.age,
    required this.gender,
    required this.calories,
    required this.water,
    required this.exercise,
    required this.sleep,
    required this.date,
  });

  int user;
  int weight;
  int height;
  int age;
  String gender;
  double calories;
  int water;
  int exercise;
  String sleep;
  DateTime date;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        weight: json["weight"],
        height: json["height"],
        age: json["age"],
        gender: json["gender"],
        calories: json["calories"].toDouble(),
        water: json["water"],
        exercise: json["exercise"],
        sleep: json["sleep"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "weight": weight,
        "height": height,
        "age": age,
        "gender": gender,
        "calories": calories,
        "water": water,
        "exercise": exercise,
        "sleep": sleep,
        "date": date.toIso8601String(),
      };
}
