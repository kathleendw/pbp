import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/sleep_tracker.dart';

List<SleepTracker> tempSleep = [];

Future<List<SleepTracker>> fetchSleepTracker() async {
  var url = Uri.parse('https://nutrirobo.up.railway.app/tracker/sleep-json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  tempSleep.clear();
  // melakukan konversi data json menjadi object ToDo
  List<SleepTracker> listSleepTracker = [];
  for (var d in data) {
    if (d != null) {
      tempSleep.add(SleepTracker.fromJson(d));
      listSleepTracker.add(SleepTracker.fromJson(d));
    }
  }

  return listSleepTracker;
}

fetchTotalSleepHours() {
  int totalSleepHours = 0;
  for (var val in tempSleep) {
    totalSleepHours += val.fields.sleephours;
  }
  return totalSleepHours.toString();
}

fetchTotalSleepMinutes() {
  int totalSleepMinutes = 0;
  for (var val in tempSleep) {
    totalSleepMinutes += val.fields.sleepminutes;
  }
  return totalSleepMinutes.toString();
}
