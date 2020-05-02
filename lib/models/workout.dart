

class Exercise{
  Exercise({this.difficulty, this.name});
  int difficulty;
  String name;
}

class Workout{
  List<Exercise> exerciseList;
}

class BaseModel {
  int id;
  bool status;
  int time;
}

class FinishWorkout extends BaseModel{
  double difficultyLevel;
  int workoutId;
  String name;

  FinishWorkout(int id, bool status, int time,{this.workoutId, this.difficultyLevel, this.name}){
    this.id = id;
    this.status = status;
    this.time = time;
  }

  Map<String, dynamic> toMap() =>{
    "difficultyLevel": difficultyLevel,
    "workoutId": workoutId,
    "name": name,
  };
}