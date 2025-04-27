import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/exercise_tracker.dart';

List<ExerciseTracker> tempExercise = [];

Future<List<ExerciseTracker>> fetchExerciseTracker() async {
  var url =
      Uri.parse('https://nutrirobo.up.railway.app/tracker/exercise-json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  tempExercise.clear();
  // melakukan konversi data json menjadi object ToDo
  List<ExerciseTracker> listExerciseTracker = [];
  for (var d in data) {
    if (d != null) {
      tempExercise.add(ExerciseTracker.fromJson(d));
      listExerciseTracker.add(ExerciseTracker.fromJson(d));
    }
  }

  return listExerciseTracker;
}

fetchTotalExercise() {
  int totalExercise = 0;
  for (var val in tempExercise) {
    totalExercise += val.fields.exercise;
  }
  return totalExercise.toString();
}
