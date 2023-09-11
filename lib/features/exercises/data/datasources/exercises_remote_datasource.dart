import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gym/core/errors/failures.dart';
import 'package:gym/core/functions/web_service_handling.dart';
import 'package:gym/core/utils/constants.dart';
import 'package:gym/features/exercises/data/models/exercises_model.dart';

abstract class ExercisesRemoteDatasource {
  Future<List<ExercisesModel>> fetchExercises();
}

class ExercisesRemoteDatasourceImpl extends ExercisesRemoteDatasource {
  final Dio dioClient;

  ExercisesRemoteDatasourceImpl({required this.dioClient}) {
    dioClient.options = BaseOptions(
      baseUrl: ConstantUtils.baseUrl,
      contentType: 'application/json',
      responseType: ResponseType.json,
      followRedirects: false,
      validateStatus: (status) => status! < 500,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
    );
  }

  @override
  Future<List<ExercisesModel>> fetchExercises() async {
    try {
      final response = await dioClient.get(
        '/codeifitech/fitness-app/master/exercises.json',
        queryParameters: {
          "fbclid":
              "IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A"
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.data);
        return List<ExercisesModel>.from(
          (json['exercises'] as List).map(
            (exercise) => ExercisesModel.fromJson(exercise),
          ),
        );
      } else {
        throw ServerFailure('Something wen wrong!');
      }
    } on SocketException {
      throw NoInternetFailure();
    } on DioException catch (e) {
      throw handleDioError(e);
    } catch (e) {
      rethrow;
    }
  }
}
