// memodelkan data yang ingin ditampilkan
// import 'package:flutter/material.dart';

// To parse this JSON data, do
//
//     final blog = blogFromJson(jsonString);

import 'dart:convert';

List<Blog> blogFromJson(String str) => List<Blog>.from(json.decode(str).map((x) => Blog.fromJson(x)));

String blogToJson(List<Blog> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Blog {
    Blog({
       // required this.pk,
        required this.fields,
    });

    //int pk;
    Fields fields;

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
       // pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
       // "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    Fields({
        required this.title,
        required this.slug,
        required this.intro,
        required this.body,
        required this.createdAt,
    });

    String title;
    String slug;
    String intro;
    String body;
    DateTime createdAt;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        slug: json["slug"],
        intro: json["intro"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "intro": intro,
        "body": body,
        "created_at": createdAt.toIso8601String(),
    };
}
