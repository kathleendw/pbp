// To parse this JSON data, do
//
//     final calorieTracker = calorieTrackerFromJson(jsonString);

import 'dart:convert';

List<CalorieTracker> calorieTrackerFromJson(String str) =>
    List<CalorieTracker>.from(
        json.decode(str).map((x) => CalorieTracker.fromJson(x)));

String calorieTrackerToJson(List<CalorieTracker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CalorieTracker {
  CalorieTracker({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory CalorieTracker.fromJson(Map<String, dynamic> json) => CalorieTracker(
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
    required this.calorie,
    required this.time,
  });

  int user;
  DateTime date;
  String description;
  int calorie;
  String time;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        calorie: json["calorie"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "date": date.toIso8601String(),
        "description": description,
        "calorie": calorie,
        "time": time,
      };
}
