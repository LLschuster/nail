


import 'package:flutter/material.dart';
import 'package:nail/models/workout.dart';
import 'package:nail/repositories/workoutRepository.dart';

class Statistics extends StatefulWidget {
  @override
  State<Statistics> createState() {
    // TODO: implement createState
    return StatisticsState();
  }
}

class StatisticsState extends State<Statistics> {
  WorkoutRepository workoutRepository;
  Map<String, dynamic> finishedWorkouts;
  bool _loading = false;


  @override
  void initState() {
    super.initState();
    workoutRepository = WorkoutRepository();
    setupData();
    _loading = true;
  }

  Future<void> setupData() async{
    var workouts = await workoutRepository.getFinishedWorkout();
    setState(() {
      finishedWorkouts = workouts;
      _loading = false;
    });
  }
    @override
  Widget build(BuildContext context) {

    Widget finishedWorkoutsList() {
      if (!_loading){
print(finishedWorkouts);
      List<FinishWorkout> workouts = finishedWorkouts["workoutList"];
      List<Widget> workoutsRows = [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("Workout", style: TextStyle(fontSize: 14),),
              Text("Difficulty", style: TextStyle(fontSize: 14),),
              Text("Date", style: TextStyle(fontSize: 14),),
            ]
          )
      ];
      for (int i=0; i<workouts.length; ++i){
        workoutsRows.add(
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text("${workouts[i].name}", style: TextStyle(fontSize: 14),),
              Text("${workouts[i].difficultyLevel}", style: TextStyle(fontSize: 14),),
              Text("${DateTime.fromMillisecondsSinceEpoch(workouts[i].time * 1000)}", style: TextStyle(fontSize: 14),),
            ]
          )
          )
          
        );
      }

      return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: workoutsRows
      ),
    );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      
    }


    return Container(
      child: finishedWorkoutsList()
    );
  }
}