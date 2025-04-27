// To parse this JSON data, do
//
//     final sleepTracker = sleepTrackerFromJson(jsonString);

import 'dart:convert';

List<SleepTracker> sleepTrackerFromJson(String str) => List<SleepTracker>.from(
    json.decode(str).map((x) => SleepTracker.fromJson(x)));

String sleepTrackerToJson(List<SleepTracker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SleepTracker {
  SleepTracker({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory SleepTracker.fromJson(Map<String, dynamic> json) => SleepTracker(
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
    required this.sleephours,
    required this.sleepminutes,
    required this.time,
  });

  int user;
  DateTime date;
  String description;
  int sleephours;
  int sleepminutes;
  String time;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        sleephours: json["sleephours"],
        sleepminutes: json["sleepminutes"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "date": date.toIso8601String(),
        "description": description,
        "sleephours": sleephours,
        "sleepminutes": sleepminutes,
        "time": time,
      };
}
