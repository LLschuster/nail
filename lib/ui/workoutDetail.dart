import 'package:flutter/material.dart';
import 'package:nail/repositories/base.dart';
import 'package:nail/repositories/workoutRepository.dart';
import 'package:nail/ui/clock.dart';
import 'package:nail/ui/selectDifficultyDialog.dart';
import 'package:nail/ui/workoutCard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WorkoutFeedDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WorkoutDetail(),
    );
  }
}

class WorkoutDetail extends StatefulWidget {
  @override
  State<WorkoutDetail> createState() {
    return WorkoutDetailState();
  }
}

class WorkoutDetailState extends State<WorkoutDetail> {
  bool workoutStarted = false;
  int setIndex = 0;
  int workoutIndex = 0;
  List<List<Map<String, String>>> workouts;
  WorkoutRepository _workoutRepository;
  Stopwatch stopwatch;
  Duration elapseTime;
  double difficultyLevel;
  
  void updateTimer(){
    if (stopwatch.isRunning){
    Future.delayed(Duration(seconds: 1), (){
      print("updating time");
      setState(() {
        elapseTime = stopwatch.elapsed;
      });
      updateTimer();
    });
    }
  }
  @override
  void initState() {
    super.initState();
    _workoutRepository = WorkoutRepository();
    workouts = _workoutRepository.getWorkout();
    stopwatch = Stopwatch();
    elapseTime = stopwatch.elapsed;
    difficultyLevel = 1.0;
  }

  Future<double> finishWorkout(BuildContext context) async{
    return await showDialog(
      context: context,
      builder: (BuildContext context){
        return SelectDifficultyDialog();
      }
    );
  }

  void startWorkout(BuildContext context) {
    if (!workoutStarted){
    return setState(() {
      workoutStarted = true;
      stopwatch.start();
      updateTimer();
      setIndex = 0;
      workoutIndex = 0;
    });
    }
    if (workoutIndex == workouts[setIndex].length-1){
      if (setIndex == workouts.length - 1){
        
        
        return setState(() async{
          stopwatch.stop();
          difficultyLevel = await finishWorkout(context);
          print("wokout is finished");
        });
      }
      return setState(() {
        setIndex++;
        workoutIndex = 0;
      });
    }
    setState(() {
      workoutIndex++;
    });
  }


  Widget workoutList() {
    if (workouts != null && workouts.length > 0){
      List<Widget> workoutDetailList = [];
      for (int i=0; i<workouts.length; ++i){
        workoutDetailList.add(
                ListTile(
                  leading: Icon(Icons.android),
                  title: Text("Set #${i+1}", style: TextStyle(color: Colors.black, fontSize: 14),),
                )
        );
        for (int j=0; j<workouts[i].length; ++j){
          workoutDetailList.add(
                ListTile(
                  title: Text("${workouts[i][j]["name"]}", style: TextStyle(color: Colors.black, fontSize: 14),),
                  trailing: Text("${workouts[i][j]["reps"]}", style: TextStyle(color: Colors.grey, fontSize: 14),),
                ),
          );
        }
      }
      return Column(children: workoutDetailList,);
    }
    return Column(
              children: <Widget>[
                Text("Your workout is loading")
              ]
            );
        }

    Widget currentWorkout() {
      return Column(
      children: <Widget>[
        Container(
                padding: EdgeInsets.all(15.0),
                child: new Image.asset("assets/${workouts[setIndex][workoutIndex]["img"]}.png",
                width: 400.0,
                height: 200.0,
              ),
              ),
        Container(
          padding: EdgeInsets.all(5.0),
          child: 
          Text("${workouts[setIndex][workoutIndex]["name"]}",
           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),),
        Container(child: Text(" ${workouts[setIndex][workoutIndex]["reps"]}", style: TextStyle(fontSize: 14)),),
      ]
    );
    }


  @override
  Widget build(BuildContext context) {
  final store = Provider.of<Base>(context);
    
    Widget body = SafeArea(
          child:  Container(
              child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              children: <Widget>[
              !workoutStarted?  Observer(
              builder: (_) => Hero(
              tag: "detail",
              child:  Container(
                padding: EdgeInsets.all(15.0),
                child: Image.asset(
                "assets/${store.currentImgWorkout}.png",
                width: 400.0,
                height: 200.0,
              ),
              ),
            ),
            ): SizedBox(height: 10),
            workoutStarted? currentWorkout() : workoutList(),    
            clock(elapseTime),            
              ]
            ) ,
            ),

           
        );

    
    return Scaffold(
        appBar: AppBar(title: Text("Full body workout")),
        body: body,
        floatingActionButton: FloatingActionButton.extended(
          label: Text(workoutStarted?"Next": "Start"),
          onPressed: () => startWorkout(context),
          icon: Icon(Icons.play_arrow),
          backgroundColor: Colors.grey,
          ),
        );
  }
}
