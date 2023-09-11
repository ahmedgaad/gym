import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gym/core/connection/network_info.dart';
import 'package:gym/features/auth/data/repositories/auth_repository.dart';
import 'package:gym/features/auth/presentation/controller/auth_cubit.dart';
import 'package:gym/features/exercises/data/datasources/exercises_remote_datasource.dart';
import 'package:gym/features/exercises/data/repositories/exercises_repository_impl.dart';
import 'package:gym/features/exercises/domain/repositories/exercises_repository.dart';
import 'package:gym/features/exercises/domain/usecases/fetch_exercises_usecase.dart';
import 'package:gym/features/exercises/presentation/controller/exercises_cubit.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  //! Features - Authentication
  //* Cubit
  sl.registerFactory(() => AuthCubit(sl<AuthRepository>()));

  //* Repository
  sl.registerLazySingleton(() => AuthRepository());

  //! Features - Exercises
  //* Cubit
  sl.registerFactory(() => ExercisesCubit(sl<FetchExercisesUsecase>()));

  //* Repository
  sl.registerLazySingleton<ExercisesRepository>(() => ExercisesRepositoryImpl(
      fitnessRemoteDatasource: sl(), networkInfo: sl<NetworkInfo>()));

  //* Usecase
  sl.registerLazySingleton(
      () => FetchExercisesUsecase(fitnessRepository: sl()));

  //* Data Source
  sl.registerLazySingleton<ExercisesRemoteDatasource>(
      () => ExercisesRemoteDatasourceImpl(dioClient: sl<Dio>()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => Dio());
}
