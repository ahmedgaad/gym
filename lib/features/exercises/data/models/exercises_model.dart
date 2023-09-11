

import 'package:gym/features/exercises/domain/entities/exercise.dart';

class ExercisesModel extends Exercise {
  const ExercisesModel({
    required super.id,
    required super.title,
    required super.thumbnail,
    required super.gif,
    required super.seconds,
  });

  factory ExercisesModel.fromJson(Map<String, dynamic> json) => ExercisesModel(
        id: json['id'],
        title: json['title'],
        thumbnail: json['thumbnail'],
        gif: json['gif'],
        seconds: json['seconds'],
      );
}
