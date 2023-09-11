import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gym/core/base/usecase.dart';
import 'package:gym/features/exercises/domain/entities/exercise.dart';
import 'package:gym/features/exercises/domain/usecases/fetch_exercises_usecase.dart';

part 'exercises_state.dart';

class ExercisesCubit extends Cubit<ExercisesStates> {
  ExercisesCubit(this.fetchExercisesUsecase) : super(ExercisesInitialState());
  final FetchExercisesUsecase fetchExercisesUsecase;

  Future<void> fetchExercises() async {
    emit(FetchExerciseDataLoadingState());
    final result = await fetchExercisesUsecase(const NoParams());

    result.fold(
      (fail) {
        emit(FetchExerciseDataFailureState(error: fail.message));
      },
      (exercises) {
        emit(FetchExerciseDataSuccessState(exercises: exercises));
      },
    );
  }
}
