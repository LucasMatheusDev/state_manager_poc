import 'dart:developer';

import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/view/states/action/home_action.dart';
import 'package:state_manager_poc/modules/home/view/states/home_state.dart';
import 'package:state_manager_poc/modules/home/view/states/state_managers/home_state_manager.dart';
import 'package:state_manager_poc/modules/home/view_model/home_view_model.dart';

class HomeController {
  final HomeStateManager _stateManager;
  final HomeViewModel _viewModel;

  HomeController({
    required HomeStateManager stateManager,
    required HomeViewModel viewModel,
  })  : _stateManager = stateManager,
        _viewModel = viewModel {
    initListenAction();
  }

  void initListenAction() {
    _stateManager.action.listen((action) {
      if (action is HomeActionInitState) {
        getFriends();
        getPosts();
      } else if (action is HomeActionLikePost) {
        final post = action.post;
        log('post title: ${post.title}');
        requestLogin();
      } else if (action is HomeActionRefresh) {
        getPosts();
      }
    });
  }

  Future<void> getFriends() async {
    _stateManager.setState(FriendLoadingState());
    final friendsAnswer = await _viewModel.getFriends();
    friendsAnswer.deal(
      onSuccess: (friends) => _stateManager.setState(
        FriendSuccessState(friends),
      ),
      onFail: (exception) {
        if (exception is FriendNotFoundException) {
          _stateManager.setState(
            FriendsNotFoundState(exception.message),
          );
        } else {
          _stateManager.setState(
            FriendFailureState(exception.message),
          );
        }
      },
    );
  }

  Future<void> getPosts() async {
    _stateManager.setState(PostLoadingState());
    final posts = await _viewModel.getPosts();
    posts.deal(
      onSuccess: (posts) => _stateManager.setState(
        PostSuccessState(posts),
      ),
      onFail: (exception) {
        if (exception is PostNotFoundException) {
          _stateManager.setState(
            PostsNotFoundState(exception.message),
          );
        } else {
          _stateManager.setState(
            PostFailureState(exception.message),
          );
        }
      },
    );
  }

  void requestLogin() {
    _stateManager.showSnackBarRequestLogin('Please, login to like this post');
  }
}
