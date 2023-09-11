import 'package:equatable/equatable.dart';

class Exercise extends Equatable {
  final String id;
  final String title;
  final String thumbnail;
  final String gif;
  final String seconds;

  const Exercise({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.gif,
    required this.seconds,
  });

  @override
  List<Object?> get props => [id, title, thumbnail, gif, seconds];
}
