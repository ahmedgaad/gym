part of 'auth_cubit.dart';

abstract class AuthStates extends Equatable {
  const AuthStates();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterSuccessState extends AuthStates {}

class RegisterFailureState extends AuthStates {
  final String error;
  const RegisterFailureState({required this.error});
}

class LoginLoadingState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginFailureState extends AuthStates {
  final String error;
  const LoginFailureState({required this.error});
  @override
  List<Object> get props => [error];
}
