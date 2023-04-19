import 'package:state_manager_poc/modules/home/model/entities/post.dart';

abstract class HomeAction {}

class HomeActionInitState extends HomeAction {}

class HomeActionInstanceState extends HomeAction {}

class HomeActionDisposeState extends HomeAction {}

class HomeActionLikePost extends HomeAction {
  final Post post;

  HomeActionLikePost(this.post);
}

class HomeActionRefresh extends HomeAction {}

class HomeActionSearchPost extends HomeAction {}
