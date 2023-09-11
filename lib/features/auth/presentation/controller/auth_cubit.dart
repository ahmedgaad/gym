import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/features/auth/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit(this.authRepository) : super(AuthInitial());
  final AuthRepository authRepository;

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(RegisterLoadingState());

    final result = await authRepository.createAccount(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
    );

    result.fold(
      (fail) {
        emit(RegisterFailureState(error: fail.message));
      },
      (sucess) {
        emit(RegisterSuccessState());
      },
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoadingState());
    final result = await authRepository.login(email: email, password: password);

    result.fold(
      (fail) {
        emit(LoginFailureState(error: fail.message));
      },
      (loggedIn) {
        emit(LoginSuccessState());
      },
    );
  }
}
