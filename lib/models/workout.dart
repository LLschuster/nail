

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
  int status;
  int time;
}

class FinishWorkout extends BaseModel{
  double difficultyLevel;
  int workoutId;
  String name;
  String workoutDetail;

  FinishWorkout(int id, int status, int time,{this.workoutId, this.difficultyLevel, this.name, this.workoutDetail}){
    this.id = id;
    this.status = status;
    this.time = time;
  }

  FinishWorkout.toSave({this.workoutId, this.difficultyLevel, this.name, this.workoutDetail});

  Map<String, dynamic> toMap() =>{
    "difficultyLevel": difficultyLevel,
    "workoutId": workoutId,
    "name": name,
    "workoutDetail": workoutDetail
  };
}