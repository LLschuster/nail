import 'package:nail/models/workout.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String FINISHED_WORKOUT_TABLE = "finishedWorkouts";
Future<Database> database() async {
    return openDatabase(
    join(await getDatabasesPath(), "fitness_track.db"),
    onCreate: (db, version){
      db.execute(
        "CREATE TABLE $FINISHED_WORKOUT_TABLE(id INTEGER PRIMARY KEY, workoutId INTEGER NOT NULL,"+
         "difficultyLevel REAL DEFAULT 3.0, name TEXT, status INTEGER DEFAULT 1, time INTEGER DEFAULT (strftime('%s','now')),"+
         "workoutDetail TEXT)"
        );
    },
    version: 1
  );
}

Future<void> insertFinishedWorkout(FinishWorkout workout) async{
  var db = await database();
  var valuesToInsert = workout.toMap();
  await db.insert(FINISHED_WORKOUT_TABLE,valuesToInsert ,conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<FinishWorkout>> getFinishedWorkouts() async{
  var db = await database();

  var result = await db.query(FINISHED_WORKOUT_TABLE);

  return List.generate(result.length, (i) {
    return 
    FinishWorkout(
      result[i]["id"],
      result[i]["status"],
      result[i]["time"],
      difficultyLevel: result[i]["difficultyLevel"],
      workoutId: result[i]["workoutId"],
      name: result[i]["name"],
      workoutDetail: result[i]["workoutDetail"]);
  });
}

Future<FinishWorkout> getLastWorkoutOfId(int id) async{
  var db = await database();

  var result = await db.query(FINISHED_WORKOUT_TABLE, where: "id = $id", orderBy: "time DESC", limit: 1);

  if (result.length <= 0) return null;
  return  
    FinishWorkout(
      result[0]["id"],
      result[0]["status"],
      result[0]["time"],
      difficultyLevel: result[0]["difficultyLevel"],
      workoutId: result[0]["workoutId"],
      name: result[0]["name"],
      workoutDetail: result[0]["workoutDetail"]
  );
}