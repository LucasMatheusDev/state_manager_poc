import 'package:state_manager_poc/login_erros.dart';
import 'package:state_manager_poc/response.dart';

class LoginController {
  final LoginUseCase _loginUseCase;

  LoginController({
    required LoginUseCase loginUseCase,
  }) : _loginUseCase = loginUseCase;

  Future<Response<bool, LoginError>> login({
    required String email,
    required String password,
  }) async {
    return await _loginUseCase.login(
      email: email.trim().toLowerCase(),
      password: password.trim(),
    );
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
