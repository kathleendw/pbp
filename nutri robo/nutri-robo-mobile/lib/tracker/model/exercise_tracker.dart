// To parse this JSON data, do
//
//     final exerciseTracker = exerciseTrackerFromJson(jsonString);

import 'dart:convert';

List<ExerciseTracker> exerciseTrackerFromJson(String str) =>
    List<ExerciseTracker>.from(
        json.decode(str).map((x) => ExerciseTracker.fromJson(x)));

String exerciseTrackerToJson(List<ExerciseTracker> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExerciseTracker {
  ExerciseTracker({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory ExerciseTracker.fromJson(Map<String, dynamic> json) =>
      ExerciseTracker(
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
    required this.exercise,
    required this.time,
  });

  int user;
  DateTime date;
  String description;
  int exercise;
  String time;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        exercise: json["exercise"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "date": date.toIso8601String(),
        "description": description,
        "exercise": exercise,
        "time": time,
      };
}
