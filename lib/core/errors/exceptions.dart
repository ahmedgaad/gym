import 'package:gym/core/errors/failures.dart';

class FailureException<T extends Failure> implements Exception {
  final T failure;

  FailureException(this.failure);
}