part of 'exercises_cubit.dart';

abstract class ExercisesStates extends Equatable {
  const ExercisesStates();

  @override
  List<Object> get props => [];
}

class ExercisesInitialState extends ExercisesStates {}

class FetchExerciseDataLoadingState extends ExercisesStates {}

class FetchExerciseDataSuccessState extends ExercisesStates {
  final List<Exercise> exercises;
  const FetchExerciseDataSuccessState({required this.exercises});

  @override
  List<Object> get props => [exercises];
}

class FetchExerciseDataFailureState extends ExercisesStates {
  final String error;
  const FetchExerciseDataFailureState({required this.error});

  @override
  List<Object> get props => [error];
}
