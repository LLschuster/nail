// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Base on _Base, Store {
  final _$pageIndexAtom = Atom(name: '_Base.pageIndex');

  @override
  int get pageIndex {
    _$pageIndexAtom.context.enforceReadPolicy(_$pageIndexAtom);
    _$pageIndexAtom.reportObserved();
    return super.pageIndex;
  }

  @override
  set pageIndex(int value) {
    _$pageIndexAtom.context.conditionallyRunInAction(() {
      super.pageIndex = value;
      _$pageIndexAtom.reportChanged();
    }, _$pageIndexAtom, name: '${_$pageIndexAtom.name}_set');
  }

  final _$currentImgWorkoutAtom = Atom(name: '_Base.currentImgWorkout');

  @override
  String get currentImgWorkout {
    _$currentImgWorkoutAtom.context.enforceReadPolicy(_$currentImgWorkoutAtom);
    _$currentImgWorkoutAtom.reportObserved();
    return super.currentImgWorkout;
  }

  @override
  set currentImgWorkout(String value) {
    _$currentImgWorkoutAtom.context.conditionallyRunInAction(() {
      super.currentImgWorkout = value;
      _$currentImgWorkoutAtom.reportChanged();
    }, _$currentImgWorkoutAtom, name: '${_$currentImgWorkoutAtom.name}_set');
  }

  final _$workoutsAtom = Atom(name: '_Base.workouts');

  @override
  ObservableFuture<List<Workout>> get workouts {
    _$workoutsAtom.context.enforceReadPolicy(_$workoutsAtom);
    _$workoutsAtom.reportObserved();
    return super.workouts;
  }

  @override
  set workouts(ObservableFuture<List<Workout>> value) {
    _$workoutsAtom.context.conditionallyRunInAction(() {
      super.workouts = value;
      _$workoutsAtom.reportChanged();
    }, _$workoutsAtom, name: '${_$workoutsAtom.name}_set');
  }

  final _$_BaseActionController = ActionController(name: '_Base');

  @override
  void mutatePageIndex(int index) {
    final _$actionInfo = _$_BaseActionController.startAction();
    try {
      return super.mutatePageIndex(index);
    } finally {
      _$_BaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void mutateCurrentImg(String value) {
    final _$actionInfo = _$_BaseActionController.startAction();
    try {
      return super.mutateCurrentImg(value);
    } finally {
      _$_BaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Future<dynamic> getWorkouts(String id) {
    final _$actionInfo = _$_BaseActionController.startAction();
    try {
      return super.getWorkouts(id);
    } finally {
      _$_BaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'pageIndex: ${pageIndex.toString()},currentImgWorkout: ${currentImgWorkout.toString()},workouts: ${workouts.toString()}';
    return '{$string}';
  }
}
