import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/water_tracker.dart';

List<WaterTracker> tempWater = [];

Future<List<WaterTracker>> fetchWaterTracker() async {
  var url = Uri.parse('https://nutrirobo.up.railway.app/tracker/water-json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  tempWater.clear();
  // melakukan konversi data json menjadi object ToDo
  List<WaterTracker> listWaterTracker = [];
  for (var d in data) {
    if (d != null) {
      tempWater.add(WaterTracker.fromJson(d));
      listWaterTracker.add(WaterTracker.fromJson(d));
    }
  }

  return listWaterTracker;
}

fetchTotalWater() {
  int totalWater = 0;
  for (var val in tempWater) {
    totalWater += val.fields.water;
  }
  return totalWater.toString();
}
