import 'package:state_manager_poc/login_erros.dart';

abstract class LoginState {}

class LoginStateLoading extends LoginState {}

class LoginStateSuccess extends LoginState {}

class LoginStateFailure extends LoginState {
  final LoginError error;

  LoginStateFailure(this.error);
}
