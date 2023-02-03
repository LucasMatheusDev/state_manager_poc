import 'package:flutter/material.dart';
import 'package:state_manager_poc/login_erros.dart';
import 'package:state_manager_poc/login_states.dart';

class LoginDCStateManager {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  final isLoading = ValueNotifier<bool>(false);

  final userIsBlock = ValueNotifier<bool>(false);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  ValueNotifier<LoginState> state = ValueNotifier(LoginStateSuccess());

  String get email => emailTextController.text;

  String get password => passwordTextController.text;

  void updateState(LoginState newState) {
    state.value = newState;

    if (newState is! LoginStateLoading) {
      isLoading.value = false;
    }

    if (newState is LoginStateFailure) {
      if (newState.error is LoginErrorUserBlocked) {
        userIsBlock.value = true;
      }
    }
  }

  void updateButtonLoading(bool value) {
    isLoading.value = value;
  }

  BuildContext get _context => scaffoldKey.currentContext!;

  void showSnackBar(String? message) {
    ScaffoldMessenger.of(_context).showSnackBar(
      SnackBar(
        content: Text(message ?? "Erro unexpected"),
      ),
    );
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
