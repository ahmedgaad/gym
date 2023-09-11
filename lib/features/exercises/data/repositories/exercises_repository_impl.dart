import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:gym/core/connection/network_info.dart';
import 'package:gym/core/errors/failures.dart';
import 'package:gym/features/exercises/data/datasources/exercises_remote_datasource.dart';
import 'package:gym/features/exercises/domain/entities/exercise.dart';
import 'package:gym/features/exercises/domain/repositories/exercises_repository.dart';

class ExercisesRepositoryImpl implements ExercisesRepository {
  final ExercisesRemoteDatasource fitnessRemoteDatasource;
  final NetworkInfo networkInfo;

  ExercisesRepositoryImpl({
    required this.fitnessRemoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Exercise>>> fetchExercises() async {
    if (await networkInfo.isConnected != ConnectivityResult.none) {
      try {
        final response = await fitnessRemoteDatasource.fetchExercises();
        return Right(response);
      } on Failure catch (e) {
        return Left(e);
      }
    }
    return Left(NoInternetFailure());
  }
}
