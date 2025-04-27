// import 'package:flutter/material.dart';

import 'models/blog.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Blog>> fetchBlog() async {
  var url =
      Uri.parse('https://nutrirobo.up.railway.app/blog/json');
  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  List<Blog> listBlog = [];
  for (var d in data) {
    if (d != null) {
      listBlog.add(Blog.fromJson(d));
    }
  }

  return listBlog;
}