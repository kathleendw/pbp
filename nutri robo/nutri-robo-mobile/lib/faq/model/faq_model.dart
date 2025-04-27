// To parse this JSON data, do
//
//     final myfaqData = myfaqDataFromJson(jsonString);

import 'dart:convert';

List<MyfaqData> myfaqDataFromJson(String str) => List<MyfaqData>.from(json.decode(str).map((x) => MyfaqData.fromJson(x)));

String myfaqDataToJson(List<MyfaqData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyfaqData {
    MyfaqData({
        required this.pk,
        required this.fields,
    });

    int pk;
    Fields fields;

    factory MyfaqData.fromJson(Map<String, dynamic> json) => MyfaqData(
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        required this.question,
        required this.answer,
    });

    String question;
    String answer;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        question: json["question"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
    };
}
