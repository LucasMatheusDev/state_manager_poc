abstract class HomeException implements Exception {
  final String message;
  final int code;

  HomeException({
    required this.message,
    required this.code,
  });
}

class FriendDefaultException extends HomeException {
  FriendDefaultException({
    required super.message,
    required super.code,
  });
}

class FriendNotFoundException extends HomeException {
  FriendNotFoundException({
    required super.message,
    required super.code,
  });
}


class PostDefaultException extends HomeException {
  PostDefaultException({
    required super.message,
    required super.code,
  });
}

class PostNotFoundException extends HomeException {
  PostNotFoundException({
    required super.message,
    required super.code,
  });
}

class AccountViewDefaultException extends HomeException {
  AccountViewDefaultException({
    required super.message,
    required super.code,
  });
}