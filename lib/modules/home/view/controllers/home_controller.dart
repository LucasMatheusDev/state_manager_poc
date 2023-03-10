import 'dart:developer';

import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/use_cases/home_use_case.dart';
import 'package:state_manager_poc/modules/home/view/states/action/home_action.dart';
import 'package:state_manager_poc/modules/home/view/states/home_state.dart';
import 'package:state_manager_poc/modules/home/view/states/state_managers/home_state_manager.dart';

class HomeController {
  final HomeStateManager stateManager;
  final HomeUseCase _viewModel;

  HomeController({
    required this.stateManager,
    required HomeUseCase viewModel,
  }) : _viewModel = viewModel {
    initListenAction();
  }

  void initListenAction() {
    stateManager.action.listen((action) {
      if (action is HomeActionInitState) {
        getPosts();
      } else if (action is HomeActionLikePost) {
        final post = action.post;
        log('post title: ${post.title}');
        requestLogin();
      } else if (action is HomeActionRefresh ||
          action is HomeActionSearchPost) {
        getPosts();
      }
    });
  }

  Future<void> getPosts() async {
    stateManager.setState(PostLoadingState());
    final posts = await _viewModel.getPosts();
    posts.deal(
      onSuccess: (posts) => stateManager.setState(
        PostSuccessState(posts),
      ),
      onFail: (exception) {
        if (exception is PostNotFoundException) {
          stateManager.setState(
            PostsNotFoundState(exception.message),
          );
        } else {
          stateManager.setState(
            PostFailureState(exception.message),
          );
        }
      },
    );
  }

  void requestLogin() {
    stateManager.showSnackBarRequestLogin('Please, login to like this post');
  }
}
