import 'package:state_manager_poc/modules/home/model/entities/friend.dart';
import 'package:state_manager_poc/modules/home/model/entities/post.dart';

abstract class HomeState {}

abstract class PostState extends HomeState {}

class PostInitial extends PostState {}

class PostSuccessState extends PostState {
  final List<Post> posts;

  PostSuccessState(this.posts);
}

class PostLoadingState extends PostState {}

class PostFailureState extends PostState {
  final String message;

  PostFailureState(this.message);
}

class PostsNotFoundState extends PostState {
  final String message;

  PostsNotFoundState(this.message);
}


abstract class FriendState extends HomeState  {}

class FriendInitial extends FriendState {}

class FriendSuccessState extends FriendState {
  final List<Friend> posts;

  FriendSuccessState(this.posts);
}

class FriendLoadingState extends FriendState {}

class FriendFailureState extends FriendState {
  final String message;

  FriendFailureState(this.message);
}

class FriendsNotFoundState extends FriendState {
  final String message;

  FriendsNotFoundState(this.message);
}

