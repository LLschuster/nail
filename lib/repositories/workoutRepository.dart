

class WorkoutRepository {
  List<List<Map<String, String>>> getWorkout(){
    var workoutDetailed = [
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
    return workoutDetailed;
  }
}