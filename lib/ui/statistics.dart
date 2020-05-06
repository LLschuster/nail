


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
  DateTime minFilterDate;
  DateTime maxFilterDate;
  Map<int, dynamic> workoutInMonthDays;
  Widget workoutOfSelectedDay;

  @override
  void initState() {
    super.initState();
    workoutRepository = WorkoutRepository();
    setupData();
    _loading = true;
    var now = DateTime.now();
    minFilterDate = DateTime.utc(now.year, now.month, 1);
    maxFilterDate = minFilterDate.add(Duration(days: 31));
    workoutInMonthDays = {};
    workoutOfSelectedDay = Container();
  }

  Future<void> setupData() async{
    var workouts = await workoutRepository.getFinishedWorkout();
    setState(() {
      finishedWorkouts = workouts;
      _loading = false;
    });
  }

  Widget showWorkoutOfSelectedDay(int day)
  {
    List<FinishWorkout> workouts = workoutInMonthDays[day];
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
      setState(() {
        workoutOfSelectedDay = Column(
          children: workoutsRows
          );
      });
  }
    @override
  Widget build(BuildContext context) {

    Widget finishedWorkoutsList() {
      if (!_loading){
        print(finishedWorkouts);
        List<FinishWorkout> workouts = finishedWorkouts["workoutList"];

        workoutInMonthDays = {};
        List<Widget> dayTiles = [];
        for (DateTime now = minFilterDate; now.isBefore(maxFilterDate);now = now.add(Duration(days: 1)))
        {
          bool isDayFilled = false;
          for (int i=0; i<workouts.length; ++i)
          {
            DateTime workoutDate = DateTime.fromMillisecondsSinceEpoch(workouts[i].time * 1000);
            if (workoutDate.isAfter(now) && workoutDate.isBefore(now.add(Duration(days: 1))))
            {
              isDayFilled = true;
              if (workoutInMonthDays.containsKey(workoutDate.day)){
                workoutInMonthDays[workoutDate.day].add(workouts[i]);
                continue;
              }
              workoutInMonthDays[workoutDate.day] = [workouts[i]];
              dayTiles.add(
                GestureDetector(
                  onTap: () {showWorkoutOfSelectedDay(now.day);},
                  child: Container(
                  width: 40,
                  height: 40,
                  child: Text("${now.day}", textAlign: TextAlign.center,),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(67, 54, 244, workouts[i].difficultyLevel != null? workouts[i].difficultyLevel/5: 0.5) 
                  ),
                  ),
                  ),
              );
            }
          }
          if (!isDayFilled)
          {
              dayTiles.add(
                GestureDetector(
                  onTap: () {showWorkoutOfSelectedDay(now.day);},
                  child: Container(
                  width: 40,
                  height: 40,
                  child: Text("${now.day}", textAlign: TextAlign.center,),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(240, 240, 240, 1) 
                  ),
                  ),
                  ),
              );
          }
        }
      return Container(
      padding: EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          Wrap(
            spacing: 10.0,
            runSpacing: 5.0,
            children: dayTiles
        ), 
        ]
      ),
    );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      
      }


    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        children: <Widget>[
        finishedWorkoutsList(),
        workoutOfSelectedDay
      ],) 
    );
  }
}