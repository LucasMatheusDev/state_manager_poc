import 'package:state_manager_poc/login_erros.dart';
import 'package:state_manager_poc/login_states.dart';
import 'package:state_manager_poc/response.dart';
import 'package:state_manager_poc/version_direct_controller/login_dc_state_manager.dart';

class LoginDCController {
  final LoginUseCase _loginUseCase;
  final LoginDCStateManager stateManager;

  LoginDCController({
    required LoginUseCase loginUseCase,
    required this.stateManager,
  }) : _loginUseCase = loginUseCase;

  Future<void> login() async {
    if (stateManager.isValidForm()) {
      stateManager.updateButtonLoading(true);

      final loginResponse = await _loginUseCase.login(
        email: stateManager.email,
        password: stateManager.password,
      );

      if (loginResponse.success) {
        stateManager.showSnackBar("Login success");
      } else if (loginResponse.error is LoginErrorInvalidCredentials) {
        stateManager.showSnackBar(loginResponse.error!.message);
      } else if (loginResponse.error is LoginErrorUserBlocked) {
        stateManager.updateState(
          LoginStateFailure(
            loginResponse.error!,
          ),
        );
      } else if (loginResponse.error is LoginNotFoundError) {
        stateManager.showSnackBar(loginResponse.error!.message);
      } else {
        stateManager.showSnackBar("Unexpected error");
      }

      stateManager.updateButtonLoading(false);
    }
  }
}

class LoginUseCase {
  Future<Response<bool, LoginError>> login({
    required String email,
    required String password,
  }) async {
    if (email == "success@gmail.com") {
      return Response<bool, LoginError>(
        success: true,
        data: true,
      );
    } else if (email == "invalid@gmail.com") {
      return Response<bool, LoginError>(
          success: false,
          error: LoginErrorInvalidCredentials(
            "Invalid credentials",
          ));
    } else if (email == "block@gmail.com") {
      return Response<bool, LoginError>(
          success: false,
          error: LoginErrorUserBlocked(
            "User blocked",
          ));
    } else {
      return Response<bool, LoginError>(
          success: false,
          error: LoginNotFoundError(
            "User not found",
          ));
    }
  }
}
