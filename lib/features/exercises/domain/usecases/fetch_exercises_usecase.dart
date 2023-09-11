import 'package:dartz/dartz.dart';
import 'package:gym/core/base/usecase.dart';
import 'package:gym/core/errors/failures.dart';
import 'package:gym/features/exercises/domain/entities/exercise.dart';
import 'package:gym/features/exercises/domain/repositories/exercises_repository.dart';

class FetchExercisesUsecase extends BaseUseCase<List<Exercise>, NoParams> {
  final ExercisesRepository fitnessRepository;
  FetchExercisesUsecase({required this.fitnessRepository});

  @override
  Future<Either<Failure, List<Exercise>>> call(NoParams parameters) async {
    return await fitnessRepository.fetchExercises();
  }
}
