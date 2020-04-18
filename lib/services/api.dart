import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:nail/models/workout.dart';

class Api {

  static Future<List<Workout>>  getWorkouts(String id) async {
    http.Response response = await http.get('http://192.168.178.28:5000/api/v1/feed/$id');
    if (response.statusCode == 200){
      var jsonResponse = convert.jsonDecode(response.body);
      List<Exercise> exercises = [];
      for (int i=0; i<jsonResponse.length; ++i){
        exercises.add(Exercise(difficulty: 1, name: jsonResponse[i]["name"]));
      }
      var workout = Workout();
      workout.exerciseList = exercises;
      return [workout];
    }
    return [];
  }
}