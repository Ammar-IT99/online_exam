
abstract class LogOutState {}

class LogOutInitial extends LogOutState {}

class LogOutLoading extends LogOutState {}

class LogOutLoggedOut extends LogOutState {
  final String message;
  LogOutLoggedOut(this.message);
}

class LogOutError extends LogOutState {
  final String error;
  LogOutError(this.error);
}
