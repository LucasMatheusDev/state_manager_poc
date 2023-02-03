import 'package:flutter/material.dart';
import 'package:state_manager_poc/login_erros.dart';
import 'package:state_manager_poc/login_states.dart';
import 'package:state_manager_poc/version_direct_state_manager/login_controller.dart';

class LoginStateManager {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final isLoading = ValueNotifier<bool>(false);

  final userIsBlock = ValueNotifier<bool>(false);

  final LoginController _controller;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ValueNotifier<LoginState> state = ValueNotifier(LoginStateSuccess());

  void updateState(LoginState newState) {
    state.value = newState;

    if (newState is! LoginStateLoading) {
      isLoading.value = false;
    }
  }

  BuildContext get context => scaffoldKey.currentContext!;

  LoginStateManager({
    required LoginController controller,
  }) : _controller = controller;

  void login() async {
    if (isValidForm()) {
      isLoading.value = true;

      final loginResponse = await _controller.login(
        email: emailTextController.text,
        password: passwordTextController.text,
      );

      if (loginResponse.success) {
        showSnackBar("Login success");
      } else if (loginResponse.error is LoginErrorInvalidCredentials) {
        showSnackBar(loginResponse.error!.message);
      } else if (loginResponse.error is LoginErrorUserBlocked) {
        userIsBlock.value = true;
        updateState(
          LoginStateFailure(
            loginResponse.error!,
          ),
        );
      } else if (loginResponse.error is LoginNotFoundError) {
        showSnackBar(loginResponse.error!.message);
      } else {
        showSnackBar("Unexpected error");
      }

      isLoading.value = false;
    }
  }

  void showSnackBar(String? message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message ?? "Erro unexpected"),
      ),
    );
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
