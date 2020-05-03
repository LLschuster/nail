import 'package:nail/db/dbconfig.dart';
import 'package:nail/models/workout.dart';

class WorkoutRepository {
  Map<String, dynamic> getWorkout() {
    var workoutDetail = [
      [
        {"name": "Push ups", "reps": "25x", "img": "push-ups"},
        {"name": "Pull ups", "reps": "20x", "img": "pull-ups"},
        {"name": "Sit ups", "reps": "18x", "img": "sit-ups"},
      ],
      [
        {"name": "Push ups", "reps": "25x", "img": "push-ups"},
        {"name": "Pull ups", "reps": "2 min", "img": "pull-ups"},
        {"name": "Sit ups", "reps": "18x", "img": "sit-ups"},
      ],
      [
        {"name": "Push ups", "reps": "25x", "img": "push-ups"},
        {"name": "extreme push ups", "reps": "20x", "img": "push-ups"},
        {"name": "Sit ups", "reps": "1 min", "img": "sit-ups"},
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
      print(e);
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
}
