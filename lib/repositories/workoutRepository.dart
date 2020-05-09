import 'package:nail/db/dbconfig.dart';
import 'package:nail/models/workout.dart';

class WorkoutRepository {
  Map<String, dynamic> getWorkout() {
    var workoutDetail = [
      [
        {"name": "squads", "reps": 25,"repsUnit": "x", "img": "push-ups", "video": "https://blog.ohiohealth.com/wp-content/uploads/2019/05/Outdoor-Beginner-Workout-Squats-2.mp4?_=1"},
        {"name": "Pull ups", "reps": 20, "repsUnit": "x", "img": "pull-ups"},
        {"name": "Sit ups", "reps": 18, "repsUnit": "x", "img": "sit-ups"},
      ],
      [
        {"name": "Push ups", "reps": 25, "repsUnit": "x", "img": "push-ups"},
        {"name": "Pull ups", "reps": 2, "repsUnit": "min", "img": "pull-ups"},
        {"name": "Sit ups", "reps": 18, "repsUnit": "x", "img": "sit-ups"},
      ],
      [
        {"name": "Push ups", "reps": 25, "repsUnit": "x", "img": "push-ups"},
        {"name": "extreme push ups", "reps": 20, "repsUnit": "x", "img": "push-ups"},
        {"name": "Sit ups", "reps": 1, "repsUnit": "min", "img": "sit-ups"},
      ],
    ];

    var workout = {
      "name": "full body workout",
      "id": 001,
      "workoutDetail": workoutDetail,
    };

    return workout;
  }

  Future<Map<String, dynamic>> getFinishedWorkout() async {
    try {
      var finishedWorkouts = await getFinishedWorkouts();
      return {"success": true, "workoutList": finishedWorkouts};
    } catch (e) {
      return {"error": "workout could not be saved;"};
    }
  }

  Future<Map<String, dynamic>> saveFinishedWorkout(
      Map<String, dynamic> doneWorkout, double difficultyLevel) async {
    try {
      FinishWorkout workout = FinishWorkout.toSave(
          workoutId: doneWorkout["id"],
          difficultyLevel: difficultyLevel,
          name: doneWorkout["name"],
          workoutDetail: doneWorkout["workoutDetail"].toString()
        );
      await insertFinishedWorkout(workout);
      return {"success": true};
    } catch (e) {
      print(e);
      return {"error": "workout could not be saved;"};
    }
  }

  //TODO Workouts should be represented by clases not maps
  Future<Map<String, dynamic>>
  calculateWorkoutDetailBaseOnFinishedWorkouts(Map<String, dynamic> workoutToDo) async {
    FinishWorkout lastWorkoutDone = await getLastWorkoutOfId(workoutToDo["id"]);
    if (lastWorkoutDone == null) return workoutToDo["workoutDetail"];
  }
}
