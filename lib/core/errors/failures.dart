abstract class Failure implements Exception {
  final String message;
  const Failure(this.message);
}

// General Failures
class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NoInternetFailure extends Failure {
  NoInternetFailure() : super("لا يوجد اتصال بالانترنت");
}

class AuthFailure extends Failure {
  AuthFailure(super.message);
}

class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure(super.message);
}