import 'package:dartz/dartz.dart';
import 'package:gym/core/errors/failures.dart';
import 'package:gym/features/exercises/domain/entities/exercise.dart';

abstract class ExercisesRepository {
  Future<Either<Failure, List<Exercise>>> fetchExercises();
}
