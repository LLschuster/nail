import 'package:flutter/material.dart';
import 'package:nail/main.dart';
import 'package:nail/repositories/base.dart';
import 'package:nail/repositories/workoutRepository.dart';
import 'package:nail/ui/clock.dart';
import 'package:nail/ui/selectDifficultyDialog.dart';
import 'package:nail/ui/workoutCard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:video_player/video_player.dart';

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
  Map<String, dynamic> workout;
  dynamic workoutDetail;
  WorkoutRepository _workoutRepository;
  Stopwatch stopwatch;
  Duration elapseTime;
  double difficultyLevel;
  VideoPlayerController videoPlayerController;

  void updateTimer() {
    if (stopwatch.isRunning) {
      Future.delayed(Duration(seconds: 1), () {
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
    workout = _workoutRepository.getWorkout();
    workoutDetail = workout["workoutDetail"];
    stopwatch = Stopwatch();
    elapseTime = stopwatch.elapsed;
    difficultyLevel = 3.0;
  }

  void initVideoPlayer()
  {
    if (videoPlayerController != null){
      return;
    }
    // the dot dot is for not repeating videoplayerController.intialize etc...
    videoPlayerController = VideoPlayerController.network(workoutDetail[setIndex][workoutIndex]["video"])
    ..initialize().then((_) { 
      setState(() {      
      });
    });
  }


  Future<double> getLevelOfFinishedWorkout(BuildContext context) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SelectDifficultyDialog();
        });
  }

  void startWorkout(BuildContext context) {
    if (!workoutStarted) {
      return setState(() {
        workoutStarted = true;
        stopwatch.start();
        updateTimer();
        setIndex = 0;
        workoutIndex = 0;
      });
    }
    if (workoutIndex == workoutDetail[setIndex].length - 1) {
      if (setIndex == workoutDetail.length - 1) {
        return setState(() async {
          stopwatch.stop();
          difficultyLevel = await getLevelOfFinishedWorkout(context);
          var result = await _workoutRepository.saveFinishedWorkout(workout, difficultyLevel);
          print("wokout is finished");
          Navigator.push(context, MaterialPageRoute(builder: (_){ return MyApp();}));
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
    if (workoutDetail != null && workoutDetail.length > 0) {
      List<Widget> workoutDetailList = [];
      for (int i = 0; i < workoutDetail.length; ++i) {
        workoutDetailList.add(ListTile(
          leading: Icon(Icons.android),
          title: Text(
            "Set #${i + 1}",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
        ));
        for (int j = 0; j < workoutDetail[i].length; ++j) {
          workoutDetailList.add(
            ListTile(
              title: Text(
                "${workoutDetail[i][j]["name"]}",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              trailing: Text(
                "${workoutDetail[i][j]["reps"]}",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          );
        }
      }
      return Column(
        children: workoutDetailList,
      );
    }
    return Column(children: <Widget>[Text("Your workout is loading")]);
  }

  Widget currentWorkoutAsset()
  {
    //TODO Why do you run so many times?
      if (workoutDetail[setIndex][workoutIndex]["video"] != null)
      {
        initVideoPlayer();
        return videoPlayerController.value.initialized ? 
            GestureDetector(
              onTap: () {
                setState(() {
                  !videoPlayerController.value.isPlaying? videoPlayerController.play() : videoPlayerController.pause();
                });
              },
              child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: VideoPlayer(videoPlayerController),
          ),
            )
         : Container(
           padding: EdgeInsets.all(5.0),
           child: CircularProgressIndicator(),
         );
      }
    return Container(
        padding: EdgeInsets.all(15.0),
        child: new Image.asset(
          "assets/${workoutDetail[setIndex][workoutIndex]["img"]}.png",
          width: 400.0,
          height: 200.0,
        ),
      );
  }

  Widget currentWorkout() {
    return Column(children: <Widget>[
      currentWorkoutAsset(),
      Container(
        padding: EdgeInsets.all(5.0),
        child: Text(
          "${workoutDetail[setIndex][workoutIndex]["name"]}",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        child: Text(" ${workoutDetail[setIndex][workoutIndex]["reps"]}",
            style: TextStyle(fontSize: 14)),
      ),
      clock(elapseTime)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Base>(context);

    Widget body = SafeArea(
      child: Container(
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            children: <Widget>[
              !workoutStarted
                  ? Observer(
                      builder: (_) => Hero(
                        tag: "detail",
                        child: Container(
                          padding: EdgeInsets.all(15.0),
                          child: Image.asset(
                            "assets/${store.currentImgWorkout}.png",
                            width: 400.0,
                            height: 200.0,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(height: 10),
              workoutStarted ? currentWorkout() : workoutList(),
              
            ]),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Full body workout")),
      body: body,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(workoutStarted ? "Next" : "Start"),
        onPressed: () => startWorkout(context),
        icon: Icon(Icons.play_arrow),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
