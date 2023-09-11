import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

abstract class BaseUseCase<T, Parameters> {
  /// The [call] method allows any class that defines it to emulate a
  /// function.
  Future<Either<Failure, T>> call(Parameters parameters);
}

class NoParams extends Equatable {
  const NoParams();

  @override
  List<Object?> get props => [];
}
