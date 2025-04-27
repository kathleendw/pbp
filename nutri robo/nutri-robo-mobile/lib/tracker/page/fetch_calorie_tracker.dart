import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/calorie_tracker.dart';

List<CalorieTracker> tempCalorie = [];

Future<List<CalorieTracker>> fetchCalorieTracker() async {
  var url = Uri.parse('https://nutrirobo.up.railway.app/tracker/calorie-json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  tempCalorie.clear();
  // melakukan konversi data json menjadi object ToDo
  List<CalorieTracker> listCalorieTracker = [];
  for (var d in data) {
    if (d != null) {
      tempCalorie.add(CalorieTracker.fromJson(d));
      listCalorieTracker.add(CalorieTracker.fromJson(d));
    }
  }

  return listCalorieTracker;
}

fetchTotalCalorie() {
  int totalCalorie = 0;
  for (var val in tempCalorie) {
    totalCalorie += val.fields.calorie;
  }

  return totalCalorie.toString();
}
