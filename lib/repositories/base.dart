import 'package:mobx/mobx.dart';
import 'package:nail/models/workout.dart';
import 'package:nail/services/api.dart';

part 'base.g.dart';

class Base extends _Base with _$Base {

}

abstract class _Base with Store{

@observable 
int pageIndex=0;

@observable 
String currentImgWorkout;

@observable
ObservableFuture<List<Workout>> workouts;

@action 
void mutatePageIndex(int index){
  pageIndex = index;
}

@action 
void mutateCurrentImg(String value){
  currentImgWorkout = value;
}

@action 
Future getWorkouts (String id){
  return workouts = ObservableFuture(Api.getWorkouts(id));
}

}