import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/feedbackItem.dart';

Future<List<FeedbackItem>> fetchFeedback() async {
  var url = Uri.parse('https://nutrirobo.up.railway.app/json-all/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object ToDo
  List<FeedbackItem> listFeedbackItem = [];
  for (var d in data) {
    if (d != null) {
      listFeedbackItem.add(FeedbackItem.fromJson(d));
    }
  }

  return listFeedbackItem;
}
