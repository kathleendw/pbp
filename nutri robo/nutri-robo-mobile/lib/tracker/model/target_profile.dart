// To parse this JSON data, do
//
//     final targetProfile = targetProfileFromJson(jsonString);

import 'dart:convert';

List<TargetProfile> targetProfileFromJson(String str) =>
    List<TargetProfile>.from(
        json.decode(str).map((x) => TargetProfile.fromJson(x)));

String targetProfileToJson(List<TargetProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TargetProfile {
  TargetProfile({
    required this.model,
    required this.pk,
    required this.fields,
  });

  Model model;
  int pk;
  Fields fields;

  factory TargetProfile.fromJson(Map<String, dynamic> json) => TargetProfile(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
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
  Gender gender;
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
        gender: genderValues.map[json["gender"]]!,
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
        "gender": genderValues.reverse[gender],
        "calories": calories,
        "water": water,
        "exercise": exercise,
        "sleep": sleep,
        "date": date.toIso8601String(),
      };
}

enum Gender { F, M }

final genderValues = EnumValues({"f": Gender.F, "m": Gender.M});

enum Model { TARGET_PROFILE_PHYSICALINFO }

final modelValues = EnumValues(
    {"target_profile.physicalinfo": Model.TARGET_PROFILE_PHYSICALINFO});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    // ignore: unnecessary_null_comparison
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
