// To parse this JSON data, do
//
//     final feedbackItem = feedbackItemFromJson(jsonString);

import 'dart:convert';

List<FeedbackItem> feedbackItemFromJson(String str) => List<FeedbackItem>.from(
    json.decode(str).map((x) => FeedbackItem.fromJson(x)));

String feedbackItemToJson(List<FeedbackItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedbackItem {
  FeedbackItem({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory FeedbackItem.fromJson(Map<String, dynamic> json) => FeedbackItem(
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
    required this.rating,
    required this.feedback,
  });

  int user;
  DateTime date;
  int rating;
  String feedback;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        date: DateTime.parse(json["date"]),
        rating: json["rating"],
        feedback: json["feedback"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "rating": rating,
        "feedback": feedback,
      };
}
