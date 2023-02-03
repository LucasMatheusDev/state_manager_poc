abstract class LoginError implements Exception {
  final String message;

  LoginError(this.message);
}

class LoginErrorInvalidCredentials extends LoginError {
  LoginErrorInvalidCredentials(String? message  )
      : super(message ?? 'Invalid credentials');
}

class LoginErrorUserBlocked extends LoginError {
  LoginErrorUserBlocked(String? message) : super(message ?? 'User blocked');
}

class LoginNotFoundError extends LoginError {
  LoginNotFoundError(String? message) : super(message ?? 'User not found');
}
